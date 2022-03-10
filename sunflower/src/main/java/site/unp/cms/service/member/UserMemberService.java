package site.unp.cms.service.member;

import javax.servlet.http.HttpServletRequest;

import site.unp.cms.domain.MemberVO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;

public interface UserMemberService{	

	public static final String USER_SE = "U";
	
	public void list(ParameterContext paramCtx) throws Exception;
    
	public void list2(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	/**
	 * 약관 및 개인정보수집 동의 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinAgre(ParameterContext paramCtx) throws Exception;

	/**
	 * 회원가입방식선택 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinSelect(ParameterContext paramCtx) throws Exception;

	/**
	 * 정보입력 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinInput(ParameterContext paramCtx) throws Exception;

	/**
	 * 정보입력 완료
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinFinish(ParameterContext paramCtx) throws Exception;

	/**
	 * 로그인 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void toLogin(ParameterContext paramCtx) throws Exception;
	/**
	 * 휴면아이디 안내 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void drmncyIdInfo(ParameterContext paramCtx) throws Exception;

	/**
	 * 아이디/비밀번호 찾기 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idPwdSearch(ParameterContext paramCtx) throws Exception;

	/**
	 * 본인확인 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void joinVerify(ParameterContext paramCtx) throws Exception;

	/**
	 * 휴대폰 본인인증 화면 호출
	 * @param request
	 * @param model
	 * @throws Exception
	 */
	public void vnamePhoneForward(ParameterContext paramCtx) throws Exception;

	/**
	 * IPIN 인증 화면 호출
	 * @param paramCtx
	 * @throws Exception
	 */
	public void vnameIPINForward(ParameterContext paramCtx) throws Exception;

	/**
	 * 실명인증 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void vnameOutput(ParameterContext paramCtx) throws Exception;

	public void setAuthentication(MemberVO vo, HttpServletRequest request);

	public void setAuthentication2(MemberVO vo, HttpServletRequest request);


	public void vnameFail(ParameterContext paramCtx) throws Exception;
	/**
	 * 아이디 찾기 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idSearch(ParameterContext paramCtx) throws Exception;

	/**
	 * 아이디 찾기 결과 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idSearchFinish(ParameterContext paramCtx) throws Exception;

	/**
	 * 비밀번호 찾기 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdSearch(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 비밀번호 찾기 결과 페이지
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdSearchInput(ParameterContext paramCtx) throws Exception;

	/**
	 * 아이디 찾기 결과 페이지 json
	 * @param paramCtx
	 * @throws Exception
	 */
	public void idSearchRequest(ParameterContext paramCtx) throws Exception;
	
	public void pwdChangeByUserSn(ParameterContext paramCtx) throws Exception;

	//암호화
	public ZValue userInfoEncode(ZValue param) throws Exception;

	//복호화
	public ZValue userInfoDecode(ZValue result) throws Exception;

	
	/**
	 * 관리자 사용자 조회시 세션에 조회 권한 추가
	 * @param paramCtx
	 * @throws Exception
	 */
	public void setCallUserId(ParameterContext paramCtx) throws Exception;


	//관리자 회원 수정
	public void update(ParameterContext paramCtx) throws Exception;

	/**
	 * 기존 비밀번호 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdCheck(ParameterContext paramCtx) throws Exception;

	public void checkPrhibtWrd(ParameterContext paramCtx) throws Exception;
	/**
	 * 비밀번호 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void pwdChangeRequest(ParameterContext paramCtx) throws Exception;

    public void deleteUser(ParameterContext paramCtx) throws Exception;

    public void print(ParameterContext paramCtx, String type) throws Exception;

    public void downloadExcel2(ParameterContext paramCtx) throws Exception;

    public void list_lock(ParameterContext paramCtx) throws Exception;

    public void list_login(ParameterContext paramCtx) throws Exception;
    
    public void changeUserPassword(ParameterContext paramCtx) throws Exception;

    public void list_action(ParameterContext paramCtx) throws Exception;

    void downloadExcel3(ParameterContext paramCtx) throws Exception;

    void print(ParameterContext paramCtx) throws Exception;

    void print2(ParameterContext paramCtx) throws Exception;

    void listDownload(ParameterContext paramCtx) throws Exception;
    
    void listUserPrint(ParameterContext paramCtx) throws Exception;

    void downloadExcel4(ParameterContext paramCtx) throws Exception;

    void downloadExcel5(ParameterContext paramCtx) throws Exception;

    void downloadExcel6(ParameterContext paramCtx) throws Exception;

    void pwInit(ParameterContext paramCtx) throws Exception;

}
