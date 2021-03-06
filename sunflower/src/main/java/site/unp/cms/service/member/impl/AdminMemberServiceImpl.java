package site.unp.cms.service.member.impl;


import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base32;
import org.apache.commons.lang.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import site.unp.cms.conf.PasswordEncrypter;
import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.service.member.AdminMemberService;
import site.unp.cms.service.member.sec.LoginHistoryAuthenticationFailureHandler;
import site.unp.cms.service.verify.GoogleOtp;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.util.MVUtils;
import site.unp.core.util.StrUtils;

@SuppressWarnings("serial")
@CommonServiceDefinition(
	countQueryId="countUserInfo",
	listQueryId="findAllUserInfo",
	viewQueryId="findOneUserInfo",
	deleteQueryId="deleteUserInfo",
	updateQueryId="updateUserInfo",
	insertQueryId="saveUserInfo",
	sqlDaoRef="memberDAO",
	pageQuery="memberPageQuery"
)
@CommonServiceLink(desc="관리자 회원 관리")
@Service
public class AdminMemberServiceImpl extends MemberServiceImpl implements AdminMemberService {

	/******************************
	 * 관리자 회원 초기 데이터 등록시 유의사항
	*******************************/

	/**
	 * 1.프로젝트에서 salt 기능을 적용하지 않는 경우
	 * TM_USER_SALT 테이블은 사용하지 않는다.
	 * TM_MNGR_INFO 의 패스워드는 1234(03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4) 값으로 초기세팅한다.
	 */

