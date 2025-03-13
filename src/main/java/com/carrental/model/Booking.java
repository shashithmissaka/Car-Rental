package com.carrental.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Booking {
    private int id;
    private String username;
    private int carId;
    private String carName;
    private String startLocation;
    private String destination;
    private BigDecimal price;
    private BigDecimal discountedPrice; // New field
    private BigDecimal taxAmount; // New field
    private BigDecimal finalPrice; // New field
    private String paymentStatus;
    private Timestamp createdAt;
    private int driverId;
    private String paymentMethod;
    private String carType;
    private String transactionId;
    private int distance;

    // Constructor with all parameters including new fields
    public Booking(int id, String username, int carId, String carName, String startLocation,
            String destination, BigDecimal price, BigDecimal discountedPrice, BigDecimal taxAmount, 
            BigDecimal finalPrice, String paymentStatus, Timestamp createdAt, int driverId, 
            String paymentMethod, String carType, int distance, String transactionId) {
        this.id = id;
        this.username = username;
        this.carId = carId;
        this.carName = carName;
        this.startLocation = startLocation;
        this.destination = destination;
        this.price = price;
        this.discountedPrice = discountedPrice;
        this.taxAmount = taxAmount;
        this.finalPrice = finalPrice;
        this.paymentStatus = paymentStatus;
        this.createdAt = createdAt;
        this.driverId = driverId;
        this.paymentMethod = paymentMethod;
        this.carType = carType;
        this.distance = distance;
        this.transactionId = transactionId;
    }

    // Getters and setters for new fields
    public BigDecimal getDiscountedPrice() {
        return discountedPrice;
    }

    public void setDiscountedPrice(BigDecimal discountedPrice) {
        this.discountedPrice = discountedPrice;
    }

    public BigDecimal getTaxAmount() {
        return taxAmount;
    }

    public void setTaxAmount(BigDecimal taxAmount) {
        this.taxAmount = taxAmount;
    }

    public BigDecimal getFinalPrice() {
        return finalPrice;
    }

    public void setFinalPrice(BigDecimal finalPrice) {
        this.finalPrice = finalPrice;
    }

    public String getCarType() {
        return carType;
    }

    public void setCarType(String carType) {
        this.carType = carType;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getDriverId() {
        return driverId;
    }

    public void setDriverId(int driverId) {
        this.driverId = driverId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public String getStartLocation() {
        return startLocation;
    }

    public void setStartLocation(String startLocation) {
        this.startLocation = startLocation;
    }

    public String getDestination() {
        return destination;
    }

    public void setDestination(String destination) {
        this.destination = destination;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public int getDistance() {
        return distance;
    }

    public void setDistance(int distance) {
        this.distance = distance;
    }
}
