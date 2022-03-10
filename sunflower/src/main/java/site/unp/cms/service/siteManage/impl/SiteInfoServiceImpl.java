package site.unp.cms.service.siteManage.impl;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.dao.siteManage.SiteGuideMenuDAO;
import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.CommonService;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
	pageQueryData="pSiteId,menuNo,viewType",
	insertQueryId="saveSiteInfo",
	sqlDaoRef="siteInfoDAO",
	listenerAndMethods={
		"siteSkinCdListener=list,forInsert,forUpdate,view"
	}
)
@Service
public class SiteInfoServiceImpl extends DefaultCrudServiceImpl implements SiteInfoService{

	@Resource(name = "siteGuideMenuDAO")
	private SiteGuideMenuDAO siteGuideMenuDAO;

	public SiteInfoServiceImpl(){
	}

	@CommonServiceLink(desc="사이트 관리", linkType=LinkType.BOS) // 리스트에 노출시 사용
	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		List<ZValue> resultList = getSqlDao(SiteInfoDAO.class).getSiteList();
		paramCtx.getModel().addAttribute(RESULT_LIST, resultList);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("updtId", user.getUserId());
			param.put("registId", user.getUserId());
		}

		initPram(paramCtx);

		boolean flag = uploadFile(paramCtx);
		if (!flag) return;

		getSqlDao(SiteInfoDAO.class).saveSiteInfo(param);

		MVUtils.setResultProperty(model, SUCCESS, "정상처리 하였습니다.");
	}

	@Override
	@CommonServiceLink(desc="사이트 기본정보", linkType=LinkType.BOS, paramString="pSiteId=ucms&viewType=VIEW")
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		super.forUpdate(paramCtx);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("updtId", user.getUserId());
			param.put("registId", user.getUserId());
		}

		initPram(paramCtx);

		boolean flag = uploadFile(paramCtx);
		if (!flag) return;

		if (param.getString("atchFileId","").equals("")){
			//fileCn_imgFile_1
			param.put("fileCn", param.getString("fileCn_imgFile_1"));
			fileMngService.updateFileCn(param);
		}

		getSqlDao(SiteInfoDAO.class).modifySiteInfo(param);

		if (param.getString("viewType").equals("VIEW")){
			String goUrl = "forUpdate.do?pSiteId="+param.getString("pSiteId")+"&viewType="+param.getString("viewType")+"&menuNo="+param.getString("menuNo");
			MVUtils.goUrl(goUrl, "정상처리 하였습니다.", model);
		} else {
			MVUtils.setResultProperty(model, SUCCESS, "정상처리 하였습니다.");
		}
	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		//ZValue param = paramCtx.getParam();
		//ModelMap model = paramCtx.getModel();

		super.view(paramCtx);

/*		List<ZValue> guideMenuList = getSqlDao(SiteInfoDAO.class).getSiteGuideMenuBySiteId(param);
		model.put("guideMenuList", guideMenuList);*/
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		getSqlDao(SiteInfoDAO.class).deleteBySiteId(param.getString("pSiteId"));

