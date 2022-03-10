package site.unp.cms.service.singl;

import java.io.BufferedOutputStream;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;

import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.web.FileDwldController;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.menu.MasterMenuManager;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;
import site.unp.core.util.StrUtils;
import site.unp.core.util.WebFactory;

public interface ContentsService {
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	/**
	 * 콘텐츠 History 사용여부 변경
	 * */
	public void updateUseAt(ParameterContext paramCtx) throws Exception;
	/**
	 * 콘텐츠 파일 내용수정
	 * */
	public void updateFile(ZValue param) throws Exception;

	/**
	 * 콘텐츠 최종파일 등록
	 * */
	public void insert(ParameterContext paramCtx) throws Exception;
	/**
	 * 준비중 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void ready(ParameterContext paramCtx) throws Exception;

	public void comparePop(ParameterContext paramCtx) throws Exception;
	
	public void compare(ParameterContext paramCtx) throws Exception;

	public void downloadContents(ParameterContext paramCtx) throws Exception;
}
