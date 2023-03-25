/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.AccountDAO;
import model.AccountDTO;
import utils.StringUtil;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        String controller = (String) request.getAttribute("action");
        String action = (String) request.getAttribute("action");
        AccountDAO dao = new AccountDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "login":
                case "register":
                    request.getRequestDispatcher(MAIN).forward(request, response);
                    break;
                case "login-handler":
                    login(request, response, session, dao);
                    break;
                case "register-handler":
                    register(request, response, session, dao);
                    break;
                case "logout":
                    logout(request, response, session);
                    break;
                default:
                    throw new ServletException();
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error_message", "Something is wrong with the database.");
            request.setAttribute("controller", LOGIN_CONTROLLER);
            request.setAttribute("action", LOGIN);
            request.getRequestDispatcher(MAIN).forward(request, response);
        } catch (ServletException | IOException ex) {
            ex.printStackTrace();
            throw ex;
        }
    }

    private void logout(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws SQLException, ServletException, IOException {
        session.setAttribute("current_user", null);
        response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
    }

    private void login(HttpServletRequest request, HttpServletResponse response, HttpSession session, AccountDAO dao)
            throws SQLException, ServletException, IOException {
        String username = request.getParameter("user");
        String password = StringUtil.hash(request.getParameter("pass") + username);

        //TODO: check validity of password
        AccountDTO account = dao.login(username, password);

        if (account != null) {
            session.setAttribute("current_user", account);
            response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
        } else {
            request.setAttribute("error_message", "Wrong username or password!");
            request.setAttribute("controller", LOGIN_CONTROLLER);
            request.setAttribute("action", LOGIN);
            request.getRequestDispatcher(MAIN).forward(request, response);
        }

    }

    private void register(HttpServletRequest request, HttpServletResponse response, HttpSession session, AccountDAO dao)
            throws SQLException, ServletException, IOException {
        String username = request.getParameter("user");
        String password = StringUtil.hash(request.getParameter("pass") + username);
        String repass = StringUtil.hash(request.getParameter("repass") + username);
        String email = request.getParameter("email");

        if (repass.equals(password)) {
            AccountDTO account = dao.register(username, password, email);
            if (account != null) {
                session.setAttribute("current_user", account);
                response.sendRedirect(request.getContextPath() + "/" + SHOP_CONTROLLER + "/" + SHOP + ".do");
            } else {
                request.setAttribute("error_message", "An account with this email already exist.");
                request.setAttribute("controller", LOGIN_CONTROLLER);
                request.setAttribute("action", LOGIN);
                request.getRequestDispatcher(MAIN).forward(request, response);
            }
        } else {
            request.setAttribute("error_message", "Passwords don't match.");
            request.setAttribute("controller", LOGIN_CONTROLLER);
            request.setAttribute("action", LOGIN);
            request.getRequestDispatcher(MAIN).forward(request, response);
        }
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
