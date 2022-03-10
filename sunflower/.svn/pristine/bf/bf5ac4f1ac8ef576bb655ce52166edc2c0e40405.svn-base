package site.unp.cms.service.siteManage.impl;


import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.dao.siteManage.PopupDAO;
import site.unp.cms.service.siteManage.PopupService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;
import site.unp.core.util.UnpCollectionUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
		sqlDaoRef		= "popupDAO",
		pageQueryData	= "siteId,menuNo,viewType,sdate,edate,searchUseAt,searchKwd,pSiteId",
		listQueryId		= "findAllPopup",
		countQueryId	= "countPopup",
		viewQueryId		= "findPopupDetail",
		insertQueryId	= "savePopup",
		updateQueryId	= "modifyPopup",
		deleteQueryId	= "deletePopup"
)
@Service
public class PopupServiceImpl extends DefaultCrudServiceImpl implements PopupService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@CommonServiceLink(desc="팝업 관리 프로그램", linkType=LinkType.BOS, paramString="pSiteId=bos")
	public void list(ParameterContext paramCtx) throws Exception {
		//ZValue param = paramCtx.getParam();
		//param.put("searchSiteId", param.getString("searchSiteId"));
		super.list(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.forInsert(paramCtx);
		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoBos");
		model.addAttribute("siteList", siteList);

	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.forUpdate(paramCtx);
		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoBos");
		model.addAttribute("siteList", siteList);

	}
	
	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		boolean flag = uploadFile(paramCtx);
		if (!flag) return;
		
		if (!param.getString("atchFileId","").equals("")){
			param.put("fileCn", param.getString("fileCn_imgFile_1"));
			fileMngService.updateFileCn(param);
		}


		ISqlDAO<ZValue> sqlDao = null;
		if (paramCtx.getSqlDAO() != null) sqlDao = paramCtx.getSqlDAO();
		else sqlDao = this.sqlDao;

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("updtId", user.getUserId());
			param.put("registId", user.getUserId());
		}
		sqlDao.modify(updateQueryId, param);
		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, messageSource.getMessage("success.common.update", null, Locale.getDefault()));
	}

	//사용자 팝업
	public void userPopup(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
    	List<ZValue> popupList = (List<ZValue>) getSqlDao(PopupDAO.class).findPopupBySiteIdSe(param.getString("siteId"));

		if( CollectionUtils.isNotEmpty(popupList) ){
			Map<String, List<ZValue>> fileMap = listHandler.getFileMap(null, popupList);
			model.addAttribute("fileMap", fileMap);

			String popupNo = param.getString("popupNo");
			for(ZValue pop : popupList){
				String rPopupNo = pop.getString("popupNo");
				if( popupNo.equals(rPopupNo) ){
					String atchFileId = pop.getString("atchFileId");
					List<ZValue> files = fileMap.get(atchFileId);
					if( CollectionUtils.isNotEmpty(files) ){
						pop.put("fileSn", files.get(0).getString("fileSn"));
						pop.put("fileCn", files.get(0).getString("fileCn"));
					}
					model.addAttribute("result", pop);
					return;
				}
			}
		}
	}

	//관리자 팝업
	public void bosPopup(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
//    	List<ZValue> popupList = (List<ZValue>) getSqlDao(PopupDAO.class).findPopupBySiteIdSe(param.getString("siteId"));
    	List<ZValue> popupList = sqlDao.findAll("findPopupBySiteIdSe",param);

		if( CollectionUtils.isNotEmpty(popupList) ){
			Map<String, List<ZValue>> fileMap = listHandler.getFileMap(null, popupList);
			UnpCollectionUtils.setFirstFile(popupList, fileMap, "atchFileId");

			String popupNo = param.getString("popupNo");
			for(ZValue pop : popupList){
				String rPopupNo = pop.getString("popupNo");
				if( popupNo.equals(rPopupNo) ){
					String atchFileId = pop.getString("atchFileId");
					List<ZValue> files = fileMap.get(atchFileId);
					if( CollectionUtils.isNotEmpty(files) ){
						pop.put("fileSn", files.get(0).getString("fileSn"));
						pop.put("fileCn", files.get(0).getString("fileCn"));
					}
					model.addAttribute("result", pop);
					return;
				}
			}
		}
	}

	/**
	 * 팝업관리 사용여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateUseAt(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.modify("modifyPopupUseAt", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 변경되었습니다.");
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.delete(paramCtx);
		MVUtils.goUrl(WebFactory.buildUrl("/bos/siteManage/popup/list.do", param, "menuNo", "pSiteId"), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	public void menuListPop(ParameterContext paramCtx) throws Exception {

	}
}