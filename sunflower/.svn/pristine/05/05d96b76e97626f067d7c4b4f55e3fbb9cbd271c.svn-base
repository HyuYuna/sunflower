package site.unp.cms.service.member.sec;

import java.io.IOException;
import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;

import site.unp.cms.mail.AttachmentMessageSender;
import site.unp.cms.service.crypto.CryptoARIA;
import site.unp.cms.service.file.FileParser;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;

public class LoginHistoryAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler implements Serializable {

	private Logger log = LoggerFactory.getLogger(this.getClass());
	private static final long serialVersionUID = 6022675258353128287L;
	private ISqlDAO<ZValue> sqlDao;
	public static final String LOGIN_TRY_INFO_KEY = "LOGIN_TRY_INFO";

	@Value("${Globals.ucms.webRootPath}")
	private String webRootPath;

	@Resource(name = "siteInfoService")
	private SiteInfoService siteInfoService;

	@Resource(name = "messageSender")
	private AttachmentMessageSender messageSender;

	@Value("${Globals.ucms.domain}")
	private String domain;

	@Resource(name = "cryptoARIA")
	private CryptoARIA cryptoARIA;

	@Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
            AuthenticationException exception) throws IOException, ServletException {

        saveFailureHistory(request, null, "N");

		super.onAuthenticationFailure(request, response, exception);
	}

	public void saveFailureHistory(HttpServletRequest request, String userId, String sttusCd) {
		ZValue params = new ZValue();
    	try {
    		String userAgent = request.getHeader("User-Agent").toUpperCase();
    		String mobileAt = "";
    		if (userAgent.indexOf("MOBILE")>-1 || userAgent.indexOf("PHONE")>-1){
    			mobileAt="Y";
    		} else {
    			mobileAt="N";
    		}
    		
    		/*System.out.println(request);*/
    		
    		ZValue param = new ZValue();
			param.put("sttusCd", sttusCd);
			param.put("userIpad", request.getRemoteAddr());
			param.put("userId", userId);
			param.put("siteId", request.getAttribute("siteId"));
			param.put("mobileAt", mobileAt);

			/* 해외접속체크 forLogin.jsp 스크립트에서 체크*/
			param.put("ovseaIpAt", request.getAttribute("ovseaIpAt"));
			
			
			sqlDao.save("insertLoginHist", param);

			/* 모바일,업무외시간 체크 메일발송 start*/

			if(sttusCd.equals("Y")) {
				String workEndAt = "";
				String ovseaIpAt = param.getString("ovseaIpAt");
				ZValue siteVO = siteInfoService.getSiteBySiteName("bos");
				String strTime = siteVO.getString("workBgntm");
				String endTime = siteVO.getString("workEndtm");
				Date nowDayTime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
				SimpleDateFormat sdf2 = new SimpleDateFormat ( "yyyy년 MM월dd일 HH시mm분ss초");
				String nowDayTimeStr = sdf.format(nowDayTime);
				Date workStart = sdf.parse(strTime);
				Date workEnd = sdf.parse(endTime);
				Date nowDayTimeFormat = sdf.parse(nowDayTimeStr);
				String loginDt = sdf2.format(nowDayTime);

				if(workStart.getTime() > nowDayTimeFormat.getTime() || workEnd.getTime() < nowDayTimeFormat.getTime()){
					workEndAt ="Y";
				}else {
					workEndAt ="N";
				}
				param.put("workEndAt", workEndAt);
				param.put("loginDt", loginDt);

				if(mobileAt.equals("Y") || workEndAt.equals("Y") || ovseaIpAt.equals("Y")){
					sendEmail(param);
				}
			}

			/* 모바일,업무외시간 체크 메일발송 end */

		} catch (Exception e) {
			e.printStackTrace();
		}

    	ZValue lastFailedLoginInfo = getLastFailedLoginInfo(request,params);
        request.getSession().setAttribute(LOGIN_TRY_INFO_KEY, lastFailedLoginInfo);
	}

	private ZValue getLastFailedLoginInfo(HttpServletRequest request, ZValue params){
		int failCnt = 0;
    	try {
    		if ("".equals(params.getString("username",""))) params.put("username", request.getParameter("username"));
    		if ("".equals(params.getString("siteId",""))) params.put("siteId", request.getParameter("siteId"));
			ZValue param = new ZValue();
			param.put("userIpad", request.getRemoteAddr());
			param.put("firstIndex", 0);
			param.put("recordCountPerPage", 5);
			param.put("userId", params.getString("username"));
			param.put("siteId", params.getString("siteId"));
	    	List<ZValue> histories = sqlDao.findAll("listAllLoginHist", param);
	    	if( CollectionUtils.isNotEmpty(histories) ) {
		    	List<ZValue> failedHistories = new ArrayList<ZValue>();
		    	for(ZValue history : histories){
		    		if ("N".equals((String)history.get("sttusCd")) && "N".equals((String)history.get("loginTryAt"))){
		    			failCnt++;
		    			failedHistories.add(history);
		    		} else {
		    			failCnt = 0;
		    		}
		    	}

		    	ZValue lastLoginFailed = histories.get(0);
		    	lastLoginFailed.put("loginFailedCount", failCnt);
		    	return lastLoginFailed;
	    	}

		} catch (Exception e) {
			e.printStackTrace();
			log.error("db error");
		}
    	return null;
	}

	public boolean checkLoginHistory(HttpServletRequest request, ZValue param){
		//HttpSession session = request.getSession();
		//EgovMap lastLoginFailed = (EgovMap)session.getAttribute(LoginHistoryAuthenticationFailureHandler.LOGIN_TRY_INFO_KEY);
		ZValue lastLoginFailed = getLastFailedLoginInfo(request,param);
		/*if( lastLoginFailed == null ) {
			lastLoginFailed = getLastFailedLoginInfo(request);
            session.setAttribute(LOGIN_TRY_INFO_KEY, lastLoginFailed);
		}*/
		if( lastLoginFailed != null && (Integer)lastLoginFailed.get("loginFailedCount") >= 5 ) {
			if (SiteInfoService.BOS_SITE_ID.equals(param.getString("siteId"))) {

				String loginTryAt = (String)lastLoginFailed.get("loginTryAt");

				//if (!"Y".equals(loginTryAt)) return false; // 관리자는 비밀번호 5회 틀린후 30분이후 로그인 가능

				/*Date loginTryDate = (Date)lastLoginFailed.get("loginTryDate");
				Date date1 = new Date();
				Date date2 = DateUtils.addMinutes(date1, -30);
				if (loginTryDate.compareTo(date2) >= 0) {
					return false;
				}*/

				Date loginTryDate = (Date)lastLoginFailed.get("loginDt");
				Date date1 = new Date();
				Date date2 = DateUtils.addMinutes(date1, -30);
				if (loginTryDate.compareTo(date2) >= 0) {
					return false;
				}

			}
			else {
				return false;
			}
		}
		return true;
	}

	public void delLoginHistory(HttpServletRequest request) {
    	try {
			ZValue param = new ZValue();
			param.put("userId", request.getParameter("userId"));
			param.put("siteId", request.getParameter("siteId"));
			sqlDao.deleteOne("deleteLoginHist", param);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public ISqlDAO<ZValue> getSqlDao() {
		return sqlDao;
	}

	public void setSqlDao(ISqlDAO<ZValue> sqlDao) {
		this.sqlDao = sqlDao;
	}

	public void sendEmail(ZValue param) throws Exception {
		String userId = param.getString("userId");
		String mobileAt = param.getString("mobileAt");
		String userIpad = param.getString("userIpad");
		String workEndAt = param.getString("workEndAt");
		String ovseaIpAt = param.getString("ovseaIpAt");
		String loginDt = param.getString("loginDt");
		String loginSe = "";

		if(ovseaIpAt.equals("Y")) {
			loginSe = "해외 접속";
		}
		else if(mobileAt.equals("Y")) {
			loginSe = "모바일 접속";
		}
		else if(workEndAt.equals("Y")) {
			loginSe = "업무시간 외 접속";
		}

		String emailFormStr = FileParser.getFileToString(webRootPath +"/template/email/ucms/loginEmailForm.html"); //메일폼 서식불러오기
		ZValue siteVO = siteInfoService.getSiteBySiteName("ucms");
		String addres = siteVO.getString("adres1") + " " + siteVO.getString("adres2") + siteVO.getString("insttNm") + ", TEL : " + siteVO.getString("telno") + ", FAX : " + siteVO.getString("faxno");
		String cpyrht = siteVO.getString("cpyrhtCn");
		String siteNm = siteVO.getString("siteNm");
		String siteUrlad = siteVO.getString("siteUrlad");
		String subject = siteNm + ") "+loginSe+" 로그인 이력";

		List<ZValue> adminList = sqlDao.findAll("findAllMngrSuperList", param);
		if (adminList.size() > 0){
			for(ZValue zvl : adminList) {
				String userEmad = cryptoARIA.decryptData(zvl.getString("userEmad"));

				emailFormStr = emailFormStr.replace("@siteNm@", siteNm);
				emailFormStr = emailFormStr.replace("@domain@", domain);
				emailFormStr = emailFormStr.replace("@subject@", subject);
				emailFormStr = emailFormStr.replace("@addres@", addres);
				emailFormStr = emailFormStr.replace("@cpyrht@", cpyrht);
				emailFormStr = emailFormStr.replace("@loginDt@", loginDt);
				emailFormStr = emailFormStr.replace("@loginSe@", loginSe);
				emailFormStr = emailFormStr.replace("@userIpad@", userIpad);
				emailFormStr = emailFormStr.replace("@userId@", userId);
				emailFormStr = emailFormStr.replaceAll("@siteUrl@", siteUrlad);

				param.put("subject", subject);
				param.put("text", emailFormStr);
				param.put("to", userEmad);

				messageSender.sndngEmail(param);
			}
		}

	}

}
