<%-- 
    Document   : Invoice
    Created on : Oct 20, 2024, 1:47:31?PM
    Author     : suraj
--%>

<%@page import="Model.Appointment"%>
<%@page import="Service.AppointmentService"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.*" %>
<%@page import="Utils.AuroraSkinCareDB"%>
<%@page import="java.util.List, java.util.Map, java.util.Set, java.util.HashMap" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Invoice - Aurora Skin Care Clinic</title>

        <!-- Your existing CSS links -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Poppins:wght@300;400;500;600;700&family=Raleway:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/nav_and_footer.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <link href="css/Form.css" rel="stylesheet">


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
                    <h1>Book Appointment</h1> 
                    <a href="#appointmentForm" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
                </div>
            </div>



            <section id="appointmentForm" class="appointment-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="appointment-form">
                                <h2 class="text-center mb-4">Invoice</h2>

                                <%-- Retrieve appointment details from request attributes --%>
                                <%-- Retrieve appointment details from request attributes --%>
                                <% Appointment appointment = (Appointment) request.getAttribute("appointment");%>
                                <form action="InvoiceController?action=generateInvoice" method="post">
                                    <label for="invoiceID">Invoice ID:</label>
                                    <input type="text" name="invoiceID" class="form-control my-1" placeholder="Enter Invoice ID" required>

                                    <label for="appointmentID">Appointment ID:</label>
                                    <input type="text" id="a_ID" name="appointmentID" value="<%= appointment.getA_ID()%>" readonly class="form-control my-1">

                                    <label for="patientID">Patient ID:</label>
                                    <input type="text" id="p_ID" name="patientID" value="<%= appointment.getP_ID()%>" readonly class="form-control my-1">

                                    <label for="taxRate">Tax Rate (%):</label>
                                    <input type="number" id="taxRate" name="taxRate" step="0.01" required class="form-control my-1">

                                    <label for="totalFee">Total Fee:</label>
                                    <input type="number" id="totalFee" name="totalFee" value="<%= appointment.getT_Price()%>" readonly class="form-control my-1">

                                    <label for="totalAmount">Total Amount:</label>
                                    <input type="number" id="totalAmount" name="totalAmount" readonly class="form-control my-1">

                                    <button type="button" class="btn btn-primary mt-3" onclick="calculateTotalAmount()">Calculate Total Amount</button>
                                    <button type="submit" class="btn btn-success container mt-3">Generate Invoice</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>
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
<script>
    function calculateTotalAmount() {
        let totalFee = parseFloat(document.getElementById("totalFee").value);
        let taxRate = parseFloat(document.getElementById("taxRate").value);

        if (!isNaN(totalFee) && !isNaN(taxRate)) {
            let totalAmount = totalFee + (totalFee * taxRate / 100);
            document.getElementById("totalAmount").value = totalAmount.toFixed(2);
        } else {
            alert("Please enter valid values for total fee and tax rate.");
        }
    }
</script>
</html>

