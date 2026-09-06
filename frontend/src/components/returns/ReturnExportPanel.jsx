function ReturnExportPanel({
  isExporting,
  onExport,
}) {
  return (
    <section className="returns-tab-content">
      <div className="returns-action-row">
        <div>
          <h2>Export Returns</h2>
          <p>
            Download the active return records
            using the filters currently applied
            in the Active Returns tab.
          </p>
        </div>

        <button
          type="button"
          className="button button-primary"
          disabled={isExporting}
          onClick={onExport}
        >
          {isExporting
            ? "Exporting..."
            : "Export Excel"}
        </button>
      </div>
    </section>
  );
}

export default ReturnExportPanel;
