package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Post;
import vn.haui.web.model.Users;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsersDao {
    public ArrayList<Users> getListUsers() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM users";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Users> list = new ArrayList<Users>();
        while (rs.next()) {
            Users  users = new Users();
            users.setEmail(rs.getString("email"));
            users.setFullName(rs.getString("fullname"));
            users.setImg(rs.getString("img"));
            users.setRoleId(rs.getInt("roleid"));
            users.setCreatedDate(rs.getDate("createddate"));
            list.add(users);
        }
        connection.close();
        return list;
    }
    //mã hóa mật khẩu MD5
    public static String encryption(String str) {
        byte[] defaultBytes = str.getBytes();
        try {
            MessageDigest algorithm = MessageDigest.getInstance("MD5");
            algorithm.reset();
            algorithm.update(defaultBytes);
            byte messageDigest[] = algorithm.digest();
            StringBuffer hexString = new StringBuffer();
            for (int i = 0; i < messageDigest.length; i++) {
                String hex = Integer.toHexString(0xFF & messageDigest[i]);
                if (hex.length() == 1) {
                    hexString.append('0');
                }
                hexString.append(hex);
            }
            str = hexString + "";
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }

        return str;

    }
    //kiểm tra xem usernam và email đã tồn tại hay chưa
    public boolean checkEmail(String email) {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM users WHERE email='" + email + "'";
        PreparedStatement preparedStatement;
        try {
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                connection.close();
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(UsersDao.class.getName()).log(Level.SEVERE, null, e);
            e.printStackTrace();
        }
        try {
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    //insert tai khoan
    public boolean insertUser(Users user) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "INSERT INTO users(email,password,fullname,createddate,roleid) values(?,?,?,?,?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setNString(3, user.getFullName());
            ps.setDate(4, user.getCreatedDate());
            ps.setInt(5, user.getRoleId());
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
    //Login
    public Users login(String email, String password) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from users where email='" + email + "' and password='" + password + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Users users=new Users();
                users.setEmail(rs.getString("email"));
                users.setFullName(rs.getString("fullname"));
                users.setRoleId(rs.getInt("roleid"));
                users.setImg(rs.getString("img"));
                users.setCreatedDate(rs.getDate("createddate"));
                connection.close();
                return users;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            connection.close();
        }
        return null;
    }
    public String getName(int userId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from users where userid='" + userId + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("fullname");
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            connection.close();
        }
        return null;
    }
    public String getImage(String email) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from users where email='" + email + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("img");
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            connection.close();
        }
        return null;
    }
    public String getImageId(int userId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from users where userid='" + userId + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("img");
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            connection.close();
        }
        return null;
    }
    public String getNameRole(int roleId) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "select * from role where roleid='" + roleId + "'";
        PreparedStatement ps;
        try {
            ps = (PreparedStatement) connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("name");
            }
            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
            connection.close();
        }
        return null;
    }
    public boolean update(Users c) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE users set fullname=?, img=?, roleid=? where email=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1,c.getFullName());
            ps.setString(2, c.getImg());
            ps.setInt(3, c.getRoleId());
            ps.setNString(4, c.getEmail());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public boolean delete(String email) throws SQLException {
        Connection connection=null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "DELETE FROM users WHERE email = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
}
