/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Connection;
import java.sql.Date;
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
public class OrderDAO {
    private static final String REVENUE = "select Totals.ProBrand, sum(Totals.Total) as TotalAll from (select OrderID, tblOrder.ProID, ProBrand, BillDate, (Price*(100-Sale)*0.01*Amount) as Total from tblOrder left outer join Product on tblOrder.ProID = Product.ProID where BillDate between ? and ?) as Totals group by ProBrand having Totals.ProBrand like ?";
    private static final String BRAND = "select distinct ProBrand from tblOrder left outer join Product on tblOrder.ProID = Product.ProID ";
    private static final String YEAR = "select distinct datepart(yyyy, BillDate) as year from tblOrder ";
    
    private static final String SELECT = "select * from tblOrder";
    private static final String READ = "select * from tblOrder where OrderID = ?";
    private static final String INSERT = "INSERT INTO BabyStore.dbo.tblOrder(OrderID, UserID, ProID, Amount, BillDate) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String DELETE = "DELETE FROM BabyStore.dbo.tblOrder WHERE OrderID = ?";
    private static final String UPDATE = "UPDATE BabyStore.dbo.tblOrder SET UserID=?, ProID=?, Amount=?, BillDate=? WHERE OrderID = ?";
    
    
    public List<OrderDTO> select() throws SQLException {
        Connection con = DBUtils.getConnection();
        List<OrderDTO> orders = null;
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(SELECT);

        while (rs.next()) {
            if (orders == null) {
                orders = new ArrayList();
            }
            OrderDTO order = new OrderDTO();
            order.setUserID(rs.getString("UserID"));
            order.setProID(rs.getString("ProID"));
            order.setOrderID(rs.getString("OrderID"));
            order.setAmount(rs.getInt("Amount"));
            order.setBillDate(rs.getDate("BillDate"));
            orders.add(order);
        }

        rs.close();
        stm.close();
        con.close();

        return orders;
    }
    
    public OrderDTO read(String id) throws SQLException {
        Connection con = DBUtils.getConnection();
        OrderDTO order = null;
        PreparedStatement stm = con.prepareStatement(READ);
        stm.setString(1, id);
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            order = new OrderDTO();
            order.setUserID(rs.getString("UserID"));
            order.setProID(rs.getString("ProID"));
            order.setOrderID(rs.getString("OrderID"));
            order.setAmount(rs.getInt("Amount"));
            order.setBillDate(rs.getDate("BillDate"));
        }

        rs.close();
        stm.close();
        con.close();

        return order;
    }
    
    public int create(OrderDTO order) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(INSERT);
        
        stm.setString(1, order.getOrderID());
        stm.setString(2, order.getUserID());
        stm.setString(3, order.getProID());
        stm.setInt(4, order.getAmount());
        stm.setDate(5, order.getBillDate());
        int count = stm.executeUpdate();
        
        stm.close();
        con.close();

        return count;
    }
    public int update(OrderDTO order) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(UPDATE);
        
        stm.setString(1, order.getUserID());
        stm.setString(2, order.getProID());
        stm.setInt(3, order.getAmount());
        stm.setDate(4, order.getBillDate());
        stm.setString(5, order.getOrderID());
        int count = stm.executeUpdate();
        
        stm.close();
        con.close();

        return count;
    }
    
    public int delete(String id) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(DELETE);
        
        stm.setString(1, id);
        int count = stm.executeUpdate();
        
        stm.close();
        con.close();

        return count;
    }
    
    public int revenue(String brand, Date to, Date from) throws SQLException {
        Connection con = DBUtils.getConnection();
        PreparedStatement stm = con.prepareStatement(REVENUE);
        stm.setDate(1, from);
        stm.setDate(2, to);
        stm.setString(3, "%"+brand+"%");
        ResultSet rs = stm.executeQuery();
        int result = 0;
        
        if (rs.next()) {
            result = (int)rs.getDouble("TotalAll");
        }
        return result;
    }
    
    public List<String> getOrderBrands() throws SQLException {
        Connection con = DBUtils.getConnection();
        List<String> brands = null;
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(BRAND);

        while (rs.next()) {
            if (brands == null) {
                brands = new ArrayList();
            }
            brands.add(rs.getString("ProBrand"));
        }

        rs.close();
        stm.close();
        con.close();

        return brands;
    }
    public List<Integer> getOrderYears() throws SQLException {
        Connection con = DBUtils.getConnection();
        List<Integer> years = null;
        Statement stm = con.createStatement();
        ResultSet rs = stm.executeQuery(YEAR);

        while (rs.next()) {
            if (years == null) {
                years = new ArrayList();
            }
            years.add(rs.getInt("year"));
        }

        rs.close();
        stm.close();
        con.close();

        return years;
    }
}
