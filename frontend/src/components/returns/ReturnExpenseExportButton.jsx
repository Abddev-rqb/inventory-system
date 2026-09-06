function ReturnExpenseExportButton({
  isExporting = false,
  disabled = false,
  onExport,
}) {
  return (
    <button
      type="button"
      className="button button-secondary"
      disabled={
        disabled
        || isExporting
      }
      onClick={onExport}
    >
      {isExporting
        ? "Exporting..."
        : "Export Excel"}
    </button>
  );
}

export default ReturnExpenseExportButton;
