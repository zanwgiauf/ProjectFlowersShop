/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Cart extends Product {

    private int CartID;
    private int Price;
    private int Quantity;
    private String Image;
    private int Total;
    private int ProductID;
    private int CustomerID;
    private Product product;
    private String Name;

    public Cart() {
    }

    public Cart(int CartID, int Price, int Quantity, String Image, int Total, int ProductID, int CustomerID, String Name) {
        super();
        this.CartID = CartID;
        this.Price = Price * Quantity;
        this.Quantity = Quantity;
        this.Image = Image;
        this.Total = Total;
        this.ProductID = ProductID;
        this.CustomerID = CustomerID;
        this.Name = Name;

    }

    public Cart(int CartID, int Price, int Quantity, String Image, int Total, int ProductID, int CustomerID, Product product, String Name) {
        this.CartID = CartID;
        this.Price = Price;
        this.Quantity = Quantity;
        this.Image = Image;
        this.Total = Total;
        this.ProductID = ProductID;
        this.CustomerID = CustomerID;
        this.product = product;
        this.Name = Name;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getCartID() {
        return CartID;
    }

    public void setCartID(int CartID) {
        this.CartID = CartID;
    }

    @Override
    public int getPrice() {
        return Price;
    }

    @Override
    public void setPrice(int Price) {
        this.Price = Price;
    }

    @Override
    public int getQuantity() {
        return Quantity;
    }

    @Override
    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    @Override
    public String getImage() {
        return Image;
    }

    @Override
    public void setImage(String Image) {
        this.Image = Image;
    }

    public int getTotal() {
        return Total;
    }

    public void setTotal(int Total) {
        this.Total = Total;
    }

    @Override
    public int getProductID() {
        return ProductID;
    }

    @Override
    public void setProductID(int ProductID) {
        this.ProductID = ProductID;
    }

    public int getCustomerID() {
        return CustomerID;
    }

    public void setCustomerID(int CustomerID) {
        this.CustomerID = CustomerID;
    }

    @Override
    public String getName() {
        return Name;
    }

    @Override
    public void setName(String Name) {
        this.Name = Name;
    }

}
