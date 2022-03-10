package site.unp.cms.service.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

public interface UwamMemberService{
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	public void forLogin(ParameterContext paramCtx) throws Exception;


	/**
	 * 승인상태 업데이트 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateConfmState(ParameterContext paramCtx) throws Exception;

	/**
	 * 사이트 URL 관련정보 상세 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void viewSite(ParameterContext paramCtx) throws Exception;

	/**
	 * 사이트 URL 관련정보 등록 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forInsertSiteStep1(ParameterContext paramCtx) throws Exception;

	public void forInsertSiteStep2(ParameterContext paramCtx) throws Exception;
	
	public void forInsertSite(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 사이트 URL 관련정보 수정 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateSiteStep1(ParameterContext paramCtx) throws Exception;

	public void forUpdateSiteStep2(ParameterContext paramCtx) throws Exception;

	public void forUpdateSite(ParameterContext paramCtx) throws Exception;

	/**
	 * 사이트 URL 관련정보 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void insertSite(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 사이트 URL 관련정보 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateSite(ParameterContext paramCtx) throws Exception;

	/**
	 * 사이트 URL 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void deleteSiteUrl(ParameterContext paramCtx) throws Exception;

	/**
	 * 사이트 경보 error log 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listErrLog(ParameterContext paramCtx) throws Exception;
}
