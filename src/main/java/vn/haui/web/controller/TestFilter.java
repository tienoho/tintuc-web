package vn.haui.web.controller;

import vn.haui.web.utils.resizeImages;

import javax.servlet.ServletContext;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/test123")
public class TestFilter extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

        //Tao anh voi nhieu kich thuoc
        ServletContext servletContext = getServletContext();
        PrintWriter out = response.getWriter();
        String url="\\upload\\images\\";
        String path=servletContext.getRealPath(url);
        out.println("<br/>File system context path (in getRealPath): " + servletContext.getRealPath(url));
        new resizeImages().AutoResezi(path);

        //new
    }
}
