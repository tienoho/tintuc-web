package vn.haui.web.model;

public class TermsRelationships {
    private int postID;
    private int categoryID;
    private int order;

    public TermsRelationships() {
    }

    public TermsRelationships(int postID, int categoryID, int order) {
        this.postID = postID;
        this.categoryID = categoryID;
        this.order = order;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }
}
