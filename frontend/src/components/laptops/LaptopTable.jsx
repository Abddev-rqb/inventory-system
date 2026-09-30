import {
  useEffect,
  useState,
} from "react";
import {
  Link,
} from "react-router-dom";


function LaptopTable({
  laptops,
  isSelectionMode = false,
  selectedLaptopIds =
    new Set(),
  onToggleLaptop = null,
  canMoveToService = false,
  movingLaptopId = null,
  onMoveToService = null,
}) {
  const [
    activeCommentLaptop,
    setActiveCommentLaptop,
  ] = useState(null);

  useEffect(() => {
    if (!activeCommentLaptop) {
      return undefined;
    }

    function handleKeyDown(event) {
      if (event.key === "Escape") {
        setActiveCommentLaptop(null);
      }
    }

    document.addEventListener(
      "keydown",
      handleKeyDown,
    );

    return () => {
      document.removeEventListener(
        "keydown",
        handleKeyDown,
      );
    };
  }, [
    activeCommentLaptop,
  ]);

  return (
    <>
      <div className="table-scroll-container">
        <table className="inventory-table">
          <thead>
            <tr>
              {isSelectionMode ? (
                <th
                  scope="col"
                  className="inventory-selection-column"
                >
                  <span className="sr-only">
                    Select
                  </span>
                </th>
              ) : null}

              <th scope="col">
                ID
              </th>

              <th
                scope="col"
                className="inventory-comments-column"
              >
                Comments
              </th>

              <th scope="col">
                Company
              </th>

              <th scope="col">
                Display type
              </th>

              <th scope="col">
                Model number
              </th>

              <th scope="col">
                Processor
              </th>

              <th scope="col">
                Processor generation
              </th>

              <th scope="col">
                RAM
              </th>

              <th scope="col">
                Storage
              </th>

              <th scope="col">
                Storage type
              </th>

              <th scope="col">
                Serial number
              </th>

              <th scope="col">
                Wholesale price
              </th>

              <th scope="col">
                Retail price
              </th>

              <th scope="col">
                QC status
              </th>

              <th scope="col">
                Inventory status
              </th>

              <th scope="col">
                Area
              </th>

              <th scope="col">
                Created at
              </th>

              {!isSelectionMode ? (
                <th scope="col">
                  Actions
                </th>
              ) : null}
            </tr>
          </thead>

          <tbody>
            {laptops.map(
              (laptop) => {
                const laptopId =
                  Number(
                    laptop.id,
                  );

                const isSelected =
                  selectedLaptopIds.has(
                    laptopId,
                  );

                const isSaleable =
                  canSelectLaptop(
                    laptop,
                  );

                return (
                  <tr
                    key={
                      laptop.id
                    }
                    className={
                      isSelected
                        ? "inventory-row-selected"
                        : undefined
                    }
                  >
                    {isSelectionMode ? (
                      <td className="inventory-selection-column">
                        <input
                          type="checkbox"
                          className="inventory-selection-checkbox"
                          aria-label={
                            `Select laptop ${laptop.id}`
                          }
                          checked={
                            isSelected
                          }
                          disabled={
                            !isSaleable
                          }
                          onChange={() => {
                            if (
                              !isSaleable ||
                              !onToggleLaptop
                            ) {
                              return;
                            }

                            onToggleLaptop(
                              laptop,
                            );
                          }}
                        />
                      </td>
                    ) : null}

                    {/* ID */}
                    <td>
                      <Link
                        to={
                          `/laptops/${laptop.id}`
                        }
                        className="inventory-table-link"
                      >
                        {laptop.id}
                      </Link>
                    </td>

                    {/* Comments */}
                    <td className="inventory-comments-cell">
                      <CommentCell
                        comment={
                          laptop.comments
                        }
                        onView={() =>
                          setActiveCommentLaptop(
                            laptop,
                          )
                        }
                      />
                    </td>

                    {/* Company */}
                    <td>
                      {displayValue(
                        laptop.company,
                      )}
                    </td>

                    {/* Display type */}
                    <td>
                      {formatChoice(
                        laptop.display_type,
                      )}
                    </td>

                    {/* Model number */}
                    <td>
                      {displayValue(
                        laptop.model_number,
                      )}
                    </td>

                    {/* Processor */}
                    <td>
                      {displayValue(
                        laptop.processor,
                      )}
                    </td>

                    {/* Processor generation */}
                    <td>
                      {displayValue(
                        laptop.processor_generation,
                      )}
                    </td>

                    {/* RAM */}
                    <td>
                      {formatNumberWithUnit(
                        laptop.ram_gb,
                        "GB",
                      )}
                    </td>

                    {/* Storage */}
                    <td>
                      {formatNumberWithUnit(
                        laptop.storage_gb,
                        "GB",
                      )}
                    </td>

                    {/* Storage type */}
                    <td>
                      {formatChoice(
                        laptop.storage_type,
                      )}
                    </td>

                    {/* Serial number */}
                    <td>
                      {displayValue(
                        laptop.serial_number,
                      )}
                    </td>

                    {/* Wholesale price */}
                    <td>
                      {formatMoney(
                        laptop.wholesale_price,
                      )}
                    </td>

                    {/* Retail price */}
                    <td>
                      {formatMoney(
                        laptop.retail_price,
                      )}
                    </td>

                    {/* QC status */}
                    <td>
                      <StatusBadge
                        type="qc"
                        value={
                          laptop.qc_status
                        }
                      />
                    </td>

                    {/* Inventory status */}
                    <td>
                      <StatusBadge
                        type="inventory"
                        value={
                          laptop.inventory_status
                        }
                      />
                    </td>

                    {/* Area */}
                    <td>
                      {displayValue(
                        laptop.area,
                      )}
                    </td>

                    {/* Created at */}
                    <td>
                      {formatDateTime(
                        laptop.created_at,
                      )}
                    </td>

                    {/* Actions */}
                    {!isSelectionMode ? (
                      <td>
                        {
                          canMoveToService
                          && canMoveLaptopToService(
                            laptop,
                          )
                          && onMoveToService
                            ? (
                                <button
                                  type="button"
                                  className="button button-secondary"
                                  disabled={
                                    movingLaptopId === laptopId
                                  }
                                  onClick={() =>
                                    onMoveToService(
                                      laptop,
                                    )
                                  }
                                >
                                  {
                                    movingLaptopId === laptopId
                                      ? "Moving..."
                                      : "To Service"
                                  }
                                </button>
                              )
                            : "—"
                        }
                      </td>
                    ) : null}
                  </tr>
                );
              },
            )}
          </tbody>
        </table>
      </div>

      {activeCommentLaptop ? (
        <CommentModal
          laptop={
            activeCommentLaptop
          }
          onClose={() =>
            setActiveCommentLaptop(
              null,
            )
          }
        />
      ) : null}
    </>
  );
}


