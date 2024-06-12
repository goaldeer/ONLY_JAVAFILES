package beans;

import java.sql.Date;

public class CommentBean {
    private int commentid;
    private int postId;
    private String author;
    private String content;
    private Date createdAt;

    public int getcommentId() {
        return commentid;
    }

    public void setcommentId(int commentid) {
        this.commentid = commentid;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
