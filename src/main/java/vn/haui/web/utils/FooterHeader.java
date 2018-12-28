package vn.haui.web.utils;

import vn.haui.web.command.SettingDao;
import vn.haui.web.common.WebFooter;
import vn.haui.web.model.Setting;

import java.sql.SQLException;
import java.util.List;

public class FooterHeader {
    public void getFooter() throws SQLException {

        SettingDao settingDao = new SettingDao();
        List<Setting> settings = settingDao.getTable("option_footer");
        if (settings != null) {
            for (Setting s : settings) {
                switch (s.getOptionName()) {
                    case "footer_slogan":
                        WebFooter.setSlogan(s.getOptionValue());
                        break;
                    case "footer_copyright":
                        WebFooter.setCopyright(s.getOptionValue());
                        break;
                    case "footer_category_id":
                        WebFooter.setCategory_id(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "footer_category_number":
                        WebFooter.setCategory_number(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "footer_logo":
                        WebFooter.setLogo(s.getOptionValue());
                        break;
                }
            }
        }
    }
    public void getHeader() throws SQLException {

        SettingDao settingDao = new SettingDao();
        List<Setting> settings = settingDao.getTable("option_header");
        if (settings != null) {
            for (Setting s : settings) {
                switch (s.getOptionName()) {
                    case "header_slogan":
                        WebFooter.setSlogan(s.getOptionValue());
                        break;
                    case "footer_copyright":
                        WebFooter.setCopyright(s.getOptionValue());
                        break;
                    case "footer_category_id":
                        WebFooter.setCategory_id(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "footer_category_number":
                        WebFooter.setCategory_number(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "header_logo":
                        WebFooter.setLogo(s.getOptionValue());
                        break;
                }
            }
        }
    }
}