function CommentCell({
  comment,
  onView,
}) {
  const normalizedComment =
    String(
      comment ?? "",
    ).trim();

  if (!normalizedComment) {
    return (
      <span className="inventory-comment-empty">
        —
      </span>
    );
  }

  const maxPreviewLength = 65;

  const isLongComment =
    normalizedComment.length >
    maxPreviewLength;

  const preview =
    isLongComment
      ? `${normalizedComment.slice(
          0,
          maxPreviewLength,
        )}...`
      : normalizedComment;

  if (!isLongComment) {
    return (
      <span
        className="inventory-comment-preview"
        title={
          normalizedComment
        }
      >
        {
          normalizedComment
        }
      </span>
    );
  }

  return (
    <div className="inventory-comment-wrapper">
      <span
        className="inventory-comment-preview"
        title={
          normalizedComment
        }
      >
        {preview}
      </span>

      <button
        type="button"
        className="inventory-comment-view-button"
        onClick={onView}
        aria-label="View full comment"
      >
        View
      </button>
    </div>
  );
}


function CommentModal({
  laptop,
  onClose,
}) {
  const comment =
    String(
      laptop.comments ?? "",
    ).trim();

  return (
    <div
      className="inventory-comment-modal-backdrop"
      role="presentation"
      onMouseDown={(event) => {
        if (
          event.target ===
          event.currentTarget
        ) {
          onClose();
        }
      }}
    >
      <div
        className="inventory-comment-modal"
        role="dialog"
        aria-modal="true"
        aria-labelledby="inventory-comment-modal-title"
      >
        <div className="inventory-comment-modal-header">
          <div>
            <h2
              id="inventory-comment-modal-title"
              className="inventory-comment-modal-title"
            >
              Laptop comment
            </h2>

            <div className="inventory-comment-modal-meta">
              <span>
                ID:{" "}
                {displayValue(
                  laptop.id,
                )}
              </span>

              <span>
                Serial:{" "}
                {displayValue(
                  laptop.serial_number,
                )}
              </span>
            </div>
          </div>

          <button
            type="button"
            className="inventory-comment-modal-close"
            onClick={onClose}
            aria-label="Close comment"
          >
            ×
          </button>
        </div>

        <div className="inventory-comment-modal-body">
          {comment || "No comment available."}
        </div>
      </div>
    </div>
  );
}


