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

import ReturnExpenseExportButton
  from "./ReturnExpenseExportButton.jsx";


describe(
  "ReturnExpenseExportButton",
  () => {
    it(
      "calls export when clicked",
      () => {
        const onExport =
          vi.fn();

        render(
          <ReturnExpenseExportButton
            onExport={onExport}
          />,
        );

        fireEvent.click(
          screen.getByRole(
            "button",
            {
              name:
                "Export Excel",
            },
          ),
        );

        expect(
          onExport
        ).toHaveBeenCalledTimes(
          1
        );
      },
    );

    it(
      "is disabled while exporting",
      () => {
        render(
          <ReturnExpenseExportButton
            isExporting
            onExport={() => {}}
          />,
        );

        expect(
          screen.getByRole(
            "button",
            {
              name:
                "Exporting...",
            },
          ),
        ).toBeDisabled();
      },
    );
  },
);
