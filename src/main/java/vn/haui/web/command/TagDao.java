package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Tag;

import java.sql.*;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TagDao {
    public ArrayList<Tag> getSetting() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM tag";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Tag> list = new ArrayList<Tag>();
        while (rs.next()) {
            Tag  tag = new Tag();
            tag.setTag_id(rs.getInt("tag_id"));
            tag.setTag_post_id(rs.getInt("tag_post_id"));
            tag.setTag_content(rs.getString("tag_content"));
            list.add(tag);
        }
        connection.close();
        return list;
    }
    public boolean insert(Tag tag) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO tag(tag_id,tag_post_id,tag_content) values(?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, tag.getTag_id());
            ps.setInt(2, tag.getTag_post_id());
            ps.setString(3, tag.getTag_content());
            ps.executeUpdate();
            connection.close();
            return true;
        } catch (SQLException e) {
            Logger.getLogger(UsersDao.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            connection.close();
        }
        return false;
    }
    public boolean update(Tag tag) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE tag set tag_content=? where tag_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, tag.getTag_content());
            ps.setInt(2, tag.getTag_id());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean delete(int id) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM tag WHERE tag_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
}
