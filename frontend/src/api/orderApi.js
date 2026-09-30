import axiosClient from "./axiosClient.js";


function notifyPendingOrdersChanged() {
  window.dispatchEvent(
    new Event(
      "pending-orders-changed",
    ),
  );
}


export async function createOrder(
  orderData,
) {
  const response =
    await axiosClient.post(
      "/orders/",
      orderData,
    );

  notifyPendingOrdersChanged();

  return response.data;
}


export async function getPendingOrders(
  params = {},
) {
  const response =
    await axiosClient.get(
      "/orders/",
      {
        params,
      },
    );

  return response.data;
}


export async function deletePendingOrder(
  orderId,
) {
  const response =
    await axiosClient.delete(
      `/orders/${orderId}/cancel/`,
    );

  notifyPendingOrdersChanged();

  return response.data;
}


export async function dispatchOrder(
  orderId,
) {
  const response =
    await axiosClient.post(
      `/orders/${orderId}/dispatch/`,
      {},
    );

  notifyPendingOrdersChanged();

  return response.data;
}


export async function bulkDispatchOrders(
  orderIds,
) {
  const response =
    await axiosClient.post(
      "/orders/dispatch/bulk/",
      {
        order_ids:
          orderIds,
      },
    );

  notifyPendingOrdersChanged();

  return response.data;
}


export async function getDispatchedOrders(
  params = {},
) {
  const response =
    await axiosClient.get(
      "/orders/dispatched/",
      {
        params,
      },
    );

  return response.data;
}


export async function revertDispatchedOrder(
  orderId,
) {
  const response =
    await axiosClient.post(
      `/orders/${orderId}/revert/`,
      {},
    );

  notifyPendingOrdersChanged();

  return response.data;
}


export async function requestOrderDeletion(
  orderId,
  reason,
) {
  const response =
    await axiosClient.post(
      `/orders/${orderId}/deletion-request/`,
      {
        reason,
      },
    );

  return response.data;
}


export async function deleteDispatchedOrder(
  orderId,
) {
  const response =
    await axiosClient.delete(
      `/orders/${orderId}/`,
    );

  return response.data;
}


export async function getOrderDeletionRequests(
  params = {},
) {
  const response =
    await axiosClient.get(
      "/order-deletion-requests/",
      {
        params,
      },
    );

  return response.data;
}


export async function approveOrderDeletionRequest(
  requestId,
) {
  const response =
    await axiosClient.post(
      (
        `/order-deletion-requests/` +
        `${requestId}/approve/`
      ),
      {},
    );

  return response.data;
}


export async function rejectOrderDeletionRequest(
  requestId,
) {
  const response =
    await axiosClient.post(
      (
        `/order-deletion-requests/` +
        `${requestId}/reject/`
      ),
      {},
    );

  return response.data;
}


export async function getSalesReport(
  params = {},
) {
  const response =
    await axiosClient.get(
      "/orders/sales/",
      {
        params,
      },
    );

  return response.data;
}

export async function exportDispatchedOrders(
  params = {},
) {
  const response =
    await axiosClient.get(
      "/orders/dispatched/export/",
      {
        params,
        responseType:
          "blob",
      },
    );

  return {
    blob:
      response.data,

    headers:
      response.headers,
  };
}

export async function exportSalesReport(
  params = {},
) {
  const response =
    await axiosClient.get(
      "/orders/sales/export/",
      {
        params,
        responseType:
          "blob",
      },
    );

  return {
    blob:
      response.data,

    headers:
      response.headers,
  };
}