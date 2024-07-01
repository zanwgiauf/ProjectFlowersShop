/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Stock {

    private int stockID;
    private int stockImport;
    private int stockExport;
    private String importAt;
    private int employeeID;

    public Stock() {
    }

    public Stock(int stockID, int stockImport, int stockExport, String importAt, int employeeID) {
        this.stockID = stockID;
        this.stockImport = stockImport;
        this.stockExport = stockExport;
        this.importAt = importAt;
        this.employeeID = employeeID;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getStockImport() {
        return stockImport;
    }

    public void setStockImport(int stockImport) {
        this.stockImport = stockImport;
    }

    public int getStockExport() {
        return stockExport;
    }

    public void setStockExport(int stockExport) {
        this.stockExport = stockExport;
    }

    public String getImportAt() {
        return importAt;
    }

    public void setImportAt(String importAt) {
        this.importAt = importAt;
    }

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

}
