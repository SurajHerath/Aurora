<%-- 
    Document   : Index
    Created on : Nov 13, 2024, 9:18:04 AM
    Author     : suraj
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Index - Squadfree Bootstrap Template</title>
        <meta name="description" content="">
        <meta name="keywords" content="">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect">
        <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Raleway:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="vendor/aos/aos.css" rel="stylesheet">
        <link href="vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
        <link href="vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

        <!-- Main CSS File -->
        <link href="css/main.css" rel="stylesheet">
    </head>

    <body class="index-page">

        <header id="header" class="header d-flex align-items-center fixed-top">
            <div class="container-fluid container-xl position-relative d-flex align-items-center justify-content-between">

                <a href="index.html" class="logo d-flex align-items-center">
                    <!-- Uncomment the line below if you also wish to use an image logo -->
                    <!-- <img src="assets/img/logo.png" alt=""> -->
                    <h1 class="sitename">Aurora Skin Care Clinic</h1>
                </a>

                <nav id="navmenu" class="navmenu">
                    <ul>
                        <!--     <li><a href="#hero" class="active">Home</a></li>
                             <li><a href="#about">About</a></li>
                             <li><a href="#services">Services</a></li> -->
                        <li class="dropdown"><a href="#"><span>Services</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="Registerdermatologist.jsp">Register Dermatologist</a></li>
                                <li><a href="DermatologistController?action=list">View Dermatologist</a></li>
                                <li><a href="RegisterReceptionist.jsp">Register Receptionist</a></li>
                                <li><a href="ReceptionistController?action=list">View Receptionist</a></li>
                                
                                 <li><a href="AddSchedule.jsp">Add Schedule</a></li>
                                <li><a href="ScheduleController?action=list">View Schedule</a></li>
                                <li><a href="AddTimeRange.jsp">Add TimeRange</a></li>
                                <li><a href="TimeRangeController?action=list">View TimeRange</a></li>
                            </ul>
                        </li>
                        
                        
                        
                        <li class="dropdown"><a href="#"><span>Patient</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="PatientRegister.jsp">Register Patient</a></li>
                                <li><a href="PatientController?action=list" class="active">Patients</a></li>
                            </ul>
                        </li>

                        
                       
                        
                        <li class="dropdown">
                            <a href="#"><span>Treatment</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="AddTreatment.jsp">Register Treatment</a></li>
                                <li><a href="TreatmentController?action=list">View Treatment</a></li>
                            </ul>
                        </li>
                        <li class="dropdown">
                            <a href="#"><span>Appointment</span> <i class="bi bi-chevron-down toggle-dropdown"></i></a>
                            <ul>
                                <li><a href="AddAppointment.jsp">Add Appointment</a></li>
                                <li><a href="AppointmentController?action=list">View Appointment</a></li>


                            </ul>
                        </li>

                    </ul>
                    <i class="mobile-nav-toggle d-xl-none bi bi-list"></i>
                </nav>
            </div>
        </header>


        <main class="main"> 
            <!-- Hero Section -->
            <section id="hero" class="hero section accent-background">
                <img src="img/1.jpg" alt="" data-aos="fade-in">
                <div class="container text-center" data-aos="fade-up" data-aos-delay="100">
                    <h2>Welcome to Aurora Skin Care Clinic</h2>
                    <br>
                    <br>
                    <p>We are experts in dermatology in Colombo</p>
                    <a href="#services" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
                </div>
            </section>



            <!-- Services Section -->
            <section id="services" class="services section">
                <!-- Section Title -->
                <div class="container section-title" data-aos="fade-up">
                    <h2>Services</h2>
                    <a href="#View" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
                </div><!-- End Section Title -->


                <div class="container">
                    <div class="row gy-4">

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="100">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="bi bi-activity icon"></i></div>
                                <h4><a href="PatientRegister.jsp" class="stretched-link">Register Patient</a></h4>
                                <p>Click Here</p>
                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="200">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="bi bi-bounding-box-circles icon"></i></div>
                                <h4><a href="AddAppointment.jsp" class="stretched-link">Make Appointment</a></h4>
                                <p>Click Here</p>
                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="300">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="bi bi-calendar4-week icon"></i></div>
                                <h4><a href="RegisterDermatologists.jsp" class="stretched-link">Register Dermatologists</a></h4>
                                <p>Click Here</p>
                            </div>
                        </div><!-- End Service Item -->

                        <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                            <div class="service-item position-relative">
                                <div class="icon"><i class="bi bi-broadcast icon"></i></div>
                                <h4><a href="AddTreatment.jsp" class="stretched-link">Add New Treatment</a></h4>
                                <p>Click Here</p>
                            </div>
                        </div><!-- End Service Item -->
                        </section>   
                        <br>



                        <section id="View" class="services section">
                            <div class="container section-title" data-aos="fade-up">
                                <h2>View Details </h2>
                                <a href="#Billing" class="btn-scroll" title="Scroll Down"><i class="bi bi-chevron-down"></i></a>
                            </div>

                            <div class="container">
                                <div class="row gy-4">

                                    <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                                        <div class="service-item position-relative">
                                            <div class="icon"><i class="bi bi-broadcast icon"></i></div>
                                            <h4><a href="PatientController?action=list" class="stretched-link">View Patients</a></h4>
                                            <p>Click Here</p>
                                        </div>
                                    </div><!-- End Service Item -->

                                    <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                                        <div class="service-item position-relative">
                                            <div class="icon"><i class="bi bi-broadcast icon"></i></div>
                                            <h4><a href="AppointmentController?action=list" class="stretched-link"></a>View Appointments</h4>
                                            <p>Click Here</p>
                                        </div>
                                    </div><!-- End Service Item -->

                                    <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                                        <div class="service-item position-relative">
                                            <div class="icon"><i class="bi bi-broadcast icon"></i></div>
                                            <h4><a href="DermatologistController?action=list" class="stretched-link">View Dermatologists</a></h4>
                                            <p>Click Here</p>
                                        </div>
                                    </div><!-- End Service Item -->

                                    <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                                        <div class="service-item position-relative">
                                            <div class="icon"><i class="bi bi-broadcast icon"></i></div>
                                            <h4><a href="TreatmentController?action=list" class="stretched-link">View Treatment</a></h4>
                                            <p>Click Here</p>
                                        </div>
                                    </div><!-- End Service Item -->
                                </div>
                            </div>
                        </section><!-- /Services Section -->
                        <br>



                        <section id="Billing" class="services section">
                            <div class="container section-title" data-aos="fade-up">
                                <h2>Billing </h2>
                                
                            </div>

                            <div class="container">
                                <div class="row gy-1">

                                    <div class="col-xl-3 col-md-6 d-flex" data-aos="fade-up" data-aos-delay="400">
                                        <div class="service-item position-relative">
                                            <div class="icon"><i class="bi bi-broadcast icon"></i></div>
                                            <h4><a href="AppointmentController?action=list" class="stretched-link">Invoice</a></h4>
                                            <p>Click Here</p>
                                        </div>
                                    </div>
                                </div>    
                        </section> 





                        <!-- Call To Action Section -->
                        <section id="call-to-action" class="call-to-action section accent-background">

                            <img src="img/2.jpg" alt="">

                            <div class="container">
                                <div class="row justify-content-center" data-aos="zoom-in" data-aos-delay="100">
                                    <div class="col-xl-10">
                                        <div class="text-center">
                                            <h3>Appoinmnets</h3>
                                            <a class="cta-btn" href="AppointmentController?action=list">Check</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section><!-- /Call To Action Section -->
                        </main>
                        <br>
                        <br>
                        <br>



                        <footer id="footer" class="footer dark-background">

                            <div class="container footer-top">
                                <div class="row gy-4">
                                    <div class="col-lg-4 col-md-6 footer-about">
                                        <a href="index.html" class="logo d-flex align-items-center">
                                            <span class="sitename">Squadfree</span>
                                        </a>
                                        <div class="footer-contact pt-3">
                                            <p>A108 Adam Street</p>
                                            <p>New York, NY 535022</p>
                                            <p class="mt-3"><strong>Phone:</strong> <span>+1 5589 55488 55</span></p>
                                            <p><strong>Email:</strong> <span>info@example.com</span></p>
                                        </div>
                                        <div class="social-links d-flex mt-4">
                                            <a href=""><i class="bi bi-twitter-x"></i></a>
                                            <a href=""><i class="bi bi-facebook"></i></a>
                                            <a href=""><i class="bi bi-instagram"></i></a>
                                            <a href=""><i class="bi bi-linkedin"></i></a>
                                        </div>
                                    </div>

                                    <div class="col-lg-2 col-md-3 footer-links">
                                        <h4>Useful Links</h4>
                                        <ul>
                                            <li><a href="#">Home</a></li>
                                            <li><a href="#">About us</a></li>
                                            <li><a href="#">Services</a></li>
                                            <li><a href="#">Terms of service</a></li>
                                            <li><a href="#">Privacy policy</a></li>
                                        </ul>
                                    </div>

                                    <div class="col-lg-6 col-md-1 footer-links">
                                        <h4>Location</h4> 
                                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7921.394273278218!2d79.85675267056916!3d6.92675921935115!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae253d10f7a7003%3A0x320b2e4d32d3838d!2sColombo!5e0!3m2!1sen!2slk!4v1729502352015!5m2!1sen!2slk" width="500" height="200" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                                    </div>


                                </div>
                            </div>

                            <div class="container copyright text-center mt-4">
                                <p>© <span>Copyright</span> <strong class="px-1 sitename">Suraj Herath</strong> <span>All Rights Reserved</span></p>
                                <div class="credits">
                                    <!-- All the links in the footer should remain intact. -->
                                    <!-- You can delete the links only if you've purchased the pro version. -->
                                    <!-- Licensing information: https://bootstrapmade.com/license/ -->
                                    <!-- Purchase the pro version with working PHP/AJAX contact form: [buy-url] -->

                                </div>
                            </div>

                        </footer>

                        <!-- Scroll Top -->
                        <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

                        <!-- Preloader -->
                        <div id="preloader"></div>

                        <!-- Vendor JS Files -->
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