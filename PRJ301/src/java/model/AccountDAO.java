/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class AccountDAO {

    private static final String REGISTER = "SELECT * FROM tblUser WHERE Email like ?";
    private static final String LOGIN = "SELECT userId, role, Email, Phone, UserAddress FROM tblUser WHERE username = ? AND password = ?";

    private static final String READ = "SELECT * FROM tblUser WHERE UserID like ?";
    private static final String DELETE = "DELETE FROM tblUser WHERE UserID = ?";
    private static final String UPDATE = "UPDATE tblUser SET username=?, password=?, Email=?, Phone=?, UserAddress=? WHERE userID = ?";
    private static final String INSERT = "INSERT INTO tblUser(userID, username, password, role, Email, Phone, UserAddress) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT = "SELECT * FROM tblUser";

    public List<AccountDTO> select() throws SQLException {
        Connection con = DBUtils.getConnection();
        List<AccountDTO> accounts = null;
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(SELECT);

        while (rs.next()) {
            if (accounts == null) {
                accounts = new ArrayList();
            }
            AccountDTO account = new AccountDTO();
            account.setUserID(rs.getString("UserID"));
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRole(rs.getString("role"));
            account.setEmail(rs.getString("Email"));
            account.setPhone(rs.getString("Phone"));
            account.setAddress(rs.getString("UserAddress"));
            accounts.add(account);
        }

        rs.close();
        stm.close();
        con.close();

        return accounts;
    }

    public AccountDTO read(String userID) throws SQLException {
        Connection con = DBUtils.getConnection();
        AccountDTO account = null;
        PreparedStatement stm = con.prepareStatement(READ);
        stm.setString(1, userID);
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            account = new AccountDTO();
            account.setUserID(userID);
            account.setUsername(rs.getString("username"));
            account.setPassword(rs.getString("password"));
            account.setRole(rs.getString("role"));
            account.setEmail(rs.getString("Email"));
            account.setPhone(rs.getString("Phone"));
            account.setAddress(rs.getString("UserAddress"));
        }

        rs.close();
        stm.close();
        con.close();

        return account;
    }

    public int update(AccountDTO account) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(UPDATE);
        stm.setString(1, account.getUsername());
        stm.setString(2, account.getPassword());
        stm.setString(3, account.getEmail());
        stm.setString(4, account.getPhone());
        stm.setString(5, account.getAddress());
        stm.setString(6, account.getUserID());

        int count = stm.executeUpdate();
        stm.close();
        con.close();

        return count;
    }

    public int create(AccountDTO account) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(INSERT);
        stm.setString(1, account.getUserID());
        stm.setString(2, account.getUsername());
        stm.setString(3, account.getPassword());
        stm.setString(4, account.getRole());
        stm.setString(5, account.getEmail());
        stm.setString(6, account.getPhone());
        stm.setString(7, account.getAddress());

        int count = stm.executeUpdate();
        stm.close();
        con.close();

        return count;
    }

    public int delete(String userID) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(DELETE);
        stm.setString(1, userID);
        int count = stm.executeUpdate();
        stm.close();
        con.close();

        return count;
    }

    public AccountDTO login(String username, String password) throws SQLException {
        Connection con = DBUtils.getConnection();
        AccountDTO account = null;
        PreparedStatement stm = con.prepareStatement(LOGIN);
        stm.setString(1, username);
        stm.setString(2, password);
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            account = new AccountDTO();
            account.setUserID(rs.getString("UserID"));
            account.setUsername(username);
            account.setPassword(password);
            account.setRole(rs.getString("role"));
        }

        rs.close();
        stm.close();
        con.close();

        return account;
    }

    public AccountDTO register(String username, String password, String email) throws SQLException {
        Connection con = DBUtils.getConnection();
        AccountDTO account = null;
        PreparedStatement stm = con.prepareStatement(REGISTER);
        stm.setString(1, email);
        ResultSet rs = stm.executeQuery();
        if (!rs.next()) {
            
            account = new AccountDTO();
            account.setUserID(username.substring(0, Math.min(10, username.length())));
            account.setUsername(username);
            account.setPassword(password);
            account.setRole("us");
            account.setEmail(email);
            create(account);
        }
        rs.close();
        stm.close();
        con.close();

        return account;
    }
}
