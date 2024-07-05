/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Nguyen Van Giau - CE170449
 */
public class Employee {

    private int EmployeeID;
    private String FullName;
    private String Phone;
    private String Email;
    private String Password;
    private int RoleID;
    private String roleName;
    private int status;
    public Employee() {
    }

    public Employee(int EmployeeID, String FullName, String Phone, String Email, String Password, int RoleID) {
        this.EmployeeID = EmployeeID;
        this.FullName = FullName;
        this.Phone = Phone;
        this.Email = Email;
        this.Password = Password;
        this.RoleID = RoleID;
    }

    public Employee(int EmployeeID, String FullName, String Phone, String Email, String Password, int RoleID, String roleName) {
        this.EmployeeID = EmployeeID;
        this.FullName = FullName;
        this.Phone = Phone;
        this.Email = Email;
        this.Password = Password;
        this.RoleID = RoleID;
        this.roleName = roleName;
    }

    public Employee(int EmployeeID, String FullName, String Phone, String Email, String Password, int RoleID, String roleName, int status) {
        this.EmployeeID = EmployeeID;
        this.FullName = FullName;
        this.Phone = Phone;
        this.Email = Email;
        this.Password = Password;
        this.RoleID = RoleID;
        this.roleName = roleName;
        this.status = status;
    }
    public Employee(int EmployeeID, String FullName, String Phone, String Email, String Password, int RoleID,  int status) {
        this.EmployeeID = EmployeeID;
        this.FullName = FullName;
        this.Phone = Phone;
        this.Email = Email;
        this.Password = Password;
        this.RoleID = RoleID;
        this.status = status;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    
    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public int getEmployeeID() {
        return EmployeeID;
    }

    public void setEmployeeID(int EmployeeID) {
        this.EmployeeID = EmployeeID;
    }

    public String getFullName() {
        return FullName;
    }

    public void setFullName(String FullName) {
        this.FullName = FullName;
    }

    public String getPhone() {
        return Phone;
    }

    public void setPhone(String Phone) {
        this.Phone = Phone;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getPassword() {
        return Password;
    }

    public void setPassword(String Password) {
        this.Password = Password;
    }

    public int getRoleID() {
        return RoleID;
    }

    public void setRoleID(int RoleID) {
        this.RoleID = RoleID;
    }

    @Override
    public String toString() {
        return "Employee{" + "EmployeeID=" + EmployeeID + ", FullName=" + FullName + ", Phone=" + Phone + ", Email=" + Email + ", Password=" + Password + ", RoleID=" + RoleID + ", roleName=" + roleName + ", status=" + status + '}';
    }

    public boolean isLocked() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
