package site.unp.cms.service.siteManage.impl;


import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.dao.siteManage.BannerDAO;
import site.unp.cms.service.siteManage.BannerService;
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
import site.unp.core.util.UnpCollectionUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
		sqlDaoRef		= "bannerDAO",
		pageQueryData	= "siteId,menuNo,viewType,searchKwd,searchUseAt,pSiteId",
		listQueryId		= "findAllBanner",
		countQueryId	= "countBanner",
		viewQueryId		= "findBannerDetail",
		insertQueryId	= "saveBanner",
		updateQueryId	= "modifyBanner",
		deleteQueryId	= "deleteBanner"
)
@Service
public class BannerServiceImpl extends DefaultCrudServiceImpl implements BannerService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	@CommonServiceLinks({
			@CommonServiceLink(desc="ucms 배너 관리", linkType=LinkType.BOS, paramString="pSiteId=ucms")
			/*@CommonServiceLink(desc="관리자 배너 관리", linkType=LinkType.BOS, paramString="pSiteId=bos")*/
	})
	public void list(ParameterContext paramCtx) throws Exception {
		//param.put("pSiteId", "ucms");
		super.list(paramCtx);
	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		super.forInsert(paramCtx);

		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoExclBos");
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		model.addAttribute("siteList", siteList);
		model.addAttribute("sortOrdr", sqlDao.findOne("findBannerMaxSortOrdr", param));
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		super.forUpdate(paramCtx);

		List<ZValue> siteList = sqlDao.findAll("findAllSiteInfoExclBos");
		ModelMap model = paramCtx.getModel();
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

		//int n = 1/0;
		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, messageSource.getMessage("success.common.update", null, Locale.getDefault()));
	}

	public List<ZValue> getBanner(ZValue param) throws Exception {
		List<ZValue> resultList = getSqlDao(BannerDAO.class).findPublishListByBannerSe(param);
		//List<ZValue> resultList = sqlDao.listDAO("BannerDAO_selectPublishList", param);
		Map<String, List<ZValue>> fileMap = listHandler.getFileMap(null, resultList);
		UnpCollectionUtils.setFirstFile(resultList, fileMap, "atchFileId");
		return resultList;
	}

	/**
	 * 배너관리 노출순서 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateSortOrdr(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue value1 = sqlDao.findOne("findBannerDetail", param);
		param.put("sortOrdr", value1.getString("sortOrdr"));
		ZValue value2 = sqlDao.findOne("findBannerDetail", param);

		String result = SUCCESS;
		String msg = "정상적으로 변경되었습니다.";

		if (value2 != null && !(value1.equals(value2))) {
			param.put("sortOrdr", value2.getString("sortOrdr"));
			sqlDao.modify("modifyBannerSortOrdr", param);

			param.put("bannerNo", value2.getString("bannerNo"));
			param.put("sortOrdr", value1.getString("sortOrdr"));
			sqlDao.modify("modifyBannerSortOrdr", param);
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
	 * 배너관리 사용여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateUseAt(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		param.put("expsrAt", param.getString("useAt"));
		sqlDao.modify("modifyBannerUseAt", param);

		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		model.addAttribute(ModelAndViewResolver.MSG_KEY, "정상적으로 변경되었습니다.");
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		super.delete(paramCtx);
		MVUtils.goUrl(WebFactory.buildUrl("/bos/siteManage/banner/list.do", param, "menuNo", "pSiteId"), "정상적으로 처리하였습니다.", paramCtx.getModel());
	}

}