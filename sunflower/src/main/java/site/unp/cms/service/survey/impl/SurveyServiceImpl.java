package site.unp.cms.service.survey.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import com.ibm.icu.util.Calendar;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.survey.SurveyService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
		sqlDaoRef="surveyDAO",
		countQueryId="countSurvey",
		listQueryId="findAllSurvey",
		viewQueryId="findOneSurvey",
		updateQueryId="updateSurvey",
		pageQueryData="menuNo,viewType,pageUnit,srcCntrGbn,srcCntrCod,srcSvItem03"
	)

@Service
public class SurveyServiceImpl extends DefaultCrudServiceImpl implements SurveyService {

	@Override
	public void list(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("svCuser", user.getUserId());
			param.put("centerCode", user.getCenterCode());
			
			if(user.getAuthorCd().equals("BU") || user.getAuthorCd().equals("BA") || user.getAuthorCd().equals("BM")){
				param.put("isBranch", "true");
			}
		}
		
		Calendar cal = Calendar.getInstance();
		
		if(param.getString("srcSvItem03").length() == 0){
			param.put("srcSvItem03", cal.get(Calendar.YEAR));
		}
		
		if(param.getString("pageUnit").length() == 0){
			param.put("pageUnit", 20);
		}
		
		param.put("sCode","CM04");
		List<ZValue> codeList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList", codeList);
		
		param.put("sCode","CM05");
		if(param.getString("srcCntrGbn").length() != 0){
			param.put("gCode",param.getString("srcCntrGbn"));
		}
		List<ZValue> codeList2 = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList2", codeList2);
		
		super.list(paramCtx);
	}
	
	@CommonServiceLink(desc="센터 이용자 만족도 설문지", linkType=LinkType.BOS)
	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		super.forInsert(paramCtx);
	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("svCuser", user.getUserId());
			param.put("centerCode", user.getCenterCode());
		}
		
		if(!param.getString("svItem06").equals("Y")){
			param.put("svItem16", "0");
			param.put("svItem17", "0");
		}
		
		if(!param.getString("svItem07").equals("Y")){
			param.put("svItem18", "0");
			param.put("svItem19", "0");
		}
		
		if(!param.getString("svItem08").equals("Y")){
			param.put("svItem20", "0");
			param.put("svItem21", "0");
		}
		
		if(!param.getString("svItem10").equals("Y")){
			param.put("svItem22", "0");
			param.put("svItem23", "0");
		}
		
		super.insert(paramCtx);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		if(!param.getString("svItem06").equals("Y")){
			param.put("svItem16", "0");
			param.put("svItem17", "0");
		}
		
		if(!param.getString("svItem07").equals("Y")){
			param.put("svItem18", "0");
			param.put("svItem19", "0");
		}
		
		if(!param.getString("svItem08").equals("Y")){
			param.put("svItem20", "0");
			param.put("svItem21", "0");
		}
		
		if(!param.getString("svItem10").equals("Y")){
			param.put("svItem22", "0");
			param.put("svItem23", "0");
		}
		
		super.update(paramCtx);
	}
	
	@CommonServiceLink(desc="센터 이용자 만족도 통계", linkType=LinkType.BOS)
	@Override
	public void stats(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("svCuser", user.getUserId());
			param.put("centerCode", user.getCenterCode());
			
			if(user.getAuthorCd().equals("BU") || user.getAuthorCd().equals("BA") || user.getAuthorCd().equals("BM")){
				param.put("isBranch", "true");
			}
		}
		
		param.put("sCode","CM04");
		List<ZValue> codeList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList", codeList);
		
		param.put("sCode","CM05");
		if(param.getString("srcCntrGbn").length() != 0){
			param.put("gCode",param.getString("srcCntrGbn"));
		}
		List<ZValue> codeList2 = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("codeList2", codeList2);
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(cal.YEAR);

		if(param.getString("srcSvItem03").length() == 0){
			param.put("srcSvItem03", year);
		}
		
		ZValue stats = sqlDao.findOne("findSurveyStats", param);
		model.addAttribute("stats", stats);
		
		List<ZValue> statsTxt = sqlDao.findAll("findSurveyStatsText", param);
		model.addAttribute("text", statsTxt);
	}
	
	@Override
	public void statsCenter(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		Calendar cal = Calendar.getInstance();
		int year = cal.get(cal.YEAR);

		if(param.getString("srcSvItem03").length() == 0){
			param.put("srcSvItem03", year);
		}
		
		ZValue sum = sqlDao.findOne("surveyStatsCenterSum", param);
		model.addAttribute("sum", sum);
		
		List<ZValue> center = sqlDao.findAll("surveyStatsCenter", param);
		model.addAttribute("center", center);
	}
	
	public void statsPrint(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("srcCntrGbn", param.getString("thisGbn"));
		param.put("srcCntrCod", param.getString("thisCtr"));
		param.put("srcSvItem03", param.getString("thisYear"));
		
		ZValue stats = sqlDao.findOne("findSurveyStats", param);
		model.addAttribute("stats", stats);
		
		List<ZValue> statsTxt = sqlDao.findAll("findSurveyStatsText", param);
		model.addAttribute("text", statsTxt);
		
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("phSeq", sqlDao.count("getPhSeq", param)+1);
        param.put("userId", user.getUserId());
        param.put("userName",user.getUserNm());
        param.put("phGroupSeq", '0');
		
        param.put("phName", "센터 이용자 만족도 통계");
        param.put("phGroup", "S-1");
		
        sqlDao.save("savePrintHistory", param);
	}

	@UnpJsonView
	public void pageUnitChange(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		param.put("pageUnit", param.getString("pageUnit"));
	}
	
	@UnpJsonView
	public void searchCodeList(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
//		System.out.println("targetDepthIdx="+param.getString("targetDepthIdx"));
		List<ZValue> titleList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("titleList", titleList);
	}
}
