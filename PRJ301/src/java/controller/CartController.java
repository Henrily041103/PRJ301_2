/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.OrderDAO;
import model.ProductDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import model.AccountDTO;
import model.ProductDTO;
import model.OrderDTO;
import utils.StringUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CartController", urlPatterns = {"/cart"})
public class CartController extends HttpServlet {

    private static final String MAIN = "/WEB-INF/layouts/main.jsp";
    private static final String SHOP_CONTROLLER = "shop";
    private static final String SHOP = "shop";
    private static final String LOGIN_CONTROLLER = "login";
    private static final String LOGIN = "login";
    private static final String CART_CONTROLLER = "cart";
    private static final String CART = "cart";
    private static final String RECEIPT = "receipt";

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
        OrderDAO odao = new OrderDAO();
        ProductDAO pdao = new ProductDAO();
        HttpSession session = request.getSession();
        HashMap<ProductDTO, Integer> cart = session.getAttribute("cart") == null ? new HashMap() : (HashMap<ProductDTO, Integer>) session.getAttribute("cart");
        //key: product - value: amount
        String action = (String) request.getAttribute("action");

        try {
            switch (action) {
                case "add":
                    add(request, response, cart, session, pdao);
                    response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
                    break;
                case "cart":
                    request.setAttribute("controller", CART_CONTROLLER);
                    request.setAttribute("action", CART);
                    request.getRequestDispatcher(MAIN).forward(request, response);
                    break;

                case "buy_handler": //Luu thong tin vao db
                    String op = request.getParameter("op");
                    switch (op) {
                        case "remove":
                            remove(request, response, cart, session, pdao);
                            response.sendRedirect(request.getContextPath() + "/" + CART_CONTROLLER + "/" + CART + ".do");
                            break;
                        case "empty":
                            session.removeAttribute("cart");
                            response.sendRedirect(request.getContextPath() + "/" + CART_CONTROLLER + "/" + CART + ".do");
                            break;
                        case "back":
                            //Trở về trang chính shop
                            response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
                            break;
                        case "buy":
                            buy(request, response, cart, session, pdao, odao);

                            break;
                        case "add":
                            changeAmount(request, response, cart, session, pdao, 1);
                            response.sendRedirect(request.getContextPath() + "/" + CART_CONTROLLER + "/" + CART + ".do");
                            break;
                        case "sub":
                            changeAmount(request, response, cart, session, pdao, -1);
                            response.sendRedirect(request.getContextPath() + "/" + CART_CONTROLLER + "/" + CART + ".do");
                            break;
                        default:
                            throw new ServletException();
                    }
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

    public void add(HttpServletRequest request, HttpServletResponse response,
            HashMap<ProductDTO, Integer> cart, HttpSession session, ProductDAO pdao)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("proId");
        int amount = request.getParameter("amount") != null ? Integer.parseInt(request.getParameter("amount")) : 1;
        ProductDTO prod = pdao.read(id);
        //check for existing product
        if (cart.containsKey(prod)) {
            if (cart.get(prod) < pdao.read(id).getStock()) {
                //if exist +1 to amount
                int newAmount = cart.get(prod) + amount;
                cart.put(prod, newAmount);
            } else {
                request.setAttribute("error_message", "out of stock");
            }
        } else {
            //if not add new product
            if (pdao.read(id).getStock() > 0) {
                cart.put(prod, 1);
            } else {
                request.setAttribute("error_message", "out of stock");
            }
        }
        session.setAttribute("cart", cart);
    }

    public void buy(HttpServletRequest request, HttpServletResponse response,
            HashMap<ProductDTO, Integer> cart, HttpSession session, ProductDAO pdao, OrderDAO odao)
            throws SQLException, ServletException, IOException {
        if (cart.size() > 0) {
            pdao.lowerStock(cart); //stock amount - cart amount
            long millis = System.currentTimeMillis();
            Date today = new Date(millis);
            List<OrderDTO> orders = new ArrayList();

            for (ProductDTO prod : cart.keySet()) {
                OrderDTO order = new OrderDTO(StringUtil.getAlphaNumericString(9), prod.getProID(),
                        ((AccountDTO) session.getAttribute("current_user")).getUserID(), cart.get(prod), today);
                odao.create(order);
                orders.add(order);
            }
            session.removeAttribute("cart");
            request.setAttribute("orders", orders);
            request.setAttribute("controller", CART_CONTROLLER);
            request.setAttribute("action", RECEIPT);
            request.getRequestDispatcher(MAIN).forward(request, response);
        } else {
            request.setAttribute("controller", SHOP_CONTROLLER);
            request.setAttribute("action", SHOP);
        }
    }

    private void changeAmount(HttpServletRequest request, HttpServletResponse response,
            HashMap<ProductDTO, Integer> cart, HttpSession session, ProductDAO pdao, int amount)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("proId");
        ProductDTO prod = pdao.read(id);
        cart.put(prod, cart.get(prod) + amount);
        if (cart.get(pdao.read(id)) <= 0) {
            cart.remove(prod);
        }
        session.setAttribute("cart", cart);
    }

    public void remove(HttpServletRequest request, HttpServletResponse response,
            HashMap<ProductDTO, Integer> cart, HttpSession session, ProductDAO pdao)
            throws ServletException, IOException, SQLException {
        String id = request.getParameter("proId");
        cart.remove(pdao.read(id));
        session.setAttribute("cart", cart);
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
