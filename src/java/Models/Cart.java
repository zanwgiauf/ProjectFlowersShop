/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Cart {

    private int cartID;
    private int price;
    private int quantity;
    private int productID;
    private int customerID;
    private String image;
    private String name;

    public Cart() {
    }

    public Cart(int cartID, int price, int quantity, int productID, int customerID) {
        this.cartID = cartID;
        this.price = price;
        this.quantity = quantity;
        this.productID = productID;
        this.customerID = customerID;
    }

    public Cart(int cartID, int price, int quantity, int productID, int customerID, String image, String name) {
        this.cartID = cartID;
        this.price = price;
        this.quantity = quantity;
        this.productID = productID;
        this.customerID = customerID;
        this.image = image;
        this.name = name;
    }

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
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

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

}
