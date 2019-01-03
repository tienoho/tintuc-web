package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Comment;
import java.sql.*;
import java.util.ArrayList;

public class CommentDao {
    public ArrayList<Comment> getAllListComment() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM comments";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Comment> list = new ArrayList<Comment>();
        while (rs.next()) {
            Comment comment=new Comment();
            comment.setComment_id(rs.getInt("comment_id"));
            comment.setComment_post_id(rs.getInt("comment_post_id"));
            comment.setComment_author(rs.getString("comment_author"));
            comment.setComment_author_email(rs.getString("comment_author_email"));
            comment.setComment_date(rs.getDate("comment_date"));
            comment.setComment_content(rs.getString("comment_content"));
            comment.setComment_parent(rs.getInt("comment_parent"));
            list.add(comment);
        }
        connection.close();
        return list;
    }
    public ArrayList<Comment> getListCommentByPost(int post_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM comments where comment_post_id=? and comment_status=0 and comment_parent=0";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, post_id);
        ResultSet rs = ps.executeQuery();
        ArrayList<Comment> list = new ArrayList<Comment>();
        while (rs.next()) {
            Comment comment=new Comment();
            comment.setComment_id(rs.getInt("comment_id"));
            comment.setComment_post_id(rs.getInt("comment_post_id"));
            comment.setComment_author(rs.getString("comment_author"));
            comment.setComment_author_email(rs.getString("comment_author_email"));
            comment.setComment_date(rs.getDate("comment_date"));
            comment.setComment_content(rs.getString("comment_content"));
            comment.setComment_parent(rs.getInt("comment_parent"));
            list.add(comment);
        }
        connection.close();

        return list;
    }
    public ArrayList<Comment> getListCommentByParent(int comment_parent) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM comments where comment_parent=? and comment_status=0";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, comment_parent);
        ResultSet rs = ps.executeQuery();
        ArrayList<Comment> list = new ArrayList<Comment>();
        while (rs.next()) {
            Comment comment=new Comment();
            comment.setComment_id(rs.getInt("comment_id"));
            comment.setComment_post_id(rs.getInt("comment_post_id"));
            comment.setComment_author(rs.getString("comment_author"));
            comment.setComment_author_email(rs.getString("comment_author_email"));
            comment.setComment_date(rs.getDate("comment_date"));
            comment.setComment_content(rs.getString("comment_content"));
            comment.setComment_parent(rs.getInt("comment_parent"));
            list.add(comment);
        }
        connection.close();

        return list;
    }
    public Comment getComment(int comment_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM comments where comment_id=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, comment_id);
        ResultSet rs = ps.executeQuery();
        Comment comment = null;
        while (rs.next()) {
            comment=new Comment();
            comment.setComment_id(rs.getInt("comment_id"));
            comment.setComment_post_id(rs.getInt("comment_post_id"));
            comment.setComment_author(rs.getString("comment_author"));
            comment.setComment_author_email(rs.getString("comment_author_email"));
            comment.setComment_date(rs.getDate("comment_date"));
            comment.setComment_content(rs.getString("comment_content"));
            comment.setComment_parent(rs.getInt("comment_parent"));
        }
        connection.close();
        return comment;
    }

    public boolean insert(Comment c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO comments(comment_post_id,comment_author,comment_author_email,comment_date,comment_content,comment_parent) VALUE (?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getComment_post_id());
            ps.setString(2, c.getComment_author());
            ps.setString(3, c.getComment_author_email());
            ps.setDate(4, c.getComment_date());
            ps.setString(5, c.getComment_content());
            ps.setInt(6, c.getComment_parent());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            assert connection != null;
            connection.close();
            return false;
        }
    }
    public boolean update(Comment c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE comments set comment_status=?,comment_author=?,comment_author_email=?,comment_content=? where comment_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getComment_status());
            ps.setString(2, c.getComment_author());
            ps.setString(3, c.getComment_author_email());
            ps.setString(4, c.getComment_content());
            ps.setInt(5, c.getComment_id());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            assert connection != null;
            connection.close();
            return false;
        }
    }
    public boolean delete(int comment_id) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM comments where comment_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, comment_id);
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
