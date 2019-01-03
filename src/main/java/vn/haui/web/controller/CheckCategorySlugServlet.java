package vn.haui.web.controller;

import vn.haui.web.command.CategoryDao;
import vn.haui.web.common.WebConstant;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/CheckCategorySlugServlet")
public class CheckCategorySlugServlet extends HttpServlet {
    CategoryDao categoryDao = new CategoryDao();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        if (categoryDao.checkCategorySlug(request.getParameter("category-slug"))) {
            response.getWriter().write("<img src=\"" + WebConstant.getLocalHost() + "/img/not-available.png\" />");
        } else {
            response.getWriter().write("<img src=\"" + WebConstant.getLocalHost() + "/img/available.png\" />");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
