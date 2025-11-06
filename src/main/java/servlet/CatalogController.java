package servlet;

import dao.DishCatalogDAO;
import dao.MenuDAO;
import model.Menu;
import model.vm.DishCardVM;
import model.vm.DishDetailVM;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Controller for customer dish catalog browsing and search
 */
@WebServlet("/catalog")
public class CatalogController extends HttpServlet {
    private MenuDAO menuDAO = new MenuDAO();
    private DishCatalogDAO dishCatalogDAO = new DishCatalogDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "showMenuList";

        try {
            switch (action) {
                case "showMenuList":
                    showMenuList(req, resp);
                    break;
                case "searchForm":
                    searchForm(req, resp);
                    break;
                case "search":
                    search(req, resp);
                    break;
                case "viewDish":
                    viewDish(req, resp);
                    break;
                default:
                    showMenuList(req, resp);
            }
        } catch (Exception e) {
            throw new ServletException("Error in CatalogController: " + e.getMessage(), e);
        }
    }

    /**
     * Show list of active menus for customer to choose
     */
    private void showMenuList(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        List<Menu> menus = menuDAO.findActiveMenus();
        req.setAttribute("menus", menus);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/gdChonMenu.jsp").forward(req, resp);
    }

    /**
     * Show search form for selected menu
     */
    private void searchForm(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int menuId = Integer.parseInt(req.getParameter("menuId"));
        Menu menu = menuDAO.findById(menuId);

        if (menu == null) {
            req.setAttribute("error", "Menu không tồn tại");
            showMenuList(req, resp);
            return;
        }

        req.setAttribute("menu", menu);
        req.getRequestDispatcher("/WEB-INF/jsp/customer/gdTimMon.jsp").forward(req, resp);
    }

    /**
     * Search dishes by keyword with pagination
     */
    private void search(HttpServletRequest req, HttpServletResponse resp) throws Exception {
        int menuId = Integer.parseInt(req.getParameter("menuId"));
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

        // Get menu info
        Menu menu = menuDAO.findById(menuId);
        if (menu == null) {
            req.setAttribute("error", "Menu không tồn tại");
            showMenuList(req, resp);
            return;
        }

        // Search dishes
        List<DishCardVM> dishes = dishCatalogDAO.searchByMenu(menuId, keyword, page, pageSize, sort);
        int totalDishes = dishCatalogDAO.countByMenu(menuId, keyword);
        int totalPages = (int) Math.ceil((double) totalDishes / pageSize);

        req.setAttribute("menu", menu);
        req.setAttribute("dishes", dishes);
        req.setAttribute("keyword", keyword);
        req.setAttribute("currentPage", page);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("totalDishes", totalDishes);
        req.setAttribute("sort", sort);

        req.getRequestDispatcher("/WEB-INF/jsp/customer/gdKetQuaMon.jsp").forward(req, resp);
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
