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
        String action = (String) request.getAttribute("action");
        AccountDAO dao = new AccountDAO();
        HttpSession session = request.getSession();

        try {
            switch (action) {
                case "login-handler":
                    login(request, session, dao);
                    break;
                case "register-handler":
                    register(request, session, dao);
                    break;
                case "logout":
                    logout(request, session);
                    break;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error_message", "Something is wrong with the database.");
            request.setAttribute("controller", LOGIN_CONTROLLER);
            request.setAttribute("action", LOGIN);
        } finally {
            request.getRequestDispatcher(MAIN).forward(request, response);
        }
    }

    private void logout(HttpServletRequest request, HttpSession session) throws SQLException {
        session.invalidate();
        request.setAttribute("controller", LOGIN_CONTROLLER);
        request.setAttribute("action", LOGIN);
    }

    private void login(HttpServletRequest request, HttpSession session, AccountDAO dao)
            throws SQLException {
        String username = request.getParameter("user");
        String password = request.getParameter("pass");

        //TODO: check validity of password
        AccountDTO account = dao.login(username, password);

        if (account != null) {
            session.setAttribute("current_user", account);
            request.setAttribute("controller", SHOP_CONTROLLER);
            request.setAttribute("action", SHOP);
        } else {
            request.setAttribute("controller", LOGIN_CONTROLLER);
            request.setAttribute("action", LOGIN);
            request.setAttribute("error_message", "Wrong username or password!");
        }

    }

    private void register(HttpServletRequest request, HttpSession session, AccountDAO dao)
            throws SQLException {
        String username = request.getParameter("user");
        String password = request.getParameter("pass");
        String repass = request.getParameter("repass");
        String email = request.getParameter("email");
//        System.out.println(username);
//        System.out.println(password);
//        System.out.println(repass);
//        System.out.println(email);
        //TODO: check validity of password
        if (repass.equals(password)) {
            AccountDTO account = dao.register(username, password, email);
            if (account != null) {
                session.setAttribute("current_user", account);
                request.setAttribute("controller", SHOP_CONTROLLER);
                request.setAttribute("action", SHOP);
//                System.out.println("Action: "+SHOP);
            } else {
                request.setAttribute("controller", LOGIN_CONTROLLER);
                request.setAttribute("action", REGISTER);
                request.setAttribute("error_message", "An account with this email already exist.");
//                System.out.println("Action: "+REGISTER);
            }
        } else {
            System.out.println("b");
            request.setAttribute("controller", LOGIN_CONTROLLER);
            request.setAttribute("action", LOGIN);
            request.setAttribute("error_message", "Passwords don't match.");
//            System.out.println("Action: "+LOGIN);
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
