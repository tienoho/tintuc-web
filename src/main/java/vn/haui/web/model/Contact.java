package vn.haui.web.model;
import java.sql.Date;
public class Contact {
    private int contact_id;
    private String contact_name;
    private String contact_email;
    private String contact_message;
    private String contact_subject;
    private Date contact_data;

    public Contact() {
    }

    public Contact(int contact_id, String contact_name, String contact_email, String contact_message, String contact_subject, Date contact_data) {
        this.contact_id = contact_id;
        this.contact_name = contact_name;
        this.contact_email = contact_email;
        this.contact_message = contact_message;
        this.contact_subject = contact_subject;
        this.contact_data = contact_data;
    }

    public int getContact_id() {
        return contact_id;
    }

    public void setContact_id(int contact_id) {
        this.contact_id = contact_id;
    }

    public String getContact_name() {
        return contact_name;
    }

    public void setContact_name(String contact_name) {
        this.contact_name = contact_name;
    }

    public String getContact_email() {
        return contact_email;
    }

    public void setContact_email(String contact_email) {
        this.contact_email = contact_email;
    }

    public String getContact_message() {
        return contact_message;
    }

    public void setContact_message(String contact_message) {
        this.contact_message = contact_message;
    }

    public String getContact_subject() {
        return contact_subject;
    }

    public void setContact_subject(String contact_subject) {
        this.contact_subject = contact_subject;
    }

    public Date getContact_data() {
        return contact_data;
    }

    public void setContact_data(Date contact_data) {
        this.contact_data = contact_data;
    }
}
