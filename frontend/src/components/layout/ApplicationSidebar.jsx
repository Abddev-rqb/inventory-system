import {
  NavLink,
} from "react-router-dom";

import {
  useCallback,
  useEffect,
  useState,
} from "react";

import {
  useAuth,
} from "../../auth/AuthContext.jsx";

import {
  getPendingOrders,
} from "../../api/orderApi.js";


function ApplicationSidebar({
  onNavigate,
}) {
  const {
    user,
    hasPermission,
  } = useAuth();

  const role =
    user?.role;

  const isAdmin =
    Boolean(
      user?.is_staff ||
      user?.is_superuser ||
      role === "admin",
    );

  const isSales =
    role === "sales";

  const isInventoryViewer =
    role ===
    "inventory_viewer";

  const canViewLaptops =
    hasPermission(
      "inventory.view_laptop",
    );

  const canViewOrders =
    hasPermission(
      "inventory.view_order",
    );

  const canViewDispatched =
    hasPermission(
      "inventory.view_order",
    );

  const canViewSales =
    !isInventoryViewer &&
    (
      isAdmin ||
      hasPermission(
        "inventory.view_sales_report",
      )
    );

  const canManageUsers =
    isAdmin ||
    isSales;

  const [
    pendingOrderCount,
    setPendingOrderCount,
  ] = useState(0);

  const loadPendingOrderCount =
    useCallback(
      async () => {
        if (!canViewOrders) {
          setPendingOrderCount(0);
          return;
        }

        try {
          const data =
            await getPendingOrders();

          if (
            Array.isArray(
              data,
            )
          ) {
            setPendingOrderCount(
              data.length,
            );
            return;
          }

          setPendingOrderCount(
            Number(
              data?.count ?? 0,
            ),
          );
        } catch {
          // Keep the last known count when
          // the sidebar refresh request fails.
        }
      },
      [
        canViewOrders,
      ],
    );

  useEffect(() => {
    if (!canViewOrders) {
      setPendingOrderCount(0);
      return undefined;
    }

    loadPendingOrderCount();

    const refreshInterval =
      window.setInterval(
        loadPendingOrderCount,
        10000,
      );

    const handleWindowFocus =
      () => {
        loadPendingOrderCount();
      };

    const handlePendingOrdersChanged =
      () => {
        loadPendingOrderCount();
      };

    window.addEventListener(
      "focus",
      handleWindowFocus,
    );

    window.addEventListener(
      "pending-orders-changed",
      handlePendingOrdersChanged,
    );

    return () => {
      window.clearInterval(
        refreshInterval,
      );

      window.removeEventListener(
        "focus",
        handleWindowFocus,
      );

      window.removeEventListener(
        "pending-orders-changed",
        handlePendingOrdersChanged,
      );
    };
  }, [
    canViewOrders,
    loadPendingOrderCount,
  ]);


  return (
    <nav
      className="sidebar-navigation"
      aria-label="Primary navigation"
    >
      {canViewLaptops ? (
        <NavLink
          to="/laptops"
          className={
            getNavigationClassName
          }
          onClick={
            onNavigate
          }
        >
          Laptop Inventory
        </NavLink>
      ) : null}


      {canViewOrders ? (
        <div className="sidebar-navigation-group">
          <p className="sidebar-navigation-heading">
            Orders
          </p>

          <NavLink
            to="/orders/pending"
            className={
              getNavigationClassName
            }
            onClick={
              onNavigate
            }
          >
            <span className="sidebar-navigation-link-content">
              <span>
                Pending Orders
              </span>

              {pendingOrderCount > 0 ? (
                <span
                  className="pending-orders-nav-badge"
                  aria-label={
                    `${pendingOrderCount} pending orders`
                  }
                >
                  {pendingOrderCount}
                </span>
              ) : null}
            </span>
          </NavLink>


          {canViewDispatched ? (
            <NavLink
              to="/orders/dispatched"
              className={
                getNavigationClassName
              }
              onClick={
                onNavigate
              }
            >
              Dispatched
            </NavLink>
          ) : null}


          {canViewSales ? (
            <NavLink
              to="/orders/sales"
              className={
                getNavigationClassName
              }
              onClick={
                onNavigate
              }
            >
              Total Sales
            </NavLink>
          ) : null}
        </div>
      ) : null}


      {canManageUsers ? (
        <div className="sidebar-navigation-group">
          <p className="sidebar-navigation-heading">
            Access Control
          </p>

          <NavLink
            to="/users"
            className={
              getNavigationClassName
            }
            onClick={
              onNavigate
            }
          >
            Users
          </NavLink>
        </div>
      ) : null}


      {!isInventoryViewer &&
      hasPermission(
        "inventory.view_return",
      ) ? (
        <NavLink
          to="/returns"
          className={
            getNavigationClassName
          }
          onClick={
            onNavigate
          }
        >
          Returns
        </NavLink>
      ) : null}
    </nav>
  );
}


function getNavigationClassName({
  isActive,
}) {
  return [
    "sidebar-navigation-link",

    isActive
      ? "sidebar-navigation-link-active"
      : "",
  ]
    .filter(Boolean)
    .join(" ");
}


export default ApplicationSidebar;