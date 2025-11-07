package servlet;

import dao.DishCatalogDAO;
import model.vm.DishCardVM;
import model.vm.DishDetailVM;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Controller for customer dish catalog browsing and search
 */
@WebServlet("/catalog")
public class CatalogController extends HttpServlet {
    private DishCatalogDAO dishCatalogDAO = new DishCatalogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "showAllDishes";

        try {
            switch (action) {
                case "showAllDishes":
                    showAllDishes(req, resp);
                    break;
                case "search":
                    search(req, resp);
                    break;
                case "viewDish":
                    viewDish(req, resp);
                    break;
                default:
                    showAllDishes(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException("Error in CatalogController: " + e.getMessage(), e);
        }
    }

    /**
     * Show all active dishes with search form (default landing page)
     */
    private void showAllDishes(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String keyword = "";
        int page = 1;
        int pageSize = 12;
        String sort = "name_asc";

        // Search all active dishes
        List<DishCardVM> dishes = dishCatalogDAO.searchAllDishes(keyword, page, pageSize, sort);
        int totalDishes = dishCatalogDAO.countAllDishes(keyword);
        int totalPages = (int) Math.ceil((double) totalDishes / pageSize);

        req.setAttribute("dishes", dishes);
        req.setAttribute("keyword", keyword);
        req.setAttribute("currentPage", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalDishes", totalDishes);
        req.setAttribute("sort", sort);

        req.getRequestDispatcher("/WEB-INF/jsp/customer/gdDanhSachMon.jsp").forward(req, resp);
    }

    /**
     * Search dishes by keyword with pagination (search all dishes, not by menu)
     */
    private void search(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        String keyword = req.getParameter("q");
        if (keyword == null) keyword = "";

        // Pagination parameters
        int page = 1;
        String pageStr = req.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int pageSize = 12;
        String sizeStr = req.getParameter("size");
        if (sizeStr != null && !sizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(sizeStr);
            } catch (NumberFormatException e) {
                pageSize = 12;
            }
        }

        // Sorting
        String sort = req.getParameter("sort");
        if (sort == null || sort.isEmpty()) {
            sort = "name_asc";
        }

        // Search all dishes
        List<DishCardVM> dishes = dishCatalogDAO.searchAllDishes(keyword, page, pageSize, sort);
        int totalDishes = dishCatalogDAO.countAllDishes(keyword);
        int totalPages = (int) Math.ceil((double) totalDishes / pageSize);

        req.setAttribute("dishes", dishes);
        req.setAttribute("keyword", keyword);
        req.setAttribute("currentPage", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalDishes", totalDishes);
        req.setAttribute("sort", sort);

        req.getRequestDispatcher("/WEB-INF/jsp/customer/gdDanhSachMon.jsp").forward(req, resp);
    }

    /**
     * View dish details
     */
    private void viewDish(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int dishId = Integer.parseInt(req.getParameter("dishId"));

        DishDetailVM dish = dishCatalogDAO.findDishById(dishId);
        if (dish == null) {
            req.setAttribute("error", "Món ăn không tồn tại");
            resp.sendRedirect(req.getContextPath() + "/catalog");
            return;
        }

        req.setAttribute("dish", dish);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/gdChiTietMon.jsp").forward(req, resp);
    }
}
