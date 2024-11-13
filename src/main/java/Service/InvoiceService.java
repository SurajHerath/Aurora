/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author suraj
 */
import Model.Invoice;
import Utils.AuroraSkinCareDB;
import java.sql.*;

public class InvoiceService {
    private AuroraSkinCareDB db = new AuroraSkinCareDB();

    public boolean generateInvoice(Invoice invoice) {
        try (Connection connection = db.getConnection()) {
            String sql = "INSERT INTO invoice (Invoice_ID, A_ID, P_ID, Tax_Rate, Total_Fee, Total_Amount, Invoice_Issue_Date) VALUES (?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(sql)) {
                stmt.setString(1, invoice.getInvoice_ID());
                stmt.setString(2, invoice.getA_ID());
                stmt.setString(3, invoice.getP_ID());
                stmt.setDouble(4, invoice.getTax_Rate());
                stmt.setDouble(5, invoice.getTotal_Fee());
                stmt.setDouble(6, invoice.getTotal_Amount()); // Ensure this uses the correct total amount
                stmt.setDate(7, new java.sql.Date(invoice.getInvoice_Issue_Date().getTime()));

                int rowsInserted = stmt.executeUpdate();
                return rowsInserted > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
