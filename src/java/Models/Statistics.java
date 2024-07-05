/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Thang Tai
 */

public class Statistics {
    private int productCount;
    private int totalQuantity;
    private double avgPrice;
    private double revenueToday;
    private double revenueThisWeek;
    private double revenueThisMonth;
    private double revenueThisYear;

    // Constructor
    public Statistics() {
        // Initialize default values
        this.productCount = 0;
        this.totalQuantity = 0;
        this.avgPrice = 0.0;
        this.revenueToday = 0.0;
        this.revenueThisWeek = 0.0;
        this.revenueThisMonth = 0.0;
        this.revenueThisYear = 0.0;
    }

    // Getters and setters
    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public double getAvgPrice() {
        return avgPrice;
    }

    public void setAvgPrice(double avgPrice) {
        this.avgPrice = avgPrice;
    }

    public double getRevenueToday() {
        return revenueToday;
    }

    public void setRevenueToday(double revenueToday) {
        this.revenueToday = revenueToday;
    }

    public double getRevenueThisWeek() {
        return revenueThisWeek;
    }

    public void setRevenueThisWeek(double revenueThisWeek) {
        this.revenueThisWeek = revenueThisWeek;
    }

    public double getRevenueThisMonth() {
        return revenueThisMonth;
    }

    public void setRevenueThisMonth(double revenueThisMonth) {
        this.revenueThisMonth = revenueThisMonth;
    }

    public double getRevenueThisYear() {
        return revenueThisYear;
    }

    public void setRevenueThisYear(double revenueThisYear) {
        this.revenueThisYear = revenueThisYear;
    }
}