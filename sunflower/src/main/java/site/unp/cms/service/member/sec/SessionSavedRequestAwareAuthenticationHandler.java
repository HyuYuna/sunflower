package site.unp.cms.service.member.sec;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import site.unp.cms.domain.MemberVO;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.StrUtils;

public class SessionSavedRequestAwareAuthenticationHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	@Resource(name="globalsProperties")
	private GlobalsProperties globalsProperties;

	private ISqlDAO<EgovMap> sqlDao;

	@Resource(name = "SqlDAO")
	protected ISqlDAO<UsersVO> uSqlDao;

	public static final String TARGET_URL = "_targetUrl_";

	Logger log = LoggerFactory.getLogger(this.getClass());

	private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {

    	SavedRequest savedRequest = requestCache.getRequest(request, response);

		String protocol = "http";
		String domain = globalsProperties.getPropertyVal().getString("Globals.ucms.domain");
		String realMode = globalsProperties.isReal() ? "Y" : "N";

 		if ("Y".equals(realMode)) protocol = "https://";
 		else protocol = "http://";
 		domain = protocol + domain;

		try {
			HttpSession session = request.getSession();
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
			String targetUrl = (String)session.getAttribute(TARGET_URL);
			String targetUrl2 = savedRequest != null ?savedRequest.getRedirectUrl() : null;

			if (targetUrl2 != null) targetUrl = targetUrl2;

			/*String siteId = this.getDefaultTargetUrl().split("/")[1];
			String menuNo = "200053";

			Date nowDt = new Date();
			Date stplatAgreDt = user.getStplatAgreDt();
			Date passwortChangeDt = user.getPasswordChangeDt();
			String userPin = user.getUserPin();

			if ("ucms".equals(siteId)) {
				if (stplatAgreDt != null && stplatAgreDt.before(nowDt)) { // 3년마다 개인정보처리방침
					targetUrl = "/"+siteId+"/member/user/reAgre.do?menuNo="+menuNo;
					//if (SiteInfoService.GONGUMOBILE_SITE_ID.equals(siteId)) targetUrl = domain+"/"+SiteInfoService.GONGU_SITE_ID+"/member/user/reAgre.do?menuNo="+menuNo + "&mobileTp=Y";
				}
				if ((passwortChangeDt != null && passwortChangeDt.before(nowDt))) { // 6개월마다 비밀번호 변경
					session.setAttribute("userId",user.getUserId());
					targetUrl = "/"+siteId+"/member/user/pwdChangeConfirm.do?menuNo="+menuNo+"&mode=i";
					//if (SiteInfoService.GONGUMOBILE_SITE_ID.equals(siteId)) targetUrl = domain+"/"+SiteInfoService.GONGU_SITE_ID+"/member/user/pwdChangeConfirm.do?menuNo="+menuNo+"&mode=i&mobileTp=Y";
				}
			}*/

			uSqlDao.modify("updateUserMemberLastLoginDt", user); // 접속일시 등록
			//String userIp = request.getRemoteAddr() +"|"+ HttpUtil.getClientBrowser(request);
			session.setAttribute("userIp", HttpUtil.getUserIpBrowserCheck(request)); //Session Hijacking 방지 = ip 비교하기 위해 세션에 처리

	    	if (StringUtils.hasText(targetUrl)) {
	    		//targetUrl = StrUtils.replace(targetUrl, "https", "http");
	    		targetUrl = StrUtils.replace(targetUrl, "&amp;amp;", "&");
	    		targetUrl = StrUtils.replace(targetUrl, "&amp;", "&");
	    		session.removeAttribute(targetUrl);
	    		getRedirectStrategy().sendRedirect(request, response, targetUrl);
	    	}
	    	else {
	    		super.onAuthenticationSuccess(request, response, authentication);
	    	}
		} catch (Exception e) {
			e.printStackTrace();
		}

    }

	public ISqlDAO<EgovMap> getSqlDao() {
		return sqlDao;
	}
	public void setSqlDao(ISqlDAO<EgovMap> sqlDao) {
		this.sqlDao = sqlDao;
	}

}
