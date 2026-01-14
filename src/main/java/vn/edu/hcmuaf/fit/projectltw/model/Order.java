package vn.edu.hcmuaf.fit.projectltw.model;

import java.util.Date;
import java.util.List;
import java.util.ArrayList;

public class Order {
    private String id; // Mã đơn hàng (VD: #ORDER-123)
    private String fullName;
    private String phone;
    private String address;
    private String note;
    private double totalMoney;
    private Date date;

    private List<CartItem> details;

    public Order(String id, String fullName, String phone, String address, String note, double totalMoney, List<CartItem> details) {
        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalMoney = totalMoney;
        this.details = details;
        this.date = new Date();
    }

    public String getId() { return id; }
    public String getFullName() { return fullName; }
    public String getPhone() { return phone; }
    public String getAddress() { return address; }
    public double getTotalMoney() { return totalMoney; }
    public Date getDate() { return date; }
    public List<CartItem> getDetails() { return details; }
}