package vn.haui.web.model;

import java.sql.Date;

public class Users {
    private String email;
    private String password;
    private String fullName;
    private Date createdDate;
    private String img;
    private int roleId;


    public Users() {

    }

    public Users(String email, String password, String fullName, Date createdDate, String img, int roleId) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.createdDate = createdDate;
        this.img = img;
        this.roleId = roleId;
    }

    public Users(String email, String password, String fullName, Date createdDate, int roleId) {
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.createdDate = createdDate;
        this.roleId = roleId;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}
