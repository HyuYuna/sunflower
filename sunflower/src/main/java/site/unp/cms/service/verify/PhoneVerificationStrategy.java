package site.unp.cms.service.verify;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.cms.domain.MemberVO;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

@Component
public class PhoneVerificationStrategy implements VerificationStrategy {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("#{prop['phone.verificationCode']}") private String hSiteCode;
	@Value("#{prop['phone.verificationPwd']}") private String hSitePassword;
	@Value("#{prop['Globals.ucms.domain']}") private String siteUrl;


	@Override
	public void request(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sRequestNumber = "REQ0000000001";        	// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 업체에서 적절하게 변경하여 쓰거나, 아래와 같이 생성한다.
	    sRequestNumber = niceCheck.getRequestNO(hSiteCode);
	  	session.setAttribute("REQ_SEQ" , sRequestNumber);	// 해킹등의 방지를 위하여 세션을 쓴다면, 세션에 요청번호를 넣는다.

	   	String sAuthType = "";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
	   	String popgubun = "N";			//Y : 취소버튼 있음 / N : 취소버튼 없음
		String customize = "";			//없으면 기본 웹페이지 / Mobile : 모바일페이지
		String sGender = ""; 			//없으면 기본 선택 값, 0 : 여자, 1 : 남자

		// CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		//리턴url은 인증 전 인증페이지를 호출하기 전 url과 동일해야 합니다. ex) 인증 전 url : http://www.~ 리턴 url : http://www.~
		boolean secure = request.isSecure(); // true : https
		String protocol = "http";
		if(secure){
			protocol = "https";
		}
	    String sReturnUrl = protocol +"://"+ siteUrl +"/"+ param.getString("siteId") +"/member/user/vnamePhoneForward.do?menuNo="+ param.getString("menuNo") +"&authTp="+ param.getString("authTp") +"&retUrl="+ URLDecoder.decode(param.getString("retUrl",""),"UTF-8");      // 성공시 이동될 URL
	    String sErrorUrl  = protocol +"://"+ siteUrl +"/"+ param.getString("siteId") +"/member/user/checkplus_fail.jsp";          // 실패시 이동될 URL

	    // 입력될 plain 데이타를 만든다.
	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber +
	                        "8:SITECODE" + hSiteCode.getBytes().length + ":" + hSiteCode +
	                        "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
	                        "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
	                        "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
	                        "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun +
	                        "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize +
							"6:GENDER" + sGender.getBytes().length + ":" + sGender;

	    String sMessage = "";
	    String sEncData = "";

	    int iReturn = niceCheck.fnEncode(hSiteCode, hSitePassword, sPlainData);
	    if( iReturn == 0 )
	    {
	        sEncData = niceCheck.getCipherData();
	        model.addAttribute("sEncPhoneData", sEncData);
	        //log.error("sEncPhoneData ===============" + sEncData);
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "암호화 시스템 에러입니다.";
	    }
	    else if( iReturn == -2)
	    {
	        sMessage = "암호화 처리오류입니다.";
	    }
	    else if( iReturn == -3)
	    {
	        sMessage = "암호화 데이터 오류입니다.";
	    }
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }
        model.addAttribute("sMessage", sMessage);
        log.error("sMessage ===============" + sMessage);
	}

	@SuppressWarnings("unused")
	@Override
	public MemberVO response(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

		//인증 후 결과값이 null로 나오는 부분은 관리담당자에게 문의 바랍니다.
	    NiceID.Check.CPClient niceCheck = new  NiceID.Check.CPClient();

	    String sEncodeData = requestReplace(request.getParameter("EncodeData"), "encodeData");
	    String sCipherTime = "";			// 복호화한 시간
	    String sRequestNumber = "";			// 요청 번호
	    String sResponseNumber = "";		// 인증 고유번호
	    String sAuthType = "";				// 인증 수단
	    String sName = "";					// 성명
	    String sDupInfo = "";				// 중복가입 확인값 (DI_64 byte)
	    String sConnInfo = "";				// 연계정보 확인값 (CI_88 byte)
	    String sBirthDate = "";				// 생년월일(YYYYMMDD)
	    String sGender = "";				// 성별
	    String sNationalInfo = "";			// 내/외국인정보 (개발가이드 참조)
		String sMobileNo = "";				// 휴대폰번호
		String sMobileCo = "";				// 통신사
	    String sMessage = "";
	    String sPlainData = "";

	    int iReturn = niceCheck.fnDecode(hSiteCode, hSitePassword, sEncodeData);

	    if( iReturn == 0 )
	    {
	        sPlainData = niceCheck.getPlainData();
	        sCipherTime = niceCheck.getCipherDateTime();

	        // 데이타를 추출합니다.
	        @SuppressWarnings("rawtypes")
			java.util.HashMap mapresult = niceCheck.fnParse(sPlainData);

	        sRequestNumber  = (String)mapresult.get("REQ_SEQ");
	        sResponseNumber = (String)mapresult.get("RES_SEQ");
	        sAuthType		= (String)mapresult.get("AUTH_TYPE");
	        sName			= (String)mapresult.get("NAME");
	        //sName			= (String)mapresult.get("UTF8_NAME"); //charset utf8 사용시 주석 해제 후 사용
	        sBirthDate		= (String)mapresult.get("BIRTHDATE");
	        sGender			= (String)mapresult.get("GENDER");
	        sNationalInfo  	= (String)mapresult.get("NATIONALINFO");
	        sDupInfo			= (String)mapresult.get("DI");
	        sConnInfo		= (String)mapresult.get("CI");
	        sMobileNo		= (String)mapresult.get("MOBILE_NO");
	        sMobileCo		= (String)mapresult.get("MOBILE_CO");

	       log.error("mapresult >>>>>>>>>>> : " + mapresult);

	        String session_sRequestNumber = (String)session.getAttribute("REQ_SEQ");
	        if(!sRequestNumber.equals(session_sRequestNumber))
	        {
	            sMessage = "세션값이 다릅니다. 올바른 경로로 접근하시기 바랍니다.";
	            sResponseNumber = "";
	            sAuthType = "";
	        }
	    }
	    else if( iReturn == -1)
	    {
	        sMessage = "복호화 시스템 에러입니다.";
	    }
	    else if( iReturn == -4)
	    {
	        sMessage = "복호화 처리오류입니다.";
	    }
	    else if( iReturn == -5)
	    {
	        sMessage = "복호화 해쉬 오류입니다.";
	    }
	    else if( iReturn == -6)
	    {
	        sMessage = "복호화 데이터 오류입니다.";
	    }
	    else if( iReturn == -9)
	    {
	        sMessage = "입력 데이터 오류입니다.";
	    }
	    else if( iReturn == -12)
	    {
	        sMessage = "사이트 패스워드 오류입니다.";
	    }
	    else
	    {
	        sMessage = "알수 없는 에러 입니다. iReturn : " + iReturn;
	    }

        MemberVO memberVO = null;

        if (sName != null && sDupInfo != null) {
        	memberVO = new MemberVO();
        	memberVO.setPassword(sDupInfo);
        	memberVO.setUserPin(sDupInfo);
        	memberVO.setUserNm(sName);

        	if (sMobileNo != null) {
        		if (sMobileNo.length() == 10) {
        			sMobileNo = sMobileNo.substring(0, 3) + "-" + sMobileNo.substring(3, 6) + "-" +sMobileNo.substring(6, 10);
        		}
        		else {
        			sMobileNo = sMobileNo.substring(0, 3) + "-" + sMobileNo.substring(3, 7) + "-" +sMobileNo.substring(7, 11);
        		}
        	}

        	if(sBirthDate != null){
    			if (sBirthDate.length() == 8) sBirthDate = sBirthDate.substring(0, 4) + "-" + sBirthDate.substring(4, 6) + "-" +sBirthDate.substring(6, 8);
        	}

        	if(sGender != null){
        		if("1".equals(sGender)) sGender = "M";
        		if("2".equals(sGender)) sGender = "F";
        	}

        	memberVO.setUserCpno(sMobileNo);
        	memberVO.setBrthdy(sBirthDate);
        	memberVO.setSexCd(sGender);
        }
        log.error("memberVO >>>>>>>>>>>1 : " + memberVO);

		return memberVO;
	}

	public String requestReplace (String paramValue, String gubun) {

        String result = "";

        if (paramValue != null) {

        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");

        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");

        	if(!gubun.equals("encodeData")){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
            paramValue = paramValue.replaceAll("=", "");
        	}

        	result = paramValue;

        }
        return result;
	}

}
