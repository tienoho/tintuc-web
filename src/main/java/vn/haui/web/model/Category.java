package vn.haui.web.model;

public class Category {
    private int categoryID;
    private String categoryName;
    private String categoryDes;
    private String categorySlug;
    private int categoryParent;
    public Category() {
    }

    public Category(int categoryID, String categoryName, String categoryDes, String categorySlug, int categoryParent) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.categoryDes = categoryDes;
        this.categorySlug = categorySlug;
        this.categoryParent = categoryParent;
    }

    public int getCategoryParent() {
        return categoryParent;
    }

    public void setCategoryParent(int categoryParent) {
        this.categoryParent = categoryParent;
    }



    public String getCategoryDes() {
        return categoryDes;
    }

    public void setCategoryDes(String categoryDes) {
        this.categoryDes = categoryDes;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getCategorySlug() {
        return categorySlug;
    }

    public void setCategorySlug(String categorySlug) {
        this.categorySlug = categorySlug;
    }
}
