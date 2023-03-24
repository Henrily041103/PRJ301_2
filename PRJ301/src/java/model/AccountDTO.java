/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author Admin
 */
public class AccountDTO {
    private String username;
    private String role;
    private String password;
    private String userID;
    private String email;
    private String phone;
    private String address;

    public AccountDTO() {
    }

    public AccountDTO(String username, String role, String password, String userID, String email, String phone, String address) {
        this.username = username;
        this.role = role;
        this.password = password;
        this.userID = userID;
        this.email = email;
        this.phone = phone;
        this.address = address;
    }

    public AccountDTO(String username, String role, String password, String userID) {
        this.username = username;
        this.role = role;
        this.password = password;
        this.userID = userID;
        this.email = null;
        this.phone = null;
        this.address = null;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
