package vn.haui.web.filter;

import vn.haui.web.command.SettingDao;
import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Setting;

import javax.servlet.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

public class filterConfig implements Filter {
    @Override
    public void init(FilterConfig fConfig) throws ServletException {
        System.out.println("Config init!");
    }

    @Override
    public void destroy() {
        System.out.println("Config Filter destroy!");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {


        SettingDao settingDao = new SettingDao();
        ArrayList<Setting> settings = null;
        try {
            settings = settingDao.getSetting();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (settings != null) {
            for (Setting s : settings) {
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
                }
            }
        }
        // Cho phép request được đi tiếp. (Vượt qua Filter này).
        chain.doFilter(request, response);
    }
}
