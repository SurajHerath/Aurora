/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;


import Model.Invoice;
import Service.InvoiceService;
import Service.AppointmentService;
import Model.Appointment;
import Utils.AuroraSkinCareDB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Date;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.IOException;
import java.util.Date;
import java.util.UUID;
/**
 *
 * @author suraj
 */

@WebServlet(name = "InvoiceController", urlPatterns = {"/InvoiceController"})
public class InvoiceController extends HttpServlet {

    private InvoiceService invoiceService = new InvoiceService();
    private AppointmentService appointmentService = new AppointmentService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("showForm".equals(action)) {
            String appointmentId = request.getParameter("a_ID");
            Appointment appointment = appointmentService.getAppointmentbyId(appointmentId);
            request.setAttribute("appointment", appointment);
            request.getRequestDispatcher("/Invoice.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("generateInvoice".equals(action)) {
            String invoiceID = request.getParameter("invoiceID");
            String appointmentID = request.getParameter("appointmentID");
            String patientID = request.getParameter("patientID");
            double taxRate = Double.parseDouble(request.getParameter("taxRate"));
            double totalFee = Double.parseDouble(request.getParameter("totalFee"));
            Date issueDate = new Date();

            // Create a new Invoice, which will automatically calculate Total_Amount
            Invoice invoice = new Invoice(invoiceID, appointmentID, patientID, taxRate, totalFee, issueDate);

            boolean success = invoiceService.generateInvoice(invoice);

            if (success) {
                request.setAttribute("invoice", invoice);
                request.getRequestDispatcher("/FinalInvoice.jsp").forward(request, response);
            } else {
                response.sendRedirect("InvoiceController?action=showForm&a_ID=" + appointmentID + "&error=Failed to generate invoice");
            }
        }
    }
}

