/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ProductDTO {
    private String proID;
    private String proBrand;
    private String proType;
    private double price;
    private double sale;
    private int stock;
    private String ageGroup;
    private String size;
    private String color;

    public ProductDTO() {
    }

    public ProductDTO(String proID, String proBrand, String proType, double price, double sale, int stock, String ageGroup, String size, String color) {
        this.proID = proID;
        this.proBrand = proBrand;
        this.proType = proType;
        this.price = price;
        this.sale = sale;
        this.stock = stock;
        this.ageGroup = ageGroup;
        this.size = size;
        this.color = color;
    }

    public String getProID() {
        return proID;
    }

    public void setProID(String proID) {
        this.proID = proID;
    }

    public String getProBrand() {
        return proBrand;
    }

    public void setProBrand(String proBrand) {
        this.proBrand = proBrand;
    }

    public String getProType() {
        return proType;
    }

    public void setProType(String proType) {
        this.proType = proType;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSale() {
        return sale;
    }

    public void setSale(double sale) {
        this.sale = sale;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(String ageGroup) {
        this.ageGroup = ageGroup;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }
    
    public String getImage() {
        return proID + ".jpg";
    }
    
    public String getName() {
        return proType + " " + proBrand;
    }

    @Override
    public String toString() {
        return "ProductDTO{" + "proID=" + proID + ", proBrand=" + proBrand + ", proType=" + proType + ", price=" + price + ", sale=" + sale + ", stock=" + stock + ", ageGroup=" + ageGroup + ", size=" + size + ", color=" + color + '}';
    }
    
    public String getDisplay() {
        switch (ageGroup) {
            case "1":
                return "0 3";
            case "2":
                return "3 6";
            case "3":
                return "6 9";
            case "4":
                return "9 12";
            default:
                return "0 3";
        }
    }
    
    public static String toData(String max, String min) {
        int maxNum = Integer.parseInt(max);
        int minNum = Integer.parseInt(min);
        List<String> rangeList = new ArrayList();
        if (minNum <= 3 && maxNum >= 0) {
            rangeList.add("1");
        }
        if (minNum <= 6 && maxNum >= 3) {
            rangeList.add("2");
        }
        if (minNum <= 9 && maxNum >= 6) {
            rangeList.add("3");
        }
        if (minNum <= 12 && maxNum >= 9) {
            rangeList.add("4");
        }
        String result = "(";
        
        for (int i = 0; i < rangeList.size();i++) {
            result += rangeList.get(i);
            if (i < rangeList.size()-1) result += ",";
        }
        result += ")";
        return result;
    }
}