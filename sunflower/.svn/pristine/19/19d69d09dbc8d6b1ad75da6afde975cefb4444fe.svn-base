package site.unp.cms.service.singl.impl;

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
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;

import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.service.singl.ContentsService;
import site.unp.cms.service.singl.FileServer;
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

@CommonServiceDefinition(
	pageQueryData="menuNo,sSiteId,searchKey,searchStr,viewType,sMenuNo,cntntsFileCours",
	sqlDaoRef="contentsDAO"
)
@CommonServiceLink(desc="웹콘텐츠 관리", linkType=LinkType.BOS, paramString="sSiteId=ucms")
@Service
public class ContentsServiceImpl extends DefaultCrudServiceImpl implements ContentsService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "siteInfoDAO")
    private SiteInfoDAO siteInfoDAO;

	@Resource(name = "masterMenuManagerService")
    private MasterMenuManager masterMenuManagerService;

	@Resource(name = "fileServerClients")
    private List<FileServer> fileServerClients;

	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		if(UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {
    		param.put("role", "ROLE_SUPER");
    	}

		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

    	super.list(paramCtx);
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if(!StringUtils.hasText(param.getString("sMenuNo"))){
    		model.addAttribute(ModelAndViewResolver.MSG_KEY, "메뉴를 먼저 선택하여 주십시오.");
    		model.addAttribute(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
    		return;
    	}

		super.doList(paramCtx, "findOneContentsHistory", "findOneContentsHistoryCount");
		super.forUpdate(paramCtx);

		ZValue result = (ZValue)model.get("result");
		String contentsPathRoot = globalsProperties.getWebRootPath() + "/WEB-INF/jsp";
		String path = contentsPathRoot + result.getString("cntntsFileCours");
		File file = new File(path);
		String contents = "";
		if (file.isFile() && param.getString("cntntsMnno").equals("")){
			contents = FileUtils.readFileToString(file, "UTF-8");
			contents = contents.replaceAll("<%\\s*@\\s*page .*%\\s*>", "");
			result.put("cntntsCn", contents);
		}

		model.addAttribute("result", result);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

    	String cntntsCn = StrUtils.htmlTostr(param.getString("cntntsCn"));
		param.put("cntntsCn", cntntsCn);
		if (param.getString("useAt").equals("Y")){
			sqlDao.modify("modifyContents", param);
		}
		sqlDao.save("saveContents", param);

		if (param.getString("useAt").equals("Y")) {
			String contentsRoot = globalsProperties.getWebRootPath() + "/WEB-INF/jsp";
			ZValue contentsPathVal = sqlDao.findOne("findOneContentsFileCours", param);
			//String contentsPath = contentsPathVal.getString("cntntsFileCours");
			String contentsPath = param.getString("cntntsFileCours","");
			if ("".equals(contentsPath)) {
				contentsPath = contentsPathVal.getString("cntntsFileCours");
			}
			if ("".equals(contentsPath)) {
				contentsPath = "/cts/" + contentsPathVal.getString("siteId") + "/" + contentsPathVal.getString("menuNo") + ".jsp";
			}
			File file = new File(contentsRoot + contentsPath);

	    	String contents = "<%@page contentType=\"text/html;charset=utf-8\" %>\n" + cntntsCn;
			FileUtils.writeStringToFile(file, contents, "UTF-8");


	    	if (fileServerClients != null) {
	    		for (FileServer fileServer : fileServerClients) {
	    	    	log.debug("fileServer RMI client bean has invoked : " + fileServer);
	    	    	fileServer.download(file, contentsPath);
	    		}
	    	}
		}

		//컨텐츠 수정후 자료관리담당 최종수정일 바로반영
		/*@SuppressWarnings("unchecked")
		HashMap<String, List<MenuManageVO>> menuMap = (HashMap<String, List<MenuManageVO>>)servletContext.getAttribute("menuAll" + param.getString("siteId"));
		masterMenuManagerService.setModifyDay(menuMap, param.getInt("sMenuNo"));*/
		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	/**
	 * 콘텐츠 History 사용여부 변경
	 * */
	public void updateUseAt(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

    	sqlDao.modify("modifyContents", param);
		sqlDao.modify("modifyContentsHistory", param);
		updateFile(param);
		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

    	if (param.getString("useAt").equals("Y")) {
			sqlDao.modify("modifyContentsHistory", param);
		}

		super.delete(paramCtx);
		updateFile(param);
		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	private String getForwardLink(ZValue param) throws UnsupportedEncodingException {
		return WebFactory.buildUrl("/bos/singl/contents/forUpdate.do", param, "sSiteId", "sUseAt", "sMenuNo", "menuNo", "viewType", "gubun","cntntsFileCours");
	}

	/**
	 * 콘텐츠 파일 내용수정
	 * */
	public void updateFile(ZValue param) throws Exception {
		ZValue result = sqlDao.findOne("findOneContents", param);
		String contentsRoot = globalsProperties.getWebRootPath() + "/WEB-INF/jsp";
		String contentsPath = result.getString("cntntsFileCours","");
		if ("".equals(contentsPath)) {
			contentsPath = "/cts/"  + result.getString("siteId") + "/" + param.getString("cMenuNo")  + ".jsp";
		}
		File file = new File(contentsRoot + contentsPath);
		String contents = "<%@page contentType=\"text/html;charset=utf-8\" %>\n" + result.getString("cntntsCn");
		FileUtils.writeStringToFile(file, contents, "UTF-8");
	}

	/**
	 * 콘텐츠 최종파일 등록
	 * */
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());
		param.put("useAt", "Y");

		List<ZValue> resultList = sqlDao.findAll("findAllContentsFileCours");
		String contentsPathRoot = globalsProperties.getWebRootPath() + "/WEB-INF/jsp";

		for (ZValue result : resultList) {
			String contentsPath = contentsPathRoot + result.getString("cntntsFileCours");
			File file = new File(contentsPath);
			String contents = "";

			if (file.isFile()){
				contents = FileUtils.readFileToString(file, "UTF-8");
				contents = contents.replaceAll("<%\\s*@\\s*page .*%\\s*>", "");
				param.put("sMenuNo", result.getString("menuNo"));
				param.put("cntntsCn", StrUtils.htmlTostr(contents));

				if (result.getString("useAt").equals("Y")) {
					sqlDao.modify("modifyContents", param);
				}
				sqlDao.save("saveContents", param);
			}
		}

		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/bos/singl/contents/list.do?menuNo=" + param.getString("menuNo") + "&sSiteId=" + param.getString("sSiteId"));
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 등록되었습니다.");
	}

	/**
	 * 준비중 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	@CommonServiceLink(desc="콘텐츠 준비중 페이지", linkType=LinkType.USER, link="/{siteId}/singl/contents/ready.do")
	public void ready(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, "/cts/cmmn/ready.jsp");
	}

	public void comparePop(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		List<ZValue> resultList = sqlDao.findAll("findAllContentsHistory", param);
		model.addAttribute(RESULT_LIST, resultList);
	}

	@UnpJsonView
	public void compare(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.putObject("cntntsMnno", param.getString("orgCntntsMnno"));
		ZValue orgVal = sqlDao.findOne("findOneContents", param);
		param.putObject("cntntsMnno", param.getString("modCntntsMnno"));
		ZValue modVal = sqlDao.findOne("findOneContents", param);
		model.addAttribute("orgVal", orgVal);
		model.addAttribute("modVal", modVal);
	}

	public void downloadContents(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("cntntsMnno"));
		Assert.hasText(param.getString("sMenuNo"));

		ModelMap model = paramCtx.getModel();
		model.put(WINDOW_MODE, STREAM_WINDOW_MODE);

		ZValue result = sqlDao.findOne("findOneContents", param);
		String fileNm = "Ver." + param.getString("cntntsMnno") + ".txt";
		String mimetype = "application/x-msdownload";

		String cntntsCn = result.getString("cntntsCn");
		HttpServletResponse response = paramCtx.getResponse();
		HttpServletRequest request = paramCtx.getRequest();
		// response.setBufferSize(fSize); // OutOfMemeory 발생
		response.setContentType(mimetype);
		// response.setHeader("Content-Disposition", "attachment;
		// filename=\"" + URLEncoder.encode(fvo.getString("OrignlFileNm"), "utf-8")
		// + "\"");
		FileDwldController.setDisposition(fileNm, request, response);
		response.setContentLength(cntntsCn.length());

		/*
		 * FileCopyUtils.copy(in, response.getOutputStream()); in.close();
		 * response.getOutputStream().flush();
		 * response.getOutputStream().close();
		 */
		InputStream in = null;
		OutputStream out = null;

		try {
			in = new ByteArrayInputStream(cntntsCn.getBytes());
			out = new BufferedOutputStream(response.getOutputStream());

			FileCopyUtils.copy(in, out);
			out.flush();

		} catch (Exception ex) {
			// ex.printStackTrace();
			// 다음 Exception 무시 처리
			// Connection reset by peer: socket write error
			log.debug("IGNORED: " + ex.getMessage());
		} finally {
			if (in != null) {
				try {
					in.close();
				} catch (Exception ignore) {
					// no-op
					log.debug("IGNORED: " + ignore.getMessage());
				}
			}
			if (out != null) {
				try {
					out.close();
				} catch (Exception ignore) {
					// no-op
					log.debug("IGNORED: " + ignore.getMessage());
				}
			}
		}
	}
}
