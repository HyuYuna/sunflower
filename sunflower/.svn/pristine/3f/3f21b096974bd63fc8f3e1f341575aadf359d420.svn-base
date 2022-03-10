package site.unp.cms.web;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.dao.siteManage.NtcnRelmDAO;
import site.unp.cms.dao.siteManage.PopupDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.siteManage.BannerService;
import site.unp.cms.service.siteManage.NtcnRelmService;
import site.unp.cms.service.siteManage.PopupService;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.cms.service.sys.SysInfoService;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.service.menu.MasterMenuManager;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.WebFactory;

/**
 * 관리자 Main 컨트롤러
 * @author jks
 *
 */
@Controller
public class AdminMainController {

	protected Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "masterMenuManagerService")
	protected MasterMenuManager masterMenuManagerService;

	@Resource(name = "bannerService")
	protected BannerService bannerService;

	@Resource(name = "ntcnRelmService")
	protected NtcnRelmService ntcnRelmService;

	@Resource(name = "popupService")
	protected PopupService popupService;

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Resource(name = "sysInfoService")
	protected SysInfoService sysInfoService;

	@Resource(name = "popupDAO")
	private PopupDAO popupDAO;

	@Resource(name = "ntcnRelmDAO")
	private NtcnRelmDAO ntcnRelmDAO;

	@SuppressWarnings("unchecked")
	@RequestMapping(value = { "/bos/main/main", "/bos/loginProcess" })
	public String bosLoginProcess(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception {
		if( !UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY") ){
			HttpUtil.winClose(response, "관리자만 접속할 수 있습니다.");
			return null;
		}

		MemberVO user1 = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("adminUser", user1);
		ZValue loginPolicy = sqlDAO.findOneById("findOneMngrLoginPolicy",user1.getUserPin());
		ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());
		/*업무지원 new 확인*/
		ZValue boardNewYn = sqlDAO.findOneById("findOneMngrMenuBoardNewYn",user1.getUserPin());
		/*문서수발신 new 확인*/
		ZValue boardNewYn2 = sqlDAO.findOneById("findOneMngrMenuBoardNewYn2",user1.getCenterCode());
		session.setAttribute("adminUser2", user);
		session.setAttribute("loginPolicy", loginPolicy);
		session.setAttribute("boardNewYn", boardNewYn);
		session.setAttribute("boardNewYn2", boardNewYn2);
		
		ZValue param = WebFactory.getAttributes(request);

		HashMap<String, List<ZValue>> map = (HashMap<String, List<ZValue>>) session.getAttribute("adminMenuMap");
		ZValue currentVo = masterMenuManagerService.getCurrentMenu(map, param.getInt("menuNo", 0));
		
		List<ZValue> popupList = null;
		//popupList = popupDAO.findPopupBySiteIdSe(SiteInfoService.BOS_SITE_ID);
		popupList = sqlDAO.findAll("findPopupBySiteIdSe",currentVo);
		
		
		
		

		/*
		 * deriveDaycnt = 오늘 - 변경일자
		 *
		 */
		/*int deriveDaycnt = (int) user.get("deriveDaycnt");*/
		/*int passwordDeriveDaycnt = (int) loginPolicy.get("passwordDeriveDaycnt");


		if(deriveDaycnt >= passwordDeriveDaycnt) {
			model.addAttribute("changePasswordYn", "Y");
		}*/

		if (currentVo != null) currentVo = masterMenuManagerService.getCurrentMenuVO(map, currentVo.getString("menuLc"));
		model.addAttribute("currentVo", currentVo);

		param.put("userId", user1.getUserId());
		param.put("bddcCenter", user1.getCenterCode());
    	param.put("pSiteId","bos");
    	if (!popupList.isEmpty()) {
    		model.addAttribute("popupList", popupList);
		}
    	/*model.addAttribute("popupList", popupDAO.findPopupBySiteIdSe(SiteInfoService.BOS_SITE_ID));*/

    	// 공지사항
    	List<ZValue> bid7List = sqlDAO.findAll("findAllBbsByMngrMainBid7",param);
    	model.addAttribute("bid7List", bid7List);

    	// 자료실
    	List<ZValue> bid11List = sqlDAO.findAll("findAllBbsByMngrMainBid11",param);
    	model.addAttribute("bid11List", bid11List);

    	// 문서 수신함
    	List<ZValue> boardList = sqlDAO.findAll("findAllBbsByMngrMainBoard",param);
    	model.addAttribute("boardList", boardList);

    	// 메일 수신함
    	List<ZValue> messageList = sqlDAO.findAll("findAllBbsByMngrMainMessage",param);
    	model.addAttribute("messageList", messageList);

    	// 최근 등록사례
    	List<ZValue> caseList = sqlDAO.findAll("findAllBbsByMngrMainCase",param);
    	model.addAttribute("caseList", caseList);

    	// 최근 지원서비스
    	List<ZValue> passList = sqlDAO.findAll("findAllBbsByMngrMainPass",param);
    	model.addAttribute("passList", passList);

    	// 상담직군 게시판
    	List<ZValue> bid1List = sqlDAO.findAll("findAllBbsByMngrMainBid1",param);
    	model.addAttribute("bid1List", bid1List);

    	// 간호직군 게시판
    	List<ZValue> bid2List = sqlDAO.findAll("findAllBbsByMngrMainBid2",param);
    	model.addAttribute("bid2List", bid2List);

    	// 행정직군 게시판
    	List<ZValue> bid4List = sqlDAO.findAll("findAllBbsByMngrMainBid4",param);
    	model.addAttribute("bid4List", bid4List);

    	// 동행직군 게시판
    	List<ZValue> bid5List = sqlDAO.findAll("findAllBbsByMngrMainBid5",param);
    	model.addAttribute("bid5List", bid5List);

    	// 부소장직군 게시판
    	List<ZValue> bid6List = sqlDAO.findAll("findAllBbsByMngrMainBid6",param);
    	model.addAttribute("bid6List", bid6List);

    	model.addAttribute("resultMypage", sqlDAO.findOne("findMainMypage",param));

		return "bos/main/bosMain";

	}

	@RequestMapping(value = "/bos/main/setContents")
	public void setContents(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
		String siteId = zvl.getString("siteId");
		Assert.hasText(siteId);
		if ("bos".equals(siteId))
			throw new IllegalArgumentException("관리자는 허용하지 않습니다.");
		masterMenuManagerService.setContents(siteId);
	}

	@RequestMapping(value = "/bos/main/reloadMenu")
	public void giveStaffAuthoFromDept(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
		String siteId = zvl.getString("siteId");
		Assert.hasText(siteId);
		if (SiteInfoService.BOS_SITE_SN.equals(siteId))
			throw new IllegalArgumentException("관리자는 허용하지 않습니다.");
		masterMenuManagerService.reloadMenu(siteId);
	}

	@RequestMapping(value = "/bos/main/createTempContentsFile")
	public void createTempContentsFile(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue zvl = WebFactory.getAttributes(request);
		String siteId = zvl.getString("siteId");
		Assert.hasText(siteId);
		if (SiteInfoService.BOS_SITE_SN.equals(siteId))
			throw new IllegalArgumentException("관리자는 허용하지 않습니다.");
		masterMenuManagerService.createTempContentsFile(siteId);
	}



}
