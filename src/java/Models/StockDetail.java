/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class StockDetail {

    private int stockDetailID;
    private int quantity;
    private String name;
    private int stockID;
    private int prductID;

    public StockDetail() {
    }

    public StockDetail(int stockDetailID, int quantity, String name, int stockID, int prductID) {
        this.stockDetailID = stockDetailID;
        this.quantity = quantity;
        this.name = name;
        this.stockID = stockID;
        this.prductID = prductID;
    }

    public int getStockDetailID() {
        return stockDetailID;
    }

    public void setStockDetailID(int stockDetailID) {
        this.stockDetailID = stockDetailID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getPrductID() {
        return prductID;
    }

    public void setPrductID(int prductID) {
        this.prductID = prductID;
    }

}
