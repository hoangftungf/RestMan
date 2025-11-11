package servlet;

import dao.InvoiceDAO;
import dao.OrderDAO;
import dao.ReportingDAO;
import dao.TableDAO;
import model.Invoice;
import model.Order;
import model.OrderItem;
import model.Table;
import model.enums.MembershipTier;
import model.vm.CustomerRevenueRow;
import model.vm.OrderDetailVM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Controller for customer revenue reporting
 */
@WebServlet("/report/customer-revenue")
public class CustomerRevenueReportController extends HttpServlet {
    private ReportingDAO reportingDAO = new ReportingDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private InvoiceDAO invoiceDAO = new InvoiceDAO();
    private TableDAO tableDAO = new TableDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Check if user has staff/manager/admin role
        String role = (String) session.getAttribute("role");
        if (!"STAFF".equals(role) && !"MANAGER".equals(role) && !"ADMIN".equals(role)) {
            session.invalidate();
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        if (action == null) action = "showFilter";

        try {
            switch (action) {
                case "showFilter":
                    showFilter(req, resp);
                    break;
                case "runReport":
                    runReport(req, resp);
                    break;
                case "viewCustomerDetail":
                    viewCustomerDetail(req, resp);
                    break;
                case "viewOrder":
                    viewOrder(req, resp);
                    break;
                case "viewInvoice":
                    viewInvoice(req, resp);
                    break;
                default:
                    showFilter(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException("Error in CustomerRevenueReportController: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }

    /**
     * Show filter form for report
     */
    private void showFilter(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        req.getRequestDispatcher("/WEB-INF/jsp/staff/gdLocDT.jsp").forward(req, resp);
    }

    /**
     * Run customer revenue report
     */
    private void runReport(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        // Parse date parameters
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String fromDateStr = req.getParameter("fromDate");
        String toDateStr = req.getParameter("toDate");

        Timestamp fromDate;
        Timestamp toDate;

        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                Date parsedFrom = sdf.parse(fromDateStr);
                fromDate = new Timestamp(parsedFrom.getTime());
            } else {
                // Default to 30 days ago
                fromDate = new Timestamp(System.currentTimeMillis() - (30L * 24 * 60 * 60 * 1000));
            }

            if (toDateStr != null && !toDateStr.isEmpty()) {
                Date parsedTo = sdf.parse(toDateStr);
                // Set to end of day
                toDate = new Timestamp(parsedTo.getTime() + (24 * 60 * 60 * 1000) - 1);
            } else {
                // Default to today
                toDate = new Timestamp(System.currentTimeMillis());
            }
        } catch (ParseException e) {
            req.setAttribute("error", "Định dạng ngày không hợp lệ");
            showFilter(req, resp);
            return;
        }

        // Parse tier filter
        MembershipTier tier = null;
        String tierStr = req.getParameter("tier");
        if (tierStr != null && !tierStr.isEmpty()) {
            try {
                tier = MembershipTier.valueOf(tierStr);
            } catch (IllegalArgumentException e) {
                // Ignore invalid tier
            }
        }

        // Parse minimum revenue
        BigDecimal minRevenue = null;
        String minRevenueStr = req.getParameter("minRevenue");
        if (minRevenueStr != null && !minRevenueStr.isEmpty()) {
            try {
                minRevenue = new BigDecimal(minRevenueStr);
            } catch (NumberFormatException e) {
                // Ignore invalid number
            }
        }

        // Parse topN
        Integer topN = null;
        String topNStr = req.getParameter("topN");
        if (topNStr != null && !topNStr.isEmpty()) {
            try {
                topN = Integer.parseInt(topNStr);
            } catch (NumberFormatException e) {
                // Ignore invalid number
            }
        }

        // Include unpaid invoices?
        boolean includeUnpaid = "true".equals(req.getParameter("includeUnpaid"));

        // Pagination
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int pageSize = 20;
        String sizeStr = req.getParameter("size");
        if (sizeStr != null && !sizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(sizeStr);
            } catch (NumberFormatException e) {
                pageSize = 20;
            }
        }

        // Get report data
        List<CustomerRevenueRow> customers = reportingDAO.customerRevenue(
            fromDate, toDate, tier, minRevenue, topN, includeUnpaid, page, pageSize
        );

        int totalCustomers = reportingDAO.countCustomerRevenue(
            fromDate, toDate, tier, minRevenue, includeUnpaid
        );

        int totalPages = (int) Math.ceil((double) totalCustomers / pageSize);

        // Calculate total revenue
        BigDecimal grandTotal = BigDecimal.ZERO;
        for (CustomerRevenueRow row : customers) {
            grandTotal = grandTotal.add(row.getTotalRevenue());
        }

        req.setAttribute("customers", customers);
        req.setAttribute("fromDate", fromDateStr);
        req.setAttribute("toDate", toDateStr);
        req.setAttribute("tier", tierStr);
        req.setAttribute("minRevenue", minRevenueStr);
        req.setAttribute("topN", topNStr);
        req.setAttribute("includeUnpaid", includeUnpaid);
        req.setAttribute("currentPage", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalCustomers", totalCustomers);
        req.setAttribute("grandTotal", grandTotal);

        req.getRequestDispatcher("/WEB-INF/jsp/staff/gdKetQuaDT.jsp").forward(req, resp);
    }

    /**
     * View customer detail with orders
     */
    private void viewCustomerDetail(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String customerKey = req.getParameter("customerKey");
        boolean guest = Boolean.parseBoolean(req.getParameter("guest"));
        String accountIdStr = req.getParameter("accountId");
        Integer accountId = (accountIdStr != null && !accountIdStr.isEmpty()) ? Integer.valueOf(accountIdStr) : null;
        String customerName = req.getParameter("customerName");
        String phone = req.getParameter("phone");
        String email = req.getParameter("email");

        if (customerName == null) customerName = "";
        if (phone == null) phone = "";
        if (email == null) email = "";

        if (!guest && accountId == null) {
            req.setAttribute("error", "Thiếu mã khách hàng.");
            resp.sendRedirect(req.getContextPath() + "/report/customer-revenue");
            return;
        }
        String fromDateStr = req.getParameter("fromDate");
        String toDateStr = req.getParameter("toDate");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Timestamp fromDate;
        Timestamp toDate;

        try {
            Date parsedFrom = sdf.parse(fromDateStr);
            fromDate = new Timestamp(parsedFrom.getTime());

            Date parsedTo = sdf.parse(toDateStr);
            toDate = new Timestamp(parsedTo.getTime() + (24 * 60 * 60 * 1000) - 1);
        } catch (ParseException e) {
            req.setAttribute("error", "Định dạng ngày không hợp lệ");
            resp.sendRedirect(req.getContextPath() + "/report/customer-revenue");
            return;
        }

        List<OrderDetailVM> orders = reportingDAO.customerOrders(guest, accountId, customerName, phone, email, fromDate, toDate);

        req.setAttribute("orders", orders);
        req.setAttribute("customerKey", customerKey);
        req.setAttribute("isGuest", guest);
        req.setAttribute("customerName", customerName);
        req.setAttribute("customerPhone", phone);
        req.setAttribute("customerEmail", email);
        req.setAttribute("fromDate", fromDateStr);
        req.setAttribute("toDate", toDateStr);

        req.getRequestDispatcher("/WEB-INF/jsp/staff/gdDonHangKH.jsp").forward(req, resp);
    }

    /**
     * View order details
     */
    private void viewOrder(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int orderId = Integer.parseInt(req.getParameter("orderId"));

        Order order = orderDAO.findById(orderId);
        if (order == null) {
            req.setAttribute("error", "Đơn hàng không tồn tại");
            resp.sendRedirect(req.getContextPath() + "/report/customer-revenue");
            return;
        }

        List<OrderItem> items = orderDAO.findItems(orderId);
        List<Invoice> invoices = invoiceDAO.findByOrderId(orderId);

        // Calculate order total
        BigDecimal orderTotal = BigDecimal.ZERO;
        for (OrderItem item : items) {
            orderTotal = orderTotal.add(item.getLineTotal());
        }

        req.setAttribute("order", order);
        req.setAttribute("items", items);
        Table table = null;
        if (order.getTableId() != null) {
            table = tableDAO.findById(order.getTableId());
        }

        req.setAttribute("invoices", invoices);
        req.setAttribute("table", table);
        req.setAttribute("orderTotal", orderTotal);

        req.getRequestDispatcher("/WEB-INF/jsp/staff/gdChiTietDon.jsp").forward(req, resp);
    }

    /**
     * View invoice details
     */
    private void viewInvoice(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int invoiceId = Integer.parseInt(req.getParameter("invoiceId"));

        Invoice invoice = invoiceDAO.findById(invoiceId);
        if (invoice == null) {
            req.setAttribute("error", "Hóa đơn không tồn tại");
            resp.sendRedirect(req.getContextPath() + "/report/customer-revenue");
            return;
        }

        // Get order details
        Order order = orderDAO.findById(invoice.getOrderId());
        List<OrderItem> items = orderDAO.findItems(invoice.getOrderId());
        Table table = null;
        if (order != null && order.getTableId() != null) {
            table = tableDAO.findById(order.getTableId());
        }

        req.setAttribute("invoice", invoice);
        req.setAttribute("order", order);
        req.setAttribute("items", items);
        req.setAttribute("table", table);

        req.getRequestDispatcher("/WEB-INF/jsp/staff/gdChiTietHD.jsp").forward(req, resp);
    }
}
