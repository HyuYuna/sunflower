package site.unp.cms.service.member.impl;


import java.io.Serializable;
import java.net.URLDecoder;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base32;
import org.apache.commons.lang.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.conf.PasswordEncrypter;
import site.unp.cms.dao.member.MemberDAO;
import site.unp.cms.dao.siteManage.SiteInfoDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.listener.member.UserInfoPrtcListener;
import site.unp.cms.mail.AttachmentMessageSender;
import site.unp.cms.service.crypto.CryptoARIA;
import site.unp.cms.service.file.FileParser;
import site.unp.cms.service.member.UserMemberService;
import site.unp.cms.service.member.sec.SessionSavedRequestAwareAuthenticationHandler;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.cms.service.sys.PrhibtWrdDicaryService;
import site.unp.cms.service.verify.GoogleOtp;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.service.sec.UnpUserDetails;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.AES256Util;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
    countQueryId="countUserMember",
    listQueryId="findAllUserMember",
    viewQueryId="findOneUserMember",
    deleteQueryId="deleteUserMember",
    updateQueryId="updateUserMember",
    insertQueryId="saveUserMember",
    sqlDaoRef="memberDAO",
    pageQueryData="userTyCd,sttusCd,searchCnd,searchCnd1,searchCnd2,searchCnd3,searchCnd4,searchCnd5,searchWrd,searchWrd2,sdate,edate,sdate1,edate1,menuNo,orderName,orderBdate,now,chGroup,chAction,pageUnit",
    listenerAndMethods={
        "userInitParamListener=insert,update,updateMy",
        "userTyCdListener=list,forInsert,forUpdate,view",
        "crtfcSeCdListener=list,forInsert,forUpdate,view",
        "sttusCdListener=list,forInsert,forUpdate,view",
        "sexCdListener=list,forInsert,forUpdate,view,joinInput,forUpdateMy",
        "userInfoPrtcListener=forUpdate,view",
        "telno1CdListener=forInsert,forUpdate,joinInput,forUpdateMy",
        "cpno1CdListener=forInsert,forUpdate,joinInput,forUpdateMy",
        "emadCdListener=forInsert,forUpdate,joinInput,forUpdateMy,joinVerify,idPwdSearch"
    }
)
@CommonServiceLink(desc="통합회원관리", linkType=LinkType.BOS)
@Service
public class UserMemberServiceImpl extends MemberServiceImpl implements Serializable, UserMemberService {

    private final Logger log = LoggerFactory.getLogger(this.getClass());

    @Resource(name="googleOtp")
	private GoogleOtp googleOtp;
    
    @Resource(name="siteInfoDAO")
	private SiteInfoDAO siteInfoDAO;
    
    @Resource(name = "messageSender")
    private AttachmentMessageSender messageSender;

    @Resource(name = "siteInfoService")
    private SiteInfoService siteInfoService;

    @Resource(name="prhibtWrdDicaryService")
    private PrhibtWrdDicaryService prhibtWrdDicaryService;

    @Value("${Globals.ucms.webRootPath}")
    private String webRootPath;

    @Resource(name = "cryptoARIA")
    private CryptoARIA cryptoARIA;

    @Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;


    @Value("#{prop['Globals.ucms.siteSeCd']}") private String siteSeCd;

    private static final long serialVersionUID = 1L;

    private static final Random RANDOM = new SecureRandom();

    @CommonServiceLink(desc="회원정보수정", linkType=LinkType.USER)
    @Override
    public void forUpdateMy(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        //HttpSession session = paramCtx.getRequest().getSession();
        String siteId = param.getString("siteId");

        if (!SiteInfoService.BOS_SITE_ID.equals(siteId)) {
            MemberVO user = new MemberVO();

            //String authSessionKey = session.getAttribute(AUTH_SESSION_KEY) != null ? (String)session.getAttribute(AUTH_SESSION_KEY) : null;
            //param.put("authSessionKey", authSessionKey);

            //if (!StringUtils.hasText(authSessionKey)) {
                String chkPwd = param.getString("chkPwd");

                if (StringUtils.hasText(chkPwd)) {

                    param.put("username", user.getUserId());

                    ZValue vo = getSqlDao(MemberDAO.class).findOneUserMemberLoginInfo(param.getString("username"));
                    ZValue saltResult = sqlDao.findOne("findOneMemberLoginSaltInfo", param);

                    if (!passwordEncoder.isPasswordValid(vo.getString("password"), chkPwd,  saltResult.getString("salt"))) {

                        MVUtils.goUrl("/"+siteId+"/member/user/forUpdateConfirm.do?menuNo="+param.getString("menuNo"), "비밀번호가 일치하지 않습니다.", model);
                        return;
                    }
                }
                else {
                    MVUtils.goUrl("/"+siteId+"/member/user/forUpdateConfirm.do?menuNo="+param.getString("menuNo"), null, model);
                    return;
                }
            //}
            param.put("userId", user.getUserId());
            //session.setAttribute(AUTH_SESSION_KEY, "Y");
        }

        super.forUpdate(paramCtx);

    }
    @UnpJsonView
    public void pageUnitChange(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        
        String pageUnit = param.getString("pageUnit");
        
        if(pageUnit.equals("0")){
            pageUnit = "999999";
        }
        
        //param.put("pageUnit", param.getString("pageUnit"));
        model.addAttribute("pageUnit", pageUnit);
    }
    @Override
    public void insert(ParameterContext paramCtx) throws Exception {
        System.out.println("==========insert.do start");
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        
        // 아이디 유효성체크
        /*
        super.checkId(paramCtx);
        int idCnt = Integer.parseInt(model.get("idCnt").toString());
        if (idCnt > 0) {
            MVUtils.goUrl("javascript:history.back();", "중복된 아이디가 있습니다. 확인바랍니다.", model);
            return;
        }
        */
        String pwd =  param.getString("userPassword");
        String pwd2 = PasswordEncrypter.encrypt(pwd);

        param.put("userPassword",pwd2);

        super.insert(paramCtx);
        
        param.put("logCate", "권한 부여");
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        param.put("regUserLevel", user.getAuthorCd());
        sqlDao.save("insertUserLog", param);

        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/list.do?menuNo=100017", "회원등록이 완료되었습니다.", model);

    }

