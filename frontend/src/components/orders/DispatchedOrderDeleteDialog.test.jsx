import {
  fireEvent,
  render,
  screen,
} from "@testing-library/react";
import {
  beforeAll,
  describe,
  expect,
  it,
  vi,
} from "vitest";

import DispatchedOrderDeleteDialog
  from "./DispatchedOrderDeleteDialog.jsx";


beforeAll(
  () => {
    if (
      !HTMLDialogElement
        .prototype
        .showModal
    ) {
      HTMLDialogElement
        .prototype
        .showModal =
        function showModal() {
          this.setAttribute(
            "open",
            "",
          );
        };
    }

    if (
      !HTMLDialogElement
        .prototype
        .close
    ) {
      HTMLDialogElement
        .prototype
        .close =
        function close() {
          this.removeAttribute(
            "open"
          );
        };
    }
  },
);


describe(
  "DispatchedOrderDeleteDialog",
  () => {
    it(
      "requires explicit confirmation before delete callback",
      () => {
        const onConfirm =
          vi.fn();

        render(
          <DispatchedOrderDeleteDialog
            order={{
              id: 10,
              order_number:
                "ORD-0010",
            }}
            onConfirm={onConfirm}
            onCancel={() => {}}
          />,
        );

        expect(
          screen.getByText(
            /ORD-0010/
          ),
        ).toBeInTheDocument();

        expect(
          onConfirm
        ).not.toHaveBeenCalled();

        fireEvent.click(
          screen.getByRole(
            "button",
            {
              name:
                "Delete Order",
            },
          ),
        );

        expect(
          onConfirm
        ).toHaveBeenCalledTimes(
          1
        );
      },
    );
  },
);
