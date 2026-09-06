from django.contrib.auth import (
    get_user_model,
)
from django.contrib.auth.models import (
    Group,
)
from django.test import TestCase
from django.utils import timezone
from datetime import timedelta
from rest_framework.test import APIClient

from apps.inventory.models import (
    Return,
    ReturnExpense,
)
from apps.inventory.roles import (
    ROLE_ADMIN,
    ROLE_INVENTORY_VIEWER,
    ROLE_SALES,
    assign_role,
)


User = get_user_model()


class ReturnExpenseExportTests(
    TestCase
):
    def setUp(
        self,
    ):
        for role in (
            ROLE_ADMIN,
            ROLE_INVENTORY_VIEWER,
            ROLE_SALES,
        ):
            Group.objects.get_or_create(
                name=role
            )

        self.admin = (
            User.objects.create_user(
                username="expense-export-admin",
                password="test-password",
            )
        )

        assign_role(
            self.admin,
            ROLE_ADMIN,
        )

        self.viewer = (
            User.objects.create_user(
                username="expense-export-viewer",
                password="test-password",
            )
        )

        assign_role(
            self.viewer,
            ROLE_INVENTORY_VIEWER,
        )

        self.sales = (
            User.objects.create_user(
                username="expense-delete-sales",
                password="test-password",
            )
        )

        assign_role(
            self.sales,
            ROLE_SALES,
        )

        self.return_record = (
            Return.objects.create(
                customer_name="Export Customer",
                customer_address="Chennai",
                company="Dell",
                display_type="non_touch",
                model_number="5420",
                processor="Intel Core i5",
                processor_generation="11th",
                ram_gb=8,
                storage_gb=256,
                storage_type="ssd",
                serial_number="EXPENSE-EXPORT-001",
                issue="Battery issue",
                service_rack="Rack E1",
                created_by=self.admin,
            )
        )

        self.client = APIClient()

    def _create_expense(
        self,
    ):
        self.client.force_authenticate(
            user=self.admin
        )

        response = self.client.post(
            (
                f"/api/v1/returns/"
                f"{self.return_record.id}/"
                "expenses/"
            ),
            {
                "item_name":
                    "Replacement Battery",
                "unit_price":
                    "1500.00",
                "quantity":
                    2,
            },
            format="json",
        )

        self.assertEqual(
            response.status_code,
            201,
            response.data,
        )

        return response.data

    def test_admin_can_export_expenses_as_xlsx(
        self,
    ):
        self._create_expense()

        response = self.client.get(
            "/api/v1/returns/expenses/export/"
        )

        self.assertEqual(
            response.status_code,
            200,
        )

        self.assertEqual(
            response[
                "Content-Type"
            ],
            (
                "application/"
                "vnd.openxmlformats-"
                "officedocument."
                "spreadsheetml.sheet"
            ),
        )

        self.assertEqual(
            response[
                "X-Exported-Rows"
            ],
            "1",
        )

        content = b"".join(
            response.streaming_content
        )

        self.assertTrue(
            content.startswith(
                b"PK"
            )
        )

    def test_export_uses_expense_search_filter(
        self,
    ):
        self._create_expense()

        response = self.client.get(
            "/api/v1/returns/expenses/export/",
            {
                "search":
                    "does-not-match",
            },
        )

        self.assertEqual(
            response.status_code,
            200,
        )

        self.assertEqual(
            response[
                "X-Exported-Rows"
            ],
            "0",
        )

    def test_inventory_viewer_cannot_export_expenses(
        self,
    ):
        self.client.force_authenticate(
            user=self.viewer
        )

        response = self.client.get(
            "/api/v1/returns/expenses/export/"
        )

        self.assertEqual(
            response.status_code,
            403,
        )

    def test_admin_can_bulk_delete_filtered_expenses_after_seven_days(
        self,
    ):
        created = self._create_expense()

        expense_id = created["id"]

        ReturnExpense.objects.filter(
            id=expense_id
        ).update(
            created_at=(
                timezone.now()
                - timedelta(
                    days=8
                )
            )
        )

        response = self.client.delete(
            "/api/v1/returns/expenses/bulk-delete/",
            {
                "expense_ids": [
                    expense_id,
                ],
            },
            format="json",
        )

        self.assertEqual(
            response.status_code,
            200,
            response.data,
        )

        self.assertEqual(
            response.data[
                "deleted_count"
            ],
            1,
        )

        self.assertFalse(
            ReturnExpense.objects.filter(
                id=expense_id
            ).exists()
        )


    def test_bulk_delete_rejects_entire_filtered_set_if_any_expense_is_newer_than_seven_days(
        self,
    ):
        created = self._create_expense()

        response = self.client.delete(
            "/api/v1/returns/expenses/bulk-delete/",
            {
                "expense_ids": [
                    created["id"],
                ],
            },
            format="json",
        )

        self.assertEqual(
            response.status_code,
            400,
            response.data,
        )

        self.assertEqual(
            response.data[
                "protected_count"
            ],
            1,
        )

        self.assertEqual(
            response.data[
                "selected_count"
            ],
            1,
        )

        self.assertTrue(
            ReturnExpense.objects.filter(
                id=created["id"]
            ).exists()
        )


    def test_sales_cannot_bulk_delete_return_expenses(
        self,
    ):
        self.client.force_authenticate(
            user=self.sales
        )

        response = self.client.delete(
            "/api/v1/returns/expenses/bulk-delete/"
        )

        self.assertEqual(
            response.status_code,
            403,
        )



    def test_bulk_delete_requires_selected_expense_ids(
        self,
    ):
        self.client.force_authenticate(
            user=self.admin
        )

        response = self.client.delete(
            "/api/v1/returns/expenses/bulk-delete/",
            {},
            format="json",
        )

        self.assertEqual(
            response.status_code,
            400,
        )

        self.assertIn(
            "Select at least one",
            response.data["detail"],
        )
