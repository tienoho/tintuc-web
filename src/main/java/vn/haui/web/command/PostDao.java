package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Post;

import java.sql.*;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class PostDao {
    //lấy ra danh sách các post
    //lấy ra thông tin chi tiết post
    public ArrayList<Post> getListPostByCategory(String column, int ID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post where " + column + "=" + ID;
        PreparedStatement st = connection.prepareStatement(sql);
        // st.setInt(1,categoryID);
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            list.add(post);
        }
        connection.close();
        return list;
    }
    //Get All
    public ArrayList<Post> getListAllPost() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post order by post_date desc";
        PreparedStatement st = connection.prepareStatement(sql);
        // st.setInt(1,categoryID);
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            list.add(post);
        }
        connection.close();
        return list;
    }
    //Get All new
    public ArrayList<Post> getListAllPostNew(int maxpost) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post  order by post_date desc limit "+maxpost;
        PreparedStatement st = connection.prepareStatement(sql);
        // st.setInt(1,categoryID);
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            list.add(post);
        }
        connection.close();
        return list;
    }
    //phan trang cho search
    public ArrayList<Post> getListSearch(String str,int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        str=str.replace("+","%").replace(" ","%");
        String sql = "SELECT * FROM post where post_slug like N'%"+str+"%' or post_title like N'%"+str+"%' limit ?,?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            list.add(post);
        }
        connection.close();
        return list;
    }
    //phan trang cho arraylist
    public ArrayList<Post> getListProductByPagesInTerm(int categoryID, int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post WHERE category_id = '" + categoryID + "' limit ?,?";
        String sql2="SELECT post.*,term.category_id FROM post,\n" +
                "  (SELECT post_id,category.category_id FROM terms_relationships\n" +
                "    inner join category\n" +
                "      on category.category_id=terms_relationships.category_id\n" +
                "         and category.category_id='"+categoryID+"')\n" +
                "  as term where post.post_id=term.post_id\n" +
                "order by post.post_date desc limit ?,?";
        PreparedStatement ps = connection.prepareStatement(sql2);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            post.setCategoryID(rs.getInt("category_id"));

            list.add(post);
        }
        connection.close();
        return list;
    }
    //Get cac bai viet lien quan
    public ArrayList<Post> getListInPostInterdepend(int categoryID, int firstResult, int maxResult,int post_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql2="SELECT post.*,term.category_id FROM post,\n" +
                "  (SELECT post_id,category.category_id FROM terms_relationships\n" +
                "    inner join category\n" +
                "      on category.category_id=terms_relationships.category_id\n" +
                "         and category.category_id='"+categoryID+"')\n" +
                "  as term where post.post_id!="+post_id+" and post.post_id=term.post_id\n" +
                "order by post.post_date desc limit ?,?";
        PreparedStatement ps = connection.prepareStatement(sql2);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            post.setCategoryID(rs.getInt("category_id"));

            list.add(post);
        }
        connection.close();
        return list;
    }
    //Get cac bai viet xem nhieu nhat
    public ArrayList<Post> getListInPostView(int number) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql2="SELECT post.* FROM post left join hit_counter_post on post.post_id=hit_counter_post.post_id " +
                "order by hit_counter desc limit ?";
        PreparedStatement ps = connection.prepareStatement(sql2);
        ps.setInt(1, number);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            list.add(post);
        }
        connection.close();
        return list;
    }
    //Get cac bai viet ngau nhien
    public ArrayList<Post> getListRandomInPost(int number) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql2="SELECT * FROM post ORDER BY RAND() LIMIT ?";
        PreparedStatement ps = connection.prepareStatement(sql2);
        ps.setInt(1, number);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            list.add(post);
        }
        connection.close();
        return list;
    }
    //
    public ArrayList<Post> getListProductByPagesInTermChildren(int categoryParentID, int firstResult, int maxResult) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql2="SELECT post.*,term.category_id FROM post,\n" +
                "(SELECT post_id,category.category_id FROM terms_relationships inner join category\n" +
                "on category.category_id=terms_relationships.category_id\n" +
                "and category.category_parent='"+categoryParentID+"')  as term where post.post_id=term.post_id\n" +
                "order by post.post_date desc  limit ?,?;";
        PreparedStatement ps = connection.prepareStatement(sql2);
        ps.setInt(1, firstResult);
        ps.setInt(2, maxResult);
        ResultSet rs = ps.executeQuery();
        ArrayList<Post> list = new ArrayList<>();
        while (rs.next()) {
            Post post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
            post.setCategoryID(rs.getInt("category_id"));

            list.add(post);
        }
        connection.close();
        return list;
    }
    public Post getPost(int postID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post WHERE post_id = '" + postID + "'";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        Post post=null;
        while (rs.next()) {
            post = new Post();
            post.setPostID(rs.getInt("post_id"));
            post.setAuthorID(rs.getInt("author_id"));
            post.setPostDateTimestamp(rs.getTimestamp("post_date"));
            post.setPostEditDate(rs.getTimestamp("post_edit_date"));
            post.setPostContent(rs.getString("post_content"));
            post.setPostTitle(rs.getString("post_title"));
            post.setPostStatus(rs.getString("post_status"));
            post.setPostSlug(rs.getString("post_slug"));
            post.setPostImg(rs.getString("post_img"));
        }
        connection.close();
        return post;
    }
    //count search
    public int getCountSearch(String str) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post where post_slug like N'%"+str+"%' or post_title like N'%"+str+"%'";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        connection.close();
        return count;
    }
    public int getCountPostByCategoyTerm(int categoryID) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql2="SELECT count(post.post_id) FROM post,\n" +
                "  (SELECT post_id FROM terms_relationships\n" +
                "    inner join category\n" +
                "      on category.category_id=terms_relationships.category_id\n" +
                "         and category.category_id='"+categoryID+"')\n" +
                "  as term where post.post_id=term.post_id\n" +
                "order by term.post_id desc";
        PreparedStatement ps = connection.prepareStatement(sql2);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        connection.close();
        return count;
    }
    public int getPostIDBySlug(String slug) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT post_id FROM post WHERE post_slug = '" + slug + "'";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        int id = 0;
        while (rs.next()) {
            id = rs.getInt(1);
        }
        connection.close();
        return id;
    }
    public int getCategoyID(String slug) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT category_id FROM category WHERE category_slug = '" + slug + "'";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        int count = 0;
        while (rs.next()) {
            count = rs.getInt(1);
        }
        connection.close();
        return count;
    }
    //kiểm tra xem post_slug  đã tồn tại hay chưa
    public boolean checkPostSlug(String post_slug) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM post WHERE post_slug='" + post_slug + "'";
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
            try {
                connection.close();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
        return false;
    }
    public boolean insert(Post c) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO post(author_id, post_date, post_edit_date, post_content, post_title, post_status, post_slug, post_img,post_summary) " +
                    "VALUE(?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, c.getAuthorID());
            ps.setTimestamp(2,c.getPostDateTimestamp());
            ps.setTimestamp(3,c.getPostEditDate());
            ps.setNString(4, c.getPostContent());
            ps.setNString(5, c.getPostTitle());
            ps.setString(6, c.getPostStatus());
            ps.setString(7, c.getPostSlug());
            ps.setString(8, c.getPostImg());
            ps.setNString(9, c.getPostSummary());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean update(Post c) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE post set post_edit_date=?, post_content=?, post_title=?," +
                    " post_slug=?,post_img=?,post_status=? ,post_summary=? where post_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setTimestamp(1,c.getPostEditDate());
            ps.setNString(2, c.getPostContent());
            ps.setNString(3, c.getPostTitle());
            ps.setString(4, c.getPostSlug());
            ps.setString(5, c.getPostImg());
            ps.setString(6, c.getPostStatus());
            ps.setNString(7, c.getPostSummary());
            ps.setInt(8, c.getPostID());
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
            String sql = "DELETE FROM post WHERE post_id = ?";
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
    public String createPostSlug(String postTitle)    {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String dateTimeNow=sdf.format(cal.getTime());
        try {
            String temp = Normalizer.normalize(postTitle, Normalizer.Form.NFD);
            Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
            String slug= pattern.matcher(temp).replaceAll("").toLowerCase().replaceAll(" ", "-").replaceAll("đ", "d");
            if(checkPostSlug(slug))
                slug=slug+"-"+dateTimeNow;
            return slug;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }
    public java.sql.Date GetDateNow()    {
        java.util.Date myDate = (Calendar.getInstance().getTime());
        return new Date(myDate.getTime());
    }
    public java.sql.Timestamp GetTimestampNow()    {
        java.util.Date myDate = (Calendar.getInstance().getTime());
        return new Timestamp(myDate.getTime());
    }
}
