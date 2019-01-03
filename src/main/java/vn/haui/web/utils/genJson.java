package vn.haui.web.utils;

import org.json.simple.JSONObject;
import vn.haui.web.command.CategoryDao;
import vn.haui.web.command.PostDao;
import vn.haui.web.common.WebConstant;
import vn.haui.web.model.Category;
import vn.haui.web.model.Post;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class genJson {
    CategoryDao categoryDao = new CategoryDao();
    PostDao postDao = new PostDao();
    List<Category> categories = new ArrayList<>();
    List<Post> posts = new ArrayList<>();
    Map objSubData1 = null;
    Map objSubData2 = null;

    public JSONObject jsonObject () throws SQLException {
        genJson genJson = new genJson();
        try {
            genJson.getCategoryData1();
            genJson.getCategoryData2(WebConstant.getCategorySubOne());
        } catch (SQLException e) {
            e.printStackTrace();
        }

        JSONObject obj1 = new JSONObject();
        obj1.put("1", genJson.objSubData1);
        obj1.put("2", genJson.objSubData2);
        //System.out.println(obj1.toJSONString());
        return obj1;
    }

    //Data1
    public void getCategoryData1() throws SQLException {
        categories = categoryDao.getListCategoryParent();
        objSubData1 = new HashMap();
        for (Category c : categories) {
            posts = postDao.getListProductByPagesInTerm(c.getCategoryID(), 1, WebConstant.getPostNumberHome());
            objSubData1.put(c.getCategoryID(), getPostData1(posts, c));
        }

    }

    public String getPostData1(List<Post> posts, Category c) {
        int dem = 0;
        String extendsImgNew = "";
        System.setProperty("file.encoding", "UTF-8");
        String content = "<section class=\"block-wrap highlights highlights-b\" data-id=\"" + c.getCategoryID() + "\">" +
                " <div class=\"block-head\"><h3 class=\"heading\">" +
                "<a href=\"" + WebConstant.getLocalHost() + "/Category/" + c.getCategorySlug() + "\">Bài viết mới</a>" +
                "    </h3></div><div class=\"block-content\"><div class=\"container cf\"><div class=\"large b-row cf\">";
        for (Post p : posts) {
            dem++;
            extendsImgNew = p.getPostImg();
            if (extendsImgNew.contains(".")) {
                extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
            }
            content += "<div class=\"column half b-col\"><article>" +
                    "<a href=\"" + WebConstant.getLocalHost() + "/post/" + p.getPostSlug() + "\"" +
                    " title=\"" + p.getPostTitle() + "\" class=\"image-link\">" +
                    "<img width=\"336\" height=\"200\"" +
                    " src=\"" + WebConstant.getLocalHost() + "/" + p.getPostImg() + "\"" +
                    " class=\"image wp-post-image\"" +
                    " alt=\"" + p.getPostImg() + "\"" +
                    " title=\"" + p.getPostTitle() + "\"" +
                    " srcset=\"" + p.getPostImg().replace(extendsImgNew, "-336x200" + extendsImgNew) + " 336w\"" +
                    " sizes=\"(max-width: 336px) 100vw, 336px\"/></a>" +
                    "<h2 class=\"post-title\">" +
                    "<a href=\"" + WebConstant.getLocalHost() + "/post/" + p.getPostSlug() + "\"" +
                    " title=\"" + p.getPostTitle() + "\">" + p.getPostTitle() + "</a>" +
                    "</h2>" +
                    "<div class=\"cf listing-meta meta below\">" +
                    "<span class=\"meta-item author\">Bởi <a href=\"" + WebConstant.getLocalHost() + "/user" + "\"" +
                    " title=\"Posts by Kate Hanson\" rel=\"author\">Kate Hanson</a></span>" +
                    "<time datetime=\"" + p.getPostDate() + "\" class=\"meta-item\">" + p.getPostDate() + "</time>" +
                    "</div>" +
                    "<div class=\"excerpt\"><p>" + tool.html2text(p.getPostContent()).substring(0, 50) + WebConstant.tobeContime + "</p></div>" +
                    "</article></div>";
            if (dem > 1) {
                dem = 0;
                break;
            }
        }
        content += "</div><ul class=\"b-row posts-list thumb\">";
        for (Post p : posts) {
            dem++;
            if (dem > 2) {
                extendsImgNew = p.getPostImg();
                if (extendsImgNew.contains(".")) {
                    extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
                }
                content += "<li class=\"column half b-col\">" +
                        "<article class=\"post cf\">" +
                        "<a href=\"" + WebConstant.getLocalHost() + "/post/" + p.getPostSlug() + "\"" +
                        " class=\"image-link\">" +
                        " <img width=\"104\" height=\"69\"" +
                        " src=\"" + WebConstant.getLocalHost() + "/" + p.getPostImg() + "\"" +
                        " class=\"attachment-post-thumbnail size-post-thumbnail wp-post-image\"" +
                        " alt=\"" + p.getPostImg() + "\"" +
                        " title=\"" + p.getPostTitle() + "\"" +
                        " srcset=\"" + p.getPostImg().replace(extendsImgNew, "-104x69" + extendsImgNew) + " 104w, " + p.getPostImg().replace(extendsImgNew, "-300x200" + extendsImgNew) + " 300w, " + p.getPostImg().replace(extendsImgNew, "-1000x667" + extendsImgNew) + " 1000w, " + p.getPostImg().replace(extendsImgNew, "-702x459" + extendsImgNew) + " 702w, " + p.getPostImg().replace(extendsImgNew, "-214x140" + extendsImgNew) + " 214w\"" +
                        " sizes=\"(max-width: 104px) 100vw, 104px\"/></a>" +
                        " <div class=\"content\"><a" +
                        " href=\"" + WebConstant.getLocalHost() + "/post/" + p.getPostSlug() + "\"" +
                        " title=\"" + p.getPostTitle() + "\">" + p.getPostTitle() + "</a>" +
                        "<div class=\"cf listing-meta below\">" +
                        "<time datetime=\"" + p.getPostDate() + "\" class=\"meta-item\">" + p.getPostDate() + "</time>" +
                        "</div></div></article></li>";
            }
        }
        content += "</ul></div></div> <!-- .block-content --></section>";
        return content;
    }

    //Data2
    public void getCategoryData2(int categoryId) throws SQLException {
        categories = categoryDao.getListCategoryChildren(categoryId);
        objSubData2 = new HashMap();
        for (Category c : categories) {
            posts = postDao.getListProductByPagesInTerm(c.getCategoryID(), 1, WebConstant.getPostNumberHomeSub());
            objSubData2.put(c.getCategoryID(), getPostData12(posts, c));
        }
    }

    public String getPostData12(List<Post> posts, Category c) {
        String extendsImgNew = "";
        System.setProperty("file.encoding", "UTF-8");
        String content = "<section class=\"block-wrap blog\" data-id=\"11\">" +
                "    <div class=\"block-head\"><h3 class=\"heading\"><a" +
                "            href=\""+WebConstant.getLocalHost()+"/Category/"+c.getCategorySlug()+"\">"+c.getCategoryName()+" mới nhất</a></h3></div>" +
                "    <div class=\"block-content\">" +
                "        <div class=\"row b-row listing meta-below grid-2\">";
        for (Post p : posts) {
            extendsImgNew = p.getPostImg();
            if (extendsImgNew.contains(".")) {
                extendsImgNew = extendsImgNew.substring(extendsImgNew.lastIndexOf("."), extendsImgNew.length());
            }
            String tomtat=tool.html2text(p.getPostContent());
            if(tomtat.length()>=50){
                tomtat=tomtat.substring(0, 50);
            }else {
                tomtat="";
            }
            content += "<div class=\"column half b-col\">" +
                    "<article class=\"highlights post-"+p.getPostID()+" post type-post status-publish format-standard has-post-thumbnail category-fitness category-lifestyle tag-culture tag-fashion tag-fitness tag-leisure tag-lifestyle\">" +
                    "<a href=\""+WebConstant.getLocalHost()+"/"+p.getPostSlug()+"\"" +
                    " title=\""+p.getPostTitle()+"\" class=\"image-link\">" +
                    "<img width=\"336\"" +
                    " height=\"200\"" +
                    " src=\""+WebConstant.getLocalHost()+"/"+p.getPostImg()+"\"" +
                    " class=\"image wp-post-image\"" +
                    " alt=\""+p.getPostImg()+"\"" +
                    " title=\""+p.getPostTitle()+"\"" +
                    " srcset=\""+p.getPostImg().replace(extendsImgNew, "-336x200" + extendsImgNew)+" 336w\"" +
                    " sizes=\"(max-width: 336px) 100vw, 336px\"/></a>" +
                    "<h2 class=\"post-title\"><a" +
                    " href=\""+WebConstant.getLocalHost()+"/"+p.getPostSlug()+"\">"+p.getPostTitle()+"</a></h2>" +
                    "<div class=\"cf listing-meta meta below\"><span class=\"meta-item author\">Bởi <a" +
                    " href=\""+WebConstant.getLocalHost()+"/user"+"\"" +
                    " title=\"Posts by Kate Hanson\" rel=\"author\">Kate Hanson</a></span>" +
                    "<time datetime=\""+p.getPostDate()+"\" class=\"meta-item\">"+p.getPostDate()+"</time>" +
                    "</div>" +
                    "<div class=\"excerpt\"><p>"+ tomtat + WebConstant.tobeContime +"</p></div>" +
                    "</article></div>";
        }
        content += "</div></div></section>";
        return content;
    }

//    public static void main(String[] args) {
//
//        JSONObject obj1 = new JSONObject();
//        obj1.put("1", "abc");
//        obj1.put("2", "qwe");
//        obj1.put("3", "asd");
//        obj1.put("4", "zxc");
//        System.out.println(obj1.toJSONString());
//        System.out.println(obj1.get("1"));
//    }
}
