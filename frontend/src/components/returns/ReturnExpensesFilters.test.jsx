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

import ReturnExpensesFilters
  from "./ReturnExpensesFilters.jsx";


const filters = {
  search: "",
  start_date: "",
  end_date: "",
};


describe(
  "ReturnExpensesFilters bulk delete",
  () => {
    it(
      "starts selection mode from Bulk Delete",
      () => {
        const onBulkDelete =
          vi.fn();

        render(
          <ReturnExpensesFilters
            filters={filters}
            disabled={false}
            canBulkDelete
            isBulkDeleteMode={false}
            onChange={() => {}}
            onApply={(event) =>
              event.preventDefault()
            }
            onClear={() => {}}
            onBulkDelete={onBulkDelete}
          />,
        );

        fireEvent.click(
          screen.getByRole(
            "button",
            {
              name:
                "Bulk Delete",
            },
          ),
        );

        expect(
          onBulkDelete
        ).toHaveBeenCalledTimes(
          1
        );
      },
    );


    it(
      "shows Delete Selected only in selection mode",
      () => {
        render(
          <ReturnExpensesFilters
            filters={filters}
            disabled={false}
            canBulkDelete
            isBulkDeleteMode
            selectedCount={2}
            onChange={() => {}}
            onApply={(event) =>
              event.preventDefault()
            }
            onClear={() => {}}
            onBulkDelete={() => {}}
            onCancelBulkDelete={() => {}}
          />,
        );

        expect(
          screen.getByRole(
            "button",
            {
              name:
                "Delete Selected (2)",
            },
          ),
        ).toBeInTheDocument();

        expect(
          screen.getByRole(
            "button",
            {
              name:
                "Cancel Selection",
            },
          ),
        ).toBeInTheDocument();
      },
    );
  },
);
