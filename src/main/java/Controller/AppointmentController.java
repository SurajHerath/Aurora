package Controller;

import Model.Appointment;
import Model.Patient;
import Model.TimeRange;
import Service.AppointmentService;
import Service.ScheduleService;
import Service.TimeRangeService;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Time;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.sql.Time;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@WebServlet("/AppointmentController")
public class AppointmentController extends HttpServlet {

    private AppointmentService appointmentService = new AppointmentService();
    private ScheduleService scheduleService = new ScheduleService();
    private TimeRangeService timeRangeService = new TimeRangeService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "list":
                    listAppointments(request, response);
                    break;
                case "delete":
                    deleteAppointment(request, response);
                    break;
                case "edit":
                    editAppointment(request, response);
                    break;
                case "search":
                    searchAppointments(request, response);
                    break;
                case "searchPatient":
                    searchPatient(request, response);
                    break;

                case "get":
                    getAppointment(request, response);
                    break;
                case "reset":
                    resetWeeklySlots(request, response);
                    break;
                case "getAvailableTimeSlots":
                    getAvailableTimeSlots(request, response);
                    break;
                default:
                    response.sendRedirect("error.jsp");
                    break;
            }

        } else {
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "add":
                    addAppointment(request, response);
                    break;
                case "update":
                    updateAppointment(request, response);
                    break;

                default:
                    response.sendRedirect("error.jsp");
                    break;
            }
        }
    }

    private void addAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String a_ID = request.getParameter("a_ID");
        String p_ID = request.getParameter("p_ID");
        String e_ID = request.getParameter("e_ID");
        String t_ID = request.getParameter("TreatmentID");
        String a_Status = request.getParameter("appointmentStatus");
        double reg_Fee = Double.parseDouble(request.getParameter("registrationFee"));
        double t_Price = Double.parseDouble(request.getParameter("treatmentPrice"));
        int schedule_ID = Integer.parseInt(request.getParameter("scheduleID"));
        int time_range_ID = Integer.parseInt(request.getParameter("timeRangeID"));
        String dateStr = request.getParameter("a_Date");
        String timeStr = request.getParameter("startTime");

        // Parse date and time strings using SimpleDateFormat
        Date a_Date = null;
        Time a_Time = null;

        try {
            if (dateStr != null && !dateStr.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = dateFormat.parse(dateStr);
                a_Date = new Date(parsedDate.getTime());
                System.out.println("Parsed Appointment Date: " + a_Date);
            } else {
                request.setAttribute("error", "Date is required.");
                request.getRequestDispatcher("appointmentForm.jsp").forward(request, response);
                return;
            }

            if (timeStr != null && !timeStr.isEmpty()) {
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                java.util.Date parsedTime = timeFormat.parse(timeStr);
                a_Time = new Time(parsedTime.getTime());
                System.out.println("Parsed Appointment Time: " + a_Time);

            } else {
                request.setAttribute("error", "Time is required.");
                request.getRequestDispatcher("appointmentForm.jsp").forward(request, response);
                return;
            }

        } catch (ParseException e) {
            e.printStackTrace(); // Log the exception for debugging
            request.setAttribute("error", "Invalid date or time format: " + e.getMessage());
            request.getRequestDispatcher("appointmentForm.jsp").forward(request, response);
            return;
        }

        // Check if time slot is available
        boolean isAvailable = timeRangeService.isTimeSlotAvailable(time_range_ID);
        if (isAvailable) {
            Appointment appointment = new Appointment(a_ID, p_ID, e_ID, a_Date, a_Time, t_ID, reg_Fee, t_Price, a_Status, schedule_ID, time_range_ID);

            // Log appointment data for debugging
            System.out.println("Appointment Object: " + appointment.toString());

            boolean appointmentAdded = appointmentService.addAppointment(appointment);
            if (appointmentAdded) {
                // Log success and alert
                System.out.println("Appointment added successfully!");
                timeRangeService.markAsBooked(time_range_ID, p_ID);
                request.setAttribute("success", "Appointment added successfully.");
                request.getRequestDispatcher("AppointmentController?action=list").forward(request, response);  // Redirect to appointment list or success page
            } else {
                request.setAttribute("error", "Failed to add appointment. Please try again.");
                request.getRequestDispatcher("appointmentForm.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "Selected time slot is not available.");
            request.getRequestDispatcher("appointmentForm.jsp").forward(request, response);
        }
    }

// Method to handle "getAvailableTimeSlots" action
    private void getAvailableTimeSlots(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String eID = request.getParameter("eID");
        String dayOfWeek = request.getParameter("dayOfWeek");

        System.out.println("Received eID: " + eID); // Debugging
        System.out.println("Received dayOfWeek: " + dayOfWeek); // Debugging

        List<TimeRange> availableTimeSlots = new ArrayList<>();
        try {
            ScheduleService scheduleService = new ScheduleService();
            Integer scheduleId = scheduleService.getScheduleByDermatologistAndDay(eID, dayOfWeek);
            if (scheduleId != null) {
                TimeRangeService timeRangeService = new TimeRangeService();
                availableTimeSlots = timeRangeService.getAvailableTimeRangesByScheduleId(scheduleId);
            }
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            new Gson().toJson(availableTimeSlots, out);
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    private void listAppointments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Appointment> appointments = appointmentService.getAllAppointments();
            request.setAttribute("appointments", appointments);
            request.getRequestDispatcher("ViewAppointment.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("error.jsp");
        }
    }

    private void searchAppointments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String searchTerm = request.getParameter("searchTerm");
        List<Appointment> appointments = appointmentService.searchAppointments(searchTerm);
        request.setAttribute("appointments", appointments);
        request.getRequestDispatcher("AppointmentController?action=list").forward(request, response);
    }

    private void getAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String a_ID = request.getParameter("a_ID");
        Appointment appointment = appointmentService.getAppointmentbyId(a_ID);
        if (appointment != null) {
            request.setAttribute("appointment", appointment);
            request.getRequestDispatcher("AppointmentController?action=list").forward(request, response);
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void editAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String a_ID = request.getParameter("a_ID");  // Get appointment ID from request
            Appointment appointment = appointmentService.getAppointmentbyId(a_ID);  // Get appointment by ID

            if (appointment != null) {
                // Set appointment as request attribute to populate the edit form
                request.setAttribute("appointment", appointment);

                // Forward to the update appointment JSP page
                request.getRequestDispatcher("/UpdateAppointment.jsp").forward(request, response);
            } else {
                // If appointment not found, redirect to appointment list page
                response.sendRedirect("AppointmentController?action=list");
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error in editAppointment: " + e.getMessage());
            // Redirect to error page in case of exception
            response.sendRedirect("error.jsp");
        }
    }

    private void updateAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String a_ID = request.getParameter("a_ID");
        String p_ID = request.getParameter("p_ID");
        String e_ID = request.getParameter("e_ID");
        String t_ID = request.getParameter("t_ID");
        String a_Status = request.getParameter("a_Status");
        double reg_Fee = Double.parseDouble(request.getParameter("reg_Fee"));
        double t_Price = Double.parseDouble(request.getParameter("t_Price"));
        int schedule_ID = Integer.parseInt(request.getParameter("schedule_ID"));
        int time_range_ID = Integer.parseInt(request.getParameter("time_range_ID"));
        String dateStr = request.getParameter("a_Date");
        String timeStr = request.getParameter("a_time");

        // Parse date and time strings using SimpleDateFormat
        Date a_Date = null;
        Time a_time = null;

        try {
            if (dateStr != null && !dateStr.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date parsedDate = dateFormat.parse(dateStr);
                a_Date = new Date(parsedDate.getTime());
            } else {
                request.setAttribute("error", "Date is required.");
                request.getRequestDispatcher("updateAppointment.jsp").forward(request, response);
                return;
            }

            if (timeStr != null && !timeStr.isEmpty()) {
                SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
                java.util.Date parsedTime = timeFormat.parse(timeStr);
                a_time = new Time(parsedTime.getTime());
            } else {
                request.setAttribute("error", "Time is required.");
                request.getRequestDispatcher("updateAppointment.jsp").forward(request, response);
                return;
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid date or time format: " + e.getMessage());
            request.getRequestDispatcher("updateAppointment.jsp").forward(request, response);
            return;
        }

        // Create appointment object for updating
        Appointment appointment = new Appointment(a_ID, p_ID, e_ID, a_Date, a_time, t_ID, reg_Fee, t_Price, a_Status, schedule_ID, time_range_ID);

        // Call service method to update appointment
        boolean isUpdated = appointmentService.updateAppointment(appointment);
        if (isUpdated) {
            request.setAttribute("success", "Appointment updated successfully.");
            request.getRequestDispatcher("AppointmentController?action=list").forward(request, response);
        } else {
            request.setAttribute("error", "Failed to update appointment.");
            request.getRequestDispatcher("updateAppointment.jsp").forward(request, response);
        }
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String a_ID = request.getParameter("a_ID");
        boolean success = appointmentService.deleteAppointment(a_ID);

        if (success) {
            response.sendRedirect("AppointmentController?action=list");
        } else {
            response.sendRedirect("error.jsp");
        }
    }

    private void searchPatient(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String query = request.getParameter("query");
        Patient patient = appointmentService.searchPatient(query);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("patient", patient);

        Gson gson = new Gson();
        PrintWriter out = response.getWriter();
        out.print(gson.toJson(responseData));
        out.flush();
    }

    private void resetWeeklySlots(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        appointmentService.resetWeeklySlots();
        response.sendRedirect("AppointmentController?action=list");
    }

}
