package site.unp.cms.service.oauth.impl;


import java.io.Serializable;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.social.ApiException;
import org.springframework.social.MissingAuthorizationException;
import org.springframework.social.connect.Connection;
import org.springframework.social.facebook.api.Facebook;
import org.springframework.social.facebook.api.User;
import org.springframework.social.facebook.api.UserOperations;
import org.springframework.social.facebook.api.impl.FacebookTemplate;
import org.springframework.social.facebook.connect.FacebookConnectionFactory;
import org.springframework.social.google.api.Google;
import org.springframework.social.google.api.impl.GoogleTemplate;
import org.springframework.social.google.api.plus.Person;
import org.springframework.social.google.api.plus.PlusOperations;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.kakao.api.Kakao;
import org.springframework.social.kakao.api.KakaoProfile;
import org.springframework.social.kakao.api.UserOperation;
import org.springframework.social.kakao.api.impl.KakaoTemplate;
import org.springframework.social.kakao.connect.KakaoConnectionFactory;
import org.springframework.social.line.api.v2.LineAPIService;
import org.springframework.social.naver.api.Naver;
import org.springframework.social.naver.api.NaverOAuth2ApiBinding;
import org.springframework.social.naver.api.abstracts.NaverUserOperation;
import org.springframework.social.naver.connect.NaverConnectionFactory;
import org.springframework.social.oauth1.AuthorizedRequestToken;
import org.springframework.social.oauth1.OAuth1Operations;
import org.springframework.social.oauth1.OAuth1Parameters;
import org.springframework.social.oauth1.OAuthToken;
import org.springframework.social.oauth2.AccessGrant;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.social.twitter.api.TwitterProfile;
import org.springframework.social.twitter.api.impl.TwitterTemplate;
import org.springframework.social.twitter.connect.TwitterConnectionFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.context.ServletContextAware;

import site.unp.cms.dao.member.MemberDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.member.sec.SessionSavedRequestAwareAuthenticationHandler;
import site.unp.cms.service.oauth.SnsAuthEtcParameters;
import site.unp.cms.service.oauth.SnsService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetails;
import site.unp.core.util.MVUtils;


