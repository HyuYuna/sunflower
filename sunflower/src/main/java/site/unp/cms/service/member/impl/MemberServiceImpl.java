package site.unp.cms.service.member.impl;


import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import site.unp.cms.dao.member.MemberDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.listener.member.UserInfoPrtcListener;
import site.unp.cms.mail.AttachmentMessageSender;
import site.unp.cms.service.file.FileParser;
import site.unp.cms.service.member.MemberService;
import site.unp.cms.service.member.sec.LoginHistoryAuthenticationFailureHandler;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.cms.service.verify.IpinVerificationStrategy;
import site.unp.cms.service.verify.PhoneVerificationStrategy;
import site.unp.cms.util.UriUtil;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetails;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.MVUtils;

/**
 * ?????? ?????? ?????? ??????
 *
 */
@SuppressWarnings("serial")
@Service("memberService")
public class MemberServiceImpl extends DefaultCrudServiceImpl implements Serializable, MemberService {

	protected Logger log = LoggerFactory.getLogger(this.getClass());
	public PasswordEncoder passwordEncoder;

	public MemberServiceImpl() {
	}

	public PasswordEncoder getPasswordEncoder() {
		return passwordEncoder;
	}

	@Resource(name="passwordEncoder")
	public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
		this.passwordEncoder = passwordEncoder;
	}

	@Resource(name = "messageSender")
	private AttachmentMessageSender messageSender;

	@Resource(name = "siteInfoService")
	private SiteInfoService siteInfoService;

	@Resource(name="loginHistoryAuthenticationFailureHandler")
	protected LoginHistoryAuthenticationFailureHandler loginHistoryAuthenticationFailureHandler;

	protected final String AUTH_SESSION_KEY = "authSessionKey";

	@Autowired
	protected PhoneVerificationStrategy phoneVerificationStrategy;

	@Autowired
	protected IpinVerificationStrategy ipinVerificationStrategy;

	@Value("#{prop['Globals.ucms.siteSeCd']}") private String siteSeCd;

	@Value("${Globals.ucms.webRootPath}")
	private String webRootPath;

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		String userId = param.getString("userId");
		String password = param.getString("userPassword");
		
		Assert.hasText(userId);
		Assert.hasText(password);
		
		super.insert(paramCtx);
	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception {
	    ZValue param = paramCtx.getParam();
		String userId = param.getString("userId");
		Assert.hasText(userId);

		super.view(paramCtx);

		//???????????? ?????? ??????????????? ???????????? ??????
		param.put(UserInfoPrtcListener.READNG_USER_ID, userId);
		
	}

	/**
	 * ????????? ?????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forLogin(ParameterContext paramCtx) throws Exception {
	}

	/**
	 * ????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void toLogin(ParameterContext paramCtx) throws Exception {

	}

	public void drLogin(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		String username = param.getString("username");
		String userNm = param.getString("userNm");
        String password = param.getString("password");
        Assert.hasText(username);
		Assert.hasText(password);

		String siteId = param.getString("siteId");
		request.setAttribute("siteId", siteId);

		String goUrl = "/"+siteId+"/member/user/forLogin.do?menuNo="+param.getString("menuNo");
		param.put("siteId", siteId);

		/*if (!loginHistoryAuthenticationFailureHandler.checkLoginHistory(paramCtx.getRequest(), param)) {
			//MVUtils.goUrl(goUrl,"???????????? 5???????????? 30????????? ??????????????? ????????????.", model);
			session.setAttribute("userId", username);
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+siteId+"/member/user/pwdError.do?menuNo="+param.getString("menuNo"));
			return;
		}*/

		ZValue result = sqlDao.findOne("findOneUserMemberLoginInfo", param);
		boolean failure = false;
		if (result != null) {
			String pwd = result.getString("password");
			if (!passwordEncoder.isPasswordValid(pwd, password, null)) {
				failure = true;
			}
		}
		else {
			failure = true;
		}

		if (failure) {
			MVUtils.goUrl(goUrl, "????????? ?????? ??????????????? ???????????? ????????????.", model);
			return;
		}

		MemberVO vo = new MemberVO();
		//vo.setUserEmad(result.getString(arg0));
    	//vo.setCrtfcSeCd(crtfcSeCd);
    	vo.setUserPin(username);
    	vo.setUserId(username);
    	vo.setPassword(password);
    	//vo.setChldCrtfcAt("N");
    	vo.setUserNm(userNm);
    	//vo.setBrthdy(brthdy);
    	//vo.setSexCd(sexCd);
    	vo.setAuthorCd("ROLE_USERKEY");
    	//vo.setUserSn(member.getLong("userSn"));

		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		SimpleGrantedAuthority vnameAuthority = new SimpleGrantedAuthority("ROLE_USERKEY");
		authorities.add(vnameAuthority);

		SecurityContext securityContext = SecurityContextHolder.getContext();
		UnpUserDetails userDetail = new UnpUserDetails(vo.getUserId(), vo.getPassword(), true, vo);
		securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(userDetail,vo.getUserPin(), authorities));

		MVUtils.goUrl("/"+siteId+"/main/main.do", "????????? ???????????????.", model);
	}

	/**
	 * ????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void logout(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession(false);

		// ?????? ?????? start =========================================
		String conectUrlad = request.getRequestURI();
		String beforeMenuNo = session.getAttribute("beforeMenuNo")==null ? null : session.getAttribute("beforeMenuNo").toString();
		String siteId = conectUrlad.split("/")[1];
		//System.out.println(siteId);
		// ?????? ??????
		String ghvrSumry = UriUtil.getGhvrSumry(conectUrlad);

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String loginDt = formatter.format(session.getCreationTime());
		
		System.out.println(loginDt);
		
		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("userNm", user.getUserNm());
			param.put("loginDt", loginDt);
		} else {
			param.put("userId", request.getParameter("username"));
			param.put("loginDt", new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()));
		}
		
		sqlDao.save("updateLoginHist", param);
		
		//sqlDao.save("saveSiteConectStats", param);
		// ?????? ?????? end =========================================

		if (session != null) {
			session.invalidate();
		}
		SecurityContextHolder.clearContext();

		String url = "";
		if (param.getString("siteId").equals("bos")){
			url = "/"+param.getString("siteId")+"/member/"+param.getString("programId")+"/forLogin.do";
		} else {
			url = "/"+param.getString("siteId")+"/main/main.do";
		}

		ModelMap model = paramCtx.getModel();
		MVUtils.goUrl(url, "???????????? ???????????????.", model);
		return;
	}


	/**
	 * ????????? ?????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void loginForward(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		model.addAttribute(UriModelAndViewResolver.WINDOW_MODE, UriModelAndViewResolver.CONFIRM_URL_WINDOW_MODE);
		model.addAttribute(UriModelAndViewResolver.CONFIRM_MSG_KEY, "????????? ????????? ??????????????????. ?????????????????? ?????????????????????????");
		model.addAttribute(UriModelAndViewResolver.GO_URL_KEY, "/portal/main/contents.do?menuNo=200412");
	}


	/**
	 * ????????? ????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void checkId(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String userId = param.getString("userId");
		Assert.hasText(userId);

		long idCnt = getSqlDao(MemberDAO.class).countUserMemberByUserId(userId);
		//??????????????? ?????? ????????????????????? ???????????? ?????? ????????? ?????? ??????????????? ??????
		//long idCnt2 = sqlDao.count("countUserDrmncyByUserId", param);
		//idCnt = idCnt + idCnt2;

		model.addAttribute("posblAt", idCnt>0 ? "N" : "Y");
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * ???????????? ?????????
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void pwdInit(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		String userId = param.getString("userId");
		String userNm = param.getString("userNm");
		long userSn = param.getLong("userSn");
		String telno = param.getString("telno");
		String userSe = param.getString("userSe");

		Assert.hasText(userId);
		Assert.hasText(telno);

		String salt = RandomStringUtils.random(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
		String encodedSaltPassword = passwordEncoder.encodePassword(userId+telno, salt);

		getSqlDao(MemberDAO.class).updatePassword(userId, encodedSaltPassword);
		// TM_USER_SALT ???????????? SALT??? ????????? ??????
		getSqlDao(MemberDAO.class).deleteMemberSaltInfo(userId, userSe);
		getSqlDao(MemberDAO.class).saveMemberSalfInfo(userSn, userId, userNm, userSe, salt);

		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, "???????????? ???????????????.");
	}

	/**
	 * ????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateSttusCd(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		String userId = param.getString("userId");
		String sttusCd = param.getString("sttusCd");
		Assert.hasText(userId);
		Assert.hasText(sttusCd);

		getSqlDao(MemberDAO.class).updateSttusCd(userId, sttusCd);

		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, "???????????? ???????????????.");
	}

	/**
	 * ??????????????? ???????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateConfirm(ParameterContext paramCtx) throws Exception {
	}

	/**
	 * ??????????????? ???????????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateMy(ParameterContext paramCtx) throws Exception {
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getUserId();

		ZValue param = paramCtx.getParam();
		param.put("userId", userId);

		forUpdate(paramCtx);
	}

	/**
	 * ??????????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateMy(ParameterContext paramCtx) throws Exception {
		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getUserId();

		ZValue param = paramCtx.getParam();
		param.put("userId", userId);
		String newPassword = param.getString("password");
		if (StringUtils.hasText(newPassword)) {
			param.put("encodedPwd", passwordEncoder.encodePassword(newPassword, null));
		}
		sqlDao.modify("updateUserMember", param);
	}



	/**
	 * ????????? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void idSearchRequest(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

		String userNm = "";
		String userEmad = "";
		String userPin = "";

		if (member != null) {
			userPin = member.getUserPin();
			param.put("userPin", userPin);
		}
		else {
			userNm = param.getString("userNm");
			userEmad = param.getString("userEmad");
			Assert.hasText(userNm);
			Assert.hasText(userEmad);
		}

		ZValue result = getSqlDao(MemberDAO.class).idPwdSearchRequest(userNm, "", userEmad, userPin);

		if (result != null) {
			model.addAttribute("userId", result.getString("userId"));
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
			SecurityContextHolder.clearContext();
		}
		else {
			MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "???????????? ????????? ????????????.");
		}
	}

	/**
	 * ???????????? ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	//@UnpJsonView
	/*public void pwdSearchRequest(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

		String userId = "";
		String userEmad = "";
		String userPin = "";

		if (member != null) {
			userPin = member.getUserPin();
			param.put("userPin", userPin);
		}
		else {
			userId = param.getString("userId");
			userEmad = param.getString("userEmad");
			Assert.hasText(userId);
			Assert.hasText(userEmad);
		}

		ZValue result = getSqlDao(MemberDAO.class).idPwdSearchRequest("", userId, userEmad, userPin);

		if (result == null) {
			MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "???????????? ????????? ????????????.");
		}
		else {
			if (!StringUtils.hasText(userId)) userId = result.getString("userId");

			ZValue siteVO = siteInfoService.getSiteBySiteName(param.getString("siteId"));

			String subject = "["+param.getString("siteId")+"] ?????? ???????????? ?????? ??????";
			String password = RandomStringUtils.random(8, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
			String addres = "[" + siteVO.getString("zipUseAt") + "]" + siteVO.getString("adres1") + siteVO.getString("adres2") + siteVO.getString("insttNm") + ", TEL : " + siteVO.getString("telno") + ", FAX : " + siteVO.getString("faxno");
			String cpyrht = siteVO.getString("cpyrhtCn");
			String encodedPassword = passwordEncoder.encodePassword(password, null);
			getSqlDao(MemberDAO.class).updatePassword(userId, encodedPassword);

			String emailFormStr = FileParser.getFileToString(webRootPath +"/template/email/"+param.getString("siteId")+"/pwdEmailForm.html"); //????????? ??????????????????
			emailFormStr = emailFormStr.replace("@domain@", globalsProperties.getDomain());
			emailFormStr = emailFormStr.replace("@subject@", subject);
			emailFormStr = emailFormStr.replace("@userId@", userId);
			emailFormStr = emailFormStr.replace("@password@", password);
			emailFormStr = emailFormStr.replace("@addres@", addres);
			emailFormStr = emailFormStr.replace("@cpyrht@", cpyrht);
			emailFormStr = emailFormStr.replaceAll("@siteUrl@", "");

			param.put("subject", subject);
			param.put("text", emailFormStr);
			param.put("to", userEmad);

			messageSender.sndngEmail(param);

			MVUtils.setResultProperty(model, SUCCESS, "????????? ??????????????? ???????????? ?????????????????????.");
		}
	}*/

	/**
	 * ???????????? ?????? ?????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdChange(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

		model.addAttribute("member", member);
	}



	/**
	 * ?????? ?????????
	 * @param paramCtx
	 * @throws Exception
	 */
	public void secsn(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("member", member);
	}

	/**
	 * ?????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void secsnRequest(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();

		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = member.getUserId();
		long userSn = member.getUserSn();
		Assert.hasText(userId);
		param.put("userId", userId);
		param.put("userSn", userSn);
		param.put("userSe", "U");

		sqlDao.deleteOne("deleteUserMember", param);
		sqlDao.deleteOne("deleteUserPin", param);
		sqlDao.deleteOne("deleteMemberSaltInfo", param);
		sqlDao.save("saveUserMemberSecsn", param);

		ModelMap model = paramCtx.getModel();
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
	}

	/**
	 * ???????????? ??????
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void crtfcEmailRequest(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String userEmad = param.getString("userEmad");
		Assert.hasText(userEmad);
		ZValue result = getSqlDao(MemberDAO.class).idPwdSearchRequest("", "", userEmad, "");

		if (result == null) {
			ZValue siteVO = siteInfoService.getSiteBySiteName(param.getString("siteId"));
			String subject = "["+param.getString("siteId")+"] ???????????? ?????? ??????";
			String crtfcCd = RandomStringUtils.random(6, "1234567890");
			String addres = "[" + siteVO.getString("zipUseAt") + "]" + siteVO.getString("adres1") + " " + siteVO.getString("adres2") + siteVO.getString("insttNm") + ", TEL : " + siteVO.getString("telno") + ", FAX : " + siteVO.getString("faxno");
			String cpyrht = siteVO.getString("cpyrhtCn");
			String emailFormStr = FileParser.getFileToString(webRootPath +"/template/email/"+param.getString("siteId")+"/crtfcEmailForm.html"); //????????? ??????????????????
			emailFormStr = emailFormStr.replace("@domain@", globalsProperties.getDomain());
			emailFormStr = emailFormStr.replace("@subject@", subject);
			emailFormStr = emailFormStr.replace("@crtfcCd@", crtfcCd);
			emailFormStr = emailFormStr.replace("@addres@", addres);
			emailFormStr = emailFormStr.replace("@cpyrht@", cpyrht);
			emailFormStr = emailFormStr.replaceAll("@siteUrl@", "");

			param.put("subject", subject);
			param.put("text", emailFormStr);
			param.put("to", userEmad);

			messageSender.sndngEmail(param);
			model.addAttribute("crtfcCd", crtfcCd);
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.SUCCESS);
		}
		else {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
		}
	}


}
