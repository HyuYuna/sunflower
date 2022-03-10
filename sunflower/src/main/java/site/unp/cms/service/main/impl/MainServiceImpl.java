package site.unp.cms.service.main.impl;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.security.crypto.codec.Base64;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.web.context.ServletContextAware;

import site.unp.cms.dao.siteManage.NtcnRelmDAO;
import site.unp.cms.dao.siteManage.PopupDAO;
import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.dao.siteManage.VisualDAO;
import site.unp.cms.service.main.MainService;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.menu.MasterMenuManager;
import site.unp.core.util.CacheUtil;
import site.unp.core.util.MVUtils;
import site.unp.core.util.UnpCollectionUtils;

@CommonServiceDefinition
@Service
public class MainServiceImpl extends DefaultCrudServiceImpl implements ServletContextAware, MainService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	//private final String[] MAIN_BBS_IDS = { "B0000240","B0000238" };
	
	protected final String AUTH_SESSION_KEY = "authSessionKey";

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	@Resource(name = "masterMenuManagerService")
	private MasterMenuManager masterMenuManagerService;

	@Resource(name = "siteInfoDAO")
	private SiteInfoDAO siteInfoDAO;

	@Resource(name = "ntcnRelmDAO")
	private NtcnRelmDAO ntcnRelmDAO;

	@Resource(name = "popupDAO")
	private PopupDAO popupDAO;

	@Resource(name = "visualDAO")
	private VisualDAO visualDAO;

	public void main(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> resultList = sqlDao.findAll("findAllUserMainCntnts", param);
		model.addAttribute("fileMap", listHandler.getFileMap(param, resultList));
		int numtest =0;
		for (ZValue vo : resultList) {
			if ("01".equals(vo.getString("mainCntntsCd"))) {
				if ("PG0002".equals(vo.getString("bbsAttrbCd"))) {
					List<ZValue> boardList = getBbs(vo.getString("bbsId"), 1);
					vo.putObject("bbsList", boardList);
				}
				else {
					List<ZValue> boardList = getBbs(vo.getString("bbsId"), 4);
					vo.putObject("bbsList", boardList);
				}

			}

			else if ("04".equals(vo.getString("mainCntntsCd"))) {
				List<ZValue> ntcnRelmList = ntcnRelmDAO.selectPublishList(SiteInfoServiceImpl.UCMS_SITE_ID, null);
				vo.putObject("ntcnRelmList", ntcnRelmList);
			}
			model.addAttribute("relmSeCd"+vo.getString("relmSeCd"), vo);
		}
		model.addAttribute("popupList", popupDAO.findPopupBySiteIdSe(SiteInfoServiceImpl.UCMS_SITE_ID));

		List<ZValue> visualList = visualDAO.findUserVisual();
		model.addAttribute("visualList", visualList);

	}

	/*
	public void main(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		//실명인증 처리후 실명인증 비 종료 시 남은 인증삭제
		UsersVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null && "ROLE_VNAME".equals(user.getAuthorCd())) {
			SecurityContextHolder.clearContext();
		}
		if (paramCtx.getRequest().getSession() != null) paramCtx.getRequest().getSession().removeAttribute(AUTH_SESSION_KEY);

		// 공통게시판
		for (String bbsId : MAIN_BBS_IDS) {
			int num = 4; // 게시물 갯수
			if ("B0000240".equals(bbsId)) num = 4;
			else if ("B0000238".equals(bbsId)) num = 1;
			List<ZValue> boardList = getBbs(bbsId, num);
			model.addAttribute(bbsId + "List", boardList);
		}


		List<ZValue> ntcnRelmList = ntcnRelmDAO.selectPublishList(SiteInfoService.UCMS_SITE_ID, null);
		model.addAttribute("ntcnRelmList", ntcnRelmList);

		model.addAttribute("popupList", popupDAO.findPopupBySiteIdSe(SiteInfoService.UCMS_SITE_ID));
	}
	*/

	public void preview(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String cvCon = new String(Base64.decode(param.getString("cntntsCn").getBytes("UTF-8")), "UTF-8");
		model.addAttribute( "cntntsCn", cvCon );
	}

	@UnpJsonView
	public void contents(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue siteInfo = siteInfoDAO.getSiteBySiteName(param.getString("siteId"));
		String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + siteInfo.getString("siteId");
		@SuppressWarnings("unchecked")
		HashMap<String, List<ZValue>> menuMap = (HashMap<String, List<ZValue>>)servletContext.getAttribute(contextScopeMenuAllName);
		ZValue currentVo = masterMenuManagerService.getCurrentMenu(menuMap, param.getInt("menuNo"));

		model.addAttribute(ModelAndViewResolver.INCLUDE_PAGE, currentVo==null ? ModelAndViewResolver.INCLUDE_DEFAULT_PAGE :currentVo.getString("cntntsFileCours"));
		if (param.getString(ModelAndViewResolver.CONTENTS_PREVEW_PARAM)!=null){
			model.addAttribute(ModelAndViewResolver.CONTENTS_PREVEW_PARAM, param.getString(ModelAndViewResolver.CONTENTS_PREVEW_PARAM));
		}
	}

	public void forPrint(ParameterContext paramCtx) throws Exception {

	}

	public void siteGo(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		String link = param.getString("link");
		Assert.hasText(link);

		ModelMap model = paramCtx.getModel();
		model.addAttribute(RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(GO_URL_KEY, link);
	}

	@CacheEvict(value=PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public void removeCache(ParameterContext paramCtx) throws Exception {
		MVUtils.goUrl("javascript:history.back();", "성공적으로 캐시 삭제되었습니다.", paramCtx.getModel());
	}


	public void removeCacheAll(ParameterContext paramCtx) throws Exception {
		cacheUtil.removeAll();
		MVUtils.goUrl("javascript:history.back();", "성공적으로 캐시 삭제되었습니다.", paramCtx.getModel());
	}


	private List<ZValue> getBbs(String bbsId, int recordCountPerPage) throws Exception {
		ZValue param = new ZValue();
		param.put("bbsId", bbsId);
		param.put("id", bbsId);
		param.put("firstIndex", 0);
		param.put("mainRecordCountPerPage", recordCountPerPage);
		param.put("queryId", "findAllBbsEstnMain");
		List<ZValue> boardList = getList(param);

		Map<String, List<ZValue>> fileMap = listHandler.getFileMap(param, boardList);
		UnpCollectionUtils.setFirstFile(boardList, fileMap, "atchFileId");

		return boardList;
	}

	private List<ZValue> getList(ZValue param) throws Exception {
		String id = param.getString("id");
		//List<ZValue> list = new ArrayList<ZValue>();
		//list = sqlDao.listDAO(param.getString("queryId"), param);
		@SuppressWarnings("unchecked")
		List<ZValue> list = (List<ZValue>) cacheUtil.load(PORTAL_MAIN_CACHE_NAME, id + "List");
		if (list == null) {
			list = sqlDao.findAll(param.getString("queryId"), param);
			cacheUtil.save(PORTAL_MAIN_CACHE_NAME, id + "List", list);
		}

		Map<String, List<ZValue>> fileMap = listHandler.getFileMap(param, list);
		UnpCollectionUtils.setFirstFile(list, fileMap, "atchFileId");
		return list;
	}



	private ServletContext servletContext;
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}
