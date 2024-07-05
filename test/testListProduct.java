
import DAOs.ProductDAO;
import Models.Product;
import java.util.List;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author Le Minh Truong - CE171886
 */
public class testListProduct {
    public static void main(String[] args) {
    ProductDAO productDAO = new ProductDAO();
    List<Product> products = productDAO.getAllProducts();
    if (products.isEmpty()) {
        System.out.println("No products found.");
    } else {
        System.out.println("Found " + products.size() + " products.");
    }
}
}
