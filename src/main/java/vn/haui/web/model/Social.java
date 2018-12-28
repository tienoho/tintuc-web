package vn.haui.web.model;

public class Social {
    private int social_id;
    private String social_name;
    private String social_url;
    private String social_title;
    private String social_icon;

    public Social() {
    }

    public Social(int social_id, String social_name, String social_url, String social_title, String social_icon) {
        this.social_id = social_id;
        this.social_name = social_name;
        this.social_url = social_url;
        this.social_title = social_title;
        this.social_icon = social_icon;
    }

    public int getSocial_id() {
        return social_id;
    }

    public void setSocial_id(int social_id) {
        this.social_id = social_id;
    }

    public String getSocial_name() {
        return social_name;
    }

    public void setSocial_name(String social_name) {
        this.social_name = social_name;
    }

    public String getSocial_url() {
        return social_url;
    }

    public void setSocial_url(String social_url) {
        this.social_url = social_url;
    }

    public String getSocial_title() {
        return social_title;
    }

    public void setSocial_title(String social_title) {
        this.social_title = social_title;
    }

    public String getSocial_icon() {
        return social_icon;
    }

    public void setSocial_icon(String social_icon) {
        this.social_icon = social_icon;
    }
}
