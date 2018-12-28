package vn.haui.web.controller;

import vn.haui.web.command.SocialDao;
import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Social;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/SocialSevlet")
public class SocialSevlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String urlPath=WebConstant.getLocalHost()+"/Admincp/social.jsp";
        SocialDao socialDao=new SocialDao();
        String[] name = request.getParameterValues("fieldsName[]");
        String[] url = request.getParameterValues("fieldsUrl[]");
        String[] title = request.getParameterValues("fieldsTitle[]");
        String[] icon = request.getParameterValues("fieldsIcon[]");

        try {
            socialDao.deleteAll();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        for (int i=0;i< name.length;i++) {
            System.out.println(name[i]+"-"+url[i]+"-"+title[i]+"-"+icon[i]);
            Social social=new Social();
            social.setSocial_name(name[i]);
            social.setSocial_url(url[i]);
            social.setSocial_title(title[i]);
            social.setSocial_icon(icon[i]);
            try {
                socialDao.insert(social);
                urlPath=WebConstant.getLocalHost()+"/Admincp/social.jsp";
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(urlPath);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
    }
}
