package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Category;
import vn.haui.web.model.TermsRelationships;

import java.sql.*;
import java.util.ArrayList;

public class TermsRelationshipsDao {
    public ArrayList<TermsRelationships> getListTermsRelationships() throws SQLException {

        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM terms_relationships";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<TermsRelationships> list = new ArrayList<TermsRelationships>();
        while (rs.next()) {
            TermsRelationships termsRelationships = new TermsRelationships();
            termsRelationships.setPostID(rs.getInt("post_id"));
            termsRelationships.setCategoryID(rs.getInt("category_id"));
            termsRelationships.setOrder(rs.getInt("ordera"));
            list.add(termsRelationships);
        }
        connection.close();
        return list;
    }
    public ArrayList<TermsRelationships> getListTermsRelationshipsByPostID(int postId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM terms_relationships where post_id="+postId;
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<TermsRelationships> list = new ArrayList<TermsRelationships>();
        while (rs.next()) {
            TermsRelationships termsRelationships = new TermsRelationships();
            termsRelationships.setPostID(rs.getInt("post_id"));
            termsRelationships.setCategoryID(rs.getInt("category_id"));
            termsRelationships.setOrder(rs.getInt("ordera"));
            list.add(termsRelationships);
        }
        connection.close();
        return list;
    }
    public boolean insert(TermsRelationships c) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO terms_relationships(post_id, category_id, ordera) VALUE(?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getPostID());
            ps.setInt(2, c.getCategoryID());
            ps.setInt(3, c.getOrder());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }

    public boolean update(TermsRelationships c) throws SQLException {
        Connection connection=null;
        try {
             connection = DBConnect.getConnecttion();
            String sql = "UPDATE terms_relationships set category_id=?, ordera=? where  post_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getCategoryID());
            ps.setInt(2, c.getOrder());
            ps.setInt(3, c.getPostID());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;

        } catch (Exception e) {
            connection.close();
            return false;
        }
    }


    public boolean delete(int post_id) throws SQLException {
        Connection connection=null;
        try {
             connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM terms_relationships WHERE  post_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, post_id);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
}
