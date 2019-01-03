package vn.haui.web.command;

import vn.haui.web.connect.DBConnect;
import vn.haui.web.model.Category;
import vn.haui.web.model.Setting;

import java.sql.*;
import java.util.ArrayList;

public class SettingDao {
    public ArrayList<Setting> getSetting() throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM option_config";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Setting> list = new ArrayList<Setting>();
        while (rs.next()) {
            Setting  setting = new Setting();
            setting.setOptionId(rs.getInt("option_id"));
            setting.setOptionName(rs.getString("option_name"));
            setting.setOptionValue(rs.getString("option_value"));
            list.add(setting);
        }
        connection.close();
        return list;
    }
    public boolean update(Setting s) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE option_config set option_value=? where option_name=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, s.getOptionValue());
            ps.setString(2, s.getOptionName());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }
    public ArrayList<Setting> getTable(String table) throws SQLException {
        Connection connection = DBConnect.getConnecttion();
        String sql = "SELECT * FROM "+table;
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        ArrayList<Setting> list = new ArrayList<Setting>();
        while (rs.next()) {
            Setting  setting = new Setting();
            setting.setOptionId(rs.getInt("footer_id"));
            setting.setOptionName(rs.getString("footer_name"));
            setting.setOptionValue(rs.getString("footer_value"));
            list.add(setting);
        }
        connection.close();
        return list;
    }
    public boolean updateFooter(Setting s) throws SQLException {
        Connection connection = null;
        try {
            connection = DBConnect.getConnecttion();
            String sql = "UPDATE option_footer set footer_value=? where footer_name=?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, s.getOptionValue());
            ps.setString(2, s.getOptionName());
            int temp = ps.executeUpdate();
            connection.close();
            return temp == 1;
        } catch (Exception e) {
            connection.close();
            return false;
        }
    }

}
