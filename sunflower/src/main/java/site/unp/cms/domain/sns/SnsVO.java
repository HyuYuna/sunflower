package site.unp.cms.domain.sns;

import java.util.Date;

import org.apache.commons.lang.builder.ReflectionToStringBuilder;

public class SnsVO {
	
	private String profileimageurl = "";
	private String screenname = "";
	private String id = "";
	private String name = "";
	private String text = "";
	private Date createdat = null;
	private String snsFlag = "";
	private String snsLink = "";

    private String[] snsFlagData;
    private String[] snsLinkData;

    /** 현재페이지 */
    private int pageIndex = 1;

    /** 페이지갯수 */
    private int pageUnit = 5;

    /** 페이지사이즈 */
    private int pageSize = 10;

    /** 첫페이지 인덱스 */
    private int firstIndex = 1;

    /** 마지막페이지 인덱스 */
    private int lastIndex = 1;

    private int totalRows = 0;

    /** 페이지당 레코드 개수 */
    private int recordCountPerPage = 5;

	private int totCnt = 0;
	
	public int getTotCnt() {
		return totCnt;
	}
	public void setTotCnt(int totCnt) {
		this.totCnt = totCnt;
	}
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String[] getSnsLinkData() {
		return snsLinkData;
	}
	public void setSnsLinkData(String[] snsLinkData) {
		this.snsLinkData = snsLinkData;
	}
	public int getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getFirstIndex() {
		return firstIndex;
	}
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	public int getLastIndex() {
		return lastIndex;
	}
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	public int getTotalRows() {
		return totalRows;
	}
	public void setTotalRows(int totalRows) {
		this.totalRows = totalRows;
	}
	public String getProfileimageurl() {
		return profileimageurl;
	}
	public void setProfileimageurl(String profileimageurl) {
		this.profileimageurl = profileimageurl;
	}
	public String getScreenname() {
		return screenname;
	}
	public void setScreenname(String screenname) {
		this.screenname = screenname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	public Date getCreatedat() {
		return createdat;
	}
	public void setCreatedat(Date createdat) {
		this.createdat = createdat;
	}
	public String getSnsFlag() {
		return snsFlag;
	}
	public void setSnsFlag(String snsFlag) {
		this.snsFlag = snsFlag;
	}
	public String getSnsLink() {
		return snsLink;
	}
	public void setSnsLink(String snsLink) {
		this.snsLink = snsLink;
	}
	public String toString(){
		return ReflectionToStringBuilder.toString(this);
	}
	public String[] getSnsFlagData() {
		return snsFlagData;
	}
	public void setSnsFlagData(String[] snsFlagData) {
		this.snsFlagData = snsFlagData;
	}
	
}
