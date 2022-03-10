package site.unp.cms.listener.member;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import site.unp.cms.dao.UpipsSqlDAO;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;

@Component
public class UserInfoPrtcListener extends CommonListenerSupport {

	public static final String READNG_USER_ID = "readngUserId"; //열람사용자ID

	@Resource(name="SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;


	@Resource(name = "upipsSqlDao")
	UpipsSqlDAO upipsSqlDao;

	@Override
	public void before(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		String siteId = param.getString("siteId");
		String userId = param.getString("userId");
		HttpSession session = paramCtx.getRequest().getSession();
		String sessionReadId= (String)session.getAttribute(READNG_USER_ID + "_" + userId);

		if (SiteInfoService.BOS_SITE_ID.equals(siteId)) {
			if( sessionReadId == null ){
				HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "열람 권한이 없습니다.");
			}
		}
		paramCtx.getModel().addAttribute("userInfoPrtcAt", "T");
	}

	@SuppressWarnings("unchecked")
	@Override
	public void after(ParameterContext paramCtx) throws Exception {

		String pq = paramCtx.getRequest().getQueryString();
		pq = StringUtils.hasText(pq) ? "?" + pq : "";
		String uri = paramCtx.getRequest().getRequestURI() + pq;
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		ZValue param = paramCtx.getParam();
		param.put("pageNo", param.getString("menuNo"));
		param.put("userId", user.getUserId());
		param.put("readngIpad", paramCtx.getUserIp());
		param.put("readngUrlad", uri);
		String readngPurpsSe = param.getString("readngPurpsSe");
		if (!StringUtils.hasText(readngPurpsSe)) {
			param.put("readngPurpsSe", "홈페이지관리");
		}
		// CMS 내부에 쌓을 경우
		sqlDAO.save("saveUserInfoPrtc", param);

		// UPIPS(개인정보보호시스템)에  쌓을 경우
		//param.put("readngInfo", sqlDAO.selectString("findOndSiteConectMenuNm", param));
		//upipsSqlDao.save("saveUpipsUserInfoPrtc", param);
	}

}
