package site.unp.cms.service.pips.impl;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.rte.fdl.string.EgovDateUtil;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.pips.UserInfoPrtcService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.CommonServiceLinks;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.ExcelGenerateVO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
		pageQueryData	= "menuNo,searchCnd,searchKwd,sdate,edate,pageUnit",
		listenerAndMethods={
				"userInfoPrtcListener=downloadExcel"
			}
)
@Service
public class UserInfoPrtcServiceImpl extends DefaultCrudServiceImpl implements UserInfoPrtcService{

	protected Logger log = LoggerFactory.getLogger(this.getClass());

	@CommonServiceLinks({
		@CommonServiceLink(desc="개인 정보 열람 이력", linkType=LinkType.BOS, paramString="")
	})
	public void list(ParameterContext paramCtx) throws Exception {
		ModelMap map = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		String sdate, edate ="";

		if (param.getString("sdate").equals("") || param.getString("edate").equals("")){
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.DATE, -7); //1일 더하기
			SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd");
			sdate = fmt.format(new java.util.Date(cal.getTime().getTime()));
			edate = new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		} else {
			sdate = param.getString("sdate");
			edate = param.getString("edate");
		}
		param.put("sdate", sdate);
		param.put("edate", edate);

		super.list(paramCtx);
	}

	@UnpJsonView
	public void printRecord(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String resultCode = "fail";
		param.put("readngSe", "P"); //출력하기

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null) {
			param.put("userId", user.getUserId());
		}

		try {
			sqlDao.save("saveUserInfoPrtc", param);
			resultCode = "success";
		} catch (Exception e) {
			log.debug(e.toString());
		}

		model.addAttribute("resultCode", resultCode);
		model.addAttribute("mnno", param.getString("mnno"));
		model.addAttribute("userId", user.getUserId());
		model.addAttribute("printDt", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
	}

	@Override
	public void downloadExcel(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String[] titles = {"번호","화면명","성명","ID","URL","열람형태","열람목적구분","열람목적비고","열람자","열람자ID","열람일시","열람IP"};
		List<ZValue> excelList = sqlDao.findAll("findAllUserInfoPrtcListExcel", param);
		ExcelGenerateVO vo = new ExcelGenerateVO("개인정보 열람이력 목록_"+ EgovDateUtil.getCurrentDateAsString(), titles, excelList);

		model.addAttribute("excel", vo);
		param.put("readngSe", "D");
		param.put("readngPurpsSe", "엑셀다운로드");
	}
}