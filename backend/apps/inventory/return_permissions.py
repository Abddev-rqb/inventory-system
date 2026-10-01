from rest_framework.permissions import (
    BasePermission,
)

from apps.inventory.roles import (
    ROLE_ADMIN,
    ROLE_INVENTORY_VIEWER,
    ROLE_SALES,
    ROLE_TECHNICIAN,
    get_user_role,
)


class ReturnPermission(
    BasePermission
):
    message = (
        "You do not have permission "
        "to perform this return action."
    )

    def has_permission(
        self,
        request,
        view,
    ):
        user = request.user

        if (
            not user
            or not user.is_authenticated
        ):
            return False

        role = get_user_role(
            user
        )

        if (
            role
            == ROLE_ADMIN
        ):
            return True

        action = getattr(
            view,
            "action",
            None,
        )

        # View return records.
        if action in {
            "list",
            "retrieve",
        }:
            return role in {
                ROLE_INVENTORY_VIEWER,
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # Add a new return.
        if (
            action
            == "create"
        ):
            return role in {
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # Edit a return.
        if action in {
            "update",
            "partial_update",
        }:
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.change_return"
                )
            )

        # Assign a technician.
        if (
            action
            == "assign_technician"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.change_return"
                )
            )

        # Load technicians for the
        # technician assignment dialog.
        if (
            action
            == "technicians"
        ):
            return role in {
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # Update return status.
        if (
            action
            == "update_status"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.change_return"
                )
            )

        # Complete repair / Done action.
        if (
            action
            == "complete_repair"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.change_return"
                )
            )

        # Add return expense.
        if (
            action
            == "add_expense"
        ):
            return role in {
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # View return expenses.
        if (
            action
            == "expenses"
        ):
            return role in {
                ROLE_INVENTORY_VIEWER,
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # Stock in a returned laptop.
        if (
            action
            == "stock_in"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.stock_in_return"
                )
            )

        # Assign return priority.
        if (
            action
            == "assign_priority"
        ):
            return role in {
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # Delete a return record.
        if (
            action
            == "destroy"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.change_return"
                )
            )

        # Return Excel import remains
        # restricted to Sales users.
        if action in {
            "import_preview",
            "import_confirm",
        }:
            return (
                role
                == ROLE_SALES
                and user.has_perm(
                    "inventory.add_return"
                )
            )

        # View stocked-in return records.
        if (
            action
            == "stocked_in"
        ):
            return role in {
                ROLE_INVENTORY_VIEWER,
                ROLE_SALES,
                ROLE_TECHNICIAN,
            }

        # Export stocked-in returns.
        if (
            action
            == "stocked_in_export"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.export_return"
                )
            )

        # Export active returns.
        if (
            action
            == "export_returns"
        ):
            return (
                role
                in {
                    ROLE_SALES,
                    ROLE_TECHNICIAN,
                }
                and user.has_perm(
                    "inventory.export_return"
                )
            )

        return False