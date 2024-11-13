<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Invoice"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice - Aurora Skin Care Clinic</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                line-height: 1.6;
                margin: 0;
                padding: 20px;
            }
            .invoice-container {
                max-width: 800px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ddd;
            }
            .invoice-header {
                text-align: center;
                color: #2c5282;
                margin-bottom: 30px;
            }
            .invoice-header h1 {
                margin-bottom: 5px;
            }
            .invoice-details {
                margin-bottom: 20px;
            }
            .invoice-details p {
                margin: 5px 0;
            }
            .invoice-table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            .invoice-table th, .invoice-table td {
                border: 1px solid #ddd;
                padding: 10px;
                text-align: left;
            }
            .invoice-table th {
                background-color: #f8f9fa;
            }
            .invoice-summary {
                background-color: #f8f9fa;
                padding: 15px;
                text-align: right;
            }
            .invoice-summary p {
                margin: 5px 0;
            }
            .print-button {
                display: block;
                margin: 20px auto;
                padding: 10px 20px;
                background-color: #2c5282;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            @media print {
                .print-button {
                    display: none;
                }
            }
        </style>
    </head>
    <body>

        <!-- Header -->
        <header id="header" class="header d-flex align-items-center fixed-top">
            <div class="container-fluid container-xl d-flex align-items-center justify-content-between">
                <a href="index.html" class="logo d-flex align-items-center">
                    <h1 class="sitename">Aurora Skin Care Clinic</h1>
                </a>
                <nav id="navmenu" class="navmenu">
                    <ul>
                        <li><a href="Index.jsp" class="active">Home</a></li>
                        <li><a href="About.jsp">About</a></li>
                        <li class="dropdown"><a href="#"><span>Services</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="TreatmentController?action=list">View Treatment</a></li>
                                <li><a href="ScheduleController?action=list">View Schedule</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#"><span>Dermatologists</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="Registerdermatologist.jsp">Register Dermatologist</a></li>
                                <li><a href="DermatologistController?action=list">View Dermatologists</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#"><span>Patient</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="PatientRegister.jsp">Register Patient</a></li>
                                <li><a href="PatientController?action=list">View Patient</a></li>
                            </ul>
                        </li>
                        <li class="dropdown"><a href="#"><span>Appointment</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="AddAppointment.jsp">Make Appointment</a></li>
                                <li><a href="AppointmentController?action=list">View Appointments</a></li>
                            </ul>
                        </li> 
                    </ul>
                    <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                </nav>
            </div>
        </header>

        <main>
            <!-- Page Title -->
            <div class="page-title accent-background" style="background-image:url('img/doctor1.jpg');">
                <div class="container position-relative">
                    <h1>Invoice</h1> 
                    <a href="#appointmentForm" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
                </div>
            </div>

            <%
                Invoice invoice = (Invoice) request.getAttribute("invoice");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                DecimalFormat decimalFormat = new DecimalFormat("#,##0.00");

                if (invoice != null) {
                    double treatmentFee = invoice.getTotal_Fee();
                    double taxRate = invoice.getTax_Rate();
                    double taxAmount = treatmentFee * (taxRate / 100);
                    double totalAmount = invoice.getTotal_Amount();
            %>
            <div class="invoice-container">
                <div class="invoice-header">
                    <h1>Aurora Skin Care Clinic</h1>
                    <h2>Invoice</h2>
                </div>

                <div class="invoice-details">
                    <p><strong>Invoice ID:</strong> <%= invoice.getInvoice_ID()%></p>
                    <p><strong>Appointment ID:</strong> <%= invoice.getA_ID()%></p>
                    <p><strong>Patient ID:</strong> <%= invoice.getP_ID()%></p>
                    <p><strong>Date:</strong> <%= dateFormat.format(invoice.getInvoice_Issue_Date())%></p>
                </div>

                <table class="invoice-table">
                    <thead>
                        <tr>
                            <th>Description</th>
                            <th style="text-align: right;">Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Treatment Fee</td>
                            <td style="text-align: right;">Rs <%= decimalFormat.format(treatmentFee)%></td>
                        </tr>
                    </tbody>
                </table>

                <div class="invoice-summary">
                    <p><strong>Subtotal:</strong> Rs <%= decimalFormat.format(treatmentFee)%></p>
                    <p><strong>Tax Rate:</strong> <%= decimalFormat.format(taxRate)%>%</p>
                    <p><strong>Tax Amount:</strong> Rs <%= decimalFormat.format(taxAmount)%></p>
                    <p><strong>Total Amount:</strong> Rs <%= decimalFormat.format(totalAmount)%></p>
                </div>

                <div style="text-align: center; margin-top: 30px;">
                    <p>Thank you for choosing Aurora Skin Care Clinic!</p>
                    <button onclick="window.print()" class="print-button">Print Invoice</button>
                </div>
            </div>
            <% } else { %>
            <div class="invoice-container">
                <div class="invoice-header">
                    <h2>Error</h2>
                    <p>Invoice data not found.</p>
                </div>
            </div>
            <% }%>
            <footer id="footer" class="footer bg-dark text-white">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-4 col-md-6">
                            <h3>Aurora Skin Care Clinic</h3>
                            <p>1234 Street, Colombo</p>
                            <p>Phone: +94 234 567 890</p>
                            <p>Email: info@auroraskincare.com</p>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <h3>Useful Links</h3>
                            <ul class="list-unstyled">
                                <li><a href="index.jsp" class="text-white">Home</a></li>
                                <li><a href="About.jsp" class="text-white">About Us</a></li>
                                <li><a href="#" class="text-white">Contact</a></li>
                            </ul>
                        </div>
                        <div class="col-lg-4 col-md-6">
                            <h3>Our Location</h3>
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7921.394273278218!2d79.85675267056916!3d6.92675921935115!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae253d10f7a7003%3A0x320b2e4d32d3838d!2sColombo!5e0!3m2!1sen!2slk!4v1729502352015!5m2!1sen!2slk" width="400" height="200" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                    <div class="row mt-4">
                        <div class="col-lg-12 text-center">
                            <p>&copy; 2024 Aurora Skin Care Clinic. All Rights Reserved.</p>
                        </div>
                    </div>
                </div>
            </footer>
    </body>
</html>