package site.unp.cms.service.main;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.ui.ModelMap;

import site.unp.cms.dao.main.UserMainCntntsDAO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.handler.ListHandler;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;


public interface UserMainCntntsService{
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	public void main(ParameterContext paramCtx) throws Exception;

	/**
	 * 사용자 메인콘텐츠 상세관리  팝업화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void mainPopup(ParameterContext paramCtx) throws Exception;

	/**
	 * 사용자 메인콘텐츠 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insert(ParameterContext paramCtx) throws Exception;

	/**
	 * 사용자 메인콘텐츠 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void update(ParameterContext paramCtx) throws Exception;

	/**
	 * 사용자 메인콘텐츠 삭제처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void delete(ParameterContext paramCtx) throws Exception;

	public void listPopup(ParameterContext paramCtx) throws Exception;
}
