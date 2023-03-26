/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.AccountDAO;
import model.AccountDTO;
import model.OrderDAO;
import model.OrderDTO;
import model.ProductDAO;
import model.ProductDTO;
import utils.StringUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ShopController", urlPatterns = {"/shop"})
public class ShopController extends HttpServlet {

    private static final String MAIN = "/WEB-INF/layouts/main.jsp";
    private static final String SHOP_CONTROLLER = "shop";
    private static final String SHOP = "shop";
    private static final String REVENUE = "revenue";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = (String) request.getAttribute("action");
        ProductDAO pdao = new ProductDAO();
        AccountDAO adao = new AccountDAO();
        OrderDAO odao = new OrderDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "shop":
                    shop(request, response, session, pdao);
                    break;
                case "product":
                    product(request, response, pdao);
                    break;
                case "user":
                    user(request, response, adao, odao);
                    break;
                case "revenue":
                    revenue(request, response, session, odao);
                    break;
                case "revenue-handler":
                    revenueHandler(request, response, odao);
                    break;
                case "edit":
                    edit(request, response, pdao);
                    break;
                case "create":
                    create(request, response, pdao);
                    break;
                    
                default:
                    throw new ServletException();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error_message", "Something is wrong.");
            request.setAttribute("controller", SHOP_CONTROLLER);
            request.setAttribute("action", SHOP);
            request.getRequestDispatcher(MAIN).forward(request, response);
        } catch (ServletException | IOException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    private void shop(HttpServletRequest request, HttpServletResponse response, HttpSession session, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        //get current page
        int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

        //display unstocked items?
        int stock = 0;
        AccountDTO currentUser = (AccountDTO) session.getAttribute("current_user");
        if (currentUser != null && "us".equals(currentUser.getRole())) {
            stock = -1;
        }

        //search and sort
        List<ProductDTO> list1 = null;
        String search = "", sort = "";
        StringBuilder searchTerm = new StringBuilder();
        if (request.getParameter("search") != null && !"".equals(request.getParameter("search").trim())) {
            search = request.getParameter("search");
            searchTerm.append("&search=").append(search);
            System.out.println(search);
            list1 = dao.select("%" + search + "%", stock);
        }
        if (request.getParameter("sort") != null && !"none".equals(request.getParameter("sort"))) {
            sort = request.getParameter("sort");
            searchTerm.append("&sort=").append(sort);
            System.out.println(sort);
            list1 = dao.select("%" + search + "%", stock, sort);
        } else {
            list1 = dao.select("%" + search + "%", stock);
        }
        //initiate rest of pagination
        int numOfPage = (int) Math.ceil(list1.size() / 8.0);
        int start = (pageNum - 1) * 8 < list1.size() ? (pageNum - 1) * 8 : list1.size();
        int stop = pageNum * 8 < list1.size() ? pageNum * 8 : list1.size();
        List<ProductDTO> list = list1.subList(start, stop);

        //send
        request.setAttribute("search_term", searchTerm.toString());
        request.setAttribute("search", search);
        request.setAttribute("sort", sort);

        request.setAttribute("numOfPage", numOfPage);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);
        request.getRequestDispatcher(MAIN).forward(request, response);
    }

    private void product(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");

        ProductDTO product = dao.read(id);

        if (product == null) {
            request.setAttribute("error_message", "Something is wrong.");
            response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
        } else {
            request.setAttribute("product", product);
            request.getRequestDispatcher(MAIN).forward(request, response);
        }
    }

    private void user(HttpServletRequest request, HttpServletResponse response, AccountDAO adao, OrderDAO odao)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");

        AccountDTO account = adao.read(id);
