package local.cms.web.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

@Entity
@Table(name = "blog_posts")
public class Post {
	private int blog_post_id;
	private String title;
	private String content;
	private Status status;
	private byte[] image;
	private Date publish;
	private Date created;
	private Date modified;
	private String username;
	private String imageSrc;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	public int getBlog_post_id() {
		return blog_post_id;
	}

	public void setBlog_post_id(int blog_post_id) {
		this.blog_post_id = blog_post_id;
	}

	@Column(name = "title")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	@Column(name = "content")
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Column(name = "status")
	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	@Column(name = "created", columnDefinition = "DATETIME")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	@Column(name = "modified", columnDefinition = "DATETIME")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getModified() {
		return modified;
	}

	public void setModified(Date modified) {
		this.modified = modified;
	}

	@Lob
	@Column(name = "post_image", columnDefinition = "mediumblob")
	public byte[] getImage() {
		return image;
	}

	public void setImage(byte[] image) {
		this.image = image;
	}

	@Column(name = "username")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Transient
	public String getImageSrc() {
		return imageSrc;
	}

	public void setImageSrc(String imageSrc) {
		this.imageSrc = imageSrc;
	}

	@PrePersist
	protected void onPrePersist() {
		this.created = new Date();
	}

	@PreUpdate
	protected void onPreUpdate() {
		this.modified = new Date();
	}

	@Column(name = "publish", columnDefinition = "DATETIME")
	@Temporal(TemporalType.TIMESTAMP)
	public Date getPublish() {
		return publish;
	}

	public void setPublish(Date publish) {
		this.publish = publish;
	}
}
