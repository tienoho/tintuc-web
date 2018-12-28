package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.HitCounter;

import java.sql.*;
import java.util.ArrayList;

public class HitCounterDao {
    public ArrayList<HitCounter> getListHitCounter() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM hit_counter_post";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<HitCounter> list = new ArrayList<HitCounter>();
        while (rs.next()) {
            HitCounter hitCounter = new HitCounter();
            hitCounter.setIdPost(rs.getInt("idPost"));
            hitCounter.setHitCounter(rs.getInt("hitCounter"));
            list.add(hitCounter);
        }
        connection.close();
        return list;
    }

    public HitCounter getHitCounter(int idPost) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM hit_counter_post where id_post=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, idPost);
        ResultSet rs = ps.executeQuery();
        HitCounter hitCounter = null;
        while (rs.next()) {
            hitCounter = new HitCounter();
            hitCounter.setIdPost(rs.getInt("idPost"));
            hitCounter.setHitCounter(rs.getInt("hitCounter"));
        }
        connection.close();
        return hitCounter;
    }
    public int getCountHitCounter(int postID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT hit_counter FROM hit_counter_post WHERE id_post = ?";

        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1,postID);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        connection.close();
        return count;
    }
    public boolean insert(HitCounter c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO hit_counter_post(id_post,hit_counter) VALUE (?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getIdPost());
            ps.setInt(2, c.getHitCounter());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean update(HitCounter c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE hit_counter_post set hit_counter=? where id_post=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getHitCounter());
            ps.setInt(2, c.getIdPost());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
}
