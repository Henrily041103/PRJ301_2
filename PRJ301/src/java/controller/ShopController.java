/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
    private static final String LOGIN_CONTROLLER = "login";
    private static final String LOGIN = "login";
    private static final String REGISTER = "register";

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
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "shop":
                    shop(request, response, dao);
                    break;
                case "product":
                    product(request, response, dao);
                    break;
                case "revenue":
                    revenue(request, response, dao);
                    break;
                case "revenue-handler":
                    request.getRequestDispatcher(MAIN).forward(request, response);
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
        String nameList[] = name.split(" của hãng ", 2);
        String brand = "", type = "";
        if (nameList.length == 2) {
            type = nameList[0];
            brand = nameList[1];
        }
        String size = request.getParameter("size") == null ? "" : request.getParameter("size");
        String color = request.getParameter("color") == null ? "" : request.getParameter("color");
        String max = request.getParameter("max") == null ? "12" : request.getParameter("max");
        String min = request.getParameter("min") == null ? "0" : request.getParameter("min");
        double price = request.getParameter("price") == null ? 10000 : Double.parseDouble(request.getParameter("price"));
        double sale = request.getParameter("sale") == null ? 0 : Double.parseDouble(request.getParameter("sale"));

        ProductDTO selector = new ProductDTO("", brand, type, price, sale, 0, "", size, color);

        List<ProductDTO> list1 = dao.select(selector, max, min);
        int numOfPage = (int)Math.ceil(list1.size()/8.0);
        int start = (pageNum - 1) * 8 < list1.size() - 1 ? (pageNum - 1) * 8 : list1.size() - 1;
        int stop = pageNum * 8 < list1.size() - 1 ? pageNum * 8 : list1.size() - 1;
        List<ProductDTO> list = list1.subList(start, stop);
        
        request.setAttribute("numOfPage", numOfPage);
        request.setAttribute("pageNum", pageNum);
        request.setAttribute("list", list);
        request.getRequestDispatcher(MAIN).forward(request, response);
    }

    private void product(HttpServletRequest request, HttpServletResponse response, ProductDAO dao) 
            throws SQLException, ServletException, IOException {
        String id = request.getParameter("id");
        
        ProductDTO product = dao.read(id);
        
        if (product==null) {
            response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
        }
    }

    private void revenue(HttpServletRequest request, HttpServletResponse response, ProductDAO dao) throws SQLException, ServletException, IOException {
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
