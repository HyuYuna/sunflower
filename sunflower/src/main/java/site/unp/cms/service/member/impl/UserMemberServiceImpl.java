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
@CommonServiceLink(desc="??????????????????", linkType=LinkType.BOS)
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

    @CommonServiceLink(desc="??????????????????", linkType=LinkType.USER)
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

                        MVUtils.goUrl("/"+siteId+"/member/user/forUpdateConfirm.do?menuNo="+param.getString("menuNo"), "??????????????? ???????????? ????????????.", model);
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
        
        // ????????? ???????????????
        /*
        super.checkId(paramCtx);
        int idCnt = Integer.parseInt(model.get("idCnt").toString());
        if (idCnt > 0) {
            MVUtils.goUrl("javascript:history.back();", "????????? ???????????? ????????????. ??????????????????.", model);
            return;
        }
        */
        String pwd =  param.getString("userPassword");
        String pwd2 = PasswordEncrypter.encrypt(pwd);

        param.put("userPassword",pwd2);

        super.insert(paramCtx);
        
        param.put("logCate", "?????? ??????");
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        param.put("regUserLevel", user.getAuthorCd());
        sqlDao.save("insertUserLog", param);

        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/list.do?menuNo=100017", "??????????????? ?????????????????????.", model);

    }

    @Override
	@UnpJsonView
    public void checkId(ParameterContext paramCtx) throws Exception {
        System.out.println("======checkId");
        ZValue param = paramCtx.getParam();
        ModelMap model = paramCtx.getModel();

        model.addAttribute("cnt", sqlDao.count("countUserMemberByUserId", param));
    }

    //????????? ?????? ??????
    @Override
    public void updateMy(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        param = userInfoEncode(param);
        super.updateMy(paramCtx);

        ModelMap model = paramCtx.getModel();
        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/forUpdateMy.do?menuNo="+param.getString("menuNo"), "?????????????????????.", model);
    }

    //????????? ?????? ??????
    @Override
    public void deleteUser(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

        ModelMap model = paramCtx.getModel();
        sqlDao.deleteOne("deleteUserMember", param);
        
        param.put("logCate", "?????? ??????");
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        param.put("regUserLevel", user.getAuthorCd());
        sqlDao.save("insertUserLog", param);
        
        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/list.do?menuNo="+param.getString("menuNo"), "?????????????????????.", model);
    }
    
    //????????? ???????????? ?????????
    @UnpJsonView
    public void pwInit(ParameterContext paramCtx) throws Exception{
        ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ModelMap model = paramCtx.getModel();
        
        param.put("initPW", PasswordEncrypter.encrypt(param.getString("userId") + param.getString("pattern")));
        
        sqlDao.modify("initPW", param);
    }
    /**
     * ?????? ??? ?????????????????? ?????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="????????????", linkType=LinkType.USER)
    public void joinAgre(ParameterContext paramCtx) throws Exception {
    }

    /**
     * ???????????????????????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void joinSelect(ParameterContext paramCtx) throws Exception {
    }

    /**
     * ???????????? ?????????
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
     * ???????????? ??????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void joinFinish(ParameterContext paramCtx) throws Exception {
        SecurityContextHolder.clearContext();
    }


    /**
     * ????????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @CommonServiceLink(desc="?????????", linkType=LinkType.USER)
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
     * ????????? ??????
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
        // ??????????????? ???????????? ???????????? ????????? ????????????
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
            //MVUtils.goUrl(goUrl,"???????????? 5???????????? 30????????? ??????????????? ????????????.", model);
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
             * ?????? ???????????? ???????????? ?????? ???????????? ?????????????????? ????????? ?????? ????????? ??????...
             */
            result = sqlDao.findOne("findOneUserDrmncyMemberLoginInfo", param);
            if (result!=null){
                if (!drmncyIdUseAt.equals("Y")){
                    session.setAttribute("drmncyId", username);
                    //"???????????? ?????? 1????????? ???????????? ???????????? ?????? ??????????????? ????????????."
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
                    String confmMsg = "??????????????? ???????????? ????????????.";
                    if ("F".equals(result.getString("sttusCd"))) confmMsg = "??????????????? ????????? ???????????????.";

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
            MVUtils.goUrl(goUrl, "????????? ?????? ??????????????? ???????????? ????????????.", model);
            return;
        } else {
            // ?????? ???????????? ????????? ????????? ????????????????????? ?????? ???????????? ????????????.
            if (drmncyIdUseAt.equals("Y")){
                sqlDao.save("saveDrmncyToUserInfo", result);//????????????????????? ?????? ???????????? ??????

                sqlDao.deleteOne("deleteUserDrmncyById", result); //  ????????????????????? ?????? ??????
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

        // ???????????? ????????? 6?????? ?????? ?????? ????????? ??????, 3???????????? ???????????? ?????? ?????? ???????????? ??????
        if (result.getInt("passwordChangeAt")==1 && result.getInt("passwordDeriveAt")==1){
            MemberVO memberVO = new MemberVO();
            memberVO.setUserSn(result.getLong("userSn"));
            memberVO.setUserId(param.getString("username"));
            memberVO.setPassword(password);
            memberVO.setUserNm(result.getString("userNm"));
          //  memberVO.setChldCrtfcAt("N");   // 14??? ?????? ??????
            memberVO.setAuthorCd("ROLE_USERKEY");
            setAuthentication2(memberVO, request);

            // ???????????? ???????????? ??????
            param.put("userId", param.getString("username"));
            sqlDao.save("updateUserMemberPasswordDeriveDt", param);

            goUrl = savedRequest == null  ? "/"+siteId+"/member/user/pwdChange.do?menuNo=300086&deriveAt=Y" : savedRequest.getRedirectUrl();

            MVUtils.goUrlHidden(map, goUrl, "???????????? ????????? ??????????????? ???????????? ?????? ??????????????????. ???????????? ?????? ???????????? ???????????????.", model);
            return;
        }

        if("Y".equals(jMeter)){

            MemberVO memberVO = new MemberVO();
            memberVO.setUserSn(result.getLong("userSn"));
            memberVO.setUserId(param.getString("username"));
            memberVO.setPassword(password);
            memberVO.setUserNm(result.getString("userNm"));
          //  memberVO.setChldCrtfcAt("N");   // 14??? ?????? ??????
            memberVO.setAuthorCd("ROLE_USERKEY");
            setAuthentication2(memberVO, request);

            goUrl = savedRequest == null  ? "/"+siteId+"/main/main.do" : savedRequest.getRedirectUrl();

            MVUtils.goUrlHidden(map, goUrl, "????????? ???????????????.", model);

        }else{
            MVUtils.goUrlHidden(map, "/"+siteId+"/login.do", "????????? ???????????????.", model);
        }
    }

    /**
     * ??????????????? ?????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	public void drmncyIdInfo(ParameterContext paramCtx) throws Exception {

    }

    /**
     * ?????????/???????????? ?????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="?????????/???????????? ??????", linkType=LinkType.USER)
    public void idPwdSearch(ParameterContext paramCtx) throws Exception {
    }

    /**
     * ???????????? ?????????
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
     * ????????? ???????????? ?????? ??????
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
     * IPIN ?????? ?????? ??????
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
     * ???????????? ??????
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

        // ??? 14??? ????????????
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

            if("A".equals(authTp) || "I".equals(authTp) || "P".equals(authTp)){                                             // ????????????, ID??????, PASSWORD ?????? ??? ?????? ???????????? ??????
                //userPinCnt = getSqlDao(MemberDAO.class).countUserMemberByUserPinId(memberVO.getUserPin());
                userPinResult = getSqlDao(MemberDAO.class).findOneUserMemberByUserPinInfo(memberVO.getUserPin());
            }

            // ??????????????? ?????? ???????????? ??? ?????? ?????????????????? ????????? ??????????????? ????????? ????????? ??????.
            if("A".equals(authTp)){                                                                                         // ????????????
                goUrl = retUrl;
                if (userPinResult != null) memberBoolean = false;
                else memberBoolean = true;
            }else if("I".equals(authTp)){                                                                                       // ID??????
                goUrl = retUrl;
                if (userPinResult == null) memberBoolean = false;
                else memberBoolean = true;
            }else if("P".equals(authTp)){                                                                                       // PASSWORD??????
                goUrl = retUrl;
                if (userPinResult == null) memberBoolean = false;
                else memberBoolean = true;
            }else{                                                                                                          // ?????????
                goUrl = savedRequest == null  ? "/": savedRequest.getRedirectUrl();
                memberBoolean = true;
            }

            if(memberBoolean){

                // userPin??? ????????????
                if (StringUtils.hasText(memberVO.getUserPin())) {

                    ZValue memberZvl = getSqlDao(MemberDAO.class).findOneUserMemberByUserPin(memberVO.getUserPin());

                    // userPin?????? ????????? TM_USER_PIN ???????????? ??????
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
                    MVUtils.winCloseRealNameLocation(goUrl, "????????? ?????????????????????.", model);
                }else{

                    MVUtils.winCloseRealNameLocation(errUrl, "????????? ?????????????????????.", model);
                    return;
                }

            }else{

                if("I".equals(authTp) || "P".equals(authTp)){
                    MVUtils.winCloseRealNameLocation(errUrl, "???????????? ????????? ????????????. ????????? ?????? ??????????????? ????????????.", model);
                    return;
                }else{
                    MVUtils.winCloseRealNameLocation(errUrl, "?????? ????????? ???????????????. ????????? ?????? ??????????????? ????????????.", model);
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

        log.error("????????? ?????????????????????.");
        ModelMap model = paramCtx.getModel();
        model.addAttribute(ModelAndViewResolver.MSG_KEY, "????????? ?????????????????????.");
        model.put(ModelAndViewResolver.WINDOW_MODE, ModelAndViewResolver.WIN_CLOSE_WINDOW_MODE);
    }
    /**
     * ????????? ?????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="????????? ??????", linkType=LinkType.USER)
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
     * ????????? ?????? ?????? ?????????
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
                // ?????? ?????? ?????????????????? ??????
                result = sqlDao.findOne("idSearchFinishDrmncy", param);
            }
            model.addAttribute("result", result);
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * ???????????? ?????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
	@CommonServiceLink(desc="???????????? ??????", linkType=LinkType.USER)
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
     * ???????????? ?????? ?????? ?????????
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
                // ?????? ?????? ?????????????????? ??????
                result = sqlDao.findOne("idSearchFinishDrmncy", param);
            }
            model.addAttribute("result", result);
        }
    }


    /**
     * ????????? ?????? ?????? ????????? json
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
            MVUtils.goUrl("/ucms/member/user/idSearch.do?menuNo="+param.getString("menuNo"), "???????????? ????????? ????????? ????????????.\n ????????? :" + result.getString("userId") + "?????????.", model);
        }
        else {
            MVUtils.goUrl("/ucms/member/user/idSearch.do?menuNo="+param.getString("menuNo"), "???????????? ????????? ????????????.", model);
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * ???????????? ?????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @Override
    @CommonServiceLink(desc="???????????? ??????", linkType=LinkType.USER)
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

                // TM_USER_SALT ???????????? SALT??? ????????? ??????
                getSqlDao(MemberDAO.class).deleteMemberSaltInfo(member.getUserId(), USER_SE);
                getSqlDao(MemberDAO.class).saveMemberSalfInfo(userSn, member.getUserId(), member.getUserNm(), USER_SE, salt);

                MVUtils.setResultProperty(model, SUCCESS, "??????????????? ?????????????????????.");

            }else {

                MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "???????????? ????????? ????????????.");
            }
        }catch(Exception e){

            e.printStackTrace();
            MVUtils.setResultProperty(model, BINDING_RESULT_ERROR, "???????????? ????????? ????????? ?????????????????????.");
        }
        SecurityContextHolder.clearContext();
    }

    /**
     * ???????????? ?????????
     * @param paramCtx
     * @throws Exception
     */
    @CommonServiceLink(desc="????????????", linkType=LinkType.USER)
    @Override
    public void secsn(ParameterContext paramCtx) throws Exception {
        super.secsn(paramCtx);
    }

    //?????????
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

    //?????????
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

    //????????? ?????? ???
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

        param.put("readngPurpsSe", "????????????(??????)");
        //???????????? ?????? ??????????????? ???????????? ??????
        param.put(UserInfoPrtcListener.READNG_USER_ID, userId);
    }

    //????????? ?????? ???
    @Override
    public void forUpdate(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        String userId = param.getString("userId");
        Assert.hasText(userId);

        super.forUpdate(paramCtx);

        param.put("readngPurpsSe", "????????????(??????)");
        //???????????? ?????? ??????????????? ???????????? ??????
        param.put(UserInfoPrtcListener.READNG_USER_ID, userId);
    }

    /**
     * ????????? ????????? ????????? ????????? ?????? ?????? ??????
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
        MVUtils.setResultProperty(model, SUCCESS, "???????????? ???????????????.");

    }


	// ????????? ?????? ??????
	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		System.out.println("============update//?????????????????????");
		ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        System.out.println(user);

		if (param.getString("userPassword").equals("") || param.getString("userPassword") == null) {
			System.out.println("????????? ???????????? ?????? ??????");
		} else {
			System.out.println("????????? ???????????? ??????, ?????????");
			// ???????????? ????????? ???????????? ??????
			String pwd = param.getString("userPassword");
			if (StringUtils.hasText(pwd)) {
				String pwd2 = PasswordEncrypter.encrypt(pwd);
				param.put("userPassword", pwd2);
			}
		}

        super.update(paramCtx);
        
        if(param.getString("userState").equals("N")){
        	param.put("logCate", "?????? ??????");
        } else {
        	param.put("logCate", "?????? ??????");
        	param.put("regExiUserAuth", param.getString("exiUserLevel"));
        }
        
        param.put("regUserId", user.getUserId());
        param.put("regUserName", user.getUserNm());
        param.put("regUserLevel", user.getAuthorCd());
        System.out.println(param);
        sqlDao.save("insertUserLog", param);

        ModelMap model = paramCtx.getModel();
        MVUtils.goUrl("/"+param.getString("siteId")+"/member/user/view.do?menuNo="+param.getString("menuNo")+"&userId="+param.getString("userId"), "?????????????????????.", model);
    }

    /**
     * ?????? ???????????? ??????
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
     * ???????????? ??????
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

        // TM_USER_SALT ???????????? SALT??? ????????? ??????
        getSqlDao(MemberDAO.class).deleteMemberSaltInfo(member.getUserId(), "U");
        getSqlDao(MemberDAO.class).saveMemberSalfInfo(member.getUserSn(), member.getUserId(), member.getUserNm(), "U", salt);


        model.addAttribute(UriModelAndViewResolver.RESULT_CODE_KEY, UriModelAndViewResolver.SUCCESS);
    }

    //????????? ??????
    @Override
    public void list(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        System.out.println("======list.do / ????????? ??????");

        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginCenterCode", member.getCenterCode());
        param.put("loginAuthorCd", member.getAuthorCd());

        super.list(paramCtx);
    }

    //????????? ????????????
    @Override
    public void list2(ParameterContext paramCtx) throws Exception {
        ModelMap model = paramCtx.getModel();
        ZValue param = paramCtx.getParam();
        System.out.println("======list2.do / ????????? ????????????");

        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("loginCenterCode", member.getCenterCode());
        param.put("loginAuthorCd", member.getAuthorCd());

        super.list(paramCtx);
    }

  //????????? ?????? ??????
    @Override
    public void list_lock(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        System.out.println("======list_lock.do / ????????? ?????? ??????");
        
        param.put("loginCenterCode", member.getCenterCode());
        param.put("loginAuthorCd", member.getAuthorCd());
        

        super.doList(paramCtx, "selectLockedUser", "totalLockUser");
    }

    //????????? ????????? ??????
    @Override
    public void list_login(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        System.out.println("======list_login.do / ????????? ????????? ??????");

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        if("BM".equals(user.getString("userLevel"))) {
			param.put("loginCenterCode", user.getString("centerCode"));
		}

        super.doList(paramCtx, "selectUserLoginHistory", "totalUserLoginHistory");
    }

    //????????? ?????? ??????
    @Override
    public void list_action(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
        System.out.println("======list_action.do / ????????? ?????? ??????");

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        if("BM".equals(user.getString("userLevel"))) {
			param.put("loginCenterCode", user.getString("centerCode"));
		}

        super.doList(paramCtx, "selectUserActionHistory", "countUserActionHistory");
    }

    //???????????? ????????????
      @Override
      public void listDownload(ParameterContext paramCtx) throws Exception {
          ZValue param = paramCtx.getParam();
          System.out.println("======listDownload.do / ???????????? ????????????");

          UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
          ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

          if("BM".equals(user.getString("userLevel"))) {
              param.put("loginCenterCode", user.getString("centerCode"));
          }
          param.put("shGroup", "DOWN");
          super.doList(paramCtx, "selectDownloadHistory", "countDownloadHistory");
      }
  //?????? ?????? ??????
    @Override
    public void listUserPrint(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        System.out.println("======listPrint.do / ?????? ?????? ??????");

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
            insertDownloadHistory(param, "????????? ?????? ??????");
            resultList = sqlDao.findAll("selectUserActionHistory", param);
        }else if(type == "listDownload"){
            param.put("shGroup", "DOWN");
            insertDownloadHistory(param, "???????????? ????????????");
            resultList = sqlDao.findAll("selectDownloadHistory", param);
        }else if(type == "listUserPrint"){
            insertDownloadHistory(param, "?????? ????????????");
            resultList = sqlDao.findAll("selectPrintHistory", param);
        }else if(type == "list_login"){
            insertDownloadHistory(param, "????????? ????????? ??????");
            resultList = sqlDao.findAll("selectUserLoginHistory", param);
        }else if(type=="userList"){
            insertDownloadHistory(param, "????????? ?????????");
            resultList = sqlDao.findAll("findAllUserMember", param);
        }else if(type=="userList2"){
            insertDownloadHistory(param, "????????? ????????????");
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
        
        insertPrintHistory(param, "????????? ?????????", "");
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
        
        insertPrintHistory(param, "????????? ????????????", "");
        model.addAttribute("resultList", resultList);
    }

    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="????????? ????????? ??????????????????", linkType=LinkType.NONE)
    public void downloadExcel(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "userList");
    }


    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="????????? ???????????? ??????????????????", linkType=LinkType.NONE)
    public void downloadExcel2(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "userList2");
    }
    

    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="????????? ???????????? ??????????????????", linkType=LinkType.NONE)
    public void downloadExcel3(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "listAction");
    }
    
    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="???????????? ???????????? ??????????????????", linkType=LinkType.NONE)
    public void downloadExcel4(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "listDownload");
    }
    
    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="?????? ???????????? ??????????????????", linkType=LinkType.NONE)
    public void downloadExcel5(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "listUserPrint");
    }
    
    @SuppressWarnings("unchecked")
    @Override
    @CommonServiceLink(desc="?????? ???????????? ??????????????????", linkType=LinkType.NONE)
    public void downloadExcel6(ParameterContext paramCtx) throws Exception {
        print(paramCtx, "list_login");
    }


    @UnpJsonView
    public void unlockUser(ParameterContext paramCtx) throws Exception{
        ZValue param = paramCtx.getParam();
        MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
        System.out.println("========?????? ???????????? ");
        

        sqlDao.save("unlockUser", param);
        
        param.put("logCate", "???????????? ??? ??????");
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
    
    //??????????????? OTP ??????
    public void myPage(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	HttpSession session = paramCtx.getSession();
    	
    	ZValue siteInfoVO = siteInfoDAO.getSiteBySiteName(param.getString(SITE_ID));
    	String adtCrtfcUseAt = siteInfoVO.getString("adtCrtfcUseAt");
    	
    	MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
    	
    	//???????????? Y?????? ???????????????????????? ??????
		if(adtCrtfcUseAt.equals("Y")) {
			session.setAttribute("username", member.getUserId());
			session.setAttribute("password", member.getPassword());
			session.setAttribute("userNm", member.getUserNm());
			
			MVUtils.goUrl("/bos/member/user/myPageOtp.do?menuNo=100275&viewType=CONTBODY", null, model);
		}else {
			MVUtils.goUrl("/bos/member/user/regMypage.do?menuNo=100275", null, model);
		}
    }

    //??????????????? OTP ?????????
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

			// ????????? Key!
			encodedKey = new String(bEncodedKey);
			
			param.put("otpKey", encodedKey);
			sqlDao.save("insertUserOtpKey", param);
		} else {
			encodedKey = userOtp.getString("otpKey");
		}
		
		// String url = getQRBarcodeURL(userName, hostName, secretKeyStr);
		// userName??? hostName??? ????????? ????????? ????????? ?????????, ????????? ???????????? ?????? ???????????? ?????????.
		String url = googleOtp.getQRBarcodeURL(userId, "sunflower-center.kr", encodedKey); // ????????? ????????? ??????!

		model.addAttribute("encodedKey", encodedKey);
		model.addAttribute("url", url);
    }
    
    //??????????????? OTP ??????
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
			MVUtils.goUrl("/bos/member/user/myPageOtp.do?menuNo=100275&viewType=CONTBODY", "OTP??????????????? ???????????? ????????? ????????? ?????? ???????????????.", model);
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
    
    // ??????????????? ?????? ??????
    public void regMypage(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();

        UsersVO user1 = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        ZValue user = sqlDAO.findOneById("findOneMngrLoginInfo2",user1.getUserPin());

        param.put("userId", user.getString("userId"));
        super.forUpdate(paramCtx);
    }

	// ??????????????? ??????
	public void insertMypage(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		//?????? ???????????? ?????? ??????
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());
		
		//???????????? ????????? ???????????? ??????
		String pwd = param.getString("userPassword");
		if (StringUtils.hasText(pwd)) {
			String pwd2 = PasswordEncrypter.encrypt(pwd);
			param.put("userPassword", pwd2);
		}

		sqlDao.modify("updateUserMemberMypage", param);

		String goUrl = WebFactory.buildUrl("/bos/member/user/regMypage.do", param, "userId", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "??? ????????? ?????? ???????????????.", model);

	}
	
	public void excelDownPopup(ParameterContext paramCtx) throws Exception {
        ZValue param = paramCtx.getParam();
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("userId", user.getUserId());
        param.put("userNm", user.getUserNm());
    }
	
	public void insertDownloadHistory(ZValue param, String shDataNm) throws Exception {
	    System.out.println("===?????????????????? ??????");
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        param.put("shUserId", user.getUserId());
        param.put("shMemo", param.getString("downloadMemo"));
        param.put("shGroup", "DOWN");
        param.put("shMenuNm", param.getString("shMenuNm"));
        param.put("shDataNm", shDataNm);
        
        sqlDao.save("saveDownloadHistory", param);
    }
	public void insertPrintHistory(ZValue param, String phName, String phGroup) throws Exception{
	    System.out.println("===???????????? ??????");
        UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
        
        param.put("userId", user.getUserId());
        param.put("userName",user.getUserNm());
        param.put("phName", phName);
        param.put("phGroup", phGroup);
	    
	    sqlDao.save("insertPrintHistory", param);
	}
}
