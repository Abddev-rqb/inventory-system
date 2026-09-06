from django.contrib.auth import (
    get_user_model,
)
from rest_framework.test import (
    APIClient,
    APITestCase,
)

from apps.inventory.models import (
    Return,
)


User = get_user_model()


class ReturnExportTests(
    APITestCase
):
    def setUp(
        self,
    ):
        self.admin = (
            User.objects.create_superuser(
                username="return-export-admin",
                email="return-export@example.com",
                password="test-password",
            )
        )

        self.client = APIClient()
        self.client.force_authenticate(
            user=self.admin,
        )

        self.return_record = (
            Return.objects.create(
                customer_name=(
                    "Export Customer"
                ),
                customer_address=(
                    "12 Export Street"
                ),
                company="Dell",
                display_type="non_touch",
                model_number="5420",
                processor="Intel Core i5",
                processor_generation="11th",
                ram_gb=8,
                storage_gb=256,
                storage_type="ssd",
                serial_number=(
                    "RETURN-EXPORT-001"
                ),
                issue="Display issue",
                service_rack="Rack E1",
                created_by=self.admin,
            )
        )


    def test_export_returns_downloads_xlsx(
        self,
    ):
        response = self.client.get(
            "/api/v1/returns/export/"
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

        workbook_bytes = b"".join(
            response.streaming_content
        )

        self.assertTrue(
            workbook_bytes.startswith(
                b"PK"
            )
        )


    def test_export_returns_respects_search_filter(
        self,
    ):
        response = self.client.get(
            "/api/v1/returns/export/",
            {
                "search": (
                    "RETURN-EXPORT-001"
                ),
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
            "1",
        )

        no_match_response = (
            self.client.get(
                "/api/v1/returns/export/",
                {
                    "search": (
                        "DOES-NOT-EXIST"
                    ),
                },
            )
        )

        self.assertEqual(
            no_match_response.status_code,
            200,
        )

        self.assertEqual(
            no_match_response[
                "X-Exported-Rows"
            ],
            "0",
        )
