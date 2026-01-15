package vn.edu.hcmuaf.fit.projectltw.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {
    private String id;
    private int userId;
    private String fullName;
    private String phone;
    private String address;
    private int totalQuantity;
    private double totalMoney;
    private int status;
    private Date date;

    private String listProductNames;

    public Order(String id, int userId, String fullName, String phone, String address, int totalQuantity, double totalMoney, int status, Date date) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.totalQuantity = totalQuantity;
        this.totalMoney = totalMoney;
        this.status = status;
        this.date = new Date();
    }

    public Order(){
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

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getListProductNames() {
        return listProductNames;
    }

    public void setListProductNames(String listProductNames) {
        this.listProductNames = listProductNames;
    }

}