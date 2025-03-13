package com.carrental.model;

public class Driver {
    
    private int driverId;
    private String driverName;
    private String phone;

    // Default constructor
    public Driver() {}

    // Constructor with parameters (can be used when creating a driver manually)
    public Driver(int driverId, String driverName, String phone) {
        this.driverId = driverId;
        this.driverName = driverName;
        this.phone = phone;
    }

    // Getters and Setters
    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public String getDriverName() {
        return driverName;
    }

    public void setDriverName(String driverName) {
        this.driverName = driverName;
    }

    public String getPhone() {
        return phone;
    }

    // Validates the phone number format before setting it
    public void setPhone(String phone) {
        // Basic phone number validation (adjust pattern as needed)
        if (phone != null && phone.matches("\\d{10}")) {
            this.phone = phone;
        } else {
            throw new IllegalArgumentException("Invalid phone number format. It should be 10 digits.");
        }
    }

    // Method to display driver details (optional)
    @Override
    public String toString() {
        return "Driver [driverId=" + driverId + ", driverName=" + driverName + ", phone=" + phone + "]";
    }
}
