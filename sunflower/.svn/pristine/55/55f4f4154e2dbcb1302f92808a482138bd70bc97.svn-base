package site.unp.cms.service.oauth;

import javax.servlet.http.HttpServletRequest;

import site.unp.cms.domain.MemberVO;
import site.unp.core.ParameterContext;


public interface SnsService{
	
	

    public static final String LOGINTYPE_GOOGLE = "GO";
    public static final String PREFIX_GOOGLE = "google";
    public static final String LOGINTYPE_FACEBOOK = "FB";
    public static final String PREFIX_FACEBOOK = "facebook";
	public static final String LOGINTYPE_NAVER = "NA";
	public static final String PREFIX_NAVER = "naver";
	public static final String LOGINTYPE_TWITTER = "TW";
	public static final String PREFIX_TWITTER = "twitter";
	public static final String LOGINTYPE_KAKAO = "KA";
	public static final String PREFIX_KAKAO = "kakao";
	public static final String LOGIN_URL = "/ucms/member/user/forLogin.do?menuNo=300019";
	public static final String MEMBER_URL = "/ucms/member/user/joinVerify.do?menuNo=300020";
	public static final String IDSEARCH_URL = "/ucms/member/user/idSearch.do?menuNo=300021";
	public static final String PWDSEARCH_URL = "/ucms/member/user/pwdSearch.do?menuNo=300082";
	public static final String PUSH_LOGIN_URL = "/push/member/uwam/forLogin.do";


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
	 * 구글 로그인
	 * @param paramCtx
	 */
	public void googleLogin(ParameterContext paramCtx);

	/**
	 * 구글 callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void googleCallback(ParameterContext paramCtx) throws Exception;

	/**
	 * 페이스북 로그인
	 * @param paramCtx
	 */
	public void facebookLogin(ParameterContext paramCtx);
	
	/**
	 * 페이스북 callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void facebookCallback(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 트위터 로그인
	 * @param paramCtx
	 */
	public void twitterLogin(ParameterContext paramCtx);
	/**
	 * 트위터 callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void twitterCallback(ParameterContext paramCtx) throws Exception;

	/**
	 * 네이버 로그인
	 * @param paramCtx
	 */
	public void naverLogin(ParameterContext paramCtx);

	/**
	 * 네이버 callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void naverCallback(ParameterContext paramCtx) throws Exception;

	/**
	 * 카카오 로그인
	 * @param paramCtx
	 */
	public void kakaoLogin(ParameterContext paramCtx);

	/**
	 * 카카오 callback
	 * @param paramCtx
	 * @throws Exception
	 */
	public void kakaoCallback(ParameterContext paramCtx) throws Exception;

	/**
	 * 인증 및 가입 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void snsPushOutput(ParameterContext paramCtx) throws Exception;

	/**
	 * 실명인증 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void snsOutput(ParameterContext paramCtx) throws Exception;

	public void setParamSession(ParameterContext paramCtx);

	public String errUrlVal(String authTp,String mode);

	public void snsFail(String url, String msg, ParameterContext paramCtx) throws Exception;

	public void setAuthentication(MemberVO vo, HttpServletRequest request);

	public void setPushAuthentication(MemberVO vo, HttpServletRequest request);

}
