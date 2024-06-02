package beans;

import java.util.Date;

public class PostBean {
    private String postName;
    private Date postTime;
    private int postId;
    private String postUser;
    private String postContent;
    private byte[] postPhoto;
    
    public String getPostName() {
		return postName;
	}
	public void setPostName(String postName) {
		this.postName = postName;
	}
	public Date getPostTime() {
		return postTime;
	}
	public void setPostTime(Date postTime) {
		this.postTime = postTime;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getPostUser() {
		return postUser;
	}
	public void setPostUser(String postUser) {
		this.postUser = postUser;
	}
	public String getPostContent() {
		return postContent;
	}
	public void setPostContent(String postContent) {
		this.postContent = postContent;
	}
	public byte[] getPostPhoto() {
		return postPhoto;
	}
	public void setPostPhoto(byte[] postPhoto) {
		this.postPhoto = postPhoto;
	}
	

    // Getters and Setters
}
