import { useEffect, useRef } from "react";

function ReturnDoneActionDialog({
  isOpen,
  returnRecord,
  isProcessing,
  errorMessage,
  onClose,
  onMoveToPending,
  onStockIn,
}) {
  const dialogRef = useRef(null);

  useEffect(() => {
    const dialog = dialogRef.current;

    if (!dialog) {
      return;
    }

    if (isOpen && !dialog.open) {
      dialog.showModal();
    }

    if (!isOpen && dialog.open) {
      dialog.close();
    }
  }, [isOpen]);

  function handleDialogClose() {
    if (!isProcessing) {
      onClose();
    }
  }

  function handleBackdropClick(event) {
    if (event.target === dialogRef.current && !isProcessing) {
      onClose();
    }
  }

  return (
    <dialog
      ref={dialogRef}
      className="return-done-action-dialog"
      onClose={handleDialogClose}
      onClick={handleBackdropClick}
      aria-labelledby="return-done-action-title"
    >
      <div className="return-done-action-card">
        <div className="return-done-action-header">
          <h2 id="return-done-action-title">
            What would you like to do?
          </h2>
        </div>

        {returnRecord ? (
          <div className="return-done-action-options">
            <button
              type="button"
              className="return-done-radio-option"
              onClick={onStockIn}
              disabled={isProcessing}
            >
              <span className="return-done-radio-circle">
                <span className="return-done-radio-dot" />
              </span>

              <span className="return-done-radio-content">
                <span className="return-done-radio-title">
                  Stock In
                </span>

                <span className="return-done-radio-description">
                  Add laptop to Inventory.
                </span>
              </span>
            </button>

            <button
              type="button"
              className="return-done-radio-option"
              onClick={onMoveToPending}
              disabled={isProcessing}
            >
              <span className="return-done-radio-circle">
                <span className="return-done-radio-dot" />
              </span>

              <span className="return-done-radio-content">
                <span className="return-done-radio-title">
                  Move to Pending Orders
                </span>

                <span className="return-done-radio-description">
                  Push to pending order
                </span>
              </span>
            </button>
          </div>
        ) : null}

        {errorMessage ? (
          <div className="return-done-action-error" role="alert">
            {errorMessage}
          </div>
        ) : null}

        <div className="return-done-action-footer">
          <button
            type="button"
            className="button button-secondary"
            onClick={onClose}
            disabled={isProcessing}
          >
            Cancel
          </button>
        </div>
      </div>
    </dialog>
  );
}

export default ReturnDoneActionDialog;