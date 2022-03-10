package site.unp.cms.domain.sns;

import java.util.ArrayList;
import java.util.List;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

@XmlRootElement(name="tistory")
@XmlAccessorType (XmlAccessType.FIELD)
public class TiStory {

	@XmlElement
	private String status;

	@XmlElement
	private String id;

	@XmlElement
	private String userId;


	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@XmlElement(name="item")
	private List<Item> item = new ArrayList<Item>();

	public List<Item> getItem() {
		return item;
	}

	public void setItem(List<Item> item) {
		this.item = item;
	}

	@Override
	public String toString(){
		return ReflectionToStringBuilder.toString(this);
	}

	@XmlRootElement(name="item")
	@XmlAccessorType (XmlAccessType.FIELD)
	public static class Item {

		@XmlElement
		private String url;
		@XmlElement
		private String nickname;
		@XmlElement
		private String title;
		@XmlElement
		private String blogIconUrl;
		@XmlElement
		private String profileImageUrl;
		@XmlElement
		private String profileThumbnailImageUrl;
		@XmlElement
		private String blogId;


		public String getUrl() {
			return url;
		}
		public void setUrl(String url) {
			this.url = url;
		}
		public String getNickname() {
			return nickname;
		}
		public void setNickname(String nickname) {
			this.nickname = nickname;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
		public String getBlogIconUrl() {
			return blogIconUrl;
		}
		public void setBlogIconUrl(String blogIconUrl) {
			this.blogIconUrl = blogIconUrl;
		}
		public String getProfileImageUrl() {
			return profileImageUrl;
		}
		public void setProfileImageUrl(String profileImageUrl) {
			this.profileImageUrl = profileImageUrl;
		}
		public String getBlogId() {
			return blogId;
		}
		public void setBlogId(String blogId) {
			this.blogId = blogId;
		}


		public String getProfileThumbnailImageUrl() {
			return profileThumbnailImageUrl;
		}
		public void setProfileThumbnailImageUrl(String profileThumbnailImageUrl) {
			this.profileThumbnailImageUrl = profileThumbnailImageUrl;
		}
		@Override
		public String toString(){
			return ReflectionToStringBuilder.toString(this);
		}
	}
}