    @Override
	@UnpJsonView
    public void checkId(ParameterContext paramCtx) throws Exception {
        System.out.println("======checkId");
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        model.addAttribute("cnt", sqlDao.count("countUserMemberByUserId", param));
    }

    //사용자 회원 수정
    @Override
    public void updateMy(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        param = userInfoEncode(param);
        super.updateMy(paramCtx);

        ModelMap model = paramCtx.getModel();
        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/forUpdateMy.do?menuNo="+param.getString("menuNo"), "수정되었습니다.", model);
    }

    //사용자 회원 삭제
    @Override
    public void deleteUser(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        ModelMap model = paramCtx.getModel();
        sqlDao.deleteOne("deleteUserMember", param);
        
        param.put("logCate", "권한 삭제");
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        param.put("regUserLevel", user.getAuthorCd());
        sqlDao.save("insertUserLog", param);
        
        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/list.do?menuNo="+param.getString("menuNo"), "삭제되었습니다.", model);
    }
    
    //사용자 비밀번호 초기화
    @UnpJsonView
    public void pwInit(ParameterContext paramCtx) throws Exception{
        ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ModelMap model = paramCtx.getModel();
        
        param.put("initPW", PasswordEncrypter.encrypt(param.getString("userId") + param.getString("pattern")));
        
        sqlDao.modify("initPW", param);
    }
    /**
     * 약관 및 개인정보수집 동의 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="회원가입", linkType=LinkType.USER)
    public void joinAgre(ParameterContext paramCtx) throws Exception {
    }

    /**
     * 회원가입방식선택 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void joinSelect(ParameterContext paramCtx) throws Exception {
    }

    /**
     * 정보입력 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void joinInput(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        String goUrl = "";
        String siteId = param.getString("siteId");

        model.addAttribute("member", member);

    }

    /**
     * 정보입력 완료
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void joinFinish(ParameterContext paramCtx) throws Exception {
        SecurityContextHolder.clearContext();
    }


    /**
     * 로그인 페이지
     * @param paramCtx
     * @throws Exception
     */
    @CommonServiceLink(desc="로그인", linkType=LinkType.USER)
    @Override
    public void forLogin(ParameterContext paramCtx) throws Exception {

        ZValue param = paramCtx.getParam();
        param.put("authTp", "L");

        if("1".equals(siteSeCd) || "3".equals(siteSeCd)){
            phoneVerificationStrategy.request(paramCtx);
            ipinVerificationStrategy.request(paramCtx);
        }
    }

    /**
     * 로그인 체크
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void toLogin(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        HttpServletRequest request = paramCtx.getRequest();
        HttpSession session = request.getSession();

        String username = param.getString("username");
        String drmncyIdUseAt = param.getString("drmncyIdUseAt");
        // 휴면아이디 해제라면 세션에서 아이디 가져오기
        if (drmncyIdUseAt.equals("Y")) {
            username = session.getAttribute("drmncyId")!=null ? session.getAttribute("drmncyId").toString() : "";
            param.put("username", username);
        }
        String password = param.getString("password");
        String jMeter = param.getString("jMeter");


        Assert.hasText(username);
        Assert.hasText(password);


        String pwd = "";
        String siteId = param.getString("siteId");
        request.setAttribute("siteId", siteId);

        String goUrl = "/"+siteId+"/member/user/forLogin.do?menuNo="+param.getString("menuNo");
        param.put("siteId", siteId);

        /*if (!loginHistoryAuthenticationFailureHandler.checkLoginHistory(paramCtx.getRequest(), param)) {
            //MVUtils.goUrl(goUrl,"비밀번호 5회틀릴시 30분동안 로그인할수 없습니다.", model);
            session.setAttribute("userId", username);
            model.addAttribute(ModelAndViewResolver.GO_URL_KEY, "/"+siteId+"/member/user/pwdError.do?menuNo="+param.getString("menuNo"));
            return;
        }*/

        ZValue result = sqlDao.findOne("findOneUserMemberLoginInfo", param);
        if (result==null){
/*          String drmncyId = session.getAttribute("drmncyId")!=null ? session.getAttribute("drmncyId").toString() : "";
            if (drmncyId.equals("")){

            }*/
            /**
             * 휴면 계정인지 확인하여 휴면 계정이면 안내페이지로 이동후 다시 로그인 유도...
             */
            result = sqlDao.findOne("findOneUserDrmncyMemberLoginInfo", param);
            if (result!=null){
                if (!drmncyIdUseAt.equals("Y")){
                    session.setAttribute("drmncyId", username);
                    //"회원님은 현재 1년동안 서비스를 이용하지 않아 휴면상태에 있습니다."
                    MVUtils.goUrl("/"+siteId+"/member/user/drmncyIdInfo.do?menuNo="+param.getString("menuNo"), null, model);
                    return;
                }
            }
        }

