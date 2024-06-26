/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Date;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Promotion {

    private int promotionID;
    private String promotionCode;
    private String description;
    private String discount;
    private String startDate;
    private String endDate;
    private int OrderID;

    public Promotion() {
    }

    public Promotion(int promotionID, String promotionCode, String description, String discount, String startDate, String endDate, int OrderID) {
        this.promotionID = promotionID;
        this.promotionCode = promotionCode;
        this.description = description;
        this.discount = discount;
        this.startDate = startDate;
        this.endDate = endDate;
        this.OrderID = OrderID;
    }

    public int getPromotionID() {
        return promotionID;
    }

    public void setPromotionID(int promotionID) {
        this.promotionID = promotionID;
    }

    public String getPromotionCode() {
        return promotionCode;
    }

    public void setPromotionCode(String promotionCode) {
        this.promotionCode = promotionCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscount() {
        return discount;
    }

    public void setDiscount(String discount) {
        this.discount = discount;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    
}
