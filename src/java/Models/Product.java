/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Product {

    private int productID;
    private String name;
    private int price;
    private int reducedPrice;
    private int quantity;
    private String description;
    private String image;
    private int categoryID;
    private int stock_quantity;

    public Product() {
    }

    public Product(int productID, String name, int price, int reducedPrice, int quantity, String description, String image, int categoryID) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.reducedPrice = reducedPrice;
        this.quantity = quantity;
        this.description = description;
        this.image = image;
        this.categoryID = categoryID;
    }

    public Product(int productID, String name, int price, int reducedPrice, int quantity, String description, String image, int categoryID, int stock_quantity) {
        this.productID = productID;
        this.name = name;
        this.price = price;
        this.reducedPrice = reducedPrice;
        this.quantity = quantity;
        this.description = description;
        this.image = image;
        this.categoryID = categoryID;
        this.stock_quantity = stock_quantity;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
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

    public int getReducedPrice() {
        return reducedPrice;
    }

    public void setReducedPrice(int reducedPrice) {
        this.reducedPrice = reducedPrice;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

}
