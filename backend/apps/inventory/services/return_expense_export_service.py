from io import BytesIO

from django.utils import timezone
from openpyxl import Workbook
from openpyxl.styles import Font


class ReturnExpenseExcelExportService:
    FILE_NAME = "return-expenses.xlsx"
    SHEET_NAME = "Return Expenses"

    HEADERS = (
        "Expense ID",
        "Return ID",
        "Customer Name",
        "Company",
        "Model Number",
        "Serial Number",
        "Technician",
        "Item Name",
        "Unit Price",
        "Quantity",
        "Total Amount",
        "Created By",
        "Created At",
    )

    @classmethod
    def build_workbook(
        cls,
        *,
        queryset,
    ):
        workbook = Workbook()
        worksheet = workbook.active
        worksheet.title = cls.SHEET_NAME

        worksheet.append(
            cls.HEADERS
        )

        for cell in worksheet[1]:
            cell.font = Font(
                bold=True
            )

        for expense in queryset:
            return_record = (
                expense.return_record
            )

            technician = (
                return_record.technician
            )

            created_by = (
                expense.created_by
            )

            technician_name = (
                cls._user_name(
                    technician
                )
            )

            created_by_name = (
                cls._user_name(
                    created_by
                )
            )

            created_at = (
                timezone.localtime(
                    expense.created_at
                ).strftime(
                    "%Y-%m-%d %H:%M:%S"
                )
                if expense.created_at
                else ""
            )

            worksheet.append(
                (
                    expense.id,
                    expense.return_record_id,
                    return_record.customer_name,
                    return_record.company,
                    return_record.model_number,
                    return_record.serial_number,
                    technician_name,
                    expense.item_name,
                    float(expense.unit_price),
                    expense.quantity,
                    float(expense.total_amount),
                    created_by_name,
                    created_at,
                )
            )

        column_widths = (
            12, 12, 24, 18, 18, 22, 22,
            26, 14, 10, 16, 22, 22,
        )

        for index, width in enumerate(
            column_widths,
            start=1,
        ):
            worksheet.column_dimensions[
                worksheet.cell(
                    row=1,
                    column=index,
                ).column_letter
            ].width = width

        output = BytesIO()
        workbook.save(output)
        output.seek(0)

        return output

    @staticmethod
    def _user_name(
        user,
    ):
        if user is None:
            return ""

        full_name = (
            user.get_full_name()
            .strip()
        )

        return (
            full_name
            or user.username
        )
