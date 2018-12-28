package vn.haui.web.controller;

import vn.haui.web.command.SettingDao;
import vn.haui.web.model.Setting;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/SettingServlet")
public class SettingServlet extends HttpServlet {
    SettingDao settingDao = new SettingDao();
    Setting setting;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = "/Admincp/setting.jsp", error = "", result = "", error_slug = "";
        String blogname = request.getParameter("blogname");
        String blogdescription = request.getParameter("blogdescription");
        String siteurl = request.getParameter("siteurl");
        String admin_email = request.getParameter("admin_email");
        String post_home = request.getParameter("post_home");
        String post_category = request.getParameter("post_category");
        String post_home_sub = request.getParameter("post_home_sub");
        String category_home_sub_one = request.getParameter("category_home_sub_one");
        String post_miss_id = request.getParameter("post_miss_id");
        String post_miss_number = request.getParameter("post_miss_number");
        String post_view_number = request.getParameter("post_view_number");
        String image_icon = request.getParameter("xImagePath-icon");
        String logo_image = request.getParameter("xImagePath-logo");
        String logo_image_2x = request.getParameter("xImagePath-logo-2x");
        String logo_image_mobile = request.getParameter("xImagePath-logo-mobile");
        String banner_header = request.getParameter("banner-header");
        String url_banner_header = request.getParameter("url-banner-header");

        HttpSession session = request.getSession(false);
        if (blogname != null && !blogname.equals("")) {
            setting = new Setting(1, "blogname", blogname);
            setSetting(setting);
        } else {
            session.setAttribute("error_blogname", "Tên Website không thể để trống");
        }
        if (blogdescription != null && !blogdescription.equals("")) {
            setting = new Setting(1, "blogdescription", blogdescription);
            setSetting(setting);
        }
        if (siteurl != null && !siteurl.equals("")) {
            setting = new Setting(1, "siteurl", siteurl);
            setSetting(setting);
        } else {
            session.setAttribute("error_siteurl", "Không thể để trống địa chỉ website");
        }
        if (admin_email != null && !admin_email.equals("")) {
            setting = new Setting(1, "admin_email", admin_email);
            setSetting(setting);
        }
        if (post_home != null && !post_home.equals("")) {
            setting = new Setting(1, "post_home", post_home);
            setSetting(setting);
        }
        if (post_category != null && !post_category.equals("")) {
            setting = new Setting(1, "post_category", post_category);
            setSetting(setting);
        }
        if (post_category != null && !post_category.equals("")) {
            setting = new Setting(1, "post_home_sub", post_home_sub);
            setSetting(setting);
        }
        if (post_category != null && !post_category.equals("")) {
            setting = new Setting(1, "category_home_sub_one", category_home_sub_one);
            setSetting(setting);
        }
        if (post_category != null && !post_category.equals("")) {
            setting = new Setting(1, "post_miss_id", post_miss_id);
            setSetting(setting);
        }
        if (post_category != null && !post_category.equals("")) {
            setting = new Setting(1, "post_miss_number", post_miss_number);
            setSetting(setting);
        }
        if (post_category != null && !post_category.equals("")) {
            setting = new Setting(1, "post_view_number", post_view_number);
            setSetting(setting);
        }
        if (image_icon != null && !image_icon.equals("")) {
            setting = new Setting(1, "icon", image_icon);
            setSetting(setting);
        }
        if (logo_image != null && !logo_image.equals("")) {
            setting = new Setting(1, "logo_image", logo_image);
            setSetting(setting);
        }
        if (logo_image_2x != null && !logo_image_2x.equals("")) {
            setting = new Setting(1, "logo_image_2x", logo_image_2x);
            setSetting(setting);
        }
        if (logo_image_mobile != null && !logo_image_mobile.equals("")) {
            setting = new Setting(1, "logo_image_mobile", logo_image_mobile);
            setSetting(setting);
        }
        if (banner_header != null && !banner_header.equals("")) {
            setting = new Setting(1, "banner_header", banner_header);
            setSetting(setting);
        }if (url_banner_header != null && !url_banner_header.equals("")) {
            setting = new Setting(1, "url_banner_header", url_banner_header);
            setSetting(setting);
        }
        //HttpSession session = request.getSession(false);
        response.sendRedirect(url);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    private void setSetting(Setting s) {
        try {
            settingDao.update(s);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}