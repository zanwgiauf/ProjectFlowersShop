/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Feedback {

    private int feedbackID;
    private String content;
    private int customerID;
    private int productID;
    private Customer customer;
    private Product product;
    private Timestamp createdDate;

    public Feedback() {
    }

    public Feedback(int feedbackID, String content, int customerID, int productID, Customer customer, Product product, Timestamp createdDate) {
        this.feedbackID = feedbackID;
        this.content = content;
        this.customerID = customerID;
        this.productID = productID;
        this.customer = customer;
        this.product = product;
        this.createdDate = createdDate;
    }

    public int getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(int feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Timestamp getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Timestamp createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "Feedback{" + "feedbackID=" + feedbackID + ", content=" + content + ", customerID=" + customerID + ", productID=" + productID + ", customer=" + customer + ", product=" + product + ", createdDate=" + createdDate + '}';
    }

  

}
