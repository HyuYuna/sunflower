package site.unp.cms.service.schdul.impl;


import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.file.EkrFileMngService;
import site.unp.cms.service.schdul.SchdulService;
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

@CommonServiceDefinition(
	pageQueryData="",
	sqlDaoRef="schdulDAO",
	listQueryId="findAllSchdul",
	countQueryId="countSchdul",
	viewQueryId="findOneSchdul",
	insertQueryId="saveSchdul",
	updateQueryId="modifySchdul",
	deleteQueryId="deleteSchdul",
	listenerAndMethods={
		"accessLogListener=insert,update,delete"
	}
)
@CommonServiceLink(desc="홈페이지 관리자 전체일정관리", linkType=LinkType.BOS)
@Service
public class SchdulServiceImpl extends DefaultCrudServiceImpl implements SchdulService {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Resource(name="ekrFileMngService")
	private EkrFileMngService ekrFileMngService;


	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2", user1.getUserPin());

    	param.put("loginId", user.getString("userId"));
    	param.put("centerCode", user.getString("centerCode"));

		super.list(paramCtx);
	}

	public void listSchdulYear(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		sqlDao.save("saveSchdul", param);

		param.put("uflRelNumber", param.getString("schdulSn"));
		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;

		MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.insert", null, Locale.getDefault()));
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();

		sqlDao.modify("modifySchdul", param);
		param.put("uflRelNumber", param.getString("cmFileUploadCode"));

		boolean flag = ekrFileMngService.uploadFile(paramCtx);
		if(!flag)
			return;

		MVUtils.setResultProperty(model, "success", messageSource.getMessage("success.common.update", null, Locale.getDefault()));

	}
	/*일정 삭제 관련 코드*/
	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		if(param.get("schdulSn")!=null){
			super.delete(paramCtx);

			param.put("uflRelNumber", param.getInt("schdulSn"));
			param.put("uflRelCode", "schdul");
			sqlDao.deleteOne("ekrFileDelete", param);
		}


	}
	/**
	 * 따로 관리하는 일정 조회
	 *
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void detailDate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2", user1.getUserPin());

    	param.put("loginId", user.getString("userId"));
    	param.put("centerCode", user.getString("centerCode"));

		/* 공통코드 하위목록 */
		List<ZValue> dateList = sqlDao.findAll("findSchdulDateList", param);
		model.addAttribute("dateList", dateList);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 따로 관리하는 연간 일정 조회
	 *
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void detailYearDate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2", user1.getUserPin());

    	param.put("loginId", user.getString("userId"));
    	param.put("centerCode", user.getString("centerCode"));

		/* 공통코드 하위목록 */
		List<ZValue> yearDateList = sqlDao.findAll("findSchdulYearList", param);
		model.addAttribute("yearDateList", yearDateList);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}



}
