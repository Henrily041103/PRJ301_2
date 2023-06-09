/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 *
 * @author Admin
 */
public class ProductDTO {
    private String name;
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

    public ProductDTO(String proID, String proBrand, String proType, double price, double sale, int stock, String ageGroup, String size, String color, String name) {
        this.proID = proID;
        this.proBrand = proBrand;
        this.proType = proType;
        this.price = price;
        this.sale = sale;
        this.stock = stock;
        this.ageGroup = ageGroup;
        this.size = size;
        this.color = color;
        this.name = name;
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
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public String getDisplay() {
        switch (ageGroup) {
            case "2":
                return "3-6";
            case "3":
                return "6-9";
            case "4":
                return "9-12";
            default:
                return "0-3";
        }
    }
    
    public String toData(String max, String min) {
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

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final ProductDTO other = (ProductDTO) obj;
        return Objects.equals(this.proID, other.proID);
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 23 * hash + Objects.hashCode(this.name);
        hash = 23 * hash + Objects.hashCode(this.proID);
        hash = 23 * hash + Objects.hashCode(this.proBrand);
        hash = 23 * hash + Objects.hashCode(this.proType);
        hash = 23 * hash + (int) (Double.doubleToLongBits(this.price) ^ (Double.doubleToLongBits(this.price) >>> 32));
        hash = 23 * hash + (int) (Double.doubleToLongBits(this.sale) ^ (Double.doubleToLongBits(this.sale) >>> 32));
        hash = 23 * hash + this.stock;
        hash = 23 * hash + Objects.hashCode(this.ageGroup);
        hash = 23 * hash + Objects.hashCode(this.size);
        hash = 23 * hash + Objects.hashCode(this.color);
        return hash;
    }
    
    
}