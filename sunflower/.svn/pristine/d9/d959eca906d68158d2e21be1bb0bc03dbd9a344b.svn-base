package site.unp.cms.service.singl.impl;


import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.Predicate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ServletContextAware;

import site.unp.cms.dao.singl.MenuDAO;
import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.service.singl.ContentsService;
import site.unp.cms.service.singl.MenuService;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.menu.MenuLoader;
import site.unp.core.util.MVUtils;
import site.unp.core.util.StrUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
		sqlDaoRef="menuDAO",
		pageQueryData="pSiteId,menuNo,searchCnd,searchKwd,viewType",
		listenerAndMethods={
			"initParamsListener=insert,update,delete,updateMenuNm,updateUpperMenuNo",
			"menuCntntsCdListener=list"
		}
)
@CommonServiceLink(desc="메뉴 관리 프로그램", linkType=LinkType.BOS)
@Service
public class MenuServiceImpl extends DefaultCrudServiceImpl implements ServletContextAware, MenuService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "siteInfoService")
	private SiteInfoService siteInfoService;

    @Resource(name = "siteInfoDAO")
    private SiteInfoDAO siteInfoDAO;

    @Resource(name = "contentsService")
	private ContentsService contentsService;


	private ServletContext servletContext;

	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}

	@UnpJsonView
	public void listJson(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		ZValue param2 = paramCtx.getParam();
		param2.put("codegCode", "MENU_CNTNTS_CD");
    	List<ZValue> menuCntntsCdList = sqlDao.findAll("findAllCmmnCdDetailByCdId", param2);
    	/*
    	System.out.println("============================================================================");
    	System.out.println(menuCntntsCdList);
    	System.out.println("============================================================================");
    	*/
    	model.addAttribute("menuCntntsCdList", menuCntntsCdList);

		String cMenuNo = param.getString("cMenuNo");
		String siteId = param.getString("pSiteId");
		if (siteId == null || "".equals(siteId)) siteId = SiteInfoService.BOS_SITE_ID; //기본 사이트 관리자로 지정
		param.put("pSiteId", siteId);

		if (StringUtils.hasText(cMenuNo)) {
			ZValue result = getSqlDao(MenuDAO.class).findOneByIdMenu(cMenuNo);
			model.addAttribute("singleJsonData", result);
		}
		else {
			List<ZValue> listMenu = getSqlDao(MenuDAO.class).findAllMenuByParam(siteId, param.getString("upperMenuNo"));
			model.addAttribute("singleJsonData", listMenu);
		}
	}

	@Override
	@CommonServiceLinks(
		{	@CommonServiceLink(desc="사용자 메뉴관리", linkType=LinkType.BOS, paramString="pSiteId=ucms"),
			@CommonServiceLink(desc="관리자 메뉴관리", linkType=LinkType.BOS, paramString="pSiteId=bos")
		}
	)
	public void list(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	/* param.put("siteId", siteId);
    	param.put("tempValue", "1");

    	List<ZValue> resultList = sqlDao.findAll("findAllMenu", param);
    	model.addAttribute("resultList", resultList); */
    	
    	ZValue param2 = paramCtx.getParam();
		param2.put("codegCode", "MENU_CNTNTS_CD");
    	List<ZValue> menuCntntsCdList = sqlDao.findAll("findAllCmmnCdDetailByCdId", param2);
    	
    	/*System.out.println("============================================================================");
    	System.out.println(menuCntntsCdList);
    	System.out.println("============================================================================");
    	*/
    	model.addAttribute("menuCntntsCdList", menuCntntsCdList);
    	
        //콘텐츠 가져오기
		String cMenuNo = param.getString("cMenuNo");
        if (cMenuNo != null && !cMenuNo.equals("")) {
        	model.addAttribute("menuCon", sqlDao.findOneById("findOneByIdMenuByContents", cMenuNo));
        }

        ZValue siteInfo = siteInfoDAO.getSiteBySiteId(null);
        model.addAttribute("siteInfo", siteInfo);
	}

	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		String siteId = param.getString("pSiteId");
		if (siteId == null || "".equals(siteId)) siteId = SiteInfoService.BOS_SITE_ID; //기본 사이트 관리자로 지정

    	String menuNm = URLDecoder.decode(param.getString("menuNm"), "UTF-8");
    	param.put("menuNm", URLDecoder.decode(menuNm, "UTF-8"));

		param.put("menuCntntsCd", "COM01"); //default준비중
		param.put("menuLink", "/"+siteId+"/singl/contents/ready.do"); //default준비중

		param.put("pSiteId", siteId);
		param.put("menuOrdr", sqlDao.count("selectMaxMenuOrdr", param));
		param.put("siteSn", sqlDao.selectString("selectSiteSn", param));

		super.insert(paramCtx);

		paramCtx.getModel().addAttribute("cMenuNo", param.getString("menuNo"));
	}

	@Override
	@UnpJsonView
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		String siteId = param.getString("pSiteId");
		if (siteId == null || "".equals(siteId)) siteId = SiteInfoService.BOS_SITE_ID; //기본 사이트 관리자로 지정

		if (param.getString("menuDc") != null && !"".equals(param.getString("menuDc"))) {
			param.put("menuDc", (StrUtils.htmlTostr(param.getString("menuDc"))));
		}

		super.update(paramCtx);

		// 콘테츠 관리 테이블에 내용 저장
		if (param.getString("chkConModi") != null && param.getString("chkConModi").equals("Y")){
			//commonContentsDAO.modify(param);

			//파일생성
			//String cntntsFileCours = menuManageVO.getcntntsFileCours();
			//String path = "/WEB-INF/jsp/framework" + cntntsFileCours;
			//File f = new File(path);
			//FileUtils.writeStringToFile(f, menuManageVO.getCvCon(), "UTF-8");
		}
	}

	@Override
	@UnpJsonView
	public void delete(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

    	String siteId = param.getString("pSiteId");
    	if( siteId == null || "".equals(siteId)) siteId = SiteInfoService.BOS_SITE_ID; //기본 사이트 관리자로 지정

		super.delete(paramCtx);

		if (!"0".equals(param.getString("upperMenuNo"))) {
			param.put("cMenuNo", param.getString("upperMenuNo"));
			ZValue result = sqlDao.findOne("findOneByIdMenu", param);
			if ("DWN01".equals(result.getString("menuCntntsCd"))) {
				param.put("menuCntntsCd", "COM01");
				param.put("menuLink", "/"+ result.getString("siteId") +"/singl/contents/ready.do");
				sqlDao.modify("updateMenuCntntsCd", param);
			}
		}
	}

	/**
	 * 메뉴명 수정(메뉴관리 오른쪽 마우스 rename기능)
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateMenuNm(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	String menuNm = URLDecoder.decode(param.getString("menuNm"),"UTF-8");
    	param.put("menuNm", URLDecoder.decode(menuNm,"UTF-8"));

		sqlDao.modify("updateMenuForMenuNm", param);
		model.addAttribute("cMenuNo", param.getString("cMenuNo"));
		model.addAttribute("useAt", param.getString("useAt"));

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 상위메뉴번호 변경(메뉴관리 오른쪽 마우스 마우스 drag기능)
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateUpperMenuNo(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	sqlDao.modify("updateMenuForUpperMenuNo", param);
    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}


	/**
	 * 메뉴 최상위/상위/하위/최하위 이동 ~
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateMoveMenuNo(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	String[] listMenu = param.getString("menuData").split(",");
		int ordr = 0;
		for (String menuNo : listMenu) {
			param.put("menuOrdr", ordr += 10);
			param.put("cMenuNo", menuNo);
			sqlDao.modify("updateMoveMenuNo", param);
		}

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	@UnpJsonView
	public void menuContentCnt(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("contentCnt", sqlDao.count("findOneContentsHistoryCount", param));
	}

	@UnpJsonView
	public void menuLoadSite(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	String siteId = param.getString("pSiteId");
    	if (!StringUtils.hasText(siteId)) {
    		param.put("pSiteId", SiteInfoService.BOS_SITE_ID); //기본 사이트 관리자
    	}
    	param.put("siteSn", sqlDao.selectString("selectSiteSn", param));

    	menuLoad(paramCtx);
    	MVUtils.setResultProperty(model, SUCCESS, "정상처리하였습니다");
    	/*String flag = "N";
    	if (flag!=null && !flag.equals("Y")) {
    		MVUtils.winCloseReload("정상처리하였습니다.", model);
    	}
    	else {
    		MVUtils.winCloseReload("현재 로딩중인 매뉴가 있습니다. 잠시 후 다시 시도하여 주십시오..", model);
    	}*/
    }

    @Resource(name="menuLoaderClients")
    private List<MenuLoader> menuLoaderClients;

    /**
     * 사용자 메뉴정보를 메모리에 올림
     * @param siteId
     * @return
     * @throws Exception
     */
	public void menuLoad(ParameterContext paramCtx) throws Exception{
    	ZValue param = paramCtx.getParam();

    	try {
    		servletContext.setAttribute("flag", "Y");
    		String siteId = param.getString("pSiteId");

    		if (!StringUtils.hasText(siteId)) {
    			String[] siteIdData = {"portal,ucms"};
    			for(String _siteId : siteIdData) {
        			HashMap<String, List<ZValue>> menuMap = getMenuCategoryMapBySiteId(paramCtx);
        			servletContext.setAttribute("menuAll"+_siteId, menuMap);
    			}
    		}
    		else {
    			HashMap<String, List<ZValue>> menuMap = getMenuCategoryMapBySiteId(paramCtx);
    			servletContext.setAttribute("menuAll_"+siteId, menuMap);  // 해당 사이트
    		}
		}
    	catch (Exception e) {
			throw e;
		}
    	finally {
			servletContext.setAttribute("flag", "N");
		}

    	try {
        	if (menuLoaderClients != null) {
        		for (MenuLoader menuLoader : menuLoaderClients) {
        	    	log.debug("menuLoader RMI client bean has invoked : " + menuLoader);
        			menuLoader.menuLoad();
        		}
        	}
		} catch (Exception e) {
			log.debug("=============================================================================");
			log.debug("Error!!!!!!!!!!!!  connect faild.... menuLoader RMI client");
			log.debug("=============================================================================");
		}

    }

	@SuppressWarnings("unchecked")
	public void menuLinkPop(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		final String pSiteId = param.getString("pSiteId");
		List<ZValue> resultList = getSqlDao(MenuDAO.class).findAllAnnotatedMenu(pSiteId);
		List<ZValue> newList = (List<ZValue>) CollectionUtils.select(resultList, new Predicate() {

			@Override
			public boolean evaluate(Object object) {
				boolean result = false;
				ZValue zvl = (ZValue)object;
	    		LinkType type = (LinkType)zvl.get("linkType");
	    		if (type == LinkType.ALL) {
	    			result = true;
	    		}
	    		else if (type == LinkType.BOS && pSiteId.equals(SiteInfoService.BOS_SITE_ID)) {
	    			result = true;
	    		}
	    		else if (type == LinkType.USER && !pSiteId.equals(SiteInfoService.BOS_SITE_ID)) {
	    			result = true;
	    		}
				return result;
			}

		});

		// 도움말 관리에서는 게시판유형별로 도움말 작성 가능하도록 게시판 유형제공
		if ("siteHpcm".equals(param.getString("pSrvcId"))){
			List<ZValue> attrbInfoList = sqlDao.findAll("findAllAttrbInfo", null);
			if (attrbInfoList!=null && attrbInfoList.size()>0){
				for (ZValue attrbInfo: attrbInfoList){
					// GS인증시에는 설문조사와 첨부파일 게시판 제외 처리
					if (!"PG0005".equals(attrbInfo.getString("attrbCd")) && !"PG0006".equals(attrbInfo.getString("attrbCd"))){
						ZValue addResult = new ZValue();
						addResult.put("groupId", "bbs");
						addResult.put("srvcId", attrbInfo.getString("attrbCd"));
						addResult.put("link", "/[siteId]/bbs/"+attrbInfo.getString("attrbCd")+"/list.do");
						addResult.put("desc", attrbInfo.getString("attrbNm"));
						newList.add(addResult);
					}
				}
			}
		}

		final String searchCnd = param.getString("searchCnd");
		final String searchWrd = param.getString("searchWrd");
		if (StringUtils.hasText(searchCnd) && StringUtils.hasText(searchWrd)) {
			newList = (List<ZValue>) CollectionUtils.select(newList, new Predicate() {

				@Override
				public boolean evaluate(Object object) {
					boolean result = false;
					ZValue zvl = (ZValue)object;
					String desc = zvl.getString("desc");
					String link = zvl.getString("link");
					if ("1".equals(searchCnd)) {
						if (StringUtils.hasText(desc)) {
							if (desc.indexOf(searchWrd) > -1) {
				    			result = true;
							}
						}
					}
					else if ("2".equals(searchCnd)) {
						if (StringUtils.hasText(link)) {
							if (link.indexOf(searchWrd) > -1) {
				    			result = true;
							}
						}
					}
					return result;
				}
			});
		}

/*		// 도움말 관리에서는 게시판유형별로 도움말 작성 가능하도록 게시판 유형제공
		if ("siteHpcm".equals(param.getString("pSrvcId"))){
			List<ZValue> attrbInfoList = sqlDao.findAll("findAllAttrbInfo", null);
			if (attrbInfoList!=null && attrbInfoList.size()>0){
				for (ZValue attrbInfo: attrbInfoList){
					// GS인증시에는 설문조사와 첨부파일 게시판 제외 처리
					if (!"PG0005".equals(attrbInfo.getString("attrbCd")) && !"PG0006".equals(attrbInfo.getString("attrbCd"))){
						ZValue addResult = new ZValue();
						addResult.put("groupId", "bbs");
						addResult.put("srvcId", attrbInfo.getString("attrbCd"));
						addResult.put("link", "/[siteId]/bbs/"+attrbInfo.getString("attrbCd")+"/list.do");
						addResult.put("desc", attrbInfo.getString("attrbNm"));
						newList.add(addResult);
					}
				}
			}
		}*/

		ModelMap model = paramCtx.getModel();
		model.addAttribute(RESULT_LIST, newList);
	}

	/**
	 * 메뉴관리 - 콘텐츠버전 관리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateContents(ParameterContext paramCtx) throws Exception {
		contentsService.forUpdate(paramCtx);
	}

	/**
	 * 메뉴관리 - 콘텐츠 버젼 비교 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void compareContentsPop(ParameterContext paramCtx) throws Exception {
		contentsService.comparePop(paramCtx);
	}

	/**
	 * 메뉴관리 - 콘텐츠 버젼 가져오기
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void compareContents(ParameterContext paramCtx) throws Exception {
		contentsService.compare(paramCtx);
	}

	/**
	 * 메뉴관리 - 콘텐츠버전 업데이트 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateContents(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		contentsService.update(paramCtx);
		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}


	/**
	 * 메뉴관리 - 컨텐츠 삭제 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteContents(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		contentsService.delete(paramCtx);
		MVUtils.goUrl(getForwardLink(param), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	private String getForwardLink(ZValue param) throws UnsupportedEncodingException {
		return WebFactory.buildUrl("/bos/singl/menu/forUpdateContents.do", param, "sSiteId", "sUseAt", "sMenuNo", "menuNo", "viewType", "gubun","cntntsFileCours");
	}

	public void downloadContents(ParameterContext paramCtx) throws Exception {
		contentsService.downloadContents(paramCtx);
	}


	public HashMap<String, List<ZValue>> getMenuCategoryMapBySiteId(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();

		List<ZValue> menuStructure = sqlDao.findAll("findAllMenuBySiteId", param);
    	HashMap<String, List<ZValue>> menuCategoryMap = getMenuCategories(menuStructure);
    	HashMap<String, List<ZValue>> obj = setMenuCategory(menuCategoryMap, PREFIX+"0", 0, new String[6]);
    	// 링크가 없는경우  하위메뉴링크로 대체 처리
    	obj = setNullLinkMenuCategory(menuCategoryMap, PREFIX+"0", 0);
    	modifyRearrangeMenu(obj);

    	HashMap<String, List<ZValue>> topObj = getTopMenuMap(menuStructure);

    	String key = CONTEXT_SCOPE_TOPMENU_PREFIX + param.getString("pSiteId");
    	servletContext.setAttribute(key, topObj.get(key));

    	return obj;
	}

	public HashMap<String, List<ZValue>> getMenuCategories(List<ZValue> list) {
		HashMap<String, List<ZValue>> categoryMap = new HashMap<String, List<ZValue>>();
		int size = list.size();
		for(int i=0; i<size; i++) {
			ZValue vo = list.get(i);
			String parentId = PREFIX+vo.getString("upperMenuNo");
			if (categoryMap.containsKey(parentId)) {
				List<ZValue> categoryList = categoryMap.get(parentId);
				categoryList.add(vo);
			}
			else {
				ArrayList<ZValue> categoryList = new ArrayList<ZValue>();
				categoryList.add(vo);
				categoryMap.put(parentId, categoryList);
			}
		}
		return categoryMap;
	}

	public HashMap<String, List<ZValue>> setMenuCategory(HashMap<String, List<ZValue>> menuCategoryMap, String parentId, int depth, String[] pos) {
		return setMenuCategory(menuCategoryMap, parentId, depth, pos, null);
	}

	public HashMap<String, List<ZValue>> setMenuCategory(HashMap<String, List<ZValue>> menuCategoryMap, String parentId, int depth, String[] pos, String gubun) {
		List<ZValue> menuCategories = menuCategoryMap.get(parentId);
		//List<ZValue> topCategories = menuCategoryMap.get(PREFIX+"0");
		if (menuCategories == null) {
			markLeafMenu(menuCategoryMap, parentId);
		}
		else {
			depth++;
			for (int i=0; i<menuCategories.size(); i++) {
				ZValue vo = menuCategories.get(i);

				if(depth > 6) {
					//log.debug("6뎁스이상은 허용하지않습니다. [menuNo," + vo.getString("menuNo") + "]");
				}

				int menuNo = vo.getInt("menuNo");

				pos[depth-1] = StrUtils.fillZero(String.valueOf(i+1), 2, true);
				String menuLc = getMenuLc(pos, depth);
				//ZValue curVo = getCurrentMenuCategory(menuCategoryMap, menuLc);
				ZValue curVo = getCurrentMenuVO(menuCategoryMap, menuLc);
				vo.put("path", curVo.getString("path"));
				//vo.setFullPath(curVo.getFullPath());

				if( !StringUtils.hasText(vo.getString("cntntsFileCours")) ) {
					String menuNoPath = curVo.getString("menuNoPath");
					String[] pathData = StrUtils.split(menuNoPath, "|");
					String leafMenuNo = pathData[pathData.length-1];
					StringBuffer cntntsFileCours = new StringBuffer();
					cntntsFileCours.append("/cts/").append("/").append(vo.getString("siteId")).append("/");
					cntntsFileCours.append(leafMenuNo).append(".jsp");
					vo.put("cntntsFileCours", cntntsFileCours.toString());
				}

				//일반컨텐츠 페이지
				StringBuffer menuLink = new StringBuffer(vo.getString("menuLink") == null ? "" : vo.getString("menuLink"));
				if (!StringUtils.hasText(menuLink)) {
					if ("CON01".equals(vo.getString("menuCntntsCd"))) {
						menuLink.append("/").append(vo.getString("siteId")).append("/main/contents.do?menuNo=").append(menuNo);
					}
					else if ("DWN01".equals(vo.getString("menuCntntsCd"))) {
						menuLink.setLength(0);
					}
				}

				else if (!"Y".equals(vo.getString("popupAt"))) { //팝업
					if (!"LNK01".equals(vo.getString("menuCntntsCd"))) {
						if (menuLink.indexOf("menuNo=") == -1 && menuLink.indexOf("javascript:") == -1) {
							if (menuLink.indexOf("?") != -1) {
								menuLink.append("&amp;menuNo=").append(menuNo);
							}
							else {
								menuLink.append("?menuNo=").append(menuNo);
							}
						}
					}
				}
				else {
					if (!"LNK01".equals(vo.getString("menuCntntsCd"))) {
						if (menuLink.indexOf("menuNo=") == -1 && menuLink.indexOf("javascript:") == -1) {
							if (menuLink.indexOf("?") != -1) {
								menuLink.append("&amp;menuNo=").append(menuNo);
							}
							else {
								menuLink.append("?menuNo=").append(menuNo);
							}
						}
					}
				}

				vo.put("allMenuCours", menuLink.toString());
				vo.put("menuLc", menuLc);
				vo.put("depth", depth);

				int index = 0;
				for (ZValue tmpvo :  menuCategories) {
					if (vo.getString("menuNo") == tmpvo.getString("menuNo")) {
						if (index > 0 && index < menuCategories.size()) {
							vo.put("preMenuNo", menuCategories.get(index-1).getString("menuNo"));
							vo.put("preMenuLink", menuCategories.get(index-1).getString("allMenuCours"));
						}
						if (index >= 0 && index < menuCategories.size()-1) {
							vo.put("nextMenuNo", menuCategories.get(index+1).getString("menuNo"));
							vo.put("nextMenuLink", menuCategories.get(index+1).getString("allMenuCours"));
						}
						break;
					}
					index++;
				}
				setMenuCategory(menuCategoryMap, PREFIX+menuNo, depth, pos, gubun);
			}
		}
		return menuCategoryMap;
	}

	public HashMap<String, List<ZValue>> setNullLinkMenuCategory(HashMap<String, List<ZValue>> menuCategoryMap, String parentId, int depth) {
		List<ZValue> menuCategories = menuCategoryMap.get(parentId);
		if (menuCategories != null && menuCategories.size() > 0) {
			depth++;
			for (int i=0; i<menuCategories.size(); i++) {
				ZValue vo = menuCategories.get(i);
				if(depth > 6) {
					//log.debug("6뎁스이상은 허용하지않습니다. [menuNo," + vo.getString("menuNo") + "]");
				}
				int menuNo = vo.getInt("menuNo");

				String allMenuCours = vo.getString("allMenuCours");

				if (!StringUtils.hasText(allMenuCours)) {
					if ("DWN01".equals(vo.getString("menuCntntsCd"))) {
						//log.debug(" ================ menuNo : " + menuNo + " ================ >" + allMenuCours);
						ZValue subVO = getDownNodeMenuCours(menuCategoryMap,PREFIX+vo.getString("menuNo"));
						if (subVO != null) {
							vo.put("allMenuCours", subVO.getString("allMenuCours"));
							//log.debug(" ================ subVO : " + subVO.getString("menuNo") + " ================ >" + subVO.getString("allMenuCours"));
						}
						else {
							vo.put("allMenuCours","/"+vo.getString("siteId")+"/singl/contents/ready.do?menuNo=" + menuNo); //default준비중
						}
					}
				}
				setNullLinkMenuCategory(menuCategoryMap, PREFIX+menuNo, depth);
			}
		}

		return menuCategoryMap;
	}


	private ZValue getDownNodeMenuCours(HashMap<String, List<ZValue>> menuCategoryMap, String menuNo) {
		ZValue vo = null;
		List<ZValue> subMenuCtgry = menuCategoryMap.get(menuNo);
		if (subMenuCtgry != null) {
			ZValue subVO = subMenuCtgry.get(0);
			if ("Y".equals(subVO.getString("useAt"))) {
				if (!StringUtils.hasText(subVO.getString("allMenuCours"))) {
					vo = getDownNodeMenuCours(menuCategoryMap,PREFIX+subVO.getString("menuNo"));
				}
				else {
					vo = subVO;
				}
			}
		}
		return vo;
	}

	public void markLeafMenu(HashMap<String, List<ZValue>> menuCategoryMap, String key) {
		Collection<List<ZValue>> menuList = menuCategoryMap.values();
		Iterator<List<ZValue>> it = menuList.iterator();
		while (it.hasNext()) {
			List<ZValue> list = it.next();
			for(ZValue vo : list) {
				int menuNo = StrUtils.parseInt(StrUtils.replace(key, PREFIX, ""));
				if (menuNo == vo.getInt("menuNo")) {
					vo.put("leafNodeAt", "Y");
					return;
				}
			}
		}
	}

	private String getMenuLc(String[] pos, int depth)	{
		String menuLc = "";
		for(int i=0; i<depth; i++) {
			menuLc += pos[i];
		}
		for(int i=depth; i<6; i++) {
			menuLc += "01";
		}
		return menuLc;
	}

	public ZValue getCurrentMenuVO(HashMap<String, List<ZValue>> menuCategoryMap, String menuLc) {
		return getCurrentMenuVO(menuCategoryMap, menuLc, new ZValue(), 0, 0);
	}

	public ZValue getCurrentMenuVO(HashMap<String, List<ZValue>> menuCategoryMap, String menuLc, ZValue savedMenuVO, int menuNo, int depth)	{
		depth++;
		int depthIdx = 0;
		if(depth == 1) depthIdx = Integer.parseInt(menuLc.substring(0,2)) -1;
		else if(depth == 2) depthIdx = Integer.parseInt(menuLc.substring(2,4)) -1;
		else if(depth == 3) depthIdx = Integer.parseInt(menuLc.substring(4,6)) -1;
		else if(depth == 4) depthIdx = Integer.parseInt(menuLc.substring(6,8)) -1;
		else if(depth == 5) depthIdx = Integer.parseInt(menuLc.substring(8,10)) -1;
		else if(depth == 6) depthIdx = Integer.parseInt(menuLc.substring(10,12)) -1;

		List<ZValue> menuCategories = menuCategoryMap.get(PREFIX+menuNo);
		if (menuCategories != null) {
			ZValue curMenuVO = menuCategories.get(depthIdx);
			String path = savedMenuVO.getString("path");
			String menuNoPath = savedMenuVO.getString("menuNoPath");
			if (depth == 1) {
				savedMenuVO.put("topMenuNo", curMenuVO.getString("MenuNo"));
				path = curMenuVO.getString("menuNm");
				menuNoPath = curMenuVO.getString("menuNo")+"";
			}
			else {
				path += "|" + curMenuVO.getString("menuNm");
				menuNoPath += "|" + curMenuVO.getString("menuNo");
			}
			savedMenuVO.put("path", path);
			savedMenuVO.put("menuNoPath", menuNoPath);
			getCurrentMenuVO(menuCategoryMap, menuLc, savedMenuVO, curMenuVO.getInt("menuNo"), depth);
		}
		return savedMenuVO;
	}

	public void modifyRearrangeMenu(HashMap<String, List<ZValue>> menuMap) throws Exception {
		Iterator<String> it = menuMap.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			List<ZValue> list = menuMap.get(key);
			for (ZValue vo : list) {
				sqlDao.modify("modifyRearrangeMenu", vo);
			}
		}
	}

	public HashMap<String, List<ZValue>> getTopMenuMap(List<ZValue> menuStructure) throws Exception {

		HashMap<String, List<ZValue>> menuStructureMap = new HashMap<String, List<ZValue>>();
		ArrayList<ZValue> topLinkList = null;
		for (ZValue vo : menuStructure) {
			String siteId = vo.getString("siteId");
			List<ZValue> topObj = menuStructureMap.get(CONTEXT_SCOPE_TOPMENU_PREFIX + siteId);

			if (topObj == null) {
				topLinkList = new ArrayList<ZValue>();
				/* 상단 로그인, 회원가입 사이트맵 고정메뉴 메뉴번호 지정 */
				if ("/ucms/member/user/forLogin.do".equals(vo.getString("menuLink")) && vo.getString("menuNm").indexOf("로그인")>-1) {
					topLinkList.add(vo);
				}
				if ("/ucms/member/user/joinAgre.do".equals(vo.getString("menuLink")) && vo.getString("menuNm").indexOf("회원가입")>-1) {
					topLinkList.add(vo);
							}
				if ("/ucms/singl/siteMap/list.do".equals(vo.getString("menuLink")) && vo.getString("menuNm").indexOf("사이트맵")>-1) {
					topLinkList.add(vo);
				}
				menuStructureMap.put(CONTEXT_SCOPE_TOPMENU_PREFIX + siteId, topLinkList);
			} else {
				/* 상단 로그인, 회원가입 사이트맵 고정메뉴 메뉴번호 지정 */
				if ("/ucms/member/user/forLogin.do".equals(vo.getString("menuLink")) && vo.getString("menuNm").indexOf("로그인")>-1) {
					topObj.add(vo);
				}
				if ("/ucms/member/user/joinAgre.do".equals(vo.getString("menuLink")) && vo.getString("menuNm").indexOf("회원가입")>-1) {
					topObj.add(vo);
							}
				if ("/ucms/singl/siteMap/list.do".equals(vo.getString("menuLink")) && vo.getString("menuNm").indexOf("사이트맵")>-1) {
					topObj.add(vo);
				}
			}
		}
		return menuStructureMap;
	}

	/**
	 * 화면노출여부 팝업
	 * @param paramCtx
	 * @throws Exception
	 */
	public void scrinExpsrAtPop(ParameterContext paramCtx) throws Exception {
	}

	/**
	 * 화면노출여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateScrinExpsrAt(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("sMenuNo", param.getString("sMenuNo"));
		param.put("scrinExpsrAt", param.getString("scrinExpsrAt"));
		sqlDao.modify("modifyScrinExpsrAt", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 일괄적용 되었습니다.");
	}

}
