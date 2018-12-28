package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Social;

import java.sql.*;
import java.util.ArrayList;

public class SocialDao {
    public ArrayList<Social> getListSocial() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM social_option";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Social> list = new ArrayList<Social>();
        while (rs.next()) {
            Social social = new Social();
            social.setSocial_id(rs.getInt("social_id"));
            social.setSocial_name(rs.getString("social_name"));
            social.setSocial_url(rs.getString("social_url"));
            social.setSocial_title(rs.getString("social_title"));
            social.setSocial_icon(rs.getString("social_icon"));
            list.add(social);
        }
        connection.close();
        return list;
    }
    public Social getSocial(int social_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM social_option WHERE social_id="+social_id;
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        Social social = null;
        while (rs.next()) {
            social = new Social();
            social.setSocial_id(rs.getInt("social_id"));
            social.setSocial_name(rs.getString("social_name"));
            social.setSocial_url(rs.getString("social_url"));
            social.setSocial_title(rs.getString("social_title"));
            social.setSocial_icon(rs.getString("social_icon"));
        }
        connection.close();
        return social;
    }
    public boolean insert(Social s) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO social_option(social_name, social_url, social_title,social_icon) VALUE(?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, s.getSocial_name());
            ps.setString(2, s.getSocial_url());
            ps.setString(3, s.getSocial_title());
            ps.setString(4, s.getSocial_icon());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }

    public boolean update(Social s) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE social_option set social_name=?, social_url=?, social_title=?,social_icon=? where social_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, s.getSocial_name());
            ps.setString(2, s.getSocial_url());
            ps.setString(3, s.getSocial_title());
            ps.setString(4, s.getSocial_icon());
            ps.setInt(5, s.getSocial_id());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }


    public boolean delete(int social_id) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM social_option WHERE social_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, social_id);
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
            String sql = "DELETE FROM social_option";
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
