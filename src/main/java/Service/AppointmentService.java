/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author suraj
 */
import Model.Appointment;
import Model.Patient;
import Model.Schedule;
import Model.TimeRange;
import Utils.AuroraSkinCareDB;
import java.sql.*;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.List;
import Service.ScheduleService;
import Service.TimeRangeService;
import java.sql.Date;
import java.sql.Time;

public class AppointmentService {

    private final AuroraSkinCareDB db = new AuroraSkinCareDB();
    private final PatientService patientService = new PatientService();
    private final ScheduleService scheduleService = new ScheduleService();
    private final TimeRangeService timeRangeService = new TimeRangeService();

    
    
    
   
    

    public Patient searchPatient(String query) {
        List<Patient> patients = patientService.searchPatients(query);
        if (!patients.isEmpty()) {
            return patients.get(0); // Return the first matched patient
        }
        return null; // No patient found
    }

    
 

   
   // Method to add an appointment
public boolean addAppointment(Appointment appointment) {
     java.util.Date utilDate = appointment.getA_Date();  // This is a java.util.Date object
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());  
    
    String query = "INSERT INTO appointment (a_ID, p_ID, e_ID, a_Date, a_time, time_range_ID, schedule_ID, t_ID, reg_Fee, t_Price, a_Status) "
                 + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

    try (Connection connection = db.getConnection();
         PreparedStatement stmt = connection.prepareStatement(query)) {

        // Setting parameters in the prepared statement from the Appointment object
        stmt.setString(1, appointment.getA_ID());
        stmt.setString(2, appointment.getP_ID());
        stmt.setString(3, appointment.getE_ID());
        stmt.setDate(4, (Date) appointment.getA_Date());      // Java.sql.Date expected
        stmt.setTime(5, appointment.getA_time());      // Java.sql.Time expected
        stmt.setInt(6, appointment.getTime_range_ID());
        stmt.setInt(7, appointment.getSchedule_ID());
        stmt.setString(8, appointment.getT_ID());
        stmt.setDouble(9, appointment.getReg_Fee());
        stmt.setDouble(10, appointment.getT_Price());
        stmt.setString(11, appointment.getA_Status());

        // Execute the update and check if insertion was successful
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}


    // Method to check if the appointment time slot is available
    public boolean isTimeSlotAvailable(int timeRangeID) {
        return timeRangeService.isTimeSlotAvailable(timeRangeID); // Assume this checks slot availability
    }

    // Method to mark the time slot as booked after adding the appointment
    public boolean markTimeSlotAsBooked(int timeRangeID, String p_ID) {
        return timeRangeService.markAsBooked(timeRangeID, p_ID); // Assume this marks the slot as booked
    }




  // Update an appointment
    public boolean updateAppointment(Appointment appointment) {
    java.util.Date utilDate = appointment.getA_Date();
    java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());

    String query = "UPDATE appointment SET p_ID = ?, e_ID = ?, a_Date = ?, a_time = ?, time_range_ID = ?, schedule_ID = ?, t_ID = ?, reg_Fee = ?, t_Price = ?, a_Status = ? "
                 + "WHERE a_ID = ?";

    try (Connection connection = db.getConnection();
         PreparedStatement stmt = connection.prepareStatement(query)) {

        // Set parameters for the prepared statement
        stmt.setString(1, appointment.getP_ID());
        stmt.setString(2, appointment.getE_ID());
        stmt.setDate(3, sqlDate);   // Java.sql.Date
        stmt.setTime(4, appointment.getA_time());  // Java.sql.Time
        stmt.setInt(5, appointment.getTime_range_ID());
        stmt.setInt(6, appointment.getSchedule_ID());
        stmt.setString(7, appointment.getT_ID());
        stmt.setDouble(8, appointment.getReg_Fee());
        stmt.setDouble(9, appointment.getT_Price());
        stmt.setString(10, appointment.getA_Status());
        stmt.setString(11, appointment.getA_ID());  // The ID to find the appointment to update

        // Execute the update query
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;  // Return true if one row was updated

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}



    // Delete an appointment
    public boolean deleteAppointment(String a_ID) {
        String sql = "DELETE FROM appointment WHERE a_ID = ?";
        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, a_ID);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get an appointment by ID
    public Appointment getAppointmentbyId(String a_ID) {
        String sql = "SELECT * FROM Appointment WHERE a_ID=?";
        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, a_ID);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return new Appointment(
                        resultSet.getString("a_ID"),
                        resultSet.getString("p_ID"),
                        resultSet.getString("e_ID"),
                        resultSet.getDate("a_Date"),
                        resultSet.getTime("a_time"),
                        resultSet.getString("t_ID"),
                        resultSet.getDouble("reg_Fee"),
                        resultSet.getDouble("t_Price"),
                        resultSet.getString("a_Status"),
                        resultSet.getInt("schedule_ID"),
                        resultSet.getInt("time_range_ID")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // List all appointments
    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT * FROM Appointment";
        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                appointments.add(new Appointment(
                        resultSet.getString("a_ID"),
                        resultSet.getString("p_ID"),
                        resultSet.getString("e_ID"),
                        resultSet.getDate("a_Date"),
                        resultSet.getTime("a_time"),
                        resultSet.getString("t_ID"),
                        resultSet.getDouble("reg_Fee"),
                        resultSet.getDouble("t_Price"),
                        resultSet.getString("a_Status"),
                        resultSet.getInt("schedule_ID"),
                        resultSet.getInt("time_range_ID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    // Search appointments by ID, patient ID, or employee ID
    public List<Appointment> searchAppointments(String searchTerm) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT * FROM Appointment WHERE a_ID LIKE ? OR p_ID LIKE ? OR e_ID LIKE ?";
        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            String query = "%" + searchTerm + "%";
            statement.setString(1, query);
            statement.setString(2, query);
            statement.setString(3, query);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                appointments.add(new Appointment(
                        resultSet.getString("a_ID"),
                        resultSet.getString("p_ID"),
                        resultSet.getString("e_ID"),
                        resultSet.getDate("a_Date"),
                        resultSet.getTime("a_time"),
                        resultSet.getString("t_ID"),
                        resultSet.getDouble("reg_Fee"),
                        resultSet.getDouble("t_Price"),
                        resultSet.getString("a_Status"),
                        resultSet.getInt("schedule_ID"),
                        resultSet.getInt("time_range_ID")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    // Reset weekly slots
    public void resetWeeklySlots() {
        String resetQuery = "UPDATE TimeRange SET is_booked = FALSE, patient_id = NULL";
        try (Connection connection = db.getConnection(); PreparedStatement statement = connection.prepareStatement(resetQuery)) {
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    
}
