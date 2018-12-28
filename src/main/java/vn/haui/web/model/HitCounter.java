package vn.haui.web.model;

public class HitCounter {
    private int idPost;
    private int hitCounter=0;

    public HitCounter() {
    }

    public HitCounter(int idPost, int hitCounter) {
        this.idPost = idPost;
        this.hitCounter = hitCounter;
    }

    public int getIdPost() {
        return idPost;
    }

    public void setIdPost(int idPost) {
        this.idPost = idPost;
    }

    public int getHitCounter() {
        return hitCounter;
    }

    public void setHitCounter(int hitCounter) {
        this.hitCounter = hitCounter;
    }
}
