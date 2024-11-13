<%-- 
    Document   : UpdateTimeRange
    Created on : Nov 6, 2024, 11:23:38 PM
    Author     : suraj
--%>


<%@page import="Model.TimeRange"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="Service.TimeRangeService" %>
<%@ page import="Controller.TimeRangeController" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Update Time Range - Aurora Skin Care Clinic</title>

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
                    <h1>Update Time Range</h1> 
                    <a href="#appointmentForm" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
                </div>
            </div>


            <section id="appointmentForm" class="appointment-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="appointment-form">
                                <h2 class="text-center mb-4">Update Time Range</h2>

                                <%
                                    TimeRange timeRange = (TimeRange) request.getAttribute("timeRange");
                                %>
                                <!-- Form to Add TimeRange -->
                                <form id="updateTimeRangeForm" method="POST" action="TimeRangeController?action=edit">
                                    <input type="hidden" name="action" value="update" />
                                    <input type="hidden" name="time_range_ID" value="${timeRange.timeRangeId}" />

                                    <div class="form-group mb-4">
                                        <label for="scheduleId" class="form-label">Schedule ID</label>
                                        <input type="text" id="scheduleId" name="schedule_ID" class="form-control" value="${timeRange.scheduleId}" required />
                                    </div>

                                    <div class="form-group mb-4">
                                        <label for="startTime" class="form-label">Start Time</label>
                                        <input type="time" id="startTime" name="start_time" class="form-control" value="${timeRange.startTime}" required />
                                    </div>

                                    <div class="form-group mb-4">
                                        <label for="endTime" class="form-label">End Time</label>
                                        <input type="time" id="endTime" name="end_time" class="form-control" value="${timeRange.endTime}" required />
                                    </div>



                                    <div class="form-group mb-4">
                                        <label for="isBooked" class="form-label">Is Booked</label>
                                        <select id="isBooked" name="is_booked" class="form-control" required>
                                            <option value="true" <c:if test="${timeRange.isBooked == true}"></c:if>Yes</option>
                                            <option value="false" <c:if test="${timeRange.isBooked == false}"></c:if>No</option>
                                        </select>
                                    </div>



                                    <div class="form-group mb-4">
                                        <label for="patientId" class="form-label">Patient ID</label>
                                        <input type="text" id="patientId" name="p_ID" class="form-control" value="${timeRange.patientId}" />
                                    </div>

                                    <input type="submit" value="Update TimeRange" class="btn btn-success container mt-3">

                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <!-- Footer -->
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

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
        <script src="assets/demo/chart-area-demo.js"></script>
        <script src="assets/demo/chart-bar-demo.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body>
</html>
