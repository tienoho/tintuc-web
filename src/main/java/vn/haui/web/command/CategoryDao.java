package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Category;

import java.sql.*;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Pattern;

public class CategoryDao {


    public ArrayList<Category> getListCategory() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Category> list = new ArrayList<Category>();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getInt("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryDes(rs.getString("category_des"));
            category.setCategorySlug(rs.getString("category_slug"));
            category.setCategoryParent(rs.getInt("category_parent"));
            list.add(category);
        }
        connection.close();
        return list;
    }
    public ArrayList<Category> getListCategoryParent() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category where category_parent=0 ";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Category> list = new ArrayList<Category>();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getInt("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryDes(rs.getString("category_des"));
            category.setCategorySlug(rs.getString("category_slug"));
            category.setCategoryParent(rs.getInt("category_parent"));
            list.add(category);
        }
        connection.close();
        return list;
    }
    public ArrayList<Category> getListCategoryChildren(int categoryParent) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category where category_parent="+categoryParent;
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Category> list = new ArrayList<Category>();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getInt("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryDes(rs.getString("category_des"));
            category.setCategorySlug(rs.getString("category_slug"));
            category.setCategoryParent(rs.getInt("category_parent"));
            list.add(category);
        }
        connection.close();
        return list;
    }
    public Category getCategory(int category_id) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category WHERE category_id="+category_id;
        PreparedStatement preparedStatement = connection.prepareStatement(sql);
        ResultSet rs = preparedStatement.executeQuery(sql);
        Category category = null;
        while (rs.next()) {
            category = new Category();
            category.setCategoryID(rs.getInt("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryDes(rs.getString("category_des"));
            category.setCategorySlug(rs.getString("category_slug"));
            category.setCategoryParent(rs.getInt("category_parent"));
        }
        return category;
    }
    // get name category
    public String getCategoryName(String category_slug) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT category_name FROM category WHERE category_slug='" + category_slug + "'";
        PreparedStatement preparedStatement;
        String nameCategory="";
        try {
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {

                nameCategory=rs.getString("category_name");
            }
            connection.close();
        } catch (SQLException e) {
            Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
        }
        return nameCategory;
    }
    //kiểm tra xem category_slug  đã tồn tại hay chưa
    public boolean checkCategorySlug(String category_slug) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM category WHERE category_slug='" + category_slug + "'";
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
        }
        return false;
    }

    public boolean insert(Category c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "INSERT INTO category(category_name, category_des, category_slug,category_parent) VALUE(?,?,?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getCategoryDes());
            ps.setString(3, c.getCategorySlug());
            ps.setInt(4, c.getCategoryParent());

            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }

    public boolean update(Category c) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE category set category_name=?, category_des=?, category_slug=?,category_parent=? where category_id=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, c.getCategoryName());
            ps.setString(2, c.getCategoryDes());
            ps.setString(3, c.getCategorySlug());
            ps.setInt(4, c.getCategoryParent());
            ps.setInt(5, c.getCategoryID());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }


    public boolean delete(int category_id) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM category WHERE category_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setLong(1, category_id);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public String createCategorySlug(String categoryName)
    {
        Calendar cal = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss");
        String dateTimeNow=sdf.format(cal.getTime());
        try {
            String temp = Normalizer.normalize(categoryName, Normalizer.Form.NFD);
            Pattern pattern = Pattern.compile("\\p{InCombiningDiacriticalMarks}+");

            String slug= pattern.matcher(temp).replaceAll("").toLowerCase().replaceAll(" ", "-").replaceAll("đ", "d");
            if(checkCategorySlug(slug))
                slug=slug+"-"+dateTimeNow;
            return slug;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return "";
    }
    public ArrayList<Category> S() throws SQLException {
        ArrayList<Category>categoriesParent= new CategoryDao().getListCategoryParent();
        ArrayList<Category>categories= new ArrayList<>();
        for (Category c:categoriesParent) {
            categories.add(c);
            for(Category c1:new CategoryDao().getListCategoryChildren(c.getCategoryID()))
            {
                categories.add(c1);
                for(Category c2:new CategoryDao().getListCategoryChildren(c1.getCategoryID()))
                    {
                    categories.add(c2);
                }
            }
        }
        return categories;
    }

    public static void main(String[] args) throws SQLException {
        CategoryDao categoryDao=new CategoryDao();
        ArrayList<Category>categories= new ArrayList<>();
        for(Category c:categoryDao.S())
        {
            System.out.println(c.getCategoryID()+"-"+c.getCategoryName()+"-"+c.getCategoryParent());
        }
    }
    public ArrayList<Category> getListCategoryByPost(int postId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT category.* FROM terms_relationships inner join category " +
                "on category.category_id=terms_relationships.category_id " +
                "and post_id="+postId;
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Category> list = new ArrayList<Category>();
        while (rs.next()) {
            Category category = new Category();
            category.setCategoryID(rs.getInt("category_id"));
            category.setCategoryName(rs.getString("category_name"));
            category.setCategoryDes(rs.getString("category_des"));
            category.setCategorySlug(rs.getString("category_slug"));
            category.setCategoryParent(rs.getInt("category_parent"));
            list.add(category);
        }
        connection.close();
        return list;
    }
}
//SELECT * FROM terms_relationships left join category on category.category_id=terms_relationships.category_id and post_id=