package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Role;
import vn.haui.web.model.Social;

import java.sql.*;
import java.util.ArrayList;

public class RoleDao {
    public ArrayList<Role> getListRole() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM role";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Role> list = new ArrayList<Role>();
        while (rs.next()) {
            Role role = new Role();
            role.setRoleid(rs.getInt("roleid"));
            role.setRoleName(rs.getString("name"));
            list.add(role);
        }
        connection.close();
        return list;
    }
    public Role getRole(int role_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM role WHERE roleid="+role_id;
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        Role role = null;
        while (rs.next()) {
            role = new Role();
            role.setRoleid(rs.getInt("roleid"));
            role.setRoleName(rs.getString("name"));
        }
        connection.close();
        return role;
    }
    public boolean insert(Role s) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO role(roleid, name) VALUE(?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, s.getRoleid());
            ps.setString(2, s.getRoleName());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean update(Role s) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE role set role.name=? where roleid=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, s.getRoleName());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean delete(int role_id) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM role WHERE roleid = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, role_id);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean deleteAll() throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM role";
            PreparedStatement ps = connection.prepareStatement(sql);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
}
