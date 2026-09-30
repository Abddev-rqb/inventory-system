from django.db import transaction
from django.utils import timezone

from apps.inventory.api_exceptions import (
    OrderValidationError,
)
from apps.inventory.models import (
    Laptop,
    Order,
    Return,
)


class OrderRevertService:
    """Move a dispatched order back to Pending Orders."""

    @classmethod
    @transaction.atomic
    def revert_order(
        cls,
        *,
        order_id,
        reverted_by,
    ):
        if (
            not reverted_by
            or not reverted_by.is_authenticated
        ):
            raise OrderValidationError(
                "An authenticated user is required."
            )

        try:
            order = (
                Order.objects
                .select_for_update()
                .get(pk=order_id)
            )
        except Order.DoesNotExist:
            raise OrderValidationError(
                (
                    f"Order with ID {order_id} "
                    "does not exist."
                )
            ) from None

        if order.status != Order.Status.DISPATCHED:
            raise OrderValidationError(
                (
                    f"Order {order.order_number} "
                    "is not dispatched."
                )
            )

        # Lock the serialized laptops belonging to this order
        # before restoring their previous inventory status.
        order_items = list(
            order.items
            .select_related("laptop")
            .order_by("id")
        )

        laptop_ids = [
            item.laptop_id
            for item in order_items
            if (
                item.laptop_id is not None
                and not item.is_custom_item
            )
        ]

        laptops = {
            laptop.id: laptop
            for laptop in (
                Laptop.objects
                .select_for_update()
                .filter(id__in=laptop_ids)
            )
        }

        now = timezone.now()

        for item in order_items:
            if (
                item.is_custom_item
                or item.laptop_id is None
            ):
                continue

            laptop = laptops.get(item.laptop_id)

            if laptop is None:
                raise OrderValidationError(
                    (
                        f"The laptop for serial number "
                        f"{item.serial_number_snapshot or 'unknown'} "
                        "no longer exists."
                    )
                )

            previous_status = (
                item.inventory_status_before_sale
            )

            if not previous_status:
                raise OrderValidationError(
                    (
                        f"The previous inventory status "
                        f"for serial number "
                        f"{item.serial_number_snapshot or laptop.serial_number} "
                        "is not available."
                    )
                )

            if (
                previous_status
                not in dict(
                    Laptop.InventoryStatus.choices
                )
            ):
                raise OrderValidationError(
                    (
                        f"The stored inventory status "
                        f"'{previous_status}' for serial number "
                        f"{item.serial_number_snapshot or laptop.serial_number} "
                        "is invalid."
                    )
                )

            laptop.inventory_status = previous_status
            laptop.updated_at = now
            laptop.save(
                update_fields=[
                    "inventory_status",
                    "updated_at",
                ]
            )

        order.status = Order.Status.PENDING
        order.dispatched_at = None
        order.updated_at = now
        order.save(
            update_fields=[
                "status",
                "dispatched_at",
                "updated_at",
            ]
        )

        if order.source_return_id is not None:
            return_record = (
                Return.objects
                .select_for_update()
                .get(
                    pk=order.source_return_id,
                )
            )

            return_record.status = (
                Return.Status.READY_FOR_DISPATCH
            )
            return_record.updated_at = now
            return_record.save(
                update_fields=[
                    "status",
                    "updated_at",
                ]
            )

        return order