	/**
	 * 2.프로젝트에서 salt 기능을 적용하는 경우
	 * TM_USER_SALT 테이블을 사용한다. 해당 테이블의 salt 데이터는 0QXx3RL0ZWtt 값으로 초기세팅한다.
	 * TM_MNGR_INFO 의 패스워드는 1234(71fda0c784920b806704a771cd90e6ea23fb85f5d27e8a42e133cb122cb3367d) 값으로 초기세팅한다.
	 *
	 * 추가) admin은 슈퍼관리자로 개발시에만 사용한다.
	 * TM_USER_SALT 테이블을 사용한다. 해당 테이블의 salt 데이터는 kzZwkSGDb6BX 값으로 초기세팅한다.
	 * TM_MNGR_INFO 의 패스워드는 unpl7471!@#(b15c2f42b8f80ba7eed662ca0de0166f9784ff2134ced8f6e984c66c112854a1)값으로 초기세팅한다.
	 */

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="siteInfoDAO")
	private SiteInfoDAO siteInfoDAO;

	@Resource(name = "loginHistoryAuthenticationFailureHandler")
	protected LoginHistoryAuthenticationFailureHandler loginHistoryAuthenticationFailureHandler;

	@Resource(name = "passwordEncoder")
	protected ShaPasswordEncoder passwordEncoder;
	
	@Resource(name="googleOtp")
	private GoogleOtp googleOtp;

	public AdminMemberServiceImpl(){
	}


	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception{
		super.forInsert(paramCtx);

		List<ZValue> authList = sqlDao.findAll("findAllAuthList");
        ModelMap model = paramCtx.getModel();
		model.addAttribute("authList", authList);
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception{
		super.forUpdate(paramCtx);

		List<ZValue> authList = sqlDao.findAll("findAllAuthList");
        ModelMap model = paramCtx.getModel();
		model.addAttribute("authList", authList);
	}

	@Override
	public void forLogin(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue siteInfoVO = siteInfoDAO.getSiteBySiteName(param.getString(SITE_ID));
		String accesIpad = siteInfoVO.getString("accesIpad");
		String userIp = paramCtx.getRequest().getRemoteAddr();
		/*if (!param.getString("lType").equals("skip")){ //임시적으로 ip 체크 우회인증
			if ( !isAccessable(userIp, accesIpad) ) {
				MVUtils.goUrl("javascript:history.back()", "접근할 수 없는 IP대역입니다. 접속하신 아이피는 "+userIp+"입니다. 본부관리자에게 요청바랍니다.", paramCtx.getModel());
			}
		}*/
		
		String adtCrtfcUseAt = siteInfoVO.getString("adtCrtfcUseAt");
		
		model.addAttribute("adtCrtfcUseAt",adtCrtfcUseAt);
	}

	public void forLogin2(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ZValue siteInfoVO = siteInfoDAO.getSiteBySiteName(param.getString(SITE_ID));
		String accesIpad = siteInfoVO.getString("accesIpad");
		String userIp = paramCtx.getRequest().getRemoteAddr();
		/*if (!param.getString("lType").equals("skip")){ //임시적으로 ip 체크 우회인증
			if ( !isAccessable(userIp, accesIpad) ) {
				MVUtils.goUrl("javascript:history.back()", "접근할 수 없는 IP대역입니다. 접속하신 아이피는 "+userIp+"입니다. 본부관리자에게 요청바랍니다.", paramCtx.getModel());
			}
		}*/
	}

	public void toLogin(ParameterContext paramCtx) throws Exception{

		ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        HttpSession session = paramCtx.getSession();

		String username = param.getString("username");
		Assert.hasText(username);
        String password = param.getString("password");
		Assert.hasText(password);
		String pwd = "";
		String adtCrtfcUseAt = param.getString("adtCrtfcUseAt");

        String goUrl = "/bos/member/admin/forLogin.do";
        paramCtx.getRequest().setAttribute("siteId", param.getString("siteId"));
        paramCtx.getRequest().setAttribute("ovseaIpAt", param.getString("ovseaIpAt"));
        
        ZValue loginPoilcy = sqlDao.findOne("findAllloginPolicy", param);
        int retryCo = (Integer)loginPoilcy.get("passwordRetryCo");
        
        
		/*if( !loginHistoryAuthenticationFailureHandler.checkLoginHistory(paramCtx.getRequest(), param) ){
			MVUtils.goUrl(goUrl, "비밀번호 5회틀릴시 30분동안 로그인할수 없습니다.", model);
			return;
		}*/

		param.put("id", username);
		param.put("userSe", "A");
		ZValue result = sqlDao.findOne("findOneMngrLoginInfo", param);
		ZValue loginSteatus = sqlDao.findOne("findOneUserLockCheck", param);
		
		/*ZValue saltResult = sqlDao.findOne("findOneMemberLoginSaltInfo", param);*/

		boolean failure = false;
		
		System.out.println("======================");
		System.out.println(loginSteatus);
		if(result != null) {
			if("S".equals(result.getString("userState"))) {
				//휴직자
				failure = true;
			}else if ("N".equals(result.getString("userState"))) {
				//퇴직자
				failure = true;
			}
		}
		
		
		if(loginSteatus != null ) {
			//있으면
			int loginFailCount = (int)((double) loginSteatus.get("loginFailCount"));
		
			
			if(loginFailCount >= retryCo ) {
				//락임
				failure = true;
			}
		}
		
		if ( result != null /*&& saltResult != null*/) {
			
			pwd = result.getString("userPassword");
			
			if (!pwd.equals(PasswordEncrypter.encrypt(password))) {
				failure = true;
			};
			
			/*if (!passwordEncoder.isPasswordValid(pwd, password,  saltResult.getString("salt"))) {
				failure = true;
			}*/
		}else {
			//아이디 없으면
			failure = true;
		}
		
		if( failure ) {
			if ( result != null) {
				model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ModelAndViewResolver.ERROR);
				//loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "N");
				//로그인 실패시 tb_user_login에 MERGE
				 if(!("S".equals(result.getString("userState")) || "N".equals(result.getString("userState")))) {
					 sqlDao.save("insertUserLockCount", param);
				 }
			}
			int loginFailCount = 0;
			
			
			
			
			if ( result != null ) {
				if(loginSteatus != null) {
					loginFailCount =  (int)((double) loginSteatus.get("loginFailCount"));
				}
				
				
				if(loginFailCount >= retryCo ) {
					//락임
					MVUtils.goUrl(goUrl, "로그인 정보를 확인해주세요", model);
				}else if("S".equals(result.getString("userState"))) {
					MVUtils.goUrl(goUrl, "휴직자 입니다. 로그인 정보를 확인해주세요", model);
				}else if("N".equals(result.getString("userState"))) {
					MVUtils.goUrl(goUrl, "퇴직자 입니다. 로그인 정보를 확인해주세요", model);
				}else {
					//틀림
					MVUtils.goUrl(goUrl, "비밀번호가 올바르지 않습니다. 허용범위 "+retryCo+"회중 "+(loginFailCount+1)+"회 틀렸습니다. "+retryCo+"회 이상 잘못입력되면 로그인이 제한됩니다.", model);
				}
			}else {
				//아이디틀림
				MVUtils.goUrl(goUrl, "로그인 정보를 확인해주세요", model);
			}
			return;
		}else {
			//성공시 0으로 다시 돌림
			sqlDao.modify("updateUserLockZero", param);
		}

		//추가인증 Y이면 추가인증페이지로 이동
		if(adtCrtfcUseAt.equals("Y")) {
			session.setAttribute("username", username);
			session.setAttribute("password", password);
			session.setAttribute("userNm", result.getString("userNm"));
			/*session.setAttribute("salt", saltResult.getString("salt"));*/
			MVUtils.goUrl("/bos/member/admin/googleCrtfc.do?viewType=CONTBODY", null, model);
		}else {
			
			//loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "Y");

			HashMap<String, String> map = new HashMap<String, String>();
			map.put("username", param.getString("username"));
			map.put("userNm", result.getString("userNm"));
			
			
			
			map.put("password", PasswordEncrypter.encrypt(password));
			map.put("userPassword", PasswordEncrypter.encrypt(password));
			map.put("centerNmae", result.getString("centerName"));
			
			//총괄관리자 로그인 알림 메일 발송
			if("CA".equals(result.getString("userLevel"))){
				Date today = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
				
				param.put("wuser", result.getString("username"));
				param.put("comId", result.getString("centerCode"));
				param.put("comId2", result.getString("centerCode").substring(0,1));
				param.put("status", "S");
				
				param.put("title", "[자동발신] 총괄 관리자 로그인 알림");
				
				String content = sdf.format(today) + "에 " + result.getString("userNm") + "(" + result.getString("username") + ")님이 로그인 하셨습니다.";
				param.put("content", content);
				
				sqlDao.save("saveMessage", param);
				
				param.put("seq", param.getString("seq"));
				param.put("receiver", "library");
				param.put("status", "N");
				
				sqlDao.save("saveMessageTgt", param);
			}
			
			//System.out.println(map.get("username"));
			//System.out.println(map.get("userNm"));
			//System.out.println(map.get("password"));
			//map.put("password", passwordEncoder.encodePassword(password,saltResult.getString("salt")));
			//System.out.println(map.get("password"));
			/*map.put("siteId", "bos");
			
			System.out.println(map);
			System.out.println(model);
			
			model.addAttribute("hiddenInput", map);
			model.addAttribute("goUrl", "/bos/login.do");*/
			
			MVUtils.goUrlHidden(map, "/bos/login.do", "", model);
		}


	}


    private boolean isAccessable(String userIp, String accessIp) {
    	if ( accessIp == null ) {
    		return true;
    	}

    	boolean condition = false;
		try {
			String[] accessIpes = StrUtils.split(accessIp, ",");
			log.debug("accessIpes : {}, userIp : {}", ArrayUtils.toString(accessIpes), userIp);
			for (String ip : accessIpes) {
				ip = StringUtils.trimAllWhitespace(ip);
				if (ip.indexOf("*") != -1) {
					if ( userIp.startsWith(ip.substring(0, ip.indexOf("*"))) ) {
						condition = true;
						break;
					}
				}
				else if(ip.indexOf("~") != -1) {
					String[] ipes = ip.split("~");
					String _ip1 = ipes[0].substring(0, ipes[0].lastIndexOf(".")+1);
					String _ip2 = ipes[1].substring(0, ipes[1].lastIndexOf(".")+1);
					if( userIp.indexOf(_ip1) > -1 && userIp.indexOf(_ip2) > -1 ) {
						String _ip11 = ipes[0].substring(ipes[0].lastIndexOf(".")+1);
						String _ip22 = ipes[1].substring(ipes[1].lastIndexOf(".")+1);
						String _userIp2 = userIp.substring(userIp.lastIndexOf(".")+1);
						if ( ( Integer.parseInt(_userIp2) >= Integer.parseInt(_ip11) ) &&
							( Integer.parseInt(_userIp2) <= Integer.parseInt(_ip22) ) ) {
							condition = true;
							break;
						}
					}
				}
				else {
					if ( userIp.equals(ip) ) {
						condition = true;
						break;
					}
				}
			}
		} catch(StringIndexOutOfBoundsException siooe) {
			log.error("StringIndexOutOfBoundsException:" + siooe.getMessage());
			condition = false;
		} catch(NumberFormatException npe) {
			log.error("NumberFormatException:" + npe.getMessage());
			condition = false;
		} catch(Exception ignored) {
			condition = false;
		}

		return condition;
    }

	public void listPop(ParameterContext paramCtx) throws Exception{
		super.list(paramCtx);
	}

	public void googleCrtfc(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		paramCtx.getRequest().setAttribute("siteId", param.getString("siteId"));

		String userId = (String) session.getAttribute("username");
		String goUrl = "/bos/member/admin/forLogin.do";
		
		if(userId == null){
			MVUtils.goUrl(goUrl, "세션이 초기화 되었습니다.", model);
			return;
		}
		
		param.put("userId", userId);
		ZValue userOtp = sqlDao.findOne("findOneUserOtpKey", param);
		
		String encodedKey = "";
		if(userOtp == null){
			byte[] buffer = new byte[5 + 5 * 5];
			new Random().nextBytes(buffer);
			Base32 codec = new Base32();
			// byte[] secretKey = Arrays.copyOf(buffer, secretSize);
			byte[] secretKey = Arrays.copyOf(buffer, 10);
			byte[] bEncodedKey = codec.encode(secretKey);

			// 생성된 Key!
			encodedKey = new String(bEncodedKey);
			
			param.put("otpKey", encodedKey);
			sqlDao.save("insertUserOtpKey", param);
		} else {
			encodedKey = userOtp.getString("otpKey");
		}
		
		// String url = getQRBarcodeURL(userName, hostName, secretKeyStr);
		// userName과 hostName은 변수로 받아서 넣어야 하지만, 여기선 테스트를 위해 하드코딩 해줬다.
		String url = googleOtp.getQRBarcodeURL(userId, "sunflower-center.kr", encodedKey); // 생성된 바코드 주소!

		model.addAttribute("encodedKey", encodedKey);
		model.addAttribute("url", url);

	}

	public void crtfcLogin(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		paramCtx.getRequest().setAttribute("siteId", param.getString("siteId"));

		String userCode = param.getString("userCode");
		String encodKey = param.getString("encodedKey");
		String username = (String) session.getAttribute("username");
		String password = (String) session.getAttribute("password");
		String userNm = (String) session.getAttribute("userNm");
		String salt = (String) session.getAttribute("salt");

		ZValue loginPoilcy = sqlDao.findOne("findAllloginPolicy", param);
		int retryCo = (Integer)loginPoilcy.get("passwordRetryCo");

		param.put("username", username);
		param.put("id", username);
		param.put("userSe", "A");

		ZValue result = sqlDao.findOne("findOneMngrLoginInfo", param);
		ZValue loginSteatus = sqlDao.findOne("findOneUserLockCheck", param);

		boolean failure = false;
		if (!"".equals(loginSteatus) && loginSteatus != null) {
			int loginFailCount = (int) ((double) loginSteatus.get("loginFailCount"));
			if (loginFailCount >= retryCo){
				failure = true;
			}
		}
		
		if (result != null) {
			boolean otpResult = googleOtp.otpResult(userCode, encodKey);
			if (!otpResult) {
				failure = true;
			}
		} else {
			failure = true;
		}

		if (failure) {
			model.addAttribute("resultCode", "error");
			//loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "N");
			sqlDao.save("insertUserLockCount", param);
			MVUtils.goUrl("/bos/member/admin/googleCrtfc.do?viewType=CONTBODY", "OTP인증번호가 일치하지 않거나 계정이 잠긴 상태입니다.", model);
			return;
		}
		
		ZValue logParam = new ZValue();
		logParam.put("sttusCd", 'N');
		logParam.put("userId", (String) session.getAttribute("username"));
		logParam.put("userIpad", request.getRemoteAddr());
		logParam.put("siteId", request.getAttribute("siteId"));

		sqlDao.save("insertLoginHist", logParam);
		

		session.removeAttribute("username");
		session.removeAttribute("password");
		session.removeAttribute("userNm");
		session.removeAttribute("salt");

		//loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "Y");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("userNm", userNm);
		map.put("password", passwordEncoder.encodePassword(password,salt));
		
		//총괄관리자인 경우 로그인 알림 메일 발송
		if("CA".equals(result.getString("userLevel"))){
			Date today = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
			
			param.put("wuser", result.getString("username"));
			param.put("comId", result.getString("centerCode"));
			param.put("comId2", result.getString("centerCode").substring(0,1));
			param.put("status", "S");
			
			param.put("title", "[자동발신] 총괄 관리자 로그인 알림");
			
			String content = sdf.format(today) + "에 " + result.getString("userNm") + "(" + result.getString("username") + ")님이 로그인 하셨습니다.";
			param.put("content", content);
			
			sqlDao.save("saveMessage", param);
			
			param.put("seq", param.getString("seq"));
			param.put("receiver", "library");
			param.put("status", "N");
			
			sqlDao.save("saveMessageTgt", param);
		}
		
		MVUtils.goUrlHidden(map, "/bos/login.do", "", model);
	}
}