import {
  fireEvent,
  render,
  screen,
} from "@testing-library/react";
import {
  describe,
  expect,
  it,
  vi,
} from "vitest";

import ReturnExpensesTable
  from "./ReturnExpensesTable.jsx";


const expenses = [
  {
    id: 11,
    customer_name: "Customer A",
    company: "Dell",
    model_number: "5420",
    serial_number: "SER-11",
    technician_name: "Tech",
    item_name: "Battery",
    unit_price: "1000.00",
    quantity: 1,
    total_amount: "1000.00",
    created_by_name: "Admin",
    created_at: "2026-08-01T10:00:00+05:30",
  },
  {
    id: 12,
    customer_name: "Customer B",
    company: "HP",
    model_number: "840",
    serial_number: "SER-12",
    technician_name: "Tech",
    item_name: "Keyboard",
    unit_price: "500.00",
    quantity: 1,
    total_amount: "500.00",
    created_by_name: "Admin",
    created_at: "2026-08-01T11:00:00+05:30",
  },
];


describe(
  "ReturnExpensesTable selection mode",
  () => {
    it(
      "shows row checkboxes only in selection mode",
      () => {
        const { rerender } =
          render(
            <ReturnExpensesTable
              expenses={expenses}
            />,
          );

        expect(
          screen.queryByLabelText(
            "Select expense 11",
          ),
        ).not.toBeInTheDocument();

        rerender(
          <ReturnExpensesTable
            expenses={expenses}
            selectionMode
            selectedExpenseIds={[]}
          />,
        );

        expect(
          screen.getByLabelText(
            "Select expense 11",
          ),
        ).toBeInTheDocument();
      },
    );


    it(
      "toggles a selected expense",
      () => {
        const onToggleExpense =
          vi.fn();

        render(
          <ReturnExpensesTable
            expenses={expenses}
            selectionMode
            selectedExpenseIds={[]}
            onToggleExpense={onToggleExpense}
          />,
        );

        fireEvent.click(
          screen.getByLabelText(
            "Select expense 11",
          ),
        );

        expect(
          onToggleExpense
        ).toHaveBeenCalledWith(
          11,
        );
      },
    );


    it(
      "supports select all visible expenses",
      () => {
        const onToggleAll =
          vi.fn();

        render(
          <ReturnExpensesTable
            expenses={expenses}
            selectionMode
            selectedExpenseIds={[]}
            onToggleAll={onToggleAll}
          />,
        );

        fireEvent.click(
          screen.getByLabelText(
            "Select all visible expenses",
          ),
        );

        expect(
          onToggleAll
        ).toHaveBeenCalledWith(
          expenses,
        );
      },
    );
  },
);
