package vn.haui.web.controller;

import vn.haui.web.command.UsersDao;
import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Users;
import vn.haui.web.utils.tool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/ManagerUserServlet")
public class ManagerUserServlet {
    UsersDao usersDao = new UsersDao();
    Users users = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = WebConstant.getLocalHost() + "/Admincp/add-user.jsp", error = "", result = "", error_slug = "";
        String command = request.getParameter("command");

        HttpSession session = request.getSession(false);
        try {
            switch (command) {
                case "insert":
                    users=new Users();
                    users.setRoleId(Integer.parseInt(request.getParameter("roleid")));
                    users.setFullName((request.getParameter("fullname")));
                    users.setEmail((request.getParameter("email")));
                    users.setImg(request.getParameter("ImagePath"));
                    users.setCreatedDate(tool.GetDateNow());
                    users.setPassword(request.getParameter("password"));
                    usersDao.insertUser(users);
                    result = "Thêm thành công";
                    session.setAttribute("result", result);
                    url=WebConstant.getLocalHost() + "/Admincp/profile.jsp";
                    break;
                case "update":
                    users=new Users();
                    users.setRoleId(Integer.parseInt(request.getParameter("roleid")));
                    users.setFullName((request.getParameter("fullname")));
                    users.setEmail((request.getParameter("email")));
                    users.setImg(request.getParameter("ImagePath"));
                    usersDao.update(users);
                    result = "Lưu thành công";
                    url=WebConstant.getLocalHost() + "/Admincp/profile.jsp";
                    session.setAttribute("result", result);
                    break;
                case "delete":
                    String email=(request.getParameter("email"));
                    usersDao.delete(email);
                    break;
                default:
                    result = "Thêm không thành công";
                    //response.sendRedirect(WebConstant.localHost + "/Admincp/category.jsp");
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            result = "Cập không thành công";
            session.setAttribute("result", result);
        }
        response.sendRedirect(url);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
        String command = request.getParameter("command");
        String url = "";
        switch (command) {
            case "delete":
                String email=(request.getParameter("email"));
                usersDao.delete(email);
                break;
        }
        response.sendRedirect(url);
    }
}
