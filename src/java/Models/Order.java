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
public class Order  {

    private int OrderID;
    private String dateCreate;
    private String phone;
    private String address;
    private int totalPrice;
    private String note;
    private int status;
    private int paymentStatus;
    private String paymentCreateAt;
    private int customerID;
    private int employeeID;
    

    public Order() {
       
    }

    public Order(int OrderID, String dateCreate, String phone, String address, int totalPrice, String note, int status, int paymentStatus, String paymentCreateAt, int customerID, int employeeID) {
        this.OrderID = OrderID;
        this.dateCreate = dateCreate;
        this.phone = phone;
        this.address = address;
        this.totalPrice = totalPrice;
        this.note = note;
        this.status = status;
        this.paymentStatus = paymentStatus;
        this.paymentCreateAt = paymentCreateAt;
        this.customerID = customerID;
        this.employeeID = employeeID;
    }

    public int getOrderID() {
        return OrderID;
    }

    public void setOrderID(int OrderID) {
        this.OrderID = OrderID;
    }

    public String getDateCreate() {
        return dateCreate;
    }

    public void setDateCreate(String dateCreate) {
        this.dateCreate = dateCreate;
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

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(int paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentCreateAt() {
        return paymentCreateAt;
    }

    public void setPaymentCreateAt(String paymentCreateAt) {
        this.paymentCreateAt = paymentCreateAt;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    
    
}
