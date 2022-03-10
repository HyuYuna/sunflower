package site.unp.cms.service.system.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.system.SmsService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
		sqlDaoRef="smsDAO",
		countQueryId="countSms",
		listQueryId="findAllSms",
		viewQueryId="findOneSms",
		updateQueryId="updateSms",
		pageQueryData="searchCnd,searchText,menuNo,viewType,pageUnit,srcCntrGbn,srcCntrCod"
	)
@CommonServiceLink(desc="sms", linkType=LinkType.BOS)
@Service
public class SmsServiceImpl extends DefaultCrudServiceImpl implements SmsService {
	
	@Override
	public void list(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("authorCd", user.getAuthorCd());
			param.put("smsGroupId", user.getCenterCode());
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
	
	public void form(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if(user != null){
			param.put("smsCenterCode", user.getCenterCode());
		}
		
		ZValue form = sqlDao.findOne("formSms", param);
		List<ZValue> senderList = sqlDao.findAll("getSmsSenderSelect", param);
		List<ZValue> smsList = sqlDao.findAll("getSmsListSelect", param);
		
		model.addAttribute("smsId", form.getString("codeName2"));
		model.addAttribute("smsKey", form.getString("codeSubcode"));
		model.addAttribute("smsGroupTitle", "해정시 문자발송 시스템");
		model.addAttribute("smsReturnUrl", "/bos/system/sms/list.do");
		model.addAttribute("smsList", smsList);
		model.addAttribute("senderList", senderList);
	}
	
	@UnpJsonView
	public void searchCodeList(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
//		System.out.println("targetDepthIdx="+param.getString("targetDepthIdx"));
		List<ZValue> titleList = sqlDao.findAll("searchCodeSelect", param);
		model.addAttribute("titleList", titleList);
	}
	
	@UnpJsonView
	public void smsDirectSuccess(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if(user != null){
			param.put("authorCd", user.getAuthorCd());
			param.put("smsGroupId", "sun_" + user.getCenterCode());
			param.put("smsUserId", user.getUserId());
			param.put("smsUserName", user.getUserNm());
		}
		
		param.put("rName", param.getString("rphone"));
		param.put("sendPhone", param.getString("sphone"));
		param.put("caseSeq", param.getString("case_seq"));
		param.put("sendResult", "success");
		
		String rPhoneX = param.getString("rphone").replace(" ", "");
		String[] rPhoneS = rPhoneX.split(",");
		
		for (int i = 0; i < rPhoneS.length; i++) {
			param.put("rPhones", rPhoneS[i]);
			sqlDao.save("smsDirectSuccessInsert", param);
		}
	}
}
