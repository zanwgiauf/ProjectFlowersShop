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
public class OrderDetail {

    private int detailID;
    private String name;
    private int price;
    private int quantity;
    private int orderID;
    private int productID;
    private String image;
    private Date dateCreate;

    public OrderDetail() {
    }

    public OrderDetail(int detailID, String name, int price, int quantity, int orderID, int productID) {
        this.detailID = detailID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.orderID = orderID;
        this.productID = productID;
    }

    public OrderDetail(int detailID, String name, int price, int quantity, int orderID, int productID, String image, Date dateCreate) {
        this.detailID = detailID;
        this.name = name;
        this.price = price;
        this.quantity = quantity;
        this.orderID = orderID;
        this.productID = productID;
        this.image = image;
        this.dateCreate = dateCreate;
    }

    

    public int getDetailID() {
        return detailID;
    }

    public void setDetailID(int detailID) {
        this.detailID = detailID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Date getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(Date dateCreate) {
        this.dateCreate = dateCreate;
    }

}
