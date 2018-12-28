package vn.haui.web.controller;

import vn.haui.web.command.UsersDao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/CheckEmailServlet")
public class CheckEmailServlet extends HttpServlet {
    UsersDao usersDao=new UsersDao();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (usersDao.checkEmail(request.getParameter("email"))) {
            response.getWriter().write("<img src=\"img/not-available.png\" />");
        } else {
            response.getWriter().write("<img src=\"img/available.png\" />");
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
