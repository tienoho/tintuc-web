package vn.haui.web.model;

public class Tag {
    private int tag_id;
    private int tag_post_id;
    private String tag_content;

    public Tag() {
    }

    public Tag(int tag_id, int tag_post_id, String tag_content) {
        this.tag_id = tag_id;
        this.tag_post_id = tag_post_id;
        this.tag_content = tag_content;
    }

    public int getTag_id() {
        return tag_id;
    }

    public void setTag_id(int tag_id) {
        this.tag_id = tag_id;
    }

    public int getTag_post_id() {
        return tag_post_id;
    }

    public void setTag_post_id(int tag_post_id) {
        this.tag_post_id = tag_post_id;
    }

    public String getTag_content() {
        return tag_content;
    }

    public void setTag_content(String tag_content) {
        this.tag_content = tag_content;
    }
}
