package vn.haui.web.common;

public class WebFooter {
    public static String slogan;
    public static String copyright;
    public static int category_id;
    public static int category_number;
    public static String logo;

    public WebFooter() {
    }

    public static String getSlogan() {
        return slogan;
    }

    public static void setSlogan(String slogan) {
        WebFooter.slogan = slogan;
    }

    public static String getCopyright() {
        return copyright;
    }

    public static void setCopyright(String copyright) {
        WebFooter.copyright = copyright;
    }

    public static int getCategory_id() {
        return category_id;
    }

    public static void setCategory_id(int category_id) {
        WebFooter.category_id = category_id;
    }

    public static int getCategory_number() {
        return category_number;
    }

    public static void setCategory_number(int category_number) {
        WebFooter.category_number = category_number;
    }

    public static String getLogo() {
        return logo;
    }

    public static void setLogo(String logo) {
        WebFooter.logo = logo;
    }
}
