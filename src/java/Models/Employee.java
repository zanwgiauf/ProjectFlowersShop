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

    private int employeeID;
    private String fullName;
    private String phone;
    private String email;
    private String password;
    private int status;
    private int roleID;

    public Employee() {
    }

    public Employee(int employeeID, String fullName, String phone, String email, String password, int status, int roleID) {
        this.employeeID = employeeID;
        this.fullName = fullName;
        this.phone = phone;
        this.email = email;
        this.password = password;
        this.status = status;
        this.roleID = roleID;
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

    public int getEmployeeID() {
        return employeeID;
    }

    public void setEmployeeID(int employeeID) {
        this.employeeID = employeeID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    @Override
    public String toString() {
        return "Employee{" + "EmployeeID=" + EmployeeID + ", FullName=" + FullName + ", Phone=" + Phone + ", Email=" + Email + ", Password=" + Password + ", RoleID=" + RoleID + ", roleName=" + roleName + ", status=" + status + '}';
    }

    public boolean isLocked() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

}
