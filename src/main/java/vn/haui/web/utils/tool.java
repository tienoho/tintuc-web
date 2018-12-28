package vn.haui.web.utils;

import org.jsoup.Jsoup;

import java.util.Calendar;


public class tool {
    //cắt các tag trong html
    public static String html2text(String html) {
        return Jsoup.parse(html).text();
    }
    public static java.sql.Date GetDateNow()
    {
        java.util.Date myDate = (Calendar.getInstance().getTime());
        java.sql.Date sqlDateNow = new java.sql.Date(myDate.getTime());
        return sqlDateNow;
    }

}