//        List<OrderDTO> orders = odao.getUserOrder(id);
        HashMap<OrderDTO, ProductDTO> orders = odao.getUserOrder(id);

        if (account == null || orders == null) {
            request.setAttribute("error_message", "Something is wrong.");
            response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
        } else {
            int total = 0;
            for (OrderDTO order : orders.keySet()) {
                total += order.getAmount() * orders.get(order).getPrice() * (100 - orders.get(order).getSale()) * 0.01;
            }
            request.setAttribute("total", total);
            request.setAttribute("account", account);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher(MAIN).forward(request, response);
        }
    }

    private void revenue(HttpServletRequest request, HttpServletResponse response, HttpSession session, OrderDAO dao)
            throws SQLException, ServletException, IOException {
        if (session.getAttribute("brand_list") == null) {
            List<String> brandList = dao.getOrderBrands();
            session.setAttribute("brand_list", brandList);
        }
        if (session.getAttribute("year_list") == null) {
            List<Integer> yearList = dao.getOrderYears();
            session.setAttribute("year_list", yearList);
        }
        request.getRequestDispatcher(MAIN).forward(request, response);
    }

    private void revenueHandler(HttpServletRequest request, HttpServletResponse response, OrderDAO dao)
            throws SQLException, ServletException, IOException {
        String brand = request.getParameter("brand");
        String year = request.getParameter("year");
        int q1 = dao.revenue(brand, Date.valueOf(year + "-05-01"), Date.valueOf(year + "-01-01"));
        int q2 = dao.revenue(brand, Date.valueOf(year + "-09-01"), Date.valueOf(year + "-05-01"));
        int q3 = dao.revenue(brand, Date.valueOf(year + "-12-31"), Date.valueOf(year + "-09-01"));

        request.setAttribute("q1", q1);
        request.setAttribute("q2", q2);
        request.setAttribute("q3", q3);
        request.setAttribute("handle", true);
        request.setAttribute("controller", SHOP_CONTROLLER);
        request.setAttribute("action", REVENUE);
        request.getRequestDispatcher(MAIN).forward(request, response);
    }

    private void edit(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");

        ProductDTO currentProduct = dao.read(id);
        if (currentProduct == null) {
            request.setAttribute("error_message", "Product does not exist.");
            request.setAttribute("controller", SHOP_CONTROLLER);
            request.setAttribute("action", SHOP);
            request.getRequestDispatcher(MAIN).forward(request, response);
        } else {
            String name = request.getParameter("name") == null ? currentProduct.getName() : request.getParameter("name");
            String brand = request.getParameter("brand") == null ? currentProduct.getProBrand() : request.getParameter("brand");
            String type = request.getParameter("type") == null ? currentProduct.getProType() : request.getParameter("type");
            String size = request.getParameter("size") == null ? currentProduct.getSize() : request.getParameter("size");
            String color = request.getParameter("color") == null ? currentProduct.getColor() : request.getParameter("color");
            String ageGroup = request.getParameter("ageRange") == null ? currentProduct.getAgeGroup() : request.getParameter("ageRange");
            double price = request.getParameter("price") == null ? currentProduct.getPrice() : Double.parseDouble(request.getParameter("price"));
            double sale = request.getParameter("sale") == null ? currentProduct.getSale() : Double.parseDouble(request.getParameter("sale"));
            int stock = request.getParameter("stock") == null ? currentProduct.getStock() : Integer.parseInt(request.getParameter("sale"));

            ProductDTO newProduct = new ProductDTO(id, brand, type, price, sale, stock, ageGroup, size, color, name);
            dao.update(newProduct);
            response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
        }

    }

    private void create(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String brand = request.getParameter("brand");
        String type = request.getParameter("type");
        String size = request.getParameter("size");
        String color = request.getParameter("color");
        String ageGroup = request.getParameter("ageRange");
        double price = Double.parseDouble(request.getParameter("price"));
        double sale = Double.parseDouble(request.getParameter("sale"));
        int stock = Integer.parseInt(request.getParameter("stock"));

        ProductDTO newProduct = new ProductDTO(id, brand, type, price, sale, stock, ageGroup, size, color, name);
        dao.create(newProduct);
        response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    public String toUTF8(String isoString) {
        String utf8String = null;
        try {
            byte[] stringBytesISO = isoString.getBytes("ISO-8859-1");
            utf8String = new String(stringBytesISO, "UTF-8");
        } catch (Exception e) {
            System.out.println("UnsupportedEncodingException is: " + e.getMessage());
            utf8String = isoString;
        }
        return utf8String;
    }
}
