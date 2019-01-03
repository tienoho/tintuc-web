package vn.haui.web.controller;

import vn.haui.web.command.ContactDao;
import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Comment;
import vn.haui.web.model.Contact;
import vn.haui.web.utils.tool;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {

    private ContactDao contactDao = new ContactDao();
    private Contact contact = null;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        String url = WebConstant.getLocalHost() + "/Admincp/contact.jsp", error = "", result = "", error_slug = "";
        String command = request.getParameter("command");
        String message = request.getParameter("message");

        HttpSession session = request.getSession(false);
        try {
            switch (command) {
                case "insert":
                    if (message.equals("")) {
                        result = "Không thể bỏ trống!";
                        session.setAttribute("result", result);
                        url = WebConstant.getLocalHost() + "/about";
                    } else {
                        contact = new Contact();
                        contact.setContact_message(message);
                        contact.setContact_name(request.getParameter("name"));
                        contact.setContact_subject(request.getParameter("subject"));
                        contact.setContact_email(request.getParameter("email"));
                        contactDao.insert(contact);
                        //save message in session
                        result="Tin nhắn của bạn đã được gửi. Cảm ơn!";
                        session.setAttribute("result", result);
                        url = WebConstant.getLocalHost() + "/about";
                    }
                    break;
                case "update":

                    break;
                case "delete":
                    contactDao.delete(Integer.parseInt(request.getParameter("contact-id")));
                    break;
                default:
                    result = "Không thành công";
                    session.setAttribute("result", result);
                    break;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            result = "Cập không thành công";
            session.setAttribute("result", result);
        }
        response.sendRedirect(url);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}