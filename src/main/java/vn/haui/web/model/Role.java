package vn.haui.web.model;

public class Role {
    private int roleid;
    private String roleName;

    public Role() {
    }

    public Role(int roleid, String roleName) {
        this.roleid = roleid;
        this.roleName = roleName;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }
}