        ZValue saltResult = sqlDao.findOne("findOneMemberLoginSaltInfo", param);
        boolean failure = false;
        if (result != null) {

            pwd = result.getString("password");

            if (!passwordEncoder.isPasswordValid(pwd, password,  saltResult.getString("salt"))) {
                failure = true;
            }else {
                if (!"T".equals(result.getString("sttusCd"))) {
                    String confmMsg = "회원가입이 승인대기 중입니다.";
                    if ("F".equals(result.getString("sttusCd"))) confmMsg = "회원가입이 미승인 되었습니다.";

                    MVUtils.goUrl(goUrl, confmMsg, model);
                    return;
                }
            }
        }
        else {
            failure = true;
        }

        if (failure) {
            model.addAttribute(RESULT_CODE_KEY, ERROR);
            paramCtx.getRequest().setAttribute("siteId", param.getString("siteId"));
            loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "N");
            MVUtils.goUrl(goUrl, "아이디 혹은 비밀번호가 일치하지 않습니다.", model);
            return;
        } else {
            // 휴면 계정에서 로그인 성공시 휴면테이블에서 회원 테이블로 이관한다.
            if (drmncyIdUseAt.equals("Y")){
                sqlDao.save("saveDrmncyToUserInfo", result);//휴면테이블에서 회원 테이블로 이관

                sqlDao.deleteOne("deleteUserDrmncyById", result); //  휴면테이블에서 삭제 처리
                session.setAttribute("drmncyId", null);
            }

            loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "Y");
        }

        SavedRequest savedRequest = session.getAttribute("SPRING_SECURITY_SAVED_REQUEST")!=null ? (SavedRequest)session.getAttribute("SPRING_SECURITY_SAVED_REQUEST") : null;
        String url = (String)session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
        if (StringUtils.hasText(url)) {
            if (url.indexOf("/join") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
            if (url.indexOf("/forLogin") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
        }
        if (savedRequest != null) {
            if (savedRequest.getRedirectUrl().indexOf("/bos/") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "/"+siteId+"/main/main.do");
        }
        if (session != null) session.removeAttribute(AUTH_SESSION_KEY);

        HashMap<String, String> map = new HashMap<String, String>();
        map.put("username", param.getString("username"));
        //map.put("password", password);
        map.put("password", passwordEncoder.encodePassword(password,saltResult.getString("salt")));

        // 비밀번호 변경을 6개월 동안 하지 않았을 경우, 3개월마다 비밀번호 변경 유도 화면으로 이동
        if (result.getInt("passwordChangeAt")==1 && result.getInt("passwordDeriveAt")==1){
            MemberVO memberVO = new MemberVO();
            memberVO.setUserSn(result.getLong("userSn"));
            memberVO.setUserId(param.getString("username"));
            memberVO.setPassword(password);
            memberVO.setUserNm(result.getString("userNm"));
          //  memberVO.setChldCrtfcAt("N");   // 14세 미만 회원
            memberVO.setAuthorCd("ROLE_USERKEY");
            setAuthentication2(memberVO, request);

            // 비밀번호 변경유도 일시
            param.put("userId", param.getString("username"));
            sqlDao.save("updateUserMemberPasswordDeriveDt", param);

            goUrl = savedRequest == null  ? "/"+siteId+"/member/user/pwdChange.do?menuNo=300086&deriveAt=Y" : savedRequest.getRedirectUrl();

            MVUtils.goUrlHidden(map, goUrl, "회원님은 장기간 비밀번호를 변경하지 않고 사용중입니다. 비밀번호 변경 화면으로 이동합니다.", model);
            return;
        }

        if("Y".equals(jMeter)){

            MemberVO memberVO = new MemberVO();
            memberVO.setUserSn(result.getLong("userSn"));
            memberVO.setUserId(param.getString("username"));
            memberVO.setPassword(password);
            memberVO.setUserNm(result.getString("userNm"));
          //  memberVO.setChldCrtfcAt("N");   // 14세 미만 회원
            memberVO.setAuthorCd("ROLE_USERKEY");
            setAuthentication2(memberVO, request);

            goUrl = savedRequest == null  ? "/"+siteId+"/main/main.do" : savedRequest.getRedirectUrl();

            MVUtils.goUrlHidden(map, goUrl, "로그인 되었습니다.", model);

        }else{
            MVUtils.goUrlHidden(map, "/"+siteId+"/login.do", "로그인 되었습니다.", model);
        }
    }

    /**
     * 휴면아이디 안내 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void drmncyIdInfo(ParameterContext paramCtx) throws Exception {

    }

    /**
     * 아이디/비밀번호 찾기 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="아이디/비밀번호 찾기", linkType=LinkType.USER)
    public void idPwdSearch(ParameterContext paramCtx) throws Exception {
    }

    /**
     * 본인확인 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void joinVerify(ParameterContext paramCtx) throws Exception {

        ZValue param = paramCtx.getParam();
        param.put("authTp", "A");
        param.put("retUrl", "/"+param.getString("siteId")+"/member/user/joinInput.do?menuNo="+param.getString("menuNo"));
        phoneVerificationStrategy.request(paramCtx);
        ipinVerificationStrategy.request(paramCtx);

    }

    /**
     * 휴대폰 본인인증 화면 호출
     * @param request
     * @param model
     * @throws Exception
     */
    @Override
	public void vnamePhoneForward(ParameterContext paramCtx) throws Exception{

        ZValue param = paramCtx.getParam();
        param.put("crtfcSeCd", "HP");
        this.vnameOutput(paramCtx);
    }

    /**
     * IPIN 인증 화면 호출
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void vnameIPINForward(ParameterContext paramCtx) throws Exception {

        ZValue param = paramCtx.getParam();
        param.put("crtfcSeCd", "IP");
        this.vnameOutput(paramCtx);
    }

    /**
     * 실명인증 처리
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void vnameOutput(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        HttpServletRequest request= paramCtx.getRequest();
        HttpSession session = request.getSession();

        MemberVO memberVO = new MemberVO();
        String siteId = param.getString("siteId");
        String crtfcSeCd = param.getString("crtfcSeCd");
        String userTyCd = param.getString("userTyCd");
        String authTp = param.getString("authTp");
        String goUrl = "";
        long userPinCnt = 0;
        ZValue userPinResult = null;
        SavedRequest savedRequest = (SavedRequest)session.getAttribute("SPRING_SECURITY_SAVED_REQUEST");

        String url= (String) session.getAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL);
        if (StringUtils.hasText(url)) {
            if (url.indexOf("/join") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
            if (url.indexOf("/forLogin") != -1) session.setAttribute(SessionSavedRequestAwareAuthenticationHandler.TARGET_URL, "");
        }

        String errUrl = "";
        if("A".equals(authTp)) errUrl = MEMBER_URL;
        else if("L".equals(authTp)) errUrl = LOGIN_URL;
        else if("I".equals(authTp)) errUrl = IDSEARCH_URL;
        else if("P".equals(authTp)) errUrl = PWDSEARCH_URL;
        else errUrl = "/";

        String retUrl = URLDecoder.decode(param.getString("retUrl",""),"UTF-8");
        retUrl = retUrl.replaceAll("&amp;", "&");

        boolean authBoolean = false;
        boolean memberBoolean = false;

        switch(crtfcSeCd) {
            case "HP" :
                memberVO = phoneVerificationStrategy.response(paramCtx);
                if (StringUtils.hasText(memberVO.getUserPin())) authBoolean = true;
                break;
            case "IP" :
                memberVO = ipinVerificationStrategy.response(paramCtx);
                if (StringUtils.hasText(memberVO.getUserPin())) authBoolean = true;
                break;
            default :
                authBoolean = true;
                memberVO.setUserPin("test_"+FileParser.getTimeStamp());
                memberVO.setUserNm("testNm_"+FileParser.getTimeStamp());
                break;
        }

        String chldCrtfcAt = param.getString("chldCrtfcAt");
        //String userNm = resultVO.getString("userNm");
        //String brthdy = resultVO.getString("brthdy");
        //String sexCd = resultVO.getString("sexCd");

        // 만 14세 미만회원
        if ("Y".equals(chldCrtfcAt)) {
            //userNm = param.getString("chldUserNm");
            //brthdy = param.getString("chldBrthdy");
            //sexCd = param.getString("chldSexCd");
        }

        String userId = param.getString("userId");
        String authorCd = "ROLE_VNAME";

        if (StringUtils.hasText(userId)) memberVO.setUserId(userId);

        memberVO.setAuthorCd(authorCd);
     //   memberVO.setCrtfcSeCd(crtfcSeCd);
     //   memberVO.setChldCrtfcAt("".equals(chldCrtfcAt) ? "N" : chldCrtfcAt);
    //    memberVO.setUserTyCd("".equals(memberVO.getUserTyCd()) ? userTyCd : memberVO.getUserTyCd());


        if (authBoolean) {

            if("A".equals(authTp) || "I".equals(authTp) || "P".equals(authTp)){                                             // 회원가입, ID찾기, PASSWORD 찾기 일 경우 회원정보 조회
                //userPinCnt = getSqlDao(MemberDAO.class).countUserMemberByUserPinId(memberVO.getUserPin());
                userPinResult = getSqlDao(MemberDAO.class).findOneUserMemberByUserPinInfo(memberVO.getUserPin());
            }

            // 회원가입을 위한 실명인증 시 해당 인증키값으로 가입한 회원정보가 있는지 조회를 한다.
            if("A".equals(authTp)){                                                                                         // 회원가입
                goUrl = retUrl;
                if (userPinResult != null) memberBoolean = false;
                else memberBoolean = true;
            }else if("I".equals(authTp)){                                                                                       // ID찾기
                goUrl = retUrl;
                if (userPinResult == null) memberBoolean = false;
                else memberBoolean = true;
            }else if("P".equals(authTp)){                                                                                       // PASSWORD찾기
                goUrl = retUrl;
                if (userPinResult == null) memberBoolean = false;
                else memberBoolean = true;
            }else{                                                                                                          // 로그인
                goUrl = savedRequest == null  ? "/": savedRequest.getRedirectUrl();
                memberBoolean = true;
            }

            if(memberBoolean){

                // userPin값 중복체크
                if (StringUtils.hasText(memberVO.getUserPin())) {

                    ZValue memberZvl = getSqlDao(MemberDAO.class).findOneUserMemberByUserPin(memberVO.getUserPin());

                    // userPin값이 없으면 TM_USER_PIN 테이블에 등록
                    if (memberZvl == null) {

                        ZValue userVO = new ZValue();
                        userVO.put("userNm", memberVO.getUserNm());
                   //     userVO.put("brthdy", memberVO.getBrthdy());
                    //    userVO.put("sexCd", memberVO.getSexCd());
                     //   userVO.put("userPin",memberVO.getUserPin());
                      //  userVO.put("crtfcSeCd", memberVO.getCrtfcSeCd());
                       // userVO.put("chldCrtfcAt", memberVO.getChldCrtfcAt());
                       // userVO.put("siteSeCd", siteSeCd);

                        sqlDao.save("saveUserMemberUserPin", userVO);
                        Object userKey = userVO.getString("userSn");
                        memberVO.setUserSn(Long.parseLong(userKey.toString()));

                    }else{
                        memberVO.setUserSn(memberZvl.getLong("userSn"));
                        if(userPinResult != null){
                            memberVO.setUserId(userPinResult.getString("userId"));
                        }
                    }
                    setAuthentication(memberVO, request);
                    MVUtils.winCloseRealNameLocation(goUrl, "인증에 성공하였습니다.", model);
                }else{

                    MVUtils.winCloseRealNameLocation(errUrl, "인증에 실패하였습니다.", model);
                    return;
                }

            }else{

                if("I".equals(authTp) || "P".equals(authTp)){
                    MVUtils.winCloseRealNameLocation(errUrl, "가입하신 정보가 없습니다. 확인후 다시 이용하시기 바랍니다.", model);
                    return;
                }else{
                    MVUtils.winCloseRealNameLocation(errUrl, "이미 등록된 회원입니다. 확인후 다시 이용하시기 바랍니다.", model);
                    return;
                }
            }
        }
        else {
            this.vnameFail(paramCtx);
        }

    }

    @Override
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

    @Override
	public void setAuthentication2(MemberVO vo, HttpServletRequest request) {
        List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
        SimpleGrantedAuthority vnameAuthority = new SimpleGrantedAuthority("ROLE_USERKEY");
        SimpleGrantedAuthority vnameAuthority2 = new SimpleGrantedAuthority("ROLE_VNAME");
        authorities.add(vnameAuthority);
        authorities.add(vnameAuthority2);
        SecurityContext securityContext = SecurityContextHolder.getContext();
        UnpUserDetails userDetail = new UnpUserDetails(String.valueOf(vo.getUserSn()), vo.getPassword(), true, vo);
        securityContext.setAuthentication(new UsernamePasswordAuthenticationToken(userDetail,String.valueOf(vo.getUserSn()), authorities));
        HttpSession session =  request.getSession();
        session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
    }


    @Override
	public void vnameFail(ParameterContext paramCtx) throws Exception{

        log.error("인증에 실패하였습니다.");
        ModelMap model = paramCtx.getModel();
        model.addAttribute(ModelAndViewResolver.MSG_KEY, "인증에 실패하였습니다.");
        model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
    }
    /**
     * 아이디 찾기 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="아이디 찾기", linkType=LinkType.USER)
    public void idSearch(ParameterContext paramCtx) throws Exception {

        ZValue param = paramCtx.getParam();
        param.put("authTp", "I");
        param.put("retUrl", "/"+param.getString("siteId")+"/member/user/idSearchFinish.do?menuNo="+param.getString("menuNo"));

        if("1".equals(siteSeCd) || "3".equals(siteSeCd)){
            phoneVerificationStrategy.request(paramCtx);
            ipinVerificationStrategy.request(paramCtx);
        }
    }

    /**
     * 아이디 찾기 결과 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void idSearchFinish(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        if (member != null) {
            String userPin = member.getUserPin();
            param.put("userPin", userPin);
            ZValue result = getSqlDao(MemberDAO.class).idSearchFinish(userPin);
            if (result==null){
                // 없을 경우 휴면계정에서 찾기
                result = sqlDao.findOne("idSearchFinishDrmncy", param);
            }
            model.addAttribute("result", result);
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * 비밀번호 찾기 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="비밀번호 찾기", linkType=LinkType.USER)
    public void pwdSearch(ParameterContext paramCtx) throws Exception {

        ZValue param = paramCtx.getParam();
        param.put("authTp", "P");
        param.put("retUrl", "/"+param.getString("siteId")+"/member/user/pwdSearchInput.do?menuNo="+param.getString("menuNo"));

        if("1".equals(siteSeCd) || "3".equals(siteSeCd)){
            phoneVerificationStrategy.request(paramCtx);
            ipinVerificationStrategy.request(paramCtx);
        }
    }

    /**
     * 비밀번호 찾기 결과 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void pwdSearchInput(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        if (member != null) {
            String userPin = member.getUserPin();
            param.put("userPin", userPin);
            ZValue result = getSqlDao(MemberDAO.class).idSearchFinish(userPin);
            if (result==null){
                // 없을 경우 휴면계정에서 찾기
                result = sqlDao.findOne("idSearchFinishDrmncy", param);
            }
            model.addAttribute("result", result);
        }
    }


    /**
     * 아이디 찾기 결과 페이지 json
     * @param paramCtx
     * @throws Exception
     */
    @Override
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
            param = userInfoEncode(param);
            userNm = param.getString("userNm");
            userEmad = param.getString("userEmad");
            Assert.hasText(userNm);
            Assert.hasText(userEmad);
        }

        ZValue result = getSqlDao(MemberDAO.class).idPwdSearchRequest(userNm, "", userEmad, userPin);

        if (result != null) {
            model.addAttribute("result", result);
            MVUtils.goUrl("/ucms/member/user/idSearch.do?menuNo="+param.getString("menuNo"), "요청하신 정보는 다음과 같습니다.\n 아이디 :" + result.getString("userId") + "입니다.", model);
        }
        else {
            MVUtils.goUrl("/ucms/member/user/idSearch.do?menuNo="+param.getString("menuNo"), "일치하는 정보가 없습니다.", model);
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * 비밀번호 변경 페이지
     * @param paramCtx
     * @throws Exception
     */
    @Override
    @CommonServiceLink(desc="비밀번호 변경", linkType=LinkType.USER)
    public void pwdChange(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        model.addAttribute("member", member);
    }

    @Override
	@UnpJsonView
    public void pwdChangeByUserSn(ParameterContext paramCtx) throws Exception {

        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        try{
            if (member != null) {

                String password = param.getString("password");

                long userSn =  member.getUserSn();
                String salt = RandomStringUtils.random(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
                String encodedSaltPassword = passwordEncoder.encodePassword(password, salt);

                getSqlDao(MemberDAO.class).updateUserMemberPasswordByUserSn(member.getUserSn(), encodedSaltPassword);

                // TM_USER_SALT 테이블에 SALT값 삭제후 등록
                getSqlDao(MemberDAO.class).deleteMemberSaltInfo(member.getUserId(), USER_SE);
                getSqlDao(MemberDAO.class).saveMemberSalfInfo(userSn, member.getUserId(), member.getUserNm(), USER_SE, salt);

                MVUtils.setResultProperty(model, SUCCESS, "비밀번호가 변경되었습니다.");

            }else {

                MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "일치하는 정보가 없습니다.");
            }
        }catch(Exception e){

            e.printStackTrace();
            MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "비밀번호 변경중 에러가 발생하였습니다.");
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * 회원탈퇴 페이지
     * @param paramCtx
     * @throws Exception
     */
    @CommonServiceLink(desc="회원탈퇴", linkType=LinkType.USER)
    @Override
    public void secsn(ParameterContext paramCtx) throws Exception {
        super.secsn(paramCtx);
    }

    //암호화
    @Override
	public ZValue userInfoEncode(ZValue param) throws Exception{
        AES256Util aes256Util = new AES256Util();

        //result.put("brthdy", aes256Util.aesDecode(result.getString("brthdy")));
        param.put("userAdres1", cryptoARIA.encryptData(param.getString("userAdres1")));
        param.put("userAdres2", cryptoARIA.encryptData(param.getString("userAdres2")));
        param.put("userTelno", cryptoARIA.encryptData(param.getString("userTelno")));
        param.put("userCpno", cryptoARIA.encryptData(param.getString("userCpno")));
        param.put("userEmad", cryptoARIA.encryptData(param.getString("userEmad")));

        return param;
    }

    //복호화
    @Override
	public ZValue userInfoDecode(ZValue result) throws Exception{
      /*
        AES256Util aes256Util = new AES256Util();
        result.put("userAdres1", cryptoARIA.decryptData(result.getString("userAdres1")));
        result.put("userAdres2", cryptoARIA.decryptData(result.getString("userAdres2")));
        result.put("userTelno", cryptoARIA.decryptData(result.getString("userTelno")));
        result.put("userCpno", cryptoARIA.decryptData(result.getString("userCpno")));
        result.put("userEmad", cryptoARIA.decryptData(result.getString("userEmad")));
        */
        return result;

    }

    //관리자 회원 뷰
    @Override
    public void view(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        String userId = param.getString("userId");
        Assert.hasText(userId);

        super.view(paramCtx);
        ZValue encResult =  (ZValue) model.get("result");
        ZValue result = userInfoDecode(encResult);
        model.addAttribute("result", result);

        param.put("readngPurpsSe", "개인정보(조회)");
        //개인정보 열람 기록때문에 파라미터 세팅
        param.put(UserInfoPrtcListener.READNG_USER_ID, userId);
    }

    //관리자 회원 뷰
    @Override
    public void forUpdate(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        String userId = param.getString("userId");
        Assert.hasText(userId);

        super.forUpdate(paramCtx);

        param.put("readngPurpsSe", "개인정보(수정)");
        //개인정보 열람 기록때문에 파라미터 세팅
        param.put(UserInfoPrtcListener.READNG_USER_ID, userId);
    }

    /**
     * 관리자 사용자 조회시 세션에 조회 권한 추가
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@UnpJsonView
    public void setCallUserId(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        String userId = param.getString("userId");
        Assert.hasText(userId);

        HttpSession session = paramCtx.getRequest().getSession();
        session.setAttribute(UserInfoPrtcListener.READNG_USER_ID + "_" + userId, userId);
        MVUtils.setResultProperty(model, SUCCESS, "정상처리 하였습니다.");

    }


	// 관리자 회원 수정
	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		System.out.println("============update//관리자회원수정");
		ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        System.out.println(user);

		if (param.getString("userPassword").equals("") || param.getString("userPassword") == null) {
			System.out.println("사용자 비밀번호 변경 안함");
		} else {
			System.out.println("사용자 비밀번호 변경, 암호화");
			// 비밀번호 변경한 경우에만 수정
			String pwd = param.getString("userPassword");
			if (StringUtils.hasText(pwd)) {
				String pwd2 = PasswordEncrypter.encrypt(pwd);
				param.put("userPassword", pwd2);
			}
		}

        super.update(paramCtx);
        
        if(param.getString("userState").equals("N")){
        	param.put("logCate", "퇴직 처리");
        } else {
        	param.put("logCate", "권한 변경");
        	param.put("regExiUserAuth", param.getString("exiUserLevel"));
        }
        
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        param.put("regUserLevel", user.getAuthorCd());
        System.out.println(param);
        sqlDao.save("insertUserLog", param);

        ModelMap model = paramCtx.getModel();
        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/view.do?menuNo="+param.getString("menuNo")+"&userId="+param.getString("userId"), "수정되었습니다.", model);
    }

    /**
     * 기존 비밀번호 체크
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@UnpJsonView
    public void pwdCheck(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue result = getSqlDao(MemberDAO.class).findOneUserMemberLoginInfo(member.getUserId());
        ZValue saltResult = sqlDao.findOne("findOneMemberLoginSaltInfo", param);

        if (!passwordEncoder.isPasswordValid(result.getString("password"), param.getString("password"), saltResult.getString("salt"))) {

            model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.ERROR);
        }
        else {
            model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
        }
    }

    @Override
	@UnpJsonView
    public void checkPrhibtWrd(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        param.put("word", param.getString("chkWord"));
        String word = prhibtWrdDicaryService.countWrdNm(paramCtx);
        String chkWord = "N";
        if (word != null) {
            chkWord = "Y";
            model.addAttribute("word", word);
        }
        model.addAttribute("chkWord", chkWord);
    }
    /**
     * 비밀번호 변경
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@UnpJsonView
    public void pwdChangeRequest(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        String salt = RandomStringUtils.random(12, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890");
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        String encodedPassword = passwordEncoder.encodePassword(param.getString("password"), salt);

        getSqlDao(MemberDAO.class).updatePassword(member.getUserId(), encodedPassword);

        // TM_USER_SALT 테이블에 SALT값 삭제후 등록
        getSqlDao(MemberDAO.class).deleteMemberSaltInfo(member.getUserId(), "U");
        getSqlDao(MemberDAO.class).saveMemberSalfInfo(member.getUserSn(), member.getUserId(), member.getUserNm(), "U", salt);


        model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
    }

    //사용자 목록
    @Override
    public void list(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        System.out.println("======list.do / 사용자 목록");

        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginCenterCode", member.getCenterCode());
        param.put("loginAuthorCd", member.getAuthorCd());

        super.list(paramCtx);
    }

    //사용자 입사정보
    @Override
    public void list2(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        System.out.println("======list2.do / 사용자 입사정보");

        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginCenterCode", member.getCenterCode());
        param.put("loginAuthorCd", member.getAuthorCd());

        super.list(paramCtx);
    }

  //잠금된 계정 목록
    @Override
    public void list_lock(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        System.out.println("======list_lock.do / 잠금된 계정 목록");
        
        param.put("loginCenterCode", member.getCenterCode());
        param.put("loginAuthorCd", member.getAuthorCd());
        

        super.doList(paramCtx, "selectLockedUser", "totalLockUser");
    }

    //사용자 로그인 기록
    @Override
    public void list_login(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        System.out.println("======list_login.do / 사용자 로그인 기록");

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        if("BM".equals(user.getString("userLevel"))) {
			param.put("loginCenterCode", user.getString("centerCode"));
		}

        super.doList(paramCtx, "selectUserLoginHistory", "totalUserLoginHistory");
    }

    //사용자 작업 기록
    @Override
    public void list_action(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        System.out.println("======list_action.do / 사용자 작업 기록");

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        if("BM".equals(user.getString("userLevel"))) {
			param.put("loginCenterCode", user.getString("centerCode"));
		}

        super.doList(paramCtx, "selectUserActionHistory", "countUserActionHistory");
    }

    //다운로드 이력관리
      @Override
      public void listDownload(ParameterContext paramCtx) throws Exception {
          ZValue param = paramCtx.getParam();
          System.out.println("======listDownload.do / 다운로드 이력관리");

          UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
          ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

          if("BM".equals(user.getString("userLevel"))) {
              param.put("loginCenterCode", user.getString("centerCode"));
          }
          param.put("shGroup", "DOWN");
          super.doList(paramCtx, "selectDownloadHistory", "countDownloadHistory");
      }
  //출력 이력 관리
    @Override
    public void listUserPrint(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        System.out.println("======listPrint.do / 출력 이력 관리");

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        if("BM".equals(user.getString("userLevel"))) {
            param.put("loginCenterCode", user.getString("centerCode"));
        }
        super.doList(paramCtx, "selectPrintHistory", "getPrintHistory");
    }


    @Override
	@UnpJsonView
    public void print(ParameterContext paramCtx, String type) throws Exception{
        System.out.println("======print.do type : " + type);
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();


        param.put("noLimit", "Y");
        List<ZValue> resultList = null;

        if(type == "listAction") {
            insertDownloadHistory(param, "사용자 작업 기록");
            resultList = sqlDao.findAll("selectUserActionHistory", param);
        }else if(type == "listDownload"){
            param.put("shGroup", "DOWN");
            insertDownloadHistory(param, "다운로드 이력관리");
            resultList = sqlDao.findAll("selectDownloadHistory", param);
        }else if(type == "listUserPrint"){
            insertDownloadHistory(param, "출력 이력관리");
            resultList = sqlDao.findAll("selectPrintHistory", param);
        }else if(type == "list_login"){
            insertDownloadHistory(param, "사용자 로그인 기록");
            resultList = sqlDao.findAll("selectUserLoginHistory", param);
        }else if(type=="userList"){
            insertDownloadHistory(param, "사용자 리스트");
            resultList = sqlDao.findAll("findAllUserMember", param);
        }else if(type=="userList2"){
            insertDownloadHistory(param, "사용자 입사정보");
            resultList = sqlDao.findAll("findAllUserMember", param);
        }else {
            
        }
        model.addAttribute("resultList", resultList);
    }
    
    @Override
    @UnpJsonView
    public void print(ParameterContext paramCtx) throws Exception{
        System.out.println("======print.do");
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();


        param.put("noLimit", "Y");
        List<ZValue> resultList = sqlDao.findAll("findAllUserMember", param);
        
        insertPrintHistory(param, "사용자 리스트", "");
        model.addAttribute("resultList", resultList);
    }
    
    @Override
    @UnpJsonView
    public void print2(ParameterContext paramCtx) throws Exception{
        System.out.println("======print2.do");
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();


        param.put("noLimit", "Y");
        List<ZValue> resultList = sqlDao.findAll("findAllUserMember", param);
        
        insertPrintHistory(param, "사용자 입사정보", "");
        model.addAttribute("resultList", resultList);
    }

    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="사용자 리스트 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "userList");
    }


    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="사용자 입사정보 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel2(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "userList2");
    }
    

    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="사용자 작업기록 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel3(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "listAction");
    }
    
    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="다운로드 이력관리 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel4(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "listDownload");
    }
    
    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="출력 이력관리 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel5(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "listUserPrint");
    }
    
    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="출력 이력관리 엑셀다운로드", linkType=LinkType.NONE)
    public void downloadExcel6(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "list_login");
    }


    @UnpJsonView
    public void unlockUser(ParameterContext paramCtx) throws Exception{
        ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        System.out.println("========계정 잠금해제 ");
        

        sqlDao.save("unlockUser", param);
        
        param.put("logCate", "패스워드 락 해제");
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        sqlDao.save("insertUserLog", param);
    }

    @Override
	@UnpJsonView
    public void changeUserPassword(ParameterContext paramCtx) throws Exception{
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	param.put("newPassword", PasswordEncrypter.encrypt((String) param.get("newPassword1")));
    	param.put("oldPassword", PasswordEncrypter.encrypt((String) param.get("oldPassword")));

    	//sqlDao.modify("updateUserPassword", param);
    	model.addAttribute("modCnt", sqlDao.modify("updateUserPassword", param));

	}
    
    //마이페이지 OTP 확인
    public void myPage(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	HttpSession session = paramCtx.getSession();
    	
    	ZValue siteInfoVO = siteInfoDAO.getSiteBySiteName(param.getString(SITE_ID));
    	String adtCrtfcUseAt = siteInfoVO.getString("adtCrtfcUseAt");
    	
    	MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	
    	//추가인증 Y이면 추가인증페이지로 이동
		if(adtCrtfcUseAt.equals("Y")) {
			session.setAttribute("username", member.getUserId());
			session.setAttribute("password", member.getPassword());
			session.setAttribute("userNm", member.getUserNm());
			
			MVUtils.goUrl("/bos/member/user/myPageOtp.do?menuNo=100275&viewType=CONTBODY", null, model);
		}else {
			MVUtils.goUrl("/bos/member/user/regMypage.do?menuNo=100275", null, model);
		}
    }

    //마이페이지 OTP 페이지
    public void myPageOtp(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		HttpServletRequest request = paramCtx.getRequest();
		HttpSession session = request.getSession();
		paramCtx.getRequest().setAttribute("siteId", param.getString("siteId"));

		String userId = (String) session.getAttribute("username");
		
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
    
    //마이페이지 OTP 확인
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
			loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "N");
			sqlDao.save("insertUserLockCount", param);
			MVUtils.goUrl("/bos/member/user/myPageOtp.do?menuNo=100275&viewType=CONTBODY", "OTP인증번호가 일치하지 않거나 계정이 잠긴 상태입니다.", model);
			return;
		}

		session.removeAttribute("username");
		session.removeAttribute("password");
		session.removeAttribute("userNm");
		session.removeAttribute("salt");

		//loginHistoryAuthenticationFailureHandler.saveFailureHistory(paramCtx.getRequest(), username, "Y");
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("username", username);
		map.put("userNm", userNm);
		map.put("password", passwordEncoder.encodePassword(password,salt));
		MVUtils.goUrlHidden(map, "/bos/member/user/regMypage.do?menuNo=100275", "", model);
	}
    
    // 마이페이지 정보 수정
    public void regMypage(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        param.put("userId", user.getString("userId"));
        super.forUpdate(paramCtx);
    }

	// 마이페이지 수정
	public void insertMypage(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		//본인 아이디만 수정 가능
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());
		
		//비밀번호 변경한 경우에만 수정
		String pwd = param.getString("userPassword");
		if (StringUtils.hasText(pwd)) {
			String pwd2 = PasswordEncrypter.encrypt(pwd);
			param.put("userPassword", pwd2);
		}

		sqlDao.modify("updateUserMemberMypage", param);

		String goUrl = WebFactory.buildUrl("/bos/member/user/regMypage.do", param, "userId", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "내 정보가 수정 되었습니다.", model);

	}
	
	public void excelDownPopup(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("userId", user.getUserId());
        param.put("userNm", user.getUserNm());
    }
	
	public void insertDownloadHistory(ZValue param, String shDataNm) throws Exception {
	    System.out.println("===다운로드이력 저장");
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("shUserId", user.getUserId());
        param.put("shMemo", param.getString("downloadMemo"));
        param.put("shGroup", "DOWN");
        param.put("shMenuNm", param.getString("shMenuNm"));
        param.put("shDataNm", shDataNm);
        
        sqlDao.save("saveDownloadHistory", param);
    }
	public void insertPrintHistory(ZValue param, String phName, String phGroup) throws Exception{
	    System.out.println("===출력이력 저장");
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        
        param.put("userId", user.getUserId());
        param.put("userName",user.getUserNm());
        param.put("phName", phName);
        param.put("phGroup", phGroup);
	    
	    sqlDao.save("insertPrintHistory", param);
	}
}