function canSelectLaptop(
  laptop,
) {
  const quantity =
    Number(
      laptop.quantity,
    );

  const saleableStatus =
    laptop.inventory_status ===
      "in_stock" ||
    laptop.inventory_status ===
      "in_stock_g";

  return (
    saleableStatus &&
    quantity === 1
  );
}


function StatusBadge({
  type,
  value,
}) {
  const normalizedValue =
    String(
      value ?? "",
    );

  const className = [
    "status-badge",
    getStatusClassName(
      type,
      normalizedValue,
    ),
  ]
    .filter(Boolean)
    .join(" ");

  return (
    <span
      className={
        className
      }
    >
      {formatChoice(
        normalizedValue,
      )}
    </span>
  );
}


function getStatusClassName(
  type,
  value,
) {
  if (
    type === "qc"
  ) {
    if (
      value === "done"
    ) {
      return (
        "status-badge-success"
      );
    }

    return (
      "status-badge-warning"
    );
  }

  if (
    value === "in_stock" ||
    value === "in_stock_g"
  ) {
    return (
      "status-badge-success"
    );
  }

  return (
    "status-badge-warning"
  );
}


function formatMoney(
  value,
) {
  const amount =
    Number(value);

  if (
    !Number.isFinite(
      amount,
    )
  ) {
    return "—";
  }

  return new Intl.NumberFormat(
    "en-IN",
    {
      style: "currency",
      currency: "INR",
      maximumFractionDigits: 2,
    },
  ).format(
    amount,
  );
}


function formatNumberWithUnit(
  value,
  unit,
) {
  if (
    value === null ||
    value === undefined ||
    value === ""
  ) {
    return "—";
  }

  return `${value} ${unit}`;
}


function formatChoice(
  value,
) {
  if (
    value === null ||
    value === undefined ||
    value === ""
  ) {
    return "—";
  }

  return String(value)
    .replaceAll(
      "_",
      " ",
    )
    .replace(
      /\b\w/g,
      (letter) =>
        letter.toUpperCase(),
    );
}


function displayValue(
  value,
) {
  if (
    value === null ||
    value === undefined ||
    value === ""
  ) {
    return "—";
  }

  return value;
}


function canMoveLaptopToService(
  laptop,
) {
  return (
    Number(laptop.quantity) === 1
    && (
      laptop.inventory_status === "in_stock"
      || laptop.inventory_status === "in_stock_g"
    )
  );
}


function formatDateTime(
  value,
) {
  if (!value) {
    return "—";
  }

  const date =
    new Date(value);

  if (
    Number.isNaN(
      date.getTime(),
    )
  ) {
    return "—";
  }

  return new Intl.DateTimeFormat(
    "en-IN",
    {
      dateStyle: "medium",
      timeStyle: "short",
    },
  ).format(date);
}


export default LaptopTable;