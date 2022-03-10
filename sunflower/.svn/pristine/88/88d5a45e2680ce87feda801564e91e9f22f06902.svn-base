package site.unp.cms.service.member.sec;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;

public class UnpLogoutSuccessHandler implements LogoutSuccessHandler {

	private String siteId;
	private String defaultTargetUrl;

	@Override
	public void onLogoutSuccess(HttpServletRequest request,
			HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {

		if ("ucms".equals(siteId)) {
			String reAgreForwardTp =  request.getParameter("reLogin") == null ? "" : request.getParameter("reLogin");
			if ("Y".equals(reAgreForwardTp)) {
				response.sendRedirect("/"+siteId+ "/member/user/forLogin.do?menuNo=300019");
			}
			else {
				response.sendRedirect(defaultTargetUrl);
			}
		}
	}

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

	public void setDefaultTargetUrl(String defaultTargetUrl) {
		this.defaultTargetUrl = defaultTargetUrl;
	}



}
