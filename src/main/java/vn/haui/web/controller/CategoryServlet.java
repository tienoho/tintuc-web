package vn.haui.web.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/CategoryServlet")
public class CategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryID = request.getParameter("categoryID");
        String pages = request.getParameter("pages");

        HttpSession session = request.getSession();
        session.setAttribute("categoryID", categoryID);
        session.setAttribute("pages", pages);

        response.sendRedirect("/Category/");
    }
}
