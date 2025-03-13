package com.carrental.model;

public class User {
    private int id;
    private String username;
    private String password;
    private String phone;
    private String nic;
    private String email; // Add the email property

    // Constructor
    public User() {}

    public User(String username, String password, String phone, String nic, String email) {
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.nic = nic;
        this.email = email; // Set the email in the constructor
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getEmail() { return email; }  // Getter for email
    public void setEmail(String email) { this.email = email; }  // Setter for email
}