/*		// 상/하단 가이드메뉴 삭제
		getSqlDao(SiteInfoDAO.class).deleteSiteGuideMenuBySiteId(param);*/

		MVUtils.setResultProperty(model, SUCCESS, "정상처리 하였습니다.");
	}

	//사이트ID 중복확인 함수
	@UnpJsonView
	public void cnfirmSiteId(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		long resultCnt = sqlDao.count("countSiteId", param);
		model.addAttribute("resultCnt", resultCnt);

	}

	//사이트 상세정보
	public ZValue getSiteBySiteName(String siteId) throws Exception{
		ZValue result = getSqlDao(SiteInfoDAO.class).getSiteBySiteName(siteId);

		// 해당 사이트의 가이드 메뉴 가져오기
		result.putObject("guideMenuList01", getSiteGuideMenuListBySiteId(siteId,"01"));
		result.putObject("guideMenuList02", getSiteGuideMenuListBySiteId(siteId,"02"));

		return result;
	}

	public List<ZValue> getSiteGuideMenuListBySiteId(String siteId, String seCd) throws Exception{
		List<ZValue> allList = siteGuideMenuDAO.getSiteGuideMenuList();
		List<ZValue> resultList = new ArrayList<ZValue>();
		if( CollectionUtils.isNotEmpty(allList) ){
			for(ZValue val : allList){
				if( val.getString("siteId").equals(siteId) && val.getString("menuSeCd").equals(seCd)){
					resultList.add(val);
				}
			}
		}
		return resultList;
	}

	@UnpJsonView
	public void useYnChange(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		getSqlDao(SiteInfoDAO.class).modifyUseYnChange(param);

		MVUtils.setResultProperty(model, CommonService.SUCCESS, "정상처리하였습니다.");
	}

	/**
	 * 상단 가이드메뉴 관리
	 * @param paramCtx
	 * @throws Exception
	 */
	@CommonServiceLink(desc="상단 가이드메뉴 프로그램", linkType=LinkType.BOS, paramString="viewType=VIEW")
	public void upendList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("pSiteId", param.getString("pSiteId", "ucms")); //ucms GS 인증시 기본 사이트를 ucms로 세팅
		param.put("menuSeCd", "01");
		//param.put("pSiteId", param.getString("pSiteId", "portal"));
		model.put("resultList", sqlDao.findAll("findSiteGuideMenuBySiteId", param));

		model.addAttribute("includePage", "/bos/siteManage/siteInfo/listSiteGuideMenu.jsp");
	}

	/**
	 * 하단 가이드메뉴 관리
	 * @param paramCtx
	 * @throws Exception
	 */
	@CommonServiceLink(desc="하단 가이드메뉴 프로그램", linkType=LinkType.BOS, paramString="viewType=VIEW")
	public void lptList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("pSiteId", param.getString("pSiteId", "ucms"));	//ucms GS 인증시 기본 사이트를 ucms로 세팅
		param.put("menuSeCd", "02");
		//param.put("pSiteId", param.getString("pSiteId", "portal"));
		model.put("resultList", sqlDao.findAll("findSiteGuideMenuBySiteId", param));

		model.addAttribute("includePage", "/bos/siteManage/siteInfo/listSiteGuideMenu.jsp");
	}

	/**
	 * 상하단 가이드메뉴 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateSiteGuideMenu(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("updtId", user.getUserId());
			param.put("registId", user.getUserId());
		}

		// 상/하단 가이드메뉴 삭제 - 캐쉬 처리위해 호출함 (캐쉬처리 안되고있어서 바꿈)
		sqlDao.deleteOne("deleteSiteGuideMenuBySiteId", param);

		// 상/하단 가이드메뉴 등록
		ZValue tempParam = new ZValue();
		tempParam.put("pSiteId", param.getString("pSiteId"));
		tempParam.put("registId", param.getString("registId"));
		tempParam.put("updtId", param.getString("updtId"));
		tempParam.put("menuSeCd", param.getString("menuSeCd"));

		List<String> menuNmList = param.getList("menuNm");
		List<String> menuNoList = param.getList("pMenuNo");
		List<String> menuLinkList = param.getList("menuLink");
		//List<String> menuOrdrList = param.getList("menuOrdr");
		List<String> popupAtList = param.getList("popupAt");
		List<String> useAtList = param.getList("useAt");
		for (int i=0;i<menuNmList.size();i++) {
			if (!"".equals(menuNmList.get(i))){
				tempParam.put("menuNo", menuNoList.size()>i ? menuNoList.get(i) : "");
				tempParam.put("menuNm", menuNmList.get(i));
				tempParam.put("menuLink", menuLinkList.get(i));
				//tempParam.put("menuOrdr", menuOrdrList.get(i));
				tempParam.put("menuOrdr", i*10);
				tempParam.put("popupAt", popupAtList.get(i));
				tempParam.put("useAt", useAtList.get(i));
				//getSqlDao(SiteGuideMenuDAO.class).saveSiteGuideMenu(tempParam);
				sqlDao.save("saveSiteGuideMenu", tempParam);
			}
		}

		String method = "upendList";
		if ("02".equals(param.getString("menuSeCd"))) {
			method = "lptList";
		}


		String rtUrl = "/bos/siteManage/siteInfo/"+method+".do?pSiteId="+param.getString("pSiteId")+"&menuNo="+param.getString("menuNo")+"&viewType="+param.getString("viewType");
		MVUtils.goUrl(rtUrl, "정상적으로 처리 되었습니다.", model);
	}

	public void initPram(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		String workBgntm = param.getString("workBgntm1") + ":" + param.getString("workBgntm2");
		if (StringUtils.hasText(param.getString("workBgntm"))) workBgntm = param.getString("workBgntm");
		param.put("workBgntm", workBgntm);

		String workEndtm = param.getString("workEndtm1") + ":" + param.getString("workEndtm2");
		if (StringUtils.hasText(param.getString("workEndtm"))) workEndtm = param.getString("workEndtm");
		param.put("workEndtm", workEndtm);
	}
}