package vn.haui.web.utils;

import vn.haui.web.command.SettingDao;
import vn.haui.web.common.WebConstant;

import java.sql.SQLException;
import java.util.ArrayList;

public class SettingConfig {
    public void getSettingStart() throws SQLException {
        SettingDao settingDao = new SettingDao();
        ArrayList<vn.haui.web.model.Setting> settings = null;
        try {
            settings = settingDao.getSetting();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (settings != null) {
            for (vn.haui.web.model.Setting s : settings) {
                switch (s.getOptionName()) {
                    case "siteurl":
                        WebConstant.setLocalHost(s.getOptionValue());
                        break;
                    case "blogdescription":
                        WebConstant.setBlogdescription(s.getOptionValue());
                        break;
                    case "blogname":
                        WebConstant.setBlogname(s.getOptionValue());
                        break;
                    case "post_category":
                        WebConstant.setPostNumber(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "post_home":
                        WebConstant.setPostNumberHome(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "post_home_sub":
                        WebConstant.setPostNumberHomeSub(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "category_home_sub_one":
                        WebConstant.setCategorySubOne(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "comment":
                        WebConstant.setComment(s.getOptionValue());
                        break;
                    case "post_number_view":
                        WebConstant.setPostView(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "category_miss":
                        WebConstant.setPostMissId(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "post_miss_number":
                        WebConstant.setPostMissNumber(Integer.parseInt(s.getOptionValue()));
                        break;
                    case "icon":
                        WebConstant.setxImagePath_icon(s.getOptionValue());
                        break;
                    case "logo_image":
                        WebConstant.setxImagePath_logo((s.getOptionValue()));
                        break;
                    case "logo_image_mobile":
                        WebConstant.setxImagePath_logo_mobile(s.getOptionValue());
                        break;
                    case "banner_header":
                        WebConstant.setBanner_header(s.getOptionValue());
                        break;
                    case "url_banner_header":
                        WebConstant.setUrl_banner_header(s.getOptionValue());
                        break;
                    case "admin_email":
                        WebConstant.setAdmin_email(s.getOptionValue());
                        break;
                }
            }
        }
    }
}
