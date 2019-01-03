package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Contact;
import vn.haui.web.utils.tool;

import java.sql.*;
import java.util.ArrayList;

public class ContactDao {
    public ArrayList<Contact> getAllListContact() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM comments";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Contact> list = new ArrayList<Contact>();
        while (rs.next()) {
            Contact contact=new Contact();
            contact.setContact_id(rs.getInt("contact_id"));
            contact.setContact_name(rs.getString("contact_name"));
            contact.setContact_subject(rs.getString("contact_subject"));
            contact.setContact_email(rs.getString("contact_email"));
            contact.setContact_message(rs.getString("contact_message"));
            contact.setContact_data(rs.getDate("contact_date"));
            list.add(contact);
        }
        connection.close();
        return list;
    }
    public Contact getContact(int contact_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM comments where comment_id=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, contact_id);
        ResultSet rs = ps.executeQuery();
        Contact contact = null;
        while (rs.next()) {
            contact=new Contact();
            contact.setContact_id(rs.getInt("contact_id"));
            contact.setContact_name(rs.getString("contact_name"));
            contact.setContact_subject(rs.getString("contact_subject"));
            contact.setContact_email(rs.getString("contact_email"));
            contact.setContact_message(rs.getString("contact_message"));
            contact.setContact_data(rs.getDate("contact_date"));
        }
        connection.close();
        return contact;
    }
    public boolean insert(Contact c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO contact(contact_name,contact_email,contact_subject,contact_message,contact_date) VALUE (?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getContact_name());
            ps.setString(2, c.getContact_email());
            ps.setString(3, c.getContact_subject());
            ps.setString(4, c.getContact_message());
            ps.setDate(5, tool.GetDateNow());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            assert connection != null;
            connection.close();
            return false;
        }
    }
    public boolean update(Contact c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE contact set contact_name=?,contact_email=?,contact_subject=?,contact_message=? where contact_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getContact_name());
            ps.setString(2, c.getContact_email());
            ps.setString(3, c.getContact_subject());
            ps.setString(4, c.getContact_message());
            ps.setInt(5, c.getContact_id());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            assert connection != null;
            connection.close();
            return false;
        }
    }
    public boolean delete(int contact_id) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM contact where contact_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, contact_id);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            assert connection != null;
            connection.close();
            return false;
        }
    }
}
