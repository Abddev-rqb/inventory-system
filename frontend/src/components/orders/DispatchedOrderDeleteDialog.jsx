import ConfirmDialog
  from "../common/ConfirmDialog.jsx";


function DispatchedOrderDeleteDialog({
  order,
  isProcessing = false,
  onConfirm,
  onCancel,
}) {
  return (
    <ConfirmDialog
      isOpen={Boolean(order)}
      title="Delete Dispatched Order"
      message={
        order
          ? (
              `Delete ${order.order_number}? `
              + "This permanently deletes the "
              + "dispatched order record and is "
              + "restricted to Admin users."
            )
          : ""
      }
      confirmLabel="Delete Order"
      cancelLabel="Cancel"
      processingLabel="Deleting..."
      variant="danger"
      isProcessing={isProcessing}
      onConfirm={onConfirm}
      onCancel={onCancel}
    />
  );
}


export default DispatchedOrderDeleteDialog;
