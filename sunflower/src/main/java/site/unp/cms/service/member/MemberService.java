package site.unp.cms.service.member;

import site.unp.core.ParameterContext;
import site.unp.core.annotation.UnpJsonView;

public interface MemberService{
	

	public static final String LOGIN_URL = "/ucms/member/user/forLogin.do?menuNo=300019";
	public static final String MEMBER_URL = "/ucms/member/user/joinVerify.do?menuNo=300020";
	public static final String IDSEARCH_URL = "/ucms/member/user/idSearch.do?menuNo=300021";
	public static final String PWDSEARCH_URL = "/ucms/member/user/pwdSearch.do?menuNo=300082";

	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	/**
	 * 로그인 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forLogin(ParameterContext paramCtx) throws Exception;

	/**
	 * 로그인 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void toLogin(ParameterContext paramCtx) throws Exception;

	public void drLogin(ParameterContext paramCtx) throws Exception;
	/**
	 * 로그아웃
	 * @param paramCtx
	 * @throws Exception
	 */
	public void logout(ParameterContext paramCtx) throws Exception;

	/**
	 * 로그인 포워딩
	 * @param paramCtx
	 * @throws Exception
	 */
	public void loginForward(ParameterContext paramCtx) throws Exception;


	/**
	 * 아이디 중복조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void checkId(ParameterContext paramCtx) throws Exception;
	/**
	 * 비밀번호 초기화
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdInit(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 승인처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateSttusCd(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 마이페이지 인증페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateConfirm(ParameterContext paramCtx) throws Exception;

	/**
	 * 마이페이지 수정페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateMy(ParameterContext paramCtx) throws Exception;

	/**
	 * 마이페이지 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateMy(ParameterContext paramCtx) throws Exception;



	/**
	 * 아이디 찾기 요청
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idSearchRequest(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 비밀번호 찾기 요청
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
			MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "일치하는 정보가 없습니다.");
		}
		else {
			if (!StringUtils.hasText(userId)) userId = result.getString("userId");

			ZValue siteVO = siteInfoService.getSiteBySiteName(param.getString("siteId"));

			String subject = "["+param.getString("siteId")+"] 회원 비밀번호 찾기 메일";
			String password = RandomStringUtils.random(8, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
			String addres = "[" + siteVO.getString("zipUseAt") + "]" + siteVO.getString("adres1") + siteVO.getString("adres2") + siteVO.getString("insttNm") + ", TEL : " + siteVO.getString("telno") + ", FAX : " + siteVO.getString("faxno");
			String cpyrht = siteVO.getString("cpyrhtCn");
			String encodedPassword = passwordEncoder.encodePassword(password, null);
			getSqlDao(MemberDAO.class).updatePassword(userId, encodedPassword);

			String emailFormStr = FileParser.getFileToString(webRootPath +"/template/email/"+param.getString("siteId")+"/pwdEmailForm.html"); //메일폼 서식불러오기
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

			MVUtils.setResultProperty(model, SUCCESS, "변경된 비밀번호가 이메일로 발송되었습니다.");
		}
	}*/

	/**
	 * 비밀번호 변경 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdChange(ParameterContext paramCtx) throws Exception;



	/**
	 * 탈퇴 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void secsn(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 탈퇴 요청
	 * @param paramCtx
	 * @throws Exception
	 */
	public void secsnRequest(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 인증메일 발송
	 * @param paramCtx
	 * @throws Exception
	 */
	public void crtfcEmailRequest(ParameterContext paramCtx) throws Exception;


}
