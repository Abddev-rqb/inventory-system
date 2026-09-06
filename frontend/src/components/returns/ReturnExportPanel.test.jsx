import {
  render,
  screen,
} from "@testing-library/react";
import userEvent from "@testing-library/user-event";
import {
  describe,
  expect,
  it,
  vi,
} from "vitest";

import ReturnExportPanel
  from "./ReturnExportPanel.jsx";


describe(
  "ReturnExportPanel",
  () => {
    it(
      "calls onExport when Export Excel is clicked",
      async () => {
        const user =
          userEvent.setup();

        const onExport =
          vi.fn();

        render(
          <ReturnExportPanel
            isExporting={false}
            onExport={onExport}
          />,
        );

        await user.click(
          screen.getByRole(
            "button",
            {
              name: "Export Excel",
            },
          ),
        );

        expect(onExport)
          .toHaveBeenCalledTimes(1);
      },
    );


    it(
      "disables the button while exporting",
      () => {
        render(
          <ReturnExportPanel
            isExporting
            onExport={vi.fn()}
          />,
        );

        expect(
          screen.getByRole(
            "button",
            {
              name: "Exporting...",
            },
          ),
        ).toBeDisabled();
      },
    );
  },
);
