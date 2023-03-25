/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.OrderDAO;
import model.ProductDAO;
import model.ProductDTO;

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
        ProductDAO dao = new ProductDAO();
        OrderDAO odao = new OrderDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "shop":
                    shop(request, response, dao);
                    request.getRequestDispatcher(MAIN).forward(request, response);
                    break;
                case "product":
                    product(request, response, dao);
                    break;
                case "revenue":
                    revenue(session, odao);
                    request.getRequestDispatcher(MAIN).forward(request, response);
                    break;
                case "revenue-handler":
                    revenueHandler(request, response, odao);
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

    private void shop(HttpServletRequest request, HttpServletResponse response, ProductDAO dao)
            throws SQLException, ServletException, IOException {
        int pageNum = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));

        String name = request.getParameter("name") == null ? "" : request.getParameter("name");
        String brand = request.getParameter("brand") == null ? "" : request.getParameter("brand");
        String type = request.getParameter("type") == null ? "" : request.getParameter("type");
        String size = request.getParameter("size") == null ? "" : request.getParameter("size");
        String color = request.getParameter("color") == null ? "" : request.getParameter("color");
        String max = request.getParameter("max") == null ? "12" : request.getParameter("max");
        String min = request.getParameter("min") == null ? "0" : request.getParameter("min");
        double price = request.getParameter("price") == null ? 10000 : Double.parseDouble(request.getParameter("price"));
        double sale = request.getParameter("sale") == null ? 0 : Double.parseDouble(request.getParameter("sale"));

        ProductDTO selector = new ProductDTO("", brand, type, price, sale, 0, "", size, color, name);

        List<ProductDTO> list1 = dao.select(selector, max, min);
        int numOfPage = (int) Math.ceil(list1.size() / 8.0);
        int start = (pageNum - 1) * 8 < list1.size() - 1 ? (pageNum - 1) * 8 : list1.size() - 1;
        int stop = pageNum * 8 < list1.size() - 1 ? pageNum * 8 : list1.size() - 1;
        List<ProductDTO> list = list1.subList(start, stop);

        request.setAttribute("numOfPage", numOfPage);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);
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

    private void revenue(HttpSession session, OrderDAO dao)
            throws SQLException, ServletException, IOException {
        if (session.getAttribute("brand_list") == null) {
            List<String> brandList = dao.getOrderBrands();
            session.setAttribute("brand_list", brandList);
        }
        if (session.getAttribute("year_list") == null) {
            List<Integer> yearList = dao.getOrderYears();
            session.setAttribute("year_list", yearList);
        }
    }

    private void revenueHandler(HttpServletRequest request, HttpServletResponse response, OrderDAO dao)
            throws SQLException, ServletException, IOException {
        String brand = request.getParameter("brand");
        String year = request.getParameter("year");
        int q1 = dao.revenue(brand, Date.valueOf(year + "-05-01"), Date.valueOf(year + "-01-01"));
        int q2 = dao.revenue(brand, Date.valueOf(year + "-09-01"), Date.valueOf(year + "-05-01"));
        int q3 = dao.revenue(brand, Date.valueOf(year + "-12-31"), Date.valueOf(year + "-09-01"));
//        System.out.println("q1: " + q1);
//        System.out.println("q2: " + q2);
//        System.out.println("q3: " + q3);

        request.setAttribute("q1", q1);
        request.setAttribute("q2", q2);
        request.setAttribute("q3", q3);
        request.setAttribute("handle", true);
        request.setAttribute("controller", SHOP_CONTROLLER);
        request.setAttribute("action", REVENUE);
        request.getRequestDispatcher(MAIN).forward(request, response);
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

}
