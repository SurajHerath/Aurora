<%-- 
    Document   : AddApointment
    Created on : Nov 4, 2024, 3:30:23 PM
    Author     : suraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="Model.Dermatologist" %>
<%@ page import="Model.Patient" %>
<%@ page import="Model.Schedule" %>
<%@ page import="Model.TimeRange" %>
<%@ page import="Model.Treatment" %>
<%@ page import="Model.Employees" %>
<%@ page import="Service.EmployeeService" %>
<%@ page import="Service.PatientService" %>
<%@ page import="Service.DermatologistService" %>
<%@ page import="Service.ScheduleService" %>
<%@ page import="Service.TimeRangeService" %>
<%@ page import="Service.TreatmentService" %>
<%@ page import="com.google.gson.Gson" %>

<%
    // Your existing Java code here
    String patientId = request.getParameter("p_ID");

    PatientService patientService = new PatientService();
    DermatologistService dermatologistService = new DermatologistService();
    EmployeeService employeeService = new EmployeeService();
    ScheduleService scheduleService = new ScheduleService();
    TimeRangeService timeRangeService = new TimeRangeService();
    TreatmentService treatmentService = new TreatmentService();

    Patient patient = patientService.getPatientByID(patientId);
    List<Dermatologist> dermatologists = dermatologistService.getAllDermatologists();
    List<Treatment> treatments = treatmentService.getAllTreatments();
    List<Employees> employees = employeeService.getAllEmployees();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Book Appointment - Aurora Skin Care Clinic</title>

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

            
            
            
            <!-- Appointment Form -->
            <section id="appointmentForm" class="appointment-section">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-8">
                            <div class="appointment-form">
                                <h2 class="text-center mb-4">Book Your Appointment</h2>
                                <form action="AppointmentController?action=add" method="post">
                                    <div class="form-group">
                                        <label for="a_ID">Appointment ID:</label>
                                        <input type="text" class="form-control" id="a_ID" name="a_ID" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="patientSearch">Search by NIC or Name:</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control" id="patientSearch" placeholder="Enter NIC or Name">
                                            <div class="input-group-append">
                                                <button class="btn btn-primary" type="button" onclick="searchPatient()">Search</button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="p_ID">Patient ID:</label>
                                        <input type="text" class="form-control" id="p_ID" name="p_ID" readonly>
                                    </div>

                                    <div class="form-group">
                                        <label for="p_Name">Patient Name:</label>
                                        <input type="text" class="form-control" id="p_Name" name="p_Name" readonly>
                                    </div>

                                    <div class="form-group">
                                        <label for="dermatologist">Choose Dermatologist:</label>
                                        <select class="form-control" id="dermatologist" name="dermatologist" required onchange="updateDermatologistID(); clearTimeSlots()">
                                            <option value="">Select Dermatologist</option>
                                            <% for (Dermatologist d : dermatologists) {
                                                for (Employees e : employees) {
                                                    if (d.getE_ID().equals(e.getE_ID())) {%>
                                            <option value="<%= d.getE_ID()%>"><%= e.getE_Name()%></option>
                                            <% }
                                                       }
                                                   } %>
                                        </select>
                                        <input type="hidden" id="e_ID" name="e_ID">
                                    </div>

                                    <div class="form-group">
                                        <label for="a_Date">Appointment Date:</label>
                                        <input type="date" class="form-control" id="a_Date" name="a_Date" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="dayOfWeek">Day of Week:</label>
                                        <select name="dayOfWeek" id="dayOfWeek" class="form-control" required>
                                            <option value="">Select Day</option>
                                            <option value="Monday">Monday</option>
                                            <option value="Tuesday">Tuesday</option>
                                            <option value="Wednesday">Wednesday</option>
                                            <option value="Thursday">Thursday</option>
                                            <option value="Friday">Friday</option>
                                            <option value="Saturday">Saturday</option>
                                            <option value="Sunday">Sunday</option>
                                        </select>
                                    </div>

                                    <div class="form-group">
                                        <button type="button" class="btn btn-secondary" onclick="searchTimeSlot()">Search Time Slots</button>
                                    </div>

                                    <div class="form-group">
                                        <label for="a_Time">Available Time Slot:</label>
                                        <select class="form-control" id="a_Time" name="a_Time" required onchange="updateTimeRangeID()">
                                            <option value="">Select Time Slot</option>
                                        </select>
                                        <input type="text" id="timeRangeID" name="timeRangeID">
                                        <input type="text" id="scheduleID" name="scheduleID">
                                        <input type="text" id="startTime" name="startTime">
                                        <input type="text" id="endTime" name="endTime">
                                    </div>

                                    <div class="form-group">
                                        <label for="treatment">Choose Treatment:</label>
                                        <select class="form-control" id="treatment" name="treatment" required onchange="showTreatmentPrice()">
                                            <option value="">Select Treatment</option>
                                            <% for (Treatment t : treatments) {%>
                                            <option value="<%= t.getT_Name()%>" data-price="<%= t.getT_Price()%>" data-id="<%= t.getT_ID()%>">
                                                <%= t.getT_Name()%> - $<%= t.getT_Price()%>
                                            </option>
                                            <% }%>
                                        </select>
                                        <input type="hidden" id="TreatmentID" name="TreatmentID">
                                    </div>

                                    <div class="form-group">
                                        <label for="treatmentPrice">Treatment Price:</label>
                                        <input type="text" class="form-control" id="treatmentPrice" name="treatmentPrice" readonly>
                                    </div>

                                    <div class="form-group">
                                        <label for="registrationFee">Registration Fee:</label>
                                        <input type="number" class="form-control" id="registrationFee" name="registrationFee" required>
                                    </div>

                                    <div class="form-group">
                                        <label for="appointmentStatus">Appointment Status:</label>
                                        <select class="form-control" id="appointmentStatus" name="appointmentStatus" required>
                                            <option value="Scheduled">Scheduled</option>
                                            <option value="Pending">Pending</option>
                                            <option value="Confirmed">Confirmed</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-block">Confirm Appointment</button>
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
        <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="js/main.js"></script>
        <script>
                                            function updateDermatologistID() {
                                                var select = document.getElementById("dermatologist");
                                                var selectedID = select.options[select.selectedIndex].value;
                                                document.getElementById("e_ID").value = selectedID;
                                            }

                                            function updateTimeRangeID() {
                                                const timeSlotSelect = document.getElementById("a_Time");
                                                const selectedOption = timeSlotSelect.options[timeSlotSelect.selectedIndex];

                                                if (selectedOption) {
                                                    document.getElementById("timeRangeID").value = selectedOption.value;
                                                    document.getElementById("scheduleID").value = selectedOption.getAttribute("data-schedule-id");
                                                    document.getElementById("startTime").value = selectedOption.getAttribute("data-start-time");
                                                    document.getElementById("endTime").value = selectedOption.getAttribute("data-end-time");
                                                }
                                            }

                                            function searchPatient() {
                                                var searchQuery = document.getElementById('patientSearch').value;
                                                fetch("AppointmentController?action=searchPatient&query=" + searchQuery)
                                                        .then(response => response.json())
                                                        .then(data => {
                                                            document.getElementById("p_ID").value = data.patient.p_ID;
                                                            document.getElementById("p_Name").value = data.patient.p_Name;
                                                        });
                                            }

                                            function showTreatmentPrice() {
                                                var treatmentSelect = document.getElementById('treatment');
                                                var price = treatmentSelect.options[treatmentSelect.selectedIndex].getAttribute('data-price');
                                                var treatmentID = treatmentSelect.options[treatmentSelect.selectedIndex].getAttribute('data-id');

                                                document.getElementById('treatmentPrice').value = price;
                                                document.getElementById('TreatmentID').value = treatmentID;
                                            }

                                            function clearTimeSlots() {
                                                document.getElementById("a_Time").innerHTML = "<option value=''>Select Time Slot</option>";
                                            }

                                            function searchTimeSlot() {
                                                const eID = document.getElementById("e_ID").value;
                                                const dayOfWeek = document.getElementById("dayOfWeek").value;

                                                if (eID && dayOfWeek) {
                                                    fetch("AppointmentController?action=getAvailableTimeSlots&eID=" + eID + "&dayOfWeek=" + dayOfWeek)
                                                            .then(response => {
                                                                if (!response.ok) {
                                                                    throw new Error(`HTTP status ${response.status}`);
                                                                }
                                                                return response.json();
                                                            })
                                                            .then(data => {
                                                                console.log("Data received:", data);

                                                                const timeSlotSelect = document.getElementById("a_Time");
                                                                timeSlotSelect.innerHTML = "<option value=''>Select Time Slot</option>";

                                                                if (data && data.length > 0) {
                                                                    data.forEach(timeSlot => {
                                                                        const option = document.createElement("option");
                                                                        option.value = timeSlot.timeRangeID;

                                                                        const startTime = timeSlot.startTime && timeSlot.startTime.trim() ? timeSlot.startTime : "N/A";
                                                                        const endTime = timeSlot.endTime && timeSlot.endTime.trim() ? timeSlot.endTime : "N/A";

                                                                        option.text = `${startTime} - ${endTime}`;
                                                                                                        option.setAttribute("data-schedule-id", timeSlot.scheduleID);
                                                                                                        option.setAttribute("data-start-time", startTime);
                                                                                                        option.setAttribute("data-end-time", endTime);

                                                                                                        timeSlotSelect.appendChild(option);
                                                                                                    });
                                                                                                } else {
                                                                                                    const option = document.createElement("option");
                                                                                                    option.value = '';
                                                                                                    option.text = 'No available time slots';
                                                                                                    timeSlotSelect.appendChild(option);
                                                                                                    alert("No available time slots found.");
                                                                                                }
                                                                                            })
                                                                                            .catch(error => {
                                                                                                console.error("Error fetching time slots:", error);
                                                                                                alert("Error fetching available time slots: " + error.message);
                                                                                            });
                                                                                } else {
                                                                                    alert("Please select both a dermatologist and day of the week.");
                                                                                }
                                                                            }

                                                                            document.addEventListener('DOMContentLoaded', function () {
                                                                                document.getElementById('dermatologist').addEventListener('change', function () {
                                                                                    updateDermatologistID();
                                                                                    clearTimeSlots();
                                                                                });

                                                                                document.getElementById('dayOfWeek').addEventListener('change', clearTimeSlots);
                                                                                document.getElementById('a_Time').addEventListener('change', updateTimeRangeID);
                                                                            });
        </script>
    </body>
</html>