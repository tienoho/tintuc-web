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

@WebServlet("/ManagerFooterServlet")
public class ManagerFooterServlet extends HttpServlet {
    SettingDao settingDao = new SettingDao();
    Setting setting;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = "/Admincp/edit-footer.jsp", error = "", result = "", error_slug = "";
        String footer_slogan = request.getParameter("footer-slogan");
        String footer_copyright = request.getParameter("footer-copyright");
        String category_home_sub_one = request.getParameter("category_home_sub_one-logo-mobile");
        String ImagePath = request.getParameter("ImagePath");
        String post_number = request.getParameter("post_number");

        HttpSession session = request.getSession(false);

        if (footer_slogan != null && !footer_slogan.equals("")) {
            setting = new Setting(1, "footer_slogan", footer_slogan);
            setSetting(setting);
        }
        if (footer_copyright != null && !footer_copyright.equals("")) {
            setting = new Setting(1, "footer_copyright", footer_copyright);
            setSetting(setting);
        }
        if (category_home_sub_one != null && !category_home_sub_one.equals("")) {
            setting = new Setting(1, "footer_category_id", category_home_sub_one);
            setSetting(setting);
        }
        if (ImagePath != null && !ImagePath.equals("")) {
            setting = new Setting(1, "footer_logo", ImagePath);
            setSetting(setting);
        }
        if (post_number != null && !post_number.equals("")) {
            setting = new Setting(1, "footer_category_number", post_number);
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
            if(settingDao.updateFooter(s)) ;
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}