@SuppressWarnings("serial")
@CommonServiceDefinition(
		listenerAndMethods={
			"userInitParamListener=snsOutput,snsPushOutput"
		}
)
@Service
public class SnsServiceImpl extends DefaultCrudServiceImpl implements ServletContextAware, Serializable, SnsService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="snsAuthEtcParameters")
	private SnsAuthEtcParameters snsAuthEtcParameters;

	@Resource(name="googleConnectionFactory")
	private GoogleConnectionFactory googleConnectionFactory;
	@Resource(name="googleOAuth2Parameters")
	private OAuth2Parameters googleOAuth2Parameters;

	@Resource(name="facebookConnectionFactory")
	private FacebookConnectionFactory facebookConnectionFactory;
	@Resource(name="facebookOAuth2Parameters")
	private OAuth2Parameters facebookOAuth2Parameters;

	@Resource(name="twitterConnectionFactory")
	private TwitterConnectionFactory twitterConnectionFactory;

	@Resource(name="kakaoConnectionFactory")
	private KakaoConnectionFactory kakaoConnectionFactory;
	@Resource(name="kakaoOAuth2Parameters")
	private OAuth2Parameters kakaoOAuth2Parameters;

	@Resource(name="naverConnectionFactory")
	private NaverConnectionFactory naverConnectionFactory;
	@Resource(name="naverOAuth2Parameters")
	private OAuth2Parameters naverOAuth2Parameters;

	@Resource(name="lineAPIService")
	private LineAPIService lineAPIService;

	@Resource(name="memberDAO")
	private MemberDAO memberDAO;

    @Value("#{prop['twitter.callbackUrl']}") private String twitterCallbackUrl;
    @Value("#{prop['Globals.ucms.siteSeCd']}") private String siteSeCd;

	/**
	 * ?????? ?????????
	 * @param paramCtx
	 */
	public void googleLogin(ParameterContext paramCtx) {
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		this.setParamSession(paramCtx);
		MVUtils.goUrl(url, null, paramCtx.getModel());
	}

	/**
	 * ?????? callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void googleCallback(ParameterContext paramCtx) throws Exception {
		HttpServletRequest request = paramCtx.getRequest();
		String siteId = snsAuthEtcParameters.getSiteId(request);
		String menuNo = snsAuthEtcParameters.getMenuNo(request);
		String authTp = snsAuthEtcParameters.getAuthTp(request);
		String retUrl = snsAuthEtcParameters.getRetUrl(request);
		String mode = snsAuthEtcParameters.getMode(request);

		String errUrl = this.errUrlVal(authTp,mode);

		try {

			OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
			AccessGrant accessGrant = oauthOperations.exchangeForAccess(paramCtx.getParam().getString("code"), googleOAuth2Parameters.getRedirectUri(), null);
			String accessToken = accessGrant.getAccessToken();
			Long expireTime = accessGrant.getExpireTime();
			if (expireTime != null && expireTime < System.currentTimeMillis()) {
				accessToken = accessGrant.getRefreshToken();
				//logger.info("accessToken is expired. refresh token = {}" , accessToken);
			}
			Connection<Google>connection = googleConnectionFactory.createConnection(accessGrant);
			Google google = connection == null ? new GoogleTemplate(accessToken) : connection.getApi();
			PlusOperations plusOperations = google.plusOperations();
			Person googleUser = plusOperations.getGoogleProfile();

			if(googleUser != null){

				ZValue val = new ZValue();
				val.put("accessToken", accessToken);
				val.put("snsId", PREFIX_GOOGLE + "_" + googleUser.getId());
				val.put("name", googleUser.getDisplayName());
				if(googleUser.getEmailAddresses() !=null){
					val.put("email", googleUser.getEmailAddresses().toString().replaceAll("[\\[\\]]", ""));
				}
				val.put("siteId", siteId);
				val.put("menuNo", menuNo);
				val.put("authTp", authTp);
				val.put("crtfcSeCd", LOGINTYPE_GOOGLE);
				val.put("prefix", PREFIX_GOOGLE);
				val.put("errBackUrl", errUrl);
				val.put("retUrl", retUrl);
				val.put("mode", mode);

				paramCtx.setParam(val);
				if ("PUSH".equals(mode)) {
					snsPushOutput(paramCtx);
				}
				else {
					snsOutput(paramCtx);
				}


			}else{
				this.snsFail(errUrl, "??????????????? ????????????. ????????? ?????? ???????????????.", paramCtx);
			}

		}catch(Exception e){

			this.snsFail(errUrl, "????????? ?????????????????????. ????????? ?????? ???????????????.", paramCtx);
		}
	}

	/**
	 * ???????????? ?????????
	 * @param paramCtx
	 */
	public void facebookLogin(ParameterContext paramCtx) {
		OAuth2Operations oauthOperations =  facebookConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, facebookOAuth2Parameters);
		this.setParamSession(paramCtx);
		MVUtils.goUrl(url, null, paramCtx.getModel());
	}

	/**
	 * ???????????? callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void facebookCallback(ParameterContext paramCtx) throws Exception {
		HttpServletRequest request = paramCtx.getRequest();
		String siteId = snsAuthEtcParameters.getSiteId(request);
		String menuNo = snsAuthEtcParameters.getMenuNo(request);
		String authTp = snsAuthEtcParameters.getAuthTp(request);
		String retUrl = snsAuthEtcParameters.getRetUrl(request);
		String mode = snsAuthEtcParameters.getMode(request);

		String errUrl = this.errUrlVal(authTp,mode);

		OAuth2Operations oauthOperations = facebookConnectionFactory.getOAuthOperations();
		AccessGrant accessGrant = oauthOperations.exchangeForAccess(paramCtx.getParam().getString("code"), facebookOAuth2Parameters.getRedirectUri(), null);
		String accessToken = accessGrant.getAccessToken();
		Long expireTime = accessGrant.getExpireTime();
		if (expireTime != null && expireTime < System.currentTimeMillis()) {
			accessToken = accessGrant.getRefreshToken();
			//logger.info("accessToken is expired. refresh token = {}" , accessToken);
		}
		Connection<Facebook>connection = facebookConnectionFactory.createConnection(accessGrant);
		Facebook facebook = connection == null ? new FacebookTemplate(accessToken) : connection.getApi();
		UserOperations userOperations = facebook.userOperations();
		User facebookUser = null;
		try {
			facebookUser = userOperations.getUserProfile();

			if(facebookUser != null){
				ZValue val = new ZValue();
				val.put("accessToken", accessToken);
				val.put("snsId", PREFIX_FACEBOOK + "_" +facebookUser.getId());
				val.put("name", facebookUser.getName());
				val.put("email", facebookUser.getEmail());
				if(facebookUser.getGender() != null && !"".equals(facebookUser.getGender())){
					if("male".equals(facebookUser.getGender())){
						val.put("sexCd", "M");
					}else{
						val.put("sexCd", "F");
					}
				}
				val.put("siteId", siteId);
				val.put("menuNo", menuNo);
				val.put("authTp", authTp);
				val.put("crtfcSeCd", LOGINTYPE_FACEBOOK);
				val.put("prefix", PREFIX_FACEBOOK);
				val.put("errBackUrl", errUrl);
				val.put("retUrl", retUrl);
				val.put("mode", mode);

				paramCtx.setParam(val);
				if ("PUSH".equals(mode)) {
					snsPushOutput(paramCtx);
				}
				else {
					snsOutput(paramCtx);
				}

			}else{
				this.snsFail(errUrl, "??????????????? ????????????. ????????? ?????? ???????????????.", paramCtx);
			}
		}
		catch (MissingAuthorizationException e) {
			e.printStackTrace();
			this.snsFail(errUrl, "????????? ?????? ????????? ??????????????? API???????????? ?????? ?????? ?????????????????????. ????????? ?????? ???????????????.", paramCtx);
		} catch (ApiException e) {
			e.printStackTrace();
			this.snsFail(errUrl, "????????? API??? ???????????? ?????? ????????? ?????????????????????. ????????? ?????? ???????????????.", paramCtx);
		}
	}

	/**
	 * ????????? ?????????
	 * @param paramCtx
	 */
	public void twitterLogin(ParameterContext paramCtx) {
		OAuth1Operations oauthOperations = twitterConnectionFactory.getOAuthOperations();
		OAuthToken requestToken = oauthOperations.fetchRequestToken(twitterCallbackUrl, null);
		HttpSession httpSession = paramCtx.getSession();
		httpSession.setAttribute("twitterRequestToken", requestToken);
		this.setParamSession(paramCtx);

		String authorizeUrl = oauthOperations.buildAuthorizeUrl(requestToken.getValue(), OAuth1Parameters.NONE);
		MVUtils.goUrl(authorizeUrl, null, paramCtx.getModel());
	}

	/**
	 * ????????? callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void twitterCallback(ParameterContext paramCtx) throws Exception{
		HttpServletRequest request = paramCtx.getRequest();
		String siteId = snsAuthEtcParameters.getSiteId(request);
		String menuNo = snsAuthEtcParameters.getMenuNo(request);
		String authTp = snsAuthEtcParameters.getAuthTp(request);
		String retUrl = snsAuthEtcParameters.getRetUrl(request);
		String mode = snsAuthEtcParameters.getMode(request);

		String errUrl = this.errUrlVal(authTp,mode);

		try{
			OAuth1Operations oauthOperations = twitterConnectionFactory.getOAuthOperations();
			OAuthToken requestToken = (OAuthToken)paramCtx.getSession().getAttribute("twitterRequestToken");
			OAuthToken accessToken = oauthOperations.exchangeForAccessToken(new AuthorizedRequestToken(requestToken, paramCtx.getParam().getString("oauth_verifier")), null);
			Connection<Twitter> connection = twitterConnectionFactory.createConnection(accessToken);
			Twitter twitter = connection != null ? connection.getApi() : new TwitterTemplate(accessToken.getValue());
			TwitterProfile twitterUser=twitter.userOperations().getUserProfile();

			if(twitterUser != null){

				ZValue val = new ZValue();
				val.put("accessToken", accessToken);
				val.put("snsId", PREFIX_TWITTER + "_" + twitterUser.getId());
				val.put("name", twitterUser.getName());
				val.put("siteId", siteId);
				val.put("menuNo", menuNo);
				val.put("authTp", authTp);
				val.put("crtfcSeCd", LOGINTYPE_TWITTER);
				val.put("prefix", PREFIX_TWITTER);
				val.put("errBackUrl", errUrl);
				val.put("retUrl", retUrl);
				val.put("mode", mode);

				paramCtx.setParam(val);
				if ("PUSH".equals(mode)) {
					snsPushOutput(paramCtx);
				}
				else {
					snsOutput(paramCtx);
				}

			}else{
				this.snsFail(errUrl, "??????????????? ????????????. ????????? ?????? ???????????????.", paramCtx);
			}
			//ConnectionKey connectionKey=connection.getKey();
		}catch(Exception e){
			e.printStackTrace();
			this.snsFail(errUrl, "????????? ?????????????????????. ????????? ?????? ???????????????.", paramCtx);
		}
	}

	/**
	 * ????????? ?????????
	 * @param paramCtx
	 */
	public void naverLogin(ParameterContext paramCtx) {
		OAuth2Operations oauthOperations = naverConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, naverOAuth2Parameters);
		this.setParamSession(paramCtx);
		MVUtils.goUrl(url, null, paramCtx.getModel());
	}

	/**
	 * ????????? callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void naverCallback(ParameterContext paramCtx) throws Exception {
		HttpServletRequest request = paramCtx.getRequest();
		String siteId = snsAuthEtcParameters.getSiteId(request);
		String menuNo = snsAuthEtcParameters.getMenuNo(request);
		String authTp = snsAuthEtcParameters.getAuthTp(request);
		String retUrl = snsAuthEtcParameters.getRetUrl(request);
		String mode = snsAuthEtcParameters.getMode(request);

		String errUrl = this.errUrlVal(authTp,mode);

		try{
			OAuth2Operations oauthOperations = naverConnectionFactory.getOAuthOperations();
			AccessGrant accessGrant = oauthOperations.exchangeForAccess(paramCtx.getParam().getString("code"), naverOAuth2Parameters.getRedirectUri(), null);
			String accessToken = accessGrant.getAccessToken();
			Connection<Naver> connection = naverConnectionFactory.createConnection(accessGrant);

			Naver naver = connection != null ? connection.getApi() : new NaverOAuth2ApiBinding(accessToken);
			NaverUserOperation naverUser = naver.userOperation();
			if(naverUser != null){

				ZValue val = new ZValue();
				val.put("accessToken", accessToken);
				val.put("snsId", PREFIX_NAVER + "_" + naverUser.getId());
				val.put("name", naverUser.getName());
				val.put("sexCd", naverUser.getGender());
				val.put("email", naverUser.getEmail());
				val.put("siteId", siteId);
				val.put("menuNo", menuNo);
				val.put("authTp", authTp);
				val.put("crtfcSeCd", LOGINTYPE_NAVER);
				val.put("prefix", PREFIX_NAVER);
				val.put("errBackUrl", errUrl);
				val.put("retUrl", retUrl);
				val.put("mode", mode);

				paramCtx.setParam(val);
				if ("PUSH".equals(mode)) {
					snsPushOutput(paramCtx);
				}
				else {
					snsOutput(paramCtx);
				}

			}else{
				this.snsFail(errUrl, "??????????????? ????????????. ????????? ?????? ???????????????.", paramCtx);
			}
		}catch(Exception e){
			e.printStackTrace();
			this.snsFail(errUrl, "????????? ?????????????????????. ????????? ?????? ???????????????.", paramCtx);
		}
	}

	/**
	 * ????????? ?????????
	 * @param paramCtx
	 */
	public void kakaoLogin(ParameterContext paramCtx) {
		OAuth2Operations oauthOperations = kakaoConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, kakaoOAuth2Parameters);
		this.setParamSession(paramCtx);
		MVUtils.goUrl(url, null, paramCtx.getModel());
	}

	/**
	 * ????????? callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void kakaoCallback(ParameterContext paramCtx) throws Exception {

		HttpServletRequest request = paramCtx.getRequest();
		String siteId = snsAuthEtcParameters.getSiteId(request);
		String menuNo = snsAuthEtcParameters.getMenuNo(request);
		String authTp = snsAuthEtcParameters.getAuthTp(request);
		String retUrl = snsAuthEtcParameters.getRetUrl(request);
		String mode = snsAuthEtcParameters.getMode(request);

		String errUrl = this.errUrlVal(authTp,mode);

		try{
			OAuth2Operations oauthOperations = kakaoConnectionFactory.getOAuthOperations();
			AccessGrant accessGrant = oauthOperations.exchangeForAccess(paramCtx.getParam().getString("code"), kakaoOAuth2Parameters.getRedirectUri(), null);
			String accessToken = accessGrant.getAccessToken();
			Long expireTime = accessGrant.getExpireTime();
			if (expireTime != null && expireTime < System.currentTimeMillis()) {
				accessToken = accessGrant.getRefreshToken();
				//logger.info("accessToken is expired. refresh token = {}" , accessToken);
			}
			Connection<Kakao>connection = kakaoConnectionFactory.createConnection(accessGrant);
			Kakao kakao = connection == null ? new KakaoTemplate(accessToken) : connection.getApi();
			UserOperation userOperation = kakao.userOperation();
			KakaoProfile kakaoUser = userOperation.getUserProfile();

			if(kakaoUser != null){

				ZValue val = new ZValue();
				val.put("accessToken", accessToken);
				val.put("snsId", PREFIX_KAKAO + "_" + kakaoUser.getId());
				val.put("name", kakaoUser.getProperties().getNickname());
				val.put("email", kakaoUser.getExtraData().get("kaccount_email"));
				val.put("siteId", siteId);
				val.put("menuNo", menuNo);
				val.put("authTp", authTp);
				val.put("crtfcSeCd", LOGINTYPE_KAKAO);
				val.put("prefix", PREFIX_KAKAO);
				val.put("errBackUrl", errUrl);
				val.put("retUrl", retUrl);
				val.put("mode", mode);

				paramCtx.setParam(val);
				if ("PUSH".equals(mode)) {
					snsPushOutput(paramCtx);
				}
				else {
					snsOutput(paramCtx);
				}

			}else{
				this.snsFail(errUrl, "??????????????? ????????????. ????????? ?????? ???????????????.", paramCtx);
			}
		}catch(Exception e){
			e.printStackTrace();
			this.snsFail(errUrl, "????????? ?????????????????????. ????????? ?????? ???????????????.", paramCtx);
		}
	}

	/**
	 * ?????? ??? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void snsPushOutput(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		HttpServletRequest request= paramCtx.getRequest();
		HttpSession session = request.getSession();

		MemberVO memberVO = new MemberVO();
		String siteId = param.getString("siteId");
    	String prefix = param.getString("prefix");
    	String snsId = param.getString("snsId");
    	String name = param.getString("name");
    	String email = param.getString("email");
    	String authTp = param.getString("authTp");
    	String errBackUrl = param.getString("errBackUrl");

    	String appDeviceId = snsAuthEtcParameters.get("snsAppDeviceId", request);
    	String appToken = snsAuthEtcParameters.get("snsAppToken", request);
    	String appOs = snsAuthEtcParameters.get("snsAppOs", request);
    	String appVersion = snsAuthEtcParameters.get("snsAppVersion", request);
    	String appModel = snsAuthEtcParameters.get("snsAppModel", request);

    	param.put("appDeviceId", appDeviceId);
    	param.put("appToken", appToken);
    	param.put("appOs", appOs);
    	param.put("appVersion", appVersion);
    	param.put("appModel", appModel);

    	ZValue pushUserResult = null;

		SavedRequest savedRequest = (SavedRequest)session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");
		String url= (String) session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
		String retUrl = URLDecoder.decode(param.getString("retUrl",""),"UTF-8");
    	retUrl = retUrl.replaceAll("&amp;", "&");

    	String goUrl = "";
    	boolean authBoolean = false;
    	boolean memberBoolean = false;

    	if (StringUtils.hasText(snsId)) authBoolean = true;

    	if (name==null || name.equals("")) {
    		log.error(prefix+"????????? ????????? ????????????. ??????????????? ??????????????????.");
			this.snsFail(errBackUrl, prefix+"????????? ????????? ????????????. ??????????????? ??????????????????.", paramCtx);
			return;
		}

    	if (StringUtils.hasText(snsId)) memberVO.setUserPin(snsId);
    	String authorCd = "ROLE_PUSHKEY";
    	memberVO.setUserNm(param.getString("name"));
    	memberVO.setUserEmad(email);
    	memberVO.setAuthorCd(authorCd);

    	if (authBoolean) {

    		if (StringUtils.hasText(memberVO.getUserPin())) {

    			pushUserResult = sqlDao.findOne("findOneUwamMember", param);

    			goUrl = "".equals(retUrl) ? "/" : retUrl;

    			if (pushUserResult != null) {
    				memberBoolean = true;
    			}
    			else {
    				//goUrl = savedRequest == null  ? gon : savedRequest.getRedirectUrl();
    				memberBoolean = false;
    			}

    			// ???????????? ????????????
    			if (memberBoolean) {
    				//????????????
    				memberVO.setUserSn(pushUserResult.getLong("userSn"));
    				if(pushUserResult != null) memberVO.setUserId(pushUserResult.getString("userId"));
    				sqlDao.modify("updateUwamMemberAppInfo", param);
    				setPushAuthentication(memberVO, request);
	    			MVUtils.goUrl(goUrl, "????????? ?????????????????????.", model);
    			}
    			else {
    				//????????? ????????????

    				sqlDao.save("saveUwamMember", param);
    				memberVO.setUserSn(param.getLong("userSn"));
    				memberVO.setUserId(param.getString("userId"));

    				setPushAuthentication(memberVO, request);
	    			MVUtils.goUrl(goUrl, "????????? ?????????????????????.", model);

    			}
    		}
    	}
    	else {
    		this.snsFail(errBackUrl, "????????? ?????????????????????. ??????????????? ???????????????.", paramCtx);
    	}

	}

	/**
	 * ???????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void snsOutput(ParameterContext paramCtx) throws Exception {

		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		HttpServletRequest request= paramCtx.getRequest();
		HttpSession session = request.getSession();

		MemberVO memberVO = new MemberVO();
    	String siteId = param.getString("siteId");
    	String prefix = param.getString("prefix");
    	String snsId = param.getString("snsId");
    	String sexCd = param.getString("sexCd");
    	String crtfcSeCd = param.getString("crtfcSeCd");
    	String name = param.getString("name");
    	String email = param.getString("email");
    	String authTp = param.getString("authTp");
    	String errBackUrl = param.getString("errBackUrl");
    	String goUrl = "";
    	long userPinCnt = 0;
    	ZValue userPinResult = null;

    	SavedRequest savedRequest = (SavedRequest)session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");

    	String url= (String) session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
    	if (StringUtils.hasText(url)) {
			if (url.indexOf("/join") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
			if (url.indexOf("/forLogin") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
		}

    	//String retUrl = "".equals(param.getString("retUrl")) ? "/"+siteId+"/member/user/joinInput.do?menuNo="+param.getString("menuNo") : URLDecoder.decode(param.getString("retUrl"),"UTF-8");
    	String retUrl = URLDecoder.decode(param.getString("retUrl",""),"UTF-8");
    	retUrl = retUrl.replaceAll("&amp;", "&");

    	boolean authBoolean = false;
    	boolean memberBoolean = false;
    	if (StringUtils.hasText(snsId)) authBoolean = true;

    	if (name==null || name.equals("")){
    		log.error(prefix+"????????? ????????? ????????????. ??????????????? ??????????????????.");
			this.snsFail(errBackUrl, prefix+"????????? ????????? ????????????. ??????????????? ??????????????????.", paramCtx);
			return;
		}

    	if (StringUtils.hasText(snsId)) memberVO.setUserPin(prefix + "_" + snsId);
    	if (StringUtils.hasText(sexCd)) memberVO.setSexCd(sexCd);
    	String authorCd = "ROLE_VNAME";
    	memberVO.setUserNm(param.getString("name"));
		memberVO.setCrtfcSeCd(crtfcSeCd);
    	memberVO.setUserEmad(email);
    	memberVO.setChldCrtfcAt("N");	// 14??? ?????? ??????
    	memberVO.setAuthorCd(authorCd);

    	if (authBoolean) {

    		if (StringUtils.hasText(memberVO.getUserPin())) {

    			if("A".equals(authTp) || "I".equals(authTp) || "P".equals(authTp)){												// ????????????, ID??????, PASSWORD ?????? ??? ?????? ???????????? ??????
        			//userPinCnt = memberDAO.countUserMemberByUserPinId(memberVO.getUserPin());
    				userPinResult = memberDAO.findOneUserMemberByUserPinInfo(memberVO.getUserPin());
        		}


    			// ??????????????? ?????? sns?????? ??? ?????? ?????????????????? ????????? ??????????????? ????????? ????????? ??????.
    			if("A".equals(authTp)){																			// ????????????
    				goUrl = retUrl;
    				if (userPinResult != null) memberBoolean = false;
    				else memberBoolean = true;
    			}else if("I".equals(authTp)){																	// ID??????
    				goUrl = retUrl;
    				if (userPinResult == null) memberBoolean = false;
    				else memberBoolean = true;
    			}else if("P".equals(authTp)){																	// PASSWORD??????
    				goUrl = retUrl;
    				if (userPinResult == null) memberBoolean = false;
    				else memberBoolean = true;
    			}else{																							// ?????????
    				goUrl = savedRequest == null  ? "/": savedRequest.getRedirectUrl();
    				memberBoolean = true;
    			}

    			if(memberBoolean){

    				// userPin??? ????????????
    				ZValue memberZvl = memberDAO.findOneUserMemberByUserPin(memberVO.getUserPin());

        			// userPin?????? ????????? TM_USER_PIN ???????????? ??????
        			if (memberZvl == null) {

        				ZValue userVO = new ZValue();
        				userVO.put("userNm", memberVO.getUserNm());
        				userVO.put("brthdy", memberVO.getBrthdy());
        				userVO.put("sexCd", memberVO.getSexCd());
        				userVO.put("userPin",memberVO.getUserPin());
        				userVO.put("crtfcSeCd", memberVO.getCrtfcSeCd());
        				userVO.put("chldCrtfcAt", memberVO.getChldCrtfcAt());
        				userVO.put("siteSeCd", siteSeCd);

        				sqlDao.save("saveUserMemberUserPin", userVO);
        				Object userKey = userVO.getString("userSn");
        				memberVO.setUserSn(Long.parseLong(userKey.toString()));

        			}else{
        				memberVO.setUserSn(memberZvl.getLong("userSn"));
        				if(userPinResult != null) memberVO.setUserId(userPinResult.getString("userId"));
        			}

        			setAuthentication(memberVO, request);
        			MVUtils.goUrl(goUrl, "????????? ?????????????????????.", model);
    			}else{

    				if("I".equals(authTp) || "P".equals(authTp)){
    					MVUtils.goUrl(errBackUrl, "???????????? ????????? ????????????. ????????? ?????? ??????????????? ????????????.", model);
    					return;
    				}else{
    					MVUtils.goUrl(errBackUrl, "?????? ????????? ???????????????. ????????? ?????? ??????????????? ????????????.", model);
    					return;
    				}

    			}
			}
    	}
    	else {
    		this.snsFail(errBackUrl, "????????? ?????????????????????. ??????????????? ???????????????.", paramCtx);
    	}
	}

	public void setParamSession(ParameterContext paramCtx){
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		snsAuthEtcParameters.set(SnsAuthEtcParameters.SNS_SITE_ID, param.getString("siteId"), request);
		snsAuthEtcParameters.set(SnsAuthEtcParameters.SNS_MENU_NO, param.getString("menuNo"), request);
		snsAuthEtcParameters.set(SnsAuthEtcParameters.SNS_AUTH_TP, param.getString("authTp"), request);
		snsAuthEtcParameters.set(SnsAuthEtcParameters.SNS_RETURN_URL, param.getString("retUrl"), request);
		snsAuthEtcParameters.set(SnsAuthEtcParameters.SNS_MODE, param.getString("mode"), request);

		snsAuthEtcParameters.set("snsAppDeviceId", param.getString("appDeviceId"), request);
		snsAuthEtcParameters.set("snsAppToken", param.getString("appToken"), request);
		snsAuthEtcParameters.set("snsAppOs", param.getString("appOs"), request);
		snsAuthEtcParameters.set("snsAppVersion", param.getString("appVersion"), request);
		snsAuthEtcParameters.set("snsAppModel", param.getString("appModel"), request);
	}

	public String errUrlVal(String authTp,String mode){
		String errUrl = "";
		if ("PUSH".equals(mode)) errUrl = PUSH_LOGIN_URL;
		else if("A".equals(authTp)) errUrl = MEMBER_URL;
		else if("L".equals(authTp)) errUrl = LOGIN_URL;
		else if("I".equals(authTp)) errUrl = IDSEARCH_URL;
		else if("P".equals(authTp)) errUrl = PWDSEARCH_URL;
		else errUrl = "/";
		return errUrl;
	}

	public void snsFail(String url, String msg, ParameterContext paramCtx) throws Exception{

		log.error("snsFail error : " + msg);
		MVUtils.goUrl(url, msg, paramCtx.getModel());
	}

	public void setAuthentication(MemberVO vo, HttpServletRequest request) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
    	SimpleGrantedAuthority vnameAuthority = new SimpleGrantedAuthority("ROLE_VNAME");
    	authorities.add(vnameAuthority);
    	SecurityContext securityContext = SecurityContextHolder.getContext();
    	UnpUserDetails userDetail = new UnpUserDetails(String.valueOf(vo.getUserSn()), vo.getPassword(), true, vo);
    	securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(userDetail,String.valueOf(vo.getUserSn()), authorities));
		HttpSession session =  request.getSession();
        session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
	}

	public void setPushAuthentication(MemberVO vo, HttpServletRequest request) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
    	SimpleGrantedAuthority vnameAuthority = new SimpleGrantedAuthority("ROLE_PUSHKEY");
    	authorities.add(vnameAuthority);
    	SecurityContext securityContext = SecurityContextHolder.getContext();
    	UnpUserDetails userDetail = new UnpUserDetails(String.valueOf(vo.getUserSn()), vo.getPassword(), true, vo);
    	securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(userDetail,String.valueOf(vo.getUserSn()), authorities));
		HttpSession session =  request.getSession();
        session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
	}

	private ServletContext servletContext;
	@Override
	public void setServletContext(ServletContext servletContext) {
		this.servletContext = servletContext;
	}
}
