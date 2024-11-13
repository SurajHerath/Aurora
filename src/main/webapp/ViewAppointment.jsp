<%-- 
    Document   : ViewAppointment
    Created on : Nov 3, 2024, 7:16:15 PM
    Author     : suraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Appointment" %>
<%@ page import="Service.AppointmentService" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Time Range - Aurora Skin Care Clinic</title>

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
               <main class="main">
    <!-- Page Title -->
    <div class="page-title accent-background" style="background-image:url('img/doctor1.jpg');">
        <div class="container position-relative">
            <h1>View Appointment</h1> 
            <a href="#View" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
        </div>
    </div><!-- End Page Title -->

    <div class="page-content">
        <div class="container-fluid px-4">
            <h1 class="mt-4 text-center">View and Manage Appointments</h1>
            <br>

            <form id="searchForm" method="GET" action="AppointmentController">
                <input type="hidden" name="action" value="search" />
                <div class="input-group mb-4">
                    <input type="text" id="searchInput" name="searchQuery" class="form-control" placeholder="Search by ID, Patient ID, or Dermatologist ID" autocomplete="off" required>
                    <button type="submit" class="btn btn-primary">Search</button>
                </div>
                <div id="suggestions" class="suggestions-box"></div>
            </form>

            <table id="tblSchedule" class="table table-striped">
                <thead>
                    <tr>
                        <th>Appointment ID</th>
                        <th>Patient ID</th>
                        <th>Dermatologist ID</th>
                        <th>Date</th>
                        <th>Time</th>
                        <th>Treatment ID</th>
                        <th>Registration Fee</th>
                        <th>Treatment Price</th>
                        <th>Status</th>
                        <th>Schedule ID</th>
                        <th>Time Range ID</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        // Retrieve the list of appointments set by the controller
                        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
                        if (appointments != null && !appointments.isEmpty()) {
                            for (Appointment appointment : appointments) {
                    %>
                    <tr>
                        <td><%= appointment.getA_ID() %></td>
                        <td><%= appointment.getP_ID() %></td>
                        <td><%= appointment.getE_ID() %></td>
                        <td><%= appointment.getA_Date() %></td>
                        <td><%= appointment.getA_time() %></td>
                        <td><%= appointment.getT_ID() %></td>
                        <td><%= appointment.getReg_Fee() %></td>
                        <td><%= appointment.getT_Price() %></td>
                        <td><%= appointment.getA_Status() %></td>
                        <td><%= appointment.getSchedule_ID() %></td>
                        <td><%= appointment.getTime_range_ID() %></td>
                        <td>
                            <a href="AppointmentController?action=edit&a_ID=<%= appointment.getA_ID() %>" class="edit-appointment btn btn-warning">Edit</a>
                            
                            <a href="InvoiceController?action=showForm&a_ID=<%= appointment.getA_ID() %>&p_ID=<%= appointment.getP_ID() %>&t_Price=<%= appointment.getT_Price() %>" class="btn btn-warning">Invoice</a>
                            
                            <a href="AppointmentController?action=delete&a_ID=<%= appointment.getA_ID() %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this appointment?');">Delete</a>
                        </td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="12">No appointments found.</td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</main>

             

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

<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="vendor/php-email-form/validate.js"></script>
<script src="vendor/aos/aos.js"></script>
<script src="vendor/purecounter/purecounter_vanilla.js"></script>
<script src="vendor/glightbox/js/glightbox.min.js"></script>
<script src="vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="vendor/swiper/swiper-bundle.min.js"></script>

<!-- Main JS File -->
<script src="js/main.js"></script>
</body>
</html>
