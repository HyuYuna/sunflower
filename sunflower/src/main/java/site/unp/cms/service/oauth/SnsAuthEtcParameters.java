package site.unp.cms.service.oauth;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class SnsAuthEtcParameters {
	public static final String SNS_CALLBACK = "snsCallback";
	public static final String SNS_RETURN_URL = "snsRetUrl";
	public static final String SNS_SITE_ID = "snsSiteId";
	public static final String SNS_MENU_NO = "snsMenuNo";
	public static final String SNS_AUTH_TP = "snsAuthTp";
	public static final String SNS_MODE = "snsMode";

	public SnsAuthEtcParameters() {
	}

	public String get(String key, HttpServletRequest request) {
		HttpSession session = request.getSession();
		return  session.getAttribute(key) != null ? (String)session.getAttribute(key) : null;
	}

	public void set(String key, String value, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute(key, value);

	}

	public String getCallbackUrl(HttpServletRequest request) {
		return get(SNS_CALLBACK, request);
	}

	public void  setCallbackUrl(String callbackUrl, HttpServletRequest request) {
		set(SNS_CALLBACK,callbackUrl, request);
	}

	public String getRetUrl(HttpServletRequest request) {
		return get(SNS_RETURN_URL, request);
	}

	public void  setRetUrl(String returnUrl, HttpServletRequest request) {
		set(SNS_RETURN_URL,returnUrl, request);
	}

	public String getSiteId(HttpServletRequest request) {
		return get(SNS_SITE_ID, request);
	}

	public void  setSiteId(String siteId, HttpServletRequest request) {
		set(SNS_SITE_ID,siteId, request);
	}

	public String getMenuNo(HttpServletRequest request) {
		return get(SNS_MENU_NO, request);
	}

	public void  setMenuNo(String menuNo, HttpServletRequest request) {
		set(SNS_MENU_NO,menuNo, request);
	}

	public String getAuthTp(HttpServletRequest request) {
		return get(SNS_AUTH_TP, request);
	}

	public void  setAuthTp(String authTp, HttpServletRequest request) {
		set(SNS_AUTH_TP,authTp, request);
	}

	public String getMode(HttpServletRequest request) {
		return get(SNS_MODE, request);
	}

	public void  setMode(String mode, HttpServletRequest request) {
		set(SNS_MODE,mode, request);
	}


}
