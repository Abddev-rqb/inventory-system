import ReturnExpenseExportButton
  from "./ReturnExpenseExportButton.jsx";


function ReturnExpensesFilters({
  filters,
  disabled,
  canExport = false,
  isExporting = false,
  canBulkDelete = false,
  isBulkDeleting = false,
  isBulkDeleteMode = false,
  selectedCount = 0,
  bulkDeleteDisabled = false,
  onChange,
  onApply,
  onClear,
  onExport,
  onBulkDelete,
  onCancelBulkDelete,
}) {
  return (
    <form
      className="returns-filter-panel"
      onSubmit={onApply}
    >
      <div className="returns-filter-grid">
        <label className="return-filter-field">
          <span>Search</span>

          <input
            value={filters.search}
            onChange={
              (event) =>
                onChange(
                  "search",
                  event.target.value,
                )
            }
            placeholder={
              "Customer, laptop, serial or item"
            }
            disabled={disabled}
          />
        </label>

        <label className="return-filter-field">
          <span>Start Date</span>

          <input
            type="date"
            value={filters.start_date}
            onChange={
              (event) =>
                onChange(
                  "start_date",
                  event.target.value,
                )
            }
            disabled={disabled}
          />
        </label>

        <label className="return-filter-field">
          <span>End Date</span>

          <input
            type="date"
            value={filters.end_date}
            onChange={
              (event) =>
                onChange(
                  "end_date",
                  event.target.value,
                )
            }
            disabled={disabled}
          />
        </label>
      </div>

      <div className="returns-filter-actions">
        <button
          type="button"
          className="button button-secondary"
          onClick={onClear}
          disabled={disabled}
        >
          Clear
        </button>

        <button
          type="submit"
          className="button button-primary"
          disabled={disabled}
        >
          Apply
        </button>

        {canExport ? (
          <ReturnExpenseExportButton
            isExporting={isExporting}
            disabled={disabled}
            onExport={onExport}
          />
        ) : null}


        {canBulkDelete
        && !isBulkDeleteMode ? (
          <button
            type="button"
            className="button button-danger"
            disabled={
              disabled
              || isBulkDeleting
              || bulkDeleteDisabled
            }
            onClick={onBulkDelete}
          >
            Bulk Delete
          </button>
        ) : null}

        {canBulkDelete
        && isBulkDeleteMode ? (
          <>
            <button
              type="button"
              className="button button-secondary"
              disabled={
                disabled
                || isBulkDeleting
              }
              onClick={onCancelBulkDelete}
            >
              Cancel Selection
            </button>

            <button
              type="button"
              className="button button-danger"
              disabled={
                disabled
                || isBulkDeleting
                || selectedCount < 1
              }
              onClick={onBulkDelete}
            >
              {isBulkDeleting
                ? "Deleting..."
                : (
                    `Delete Selected (${selectedCount})`
                  )}
            </button>
          </>
        ) : null}
      </div>
    </form>
  );
}


export default ReturnExpensesFilters;
