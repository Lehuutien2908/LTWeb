package vn.edu.hcmuaf.fit.projectltw.model;

import java.util.Date;
import java.util.List;

public class Order {
    private String id;
    private String fullName;
    private String phone;
    private String address;
    private String note;
    private double totalMoney;
    private Date date;

    // Đổi tên từ 'details' thành 'items' để khớp với OrderDAO
    private List<CartItem> items;

    public Order(String id, String fullName, String phone, String address, String note, double totalMoney, List<CartItem> items) {
        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.note = note;
        this.totalMoney = totalMoney;
        this.items = items;
        this.date = new Date();
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public double getTotalMoney() {
        return totalMoney;
    }

    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
    }
}