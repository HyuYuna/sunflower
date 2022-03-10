package site.unp.cms.service.member.impl;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.member.UwamMemberService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

@CommonServiceDefinition(
		pageQueryData="searchCnd,searchCnd1,searchCnd2,searchCnd3,searchCnd4,searchCnd5,searchWrd,sdate,edate,menuNo,orderName,orderBdate,siteSeCd,siteNmWrd",
		listenerAndMethods={
			"userInitParamListener=update",
			"siteSeCdListener=view,viewSite,forInsertSiteStep1,forUpdateSiteStep1,forInsertSiteStep2,forUpdateSiteStep2,forInsertSite,forUpdateSite",
			"siteAlarmCycleCdListener=view,viewSite,forInsertSiteStep1,forUpdateSiteStep1,forInsertSite,forUpdateSite"
		}
	)
@CommonServiceLink(desc="PUSH 회원정보 관리", linkType=LinkType.BOS)
@Service
public class UwamMemberServiceImpl extends DefaultCrudServiceImpl implements UwamMemberService{

	public void forLogin(ParameterContext paramCtx) throws Exception {

	}

	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		super.view(paramCtx);

		super.doList(paramCtx, "findAllUwamMemberSite", "countUwamMemberSite");
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		super.forUpdate(paramCtx);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		super.update(paramCtx);
	}

	/**
	 * 승인상태 업데이트 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateConfmState(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		sqlDao.modify("updateUwamMemberConfm", param);
		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 사이트 URL 관련정보 상세 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void viewSite(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue result = sqlDao.findOne("findOneUwamMemberSite", param);
		model.addAttribute(RESULT, result);
		List<ZValue> urlList = sqlDao.findAll("findAllUwamMemberSiteUrl", param);
		model.addAttribute("urlList", urlList);
	}

	/**
	 * 사이트 URL 관련정보 등록 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forInsertSiteStep1(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpSession session = paramCtx.getRequest().getSession();
		model.addAttribute("step1Param",session.getAttribute("step1Param"));


	}

	public void forInsertSiteStep2(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpSession session = paramCtx.getRequest().getSession();
		ZValue zvl = new ZValue();
		zvl.put("siteSn", param.getString("siteSn"));
		zvl.put("userSn", param.getString("userSn"));
		zvl.put("menuNo", param.getString("menuNo"));
		zvl.put("siteSeCd", param.getString("siteSeCd"));
		zvl.put("siteNm", param.getString("siteNm"));
		zvl.put("siteAlarmCycleCd", param.getString("siteAlarmCycleCd"));
		zvl.put("timeOutCycle", param.getString("timeOutCycle"));
		zvl.put("alarmStopDt", param.getString("alarmStopDt"));
		zvl.put("alarmStopDe", param.getString("alarmStopDe"));
		zvl.put("alarmStopTime", param.getString("alarmStopTime"));
		zvl.put("prevStep", param.getString("prevStep"));
		zvl.put("updtFlag", param.getString("updtFlag"));

		session.setAttribute("step1Param", zvl);
		model.addAttribute("step1Param", zvl);
	}

	public void forInsertSite(ParameterContext paramCtx) throws Exception {
	}
	
	/**
	 * 사이트 URL 관련정보 수정 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateSiteStep1(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue result = sqlDao.findOne("findOneUwamMemberSite", param);
		model.addAttribute(RESULT, result);
	}


	public void forUpdateSiteStep2(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpSession session = paramCtx.getRequest().getSession();
		ZValue zvl = new ZValue();
		zvl.put("siteSn", param.getString("siteSn"));
		zvl.put("userSn", param.getString("userSn"));
		zvl.put("menuNo", param.getString("menuNo"));
		zvl.put("siteSeCd", param.getString("siteSeCd"));
		zvl.put("siteNm", param.getString("siteNm"));
		zvl.put("siteAlarmCycleCd", param.getString("siteAlarmCycleCd"));
		zvl.put("timeOutCycle", param.getString("timeOutCycle"));
		zvl.put("alarmStopDt", param.getString("alarmStopDt"));
		zvl.put("alarmStopDe", param.getString("alarmStopDe"));
		zvl.put("alarmStopTime", param.getString("alarmStopTime"));
		zvl.put("prevStep", param.getString("prevStep"));
		zvl.put("updtFlag", param.getString("updtFlag"));

		session.setAttribute("step1Param", zvl);
		model.addAttribute("step1Param", zvl);
		List<ZValue> urlList = sqlDao.findAll("findAllUwamMemberSiteUrl", param);
		model.addAttribute("urlList", urlList);
	}

	public void forUpdateSite(ParameterContext paramCtx) throws Exception {
		this.viewSite(paramCtx);
	}

	/**
	 * 사이트 URL 관련정보 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void insertSite(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		// HttpSession session = paramCtx.getRequest().getSession();
		// param.putAll((ZValue)session.getAttribute("step1Param"));
		sqlDao.save("saveUwamMemberSite", param);

		List<String> siteUrlList = param.getList("siteUrl");
		for (String siteUrl : siteUrlList) {
			if (StringUtils.hasText(siteUrl)) {
				param.put("siteUrl", siteUrl);
				sqlDao.save("saveUwamMemberSiteUrl", param);
				sqlDao.save("saveUwamMemberSiteUrlLastState", param);
			}
		}

		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		// session.removeAttribute("step1Param");

	}

	/**
	 * 사이트 URL 관련정보 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateSite(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		sqlDao.modify("updateUwamMemberSite", param);

		List<String> siteUrlList = param.getList("siteUrl");
		List<String> urlSnList = param.getList("urlSn");
		int n= 0;
		for (String siteUrl : siteUrlList) {
			if (StringUtils.hasText(siteUrl)) {
				param.put("siteUrl", siteUrl);
				String urlSn = urlSnList.get(n);
				
				if ("".equals(urlSn)) {
					sqlDao.save("saveUwamMemberSiteUrl", param);
					sqlDao.save("saveUwamMemberSiteUrlLastState", param);
				} else {
					param.put("urlSn", urlSn);
					sqlDao.modify("updateUwamMemberSiteUrl", param);
				}
				n++;
			}
		}

		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		// HttpSession session = paramCtx.getRequest().getSession();
		// session.removeAttribute("step1Param");
	}


	/**
	 * 사이트 URL 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void deleteSiteUrl(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		sqlDao.modify("deleteUwamMemberSiteUrl", param);
		model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 사이트 경보 error log 목록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listErrLog(ParameterContext paramCtx) throws Exception {
		super.doList(paramCtx, "findAllUwamMemberSiteErrLog", "countUwamMemberSiteErrLog");
	}
}