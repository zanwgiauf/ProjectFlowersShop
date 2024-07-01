/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAOs;

import DBConnect.DBConnection;
import Models.Employee;
import Models.Role;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class EmployeeDAO {

    Connection conn;

    public EmployeeDAO() {
        conn = DBConnection.connect();
        if (conn != null) {
            System.out.println("Database connection established successfully.");
        } else {
            System.out.println("Failed to establish database connection.");
        }
    }

    public List<Employee> getAllEmployeeWithParam(String searchParam) {
        List<Employee> employees = new ArrayList<>();
        List<Object> list = new ArrayList<>();

        try {
            StringBuilder query = new StringBuilder();
            query.append("select e.*, r.Name from Employees e Join Roles r on e.RoleID = r.RoleID  where 1=1 ");
            if (searchParam != null && !searchParam.trim().isEmpty()) {
                query.append(" AND (e.FullName LIKE ? OR e.Email LIKE ?)");
                list.add("%" + searchParam + "%");
                list.add("%" + searchParam + "%");
            }
            query.append(" ORDER BY e.EmployeeID DESC");
            PreparedStatement preparedStatement;
            preparedStatement = conn.prepareStatement(query.toString());
            mapParams(preparedStatement, list);
            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    Employee employee = new Employee();
                    employee.setEmployeeID(resultSet.getInt("EmployeeID"));
                    employee.setFullName(resultSet.getString("FullName"));
                    employee.setPhone(resultSet.getString("Phone"));
                    employee.setEmail(resultSet.getString("Email"));
                    employee.setRoleName(resultSet.getString("Name"));
                    employee.setStatus(resultSet.getInt("status"));
                    employees.add(employee);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return employees;
    }

    public boolean addEmployee(String fullName, String phone, String email, String password, int roleId) {
        boolean result = false;
        try {
            String sql = "INSERT INTO Employees (FullName, Phone, Email, Password, RoleID) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setString(4, getMd5(password));
            ps.setInt(5, roleId);
            result = ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        return result;
    }

    public boolean changeStatus(int status, int emId) {
        boolean result = false;
        try {
            String sql = "UPDATE Employees SET status = ? WHERE EmployeeID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setInt(2, emId);
            result = ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        return result;
    }

    public boolean updateEmployee(int id, String fullName, String phone, String email) {
        boolean result = false;
        try {
            String sql = "UPDATE Employees SET FullName = ?, Phone = ?, Email = ? WHERE EmployeeID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, email);
            ps.setInt(4, id);
            result = ps.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        return result;
    }

    public boolean emailExists(String email) {
        boolean exists = false;
        try {
            String sql = "SELECT COUNT(*) FROM Employees WHERE Email = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException ex) {
            System.out.println(ex.toString());
        }
        return exists;
    }

    public String getMd5(String input) {
        try {

            // Static getInstance method is called with hashing MD5
            MessageDigest md = MessageDigest.getInstance("MD5");

            // digest() method is called to calculate message digest
            // of an input digest() return array of byte
            byte[] messageDigest = md.digest(input.getBytes());

            // Convert byte array into signum representation
            BigInteger no = new BigInteger(1, messageDigest);

            // Convert message digest into hex value
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } // For specifying wrong message digest algorithms
        catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }

    public void mapParams(PreparedStatement ps, List<Object> args) throws SQLException {
        int i = 1;
        for (Object arg : args) {
            if (arg instanceof Date) {
                ps.setTimestamp(i++, new Timestamp(((Date) arg).getTime()));
            } else if (arg instanceof Integer) {
                ps.setInt(i++, (Integer) arg);
            } else if (arg instanceof Long) {
                ps.setLong(i++, (Long) arg);
            } else if (arg instanceof Double) {
                ps.setDouble(i++, (Double) arg);
            } else if (arg instanceof Float) {
                ps.setFloat(i++, (Float) arg);
            } else {
                ps.setString(i++, (String) arg);
            }

        }
    }

    public List<Employee> Paging(List<Employee> employees, int page, int pageSize) {
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, employees.size());

        if (fromIndex > toIndex) {
            // Handle the case where fromIndex is greater than toIndex
            fromIndex = toIndex;
        }

        return employees.subList(fromIndex, toIndex);
    }

}
