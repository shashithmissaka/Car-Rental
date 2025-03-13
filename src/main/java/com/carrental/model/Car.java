package com.carrental.model;

import java.math.BigDecimal;
import java.util.Objects;

public class Car {
    private int id;
    private String carName;
    private String carType;
    private String startLocation;
    private String destination;
    private BigDecimal price;
    private boolean availability;
    private int driverId;
    private int distance; // Added distance field

    // Default Constructor
    public Car() {}

    // Parameterized Constructor
    public Car(int id, String carName, String carType, String startLocation, String destination, BigDecimal price, boolean availability, int driverId, int distance) {
        this.id = id;
        this.carName = carName;
        this.carType = carType;
        this.startLocation = startLocation;
        this.destination = destination;
        setPrice(price);
        this.availability = availability;
        this.driverId = driverId;
        this.distance = distance; // Set the distance
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getCarName() { return carName; }
    public void setCarName(String carName) { this.carName = carName; }

    public String getCarType() { return carType; }
    public void setCarType(String carType) { this.carType = carType; }

    public String getStartLocation() { return startLocation; }
    public void setStartLocation(String startLocation) { this.startLocation = startLocation; }

    public String getDestination() { return destination; }
    public void setDestination(String destination) { this.destination = destination; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) {
        if (price == null || price.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Price must be a positive value");
        }
        this.price = price;
    }

    public boolean isAvailable() { return availability; }
    public void setAvailable(boolean availability) { this.availability = availability; }

    public int getDriverId() { return driverId; }
    public void setDriverId(int driverId) { this.driverId = driverId; }

    public int getDistance() { return distance; } // Getter for distance
    public void setDistance(int distance) { this.distance = distance; } // Setter for distance

    // Equals and HashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Car car = (Car) o;
        return id == car.id && driverId == car.driverId && availability == car.availability && distance == car.distance && // Compare distance
               Objects.equals(carName, car.carName) &&
               Objects.equals(carType, car.carType) &&
               Objects.equals(startLocation, car.startLocation) &&
               Objects.equals(destination, car.destination) &&
               Objects.equals(price, car.price);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, carName, carType, startLocation, destination, price, availability, driverId, distance); // Include distance in hashCode
    }

    // Comparator for sorting cars by price
    public static class CarPriceComparator implements java.util.Comparator<Car> {
        @Override
        public int compare(Car c1, Car c2) {
            return c1.getPrice().compareTo(c2.getPrice());
        }
    }

    // ToString method for debugging/logging
    @Override
    public String toString() {
        return "Car{" +
                "id=" + id +
                ", carName='" + carName + '\'' +
                ", carType='" + carType + '\'' +
                ", startLocation='" + startLocation + '\'' +
                ", destination='" + destination + '\'' +
                ", price=" + price +
                ", availability=" + availability +
                ", driverId=" + driverId +
                ", distance=" + distance + // Include distance in toString
                '}';
    }
}
