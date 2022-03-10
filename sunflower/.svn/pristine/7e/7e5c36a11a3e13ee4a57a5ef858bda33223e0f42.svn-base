package site.unp.cms.service.verify;

import java.net.URLDecoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import Kisinfo.Check.IPINClient;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.cms.domain.MemberVO;

import org.springframework.beans.factory.annotation.Value;

@Component
public class IpinVerificationStrategy implements VerificationStrategy {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Value("#{prop['ipin.verificationCode']}") private String iSiteCode;
	@Value("#{prop['ipin.verificationPwd']}") private String iSitePassword;
	@Value("#{prop['Globals.ucms.domain']}") private String siteUrl;

	@Override
	public void request(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();

/*
		┌ sReturnURL 변수에 대한 설명  ─────────────────────────────────────────────────────
			NICE평가정보 팝업에서 인증받은 사용자 정보를 암호화하여 귀사로 리턴합니다.
			따라서 암호화된 결과 데이타를 리턴받으실 URL 정의해 주세요.

			* URL 은 http 부터 입력해 주셔야하며, 외부에서도 접속이 유효한 정보여야 합니다.
			* 당사에서 배포해드린 샘플페이지 중, ipin_process.jsp 페이지가 사용자 정보를 리턴받는 예제 페이지입니다.

			아래는 URL 예제이며, 귀사의 서비스 도메인과 서버에 업로드 된 샘플페이지 위치에 따라 경로를 설정하시기 바랍니다.
			예 - http://www.test.co.kr/ipin_process.jsp, https://www.test.co.kr/ipin_process.jsp, https://test.co.kr/ipin_process.jsp
		└────────────────────────────────────────────────────────────────────
*/
		boolean secure = request.isSecure(); // true : https
		String protocol = "http";
		if(secure){
			protocol = "https";
		}
		String sReturnURL = protocol +"://"+ siteUrl +"/"+ param.getString("siteId") +"/member/user/vnameIPINForward.do?menuNo="+ param.getString("menuNo") +"&authTp="+ param.getString("authTp") +"&retUrl="+ URLDecoder.decode(param.getString("retUrl",""),"UTF-8");

/*
		┌ sCPRequest 변수에 대한 설명  ─────────────────────────────────────────────────────
			[CP 요청번호]로 귀사에서 데이타를 임의로 정의하거나, 당사에서 배포된 모듈로 데이타를 생성할 수 있습니다.

			CP 요청번호는 인증 완료 후, 암호화된 결과 데이타에 함께 제공되며
			데이타 위변조 방지 및 특정 사용자가 요청한 것임을 확인하기 위한 목적으로 이용하실 수 있습니다.

			따라서 귀사의 프로세스에 응용하여 이용할 수 있는 데이타이기에, 필수값은 아닙니다.
		└────────────────────────────────────────────────────────────────────
*/
		String sCPRequest = "";

		// 객체 생성
		IPINClient pClient = new IPINClient();

		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
		sCPRequest = pClient.getRequestNO(iSiteCode);

		// CP 요청번호를 세션에 저장합니다.
		// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
		// 필수사항은 아니며, 보안을 위한 권고사항입니다.
		session.setAttribute("CPREQUEST", sCPRequest);

		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		int iRtn = pClient.fnRequest(iSiteCode, iSitePassword, sCPRequest, sReturnURL);

		String sRtnMsg					= "";			// 처리결과 메세지
		String sEncData					= "";			// 암호화 된 데이타

		// Method 결과값에 따른 처리사항
		if (iRtn == 0)
		{
			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
			sEncData = pClient.getCipherData();		//암호화 된 데이타
			sRtnMsg = "정상 처리되었습니다.";
			model.addAttribute("sEncIpinData", sEncData);
		}
		else if (iRtn == -1 || iRtn == -2)
		{
			sRtnMsg =	"배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.<BR>" +
						"귀사 서버환경에 맞는 모듈이 없다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		}
		else if (iRtn == -9)
		{
			sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		}
		else
		{
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
		}
		model.addAttribute("sRtnMsg", sRtnMsg);
	}

	@SuppressWarnings("unused")
	@Override
	public MemberVO response(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();


		// 사용자 정보 및 CP 요청번호를 암호화한 데이타입니다.
	    String sResponseData = requestReplace(request.getParameter("enc_data"), "encodeData");

	    // CP 요청번호 : ipin_main.jsp 에서 세션 처리한 데이타
	    String sCPRequest = (String)session.getAttribute("CPREQUEST");

	    // 객체 생성
		IPINClient pClient = new IPINClient();

/*
		┌ 복호화 함수 설명  ──────────────────────────────────────────────────────────
			Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.

			fnResponse 함수는 결과 데이타를 복호화 하는 함수이며,
			'sCPRequest'값을 추가로 보내시면 CP요청번호 일치여부도 확인하는 함수입니다. (세션에 넣은 sCPRequest 데이타로 검증)

			따라서 귀사에서 원하는 함수로 이용하시기 바랍니다.
		└────────────────────────────────────────────────────────────────────
*/
		int iRtn = pClient.fnResponse(iSiteCode, iSitePassword, sResponseData);
		//int iRtn = pClient.fnResponse(sSiteCode, sSitePw, sResponseData, sCPRequest);

		String sRtnMsg				= "";							// 처리결과 메세지
		String sVNumber				= pClient.getVNumber();			// 가상주민번호 (13자리이며, 숫자 또는 문자 포함)
		String sName				= pClient.getName();			// 이름
		String sDupInfo				= pClient.getDupInfo();			// 중복가입 확인값 (DI - 64 byte 고유값)
		String sAgeCode				= pClient.getAgeCode();			// 연령대 코드 (개발 가이드 참조)
		String sGenderCode			= pClient.getGenderCode();		// 성별 코드 (개발 가이드 참조)
		String sBirthDate			= pClient.getBirthDate();		// 생년월일 (YYYYMMDD)
		String sNationalInfo		= pClient.getNationalInfo();	// 내/외국인 정보 (개발 가이드 참조)
		String sCPRequestNum		= pClient.getCPRequestNO();		// CP 요청번호

		// Method 결과값에 따른 처리사항
		if (iRtn == 1)
		{
			/*다음과 같이 사용자 정보를 추출할 수 있습니다.
			사용자에게 보여주는 정보는, '이름' 데이타만 노출 가능합니다.

			사용자 정보를 다른 페이지에서 이용하실 경우에는
			보안을 위하여 암호화 데이타(sResponseData)를 통신하여 복호화 후 이용하실것을 권장합니다. (현재 페이지와 같은 처리방식)

			만약, 복호화된 정보를 통신해야 하는 경우엔 데이타가 유출되지 않도록 주의해 주세요. (세션처리 권장)
			form 태그의 hidden 처리는 데이타 유출 위험이 높으므로 권장하지 않습니다.*/

			// 사용자 인증정보에 대한 변수
			/*System.out.println("가상주민번호 : " + sVNumber + "<BR>");
			System.out.println("이름 : " + sName + "<BR>");
			System.out.println("중복가입 확인값 (DI) : " + sDupInfo + "<BR>");
			System.out.println("연령대 코드 : " + sAgeCode + "<BR>");
			System.out.println("성별 코드 : " + sGenderCode + "<BR>");
			System.out.println("생년월일 : " + sBirthDate + "<BR>");
			System.out.println("내/외국인 정보 : " + sNationalInfo + "<BR>");
			System.out.println("CP 요청번호 : " + sCPRequestNum + "<BR>");
			System.out.println("***** 복호화 된 정보가 정상인지 확인해 주시기 바랍니다.<BR><BR><BR><BR>");*/

			sRtnMsg = "정상 처리되었습니다.";
		}
		else if (iRtn == -1 || iRtn == -4)
		{
			sRtnMsg =	"iRtn 값, 서버 환경정보를 정확히 확인하여 주시기 바랍니다.";
		}
		else if (iRtn == -6)
		{
			sRtnMsg =	"당사는 한글 charset 정보를 euc-kr 로 처리하고 있으니, euc-kr 에 대해서 허용해 주시기 바랍니다.<BR>" +
						"한글 charset 정보가 명확하다면 ..<BR><B>iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.</B>";
		}
		else if (iRtn == -9)
		{
			sRtnMsg = "입력값 오류 : fnResponse 함수 처리시, 필요한 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		}
		else if (iRtn == -12)
		{
			sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
		}
		else if (iRtn == -13)
		{
			sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
		}
		else
		{
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 전산 담당자에게 문의해 주세요.";
		}

        MemberVO memberVO = null;

        if (sName != null && sDupInfo != null) {
        	memberVO = new MemberVO();
        	memberVO.setPassword(sDupInfo);
        	memberVO.setUserPin(sDupInfo);
        	memberVO.setUserNm(sName);

        	if(sBirthDate != null){
    			if (sBirthDate.length() == 8) sBirthDate = sBirthDate.substring(0, 4) + "-" + sBirthDate.substring(4, 6) + "-" +sBirthDate.substring(6, 8);
        	}

        	if(sGenderCode != null){
        		if("1".equals(sGenderCode)) sGenderCode = "M";
        		if("2".equals(sGenderCode)) sGenderCode = "F";
        	}

        	memberVO.setBrthdy(sBirthDate);
        	memberVO.setSexCd(sGenderCode);
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
