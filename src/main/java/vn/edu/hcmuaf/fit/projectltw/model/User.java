package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class User implements Serializable {
    private int id;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private int role; // 0: User, 1: Admin
//    private Timestamp createdAt;

    public User() {
    }

    public User(int id, String password, String fullName, String email, String phone, String address, int role) {
        this.id = id;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
//        this.createdAt = createdAt;
    }

    // 3. Getters và Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public int getRole() { return role; }
    public void setRole(int role) { this.role = role; }

//    public Timestamp getCreatedAt() { return createdAt; }
//    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", role=" + role +
                '}';
    }
}