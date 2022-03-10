package site.unp.cms.service.siteManage.impl;

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
import site.unp.cms.service.singl.FileServer;
import site.unp.cms.service.siteManage.IndvdlinfoColctService;
import site.unp.cms.web.FileDwldController;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLinks;
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
	pageQueryData="menuNo,sSiteId,searchKey,searchStr,viewType,colctSe,pSiteId,cntntsFileCours",
	sqlDaoRef="contentsDAO"
)
@Service
public class IndvdlinfoColctServiceImpl extends DefaultCrudServiceImpl implements IndvdlinfoColctService{

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
	@CommonServiceLinks({
	@CommonServiceLink(desc="개인정보 처리방침", linkType=LinkType.BOS, paramString="colctSe=IC01&pSiteId=ucms"),
	@CommonServiceLink(desc="개인정보 수집/이용 동의", linkType=LinkType.BOS, paramString="colctSe=IC02&pSiteId=ucms"),
	@CommonServiceLink(desc="개인정보 이용 고지사항", linkType=LinkType.BOS, paramString="colctSe=IC03&pSiteId=ucms"),
	@CommonServiceLink(desc="개인정보 제3자 동의", linkType=LinkType.BOS, paramString="colctSe=IC04&pSiteId=ucms"),
	@CommonServiceLink(desc="개인정보 제3자 고지사항", linkType=LinkType.BOS, paramString="colctSe=IC05&pSiteId=ucms"),
	@CommonServiceLink(desc="주민등록번호 처리 근거", linkType=LinkType.BOS, paramString="colctSe=IC06&pSiteId=ucms"),
	@CommonServiceLink(desc="개인정보 처리업무 위탁 준수", linkType=LinkType.BOS, paramString="colctSe=IC07&pSiteId=ucms"),
	@CommonServiceLink(desc="비밀번호 작성 규칙", linkType=LinkType.BOS, paramString="colctSe=PW01&pSiteId=ucms")
	})
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if(!StringUtils.hasText(param.getString("colctSe"))){
    		model.addAttribute(ModelAndViewResolver.MSG_KEY, "개인정보 수집관리 구분값이 없습니다.");
    		model.addAttribute(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
    		return;
    	}

		super.doList(paramCtx, "findAllIndvdlinfoColctHist", "countIndvdlinfoColctHist");
		super.forUpdate(paramCtx);

		ZValue result = (ZValue)model.get("result");
		String contentsPathRoot = globalsProperties.getWebRootPath();
		String path =  File.separator + "WEB-INF" + File.separator + "jsp" + File.separator + param.getString("pSiteId") + File.separator + param.getString("groupId") + File.separator + param.getString("programId") + File.separator;
		File file = new File(contentsPathRoot + path);
		if (!file.isDirectory()) file.mkdir();

		file = new File(contentsPathRoot + path + param.getString("colctSe") + ".jsp");
		if (!file.isFile()) file.createNewFile(); 

		String contents = "";
		if (file.isFile() && param.getString("colctMnno").equals("")){
			contents = FileUtils.readFileToString(file, "UTF-8");
			contents = contents!=null ? contents.replaceAll("<%\\s*@\\s*page .*%\\s*>", "") : "";
			if (result!=null) { 
				result.put("colctCn", contents);
			}
		}

		model.addAttribute("colctPath", path + param.getString("colctSe") + ".jsp");
		model.addAttribute("result", result);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

    	String colctCn = StrUtils.htmlTostr(param.getString("colctCn"));
		param.put("colctCn", colctCn);
		// 기존 버전 전체 미사용으로 변경
		sqlDao.save("updateIndvdlinfoColctUseAtAllN", param);
		sqlDao.save("saveIndvdlinfoColct", param);

		String contentsPathRoot = globalsProperties.getWebRootPath();
		String path =  File.separator + "WEB-INF" + File.separator + "jsp" + File.separator + param.getString("pSiteId") + File.separator + param.getString("groupId") + File.separator + param.getString("programId") + File.separator;
		File file = new File(contentsPathRoot + path + param.getString("colctSe") + ".jsp");

    	String contents = "<%@page contentType=\"text/html;charset=utf-8\" %>\n" + colctCn;
		FileUtils.writeStringToFile(file, contents, "UTF-8");

		String url = "/bos/siteManage/indvdlinfoColct/forUpdate.do?pSiteId="+param.getString("pSiteId")+"&colctSe="+param.getString("colctSe")+"&menuNo="+param.getString("menuNo");
    	MVUtils.goUrl(url, "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	/**
	 * 콘텐츠 History 사용여부 변경
	 * */
	public void updateUseAt(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

		updateFile(param);
		
		String url = "/bos/siteManage/indvdlinfoColct/forUpdate.do?pSiteId="+param.getString("pSiteId")+"&colctSe="+param.getString("colctSe")+"&menuNo="+param.getString("menuNo");
		MVUtils.goUrl(url, "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO adminUser = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
    	param.put("userId", adminUser.getUserId());

		super.delete(paramCtx);
		
		updateFile(param);
		
		String url = "/bos/siteManage/indvdlinfoColct/forUpdate.do?pSiteId="+param.getString("pSiteId")+"&colctSe="+param.getString("colctSe")+"&menuNo="+param.getString("menuNo");
		MVUtils.goUrl(url, "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	/**
	 * 콘텐츠 파일 내용수정
	 * */
	public void updateFile(ZValue param) throws Exception {
		ZValue result = sqlDao.findOne("findOneIndvdlinfoColct", param);
		result.put("pSiteId", param.getString("pSiteId"));
    	sqlDao.modify("modifyIndvdlinfoColctUseAt", result);

		String contentsPathRoot = globalsProperties.getWebRootPath();
		String path =  File.separator + "WEB-INF" + File.separator + "jsp" + File.separator + param.getString("pSiteId") + File.separator + param.getString("groupId") + File.separator + param.getString("programId") + File.separator;
		File file = new File(contentsPathRoot + path + param.getString("colctSe") + ".jsp");
		
		String contents = "<%@page contentType=\"text/html;charset=utf-8\" %>\n" + result.getString("colctCn");
		FileUtils.writeStringToFile(file, contents, "UTF-8");
	}
}
