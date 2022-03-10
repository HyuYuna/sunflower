package site.unp.cms.service.siteManage;

import java.util.List;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;


public interface SiteInfoService{
	public static final String BOS_SITE_SN = "1";
	public static final String BOS_SITE_ID = "bos";
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	
	//사이트ID 중복확인 함수
	
	public void cnfirmSiteId(ParameterContext paramCtx) throws Exception ;

	//사이트 상세정보
	public ZValue getSiteBySiteName(String siteId) throws Exception;

	public List<ZValue> getSiteGuideMenuListBySiteId(String siteId, String seCd) throws Exception;


	public void useYnChange(ParameterContext paramCtx) throws Exception;

	/**
	 * 상단 가이드메뉴 관리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void upendList(ParameterContext paramCtx) throws Exception;

	/**
	 * 하단 가이드메뉴 관리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void lptList(ParameterContext paramCtx) throws Exception;

	/**
	 * 상하단 가이드메뉴 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateSiteGuideMenu(ParameterContext paramCtx) throws Exception;
}
