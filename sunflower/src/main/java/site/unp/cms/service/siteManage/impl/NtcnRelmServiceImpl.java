package site.unp.cms.service.siteManage.impl;


import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.siteManage.NtcnRelmService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
		sqlDaoRef		= "ntcnRelmDAO",
		pageQueryData	= "siteId,menuNo,viewType,searchKwd,searchUseAt,pSiteId",
		countQueryId	= "countNtcnRelm",
		listQueryId		= "findAllNtcnRelm",
		viewQueryId		= "findNtcnRelmDetail",
		insertQueryId	= "saveNtcnRelm",
		updateQueryId	= "modifyNtcnRelm",
		deleteQueryId	= "deleteNtcnRelm"
		)
@Service
public class NtcnRelmServiceImpl extends DefaultCrudServiceImpl implements NtcnRelmService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@CommonServiceLinks({
		@CommonServiceLink(desc="알림영역 관리", linkType=LinkType.BOS, paramString="pSiteId=ucms")
	})
	public void list(ParameterContext paramCtx) throws Exception {
		//ZValue param = paramCtx.getParam();
		//param.put("searchSiteId", param.getString("searchSiteId"));
		super.list(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		super.forInsert(paramCtx);
		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoExclBos");
		model.addAttribute("siteList", siteList);
		model.addAttribute("sortOrdr", sqlDao.findOne("findNtcnRelmMaxSortOrdr", param));
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.forUpdate(paramCtx);
		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoExclBos");
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

	public void findAllMainList(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> findAllMainList = sqlDao.findAll("findAllMainList", param);
		model.addAttribute("popupMainList", findAllMainList);
	}

	/**
	 * 알림영역관리 노출순서 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateSortOrdr(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue value1 = sqlDao.findOne("findNtcnRelmDetail", param);
		param.put("sortOrdr", value1.getString("sortOrdr"));
		ZValue value2 = sqlDao.findOne("findNtcnRelmDetail", param);

		String result = SUCCESS;
		String msg = "정상적으로 변경되었습니다.";

		if (value2 != null && !(value1.equals(value2))) {
			param.put("sortOrdr", value2.getString("sortOrdr"));
			sqlDao.modify("modifyNtcnRelmSortOrdr", param);

			param.put("ntcnNo", value2.getString("ntcnNo"));
			param.put("sortOrdr", value1.getString("sortOrdr"));
			sqlDao.modify("modifyNtcnRelmSortOrdr", param);
		} else {
			String option = param.getString("option");
			if (option.equals("1") || option.equals("2")) {
				msg = "첫번째 순서 입니다.";
			} else { msg = "마지막 순서 입니다."; }
			result = FAIL;
		}
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, result);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, msg);
	}

	/**
	 * 알림영역관리 사용여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateUseAt(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.modify("modifyNtcnRelmUseAt", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 변경되었습니다.");
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.delete(paramCtx);
		MVUtils.goUrl(WebFactory.buildUrl("/bos/siteManage/ntcnRelm/list.do", param, "menuNo", "pSiteId"), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

	public void menuListPop(ParameterContext paramCtx) throws Exception {

	}
}
