from unittest.mock import patch

from django.contrib.auth import (
    get_user_model,
)
from django.contrib.auth.models import (
    Group,
)
from django.test import TestCase
from rest_framework.test import APIClient

from apps.inventory.roles import (
    ROLE_ADMIN,
    ROLE_SALES,
    assign_role,
)


User = get_user_model()


class DispatchedDirectDeletePermissionTests(
    TestCase
):
    def setUp(
        self,
    ):
        for role in (
            ROLE_ADMIN,
            ROLE_SALES,
        ):
            Group.objects.get_or_create(
                name=role
            )

        self.admin = (
            User.objects.create_user(
                username="direct-delete-admin",
                password="test-password",
            )
        )

        assign_role(
            self.admin,
            ROLE_ADMIN,
        )

        self.sales = (
            User.objects.create_user(
                username="direct-delete-sales",
                password="test-password",
            )
        )

        assign_role(
            self.sales,
            ROLE_SALES,
        )

        self.client = APIClient()


    @patch(
        "apps.inventory.views."
        "OrderDeletionService.admin_delete_order"
    )
    def test_admin_can_reach_direct_delete_service(
        self,
        delete_order_mock,
    ):
        delete_order_mock.return_value = {
            "deleted_order_id": 123,
        }

        self.client.force_authenticate(
            user=self.admin
        )

        response = self.client.delete(
            "/api/v1/orders/123/"
        )

        self.assertEqual(
            response.status_code,
            200,
            response.data,
        )

        delete_order_mock.assert_called_once()


    @patch(
        "apps.inventory.views."
        "OrderDeletionService.admin_delete_order"
    )
    def test_sales_cannot_directly_delete_dispatched_order(
        self,
        delete_order_mock,
    ):
        self.client.force_authenticate(
            user=self.sales
        )

        response = self.client.delete(
            "/api/v1/orders/123/"
        )

        self.assertEqual(
            response.status_code,
            403,
        )

        delete_order_mock.assert_not_called()
