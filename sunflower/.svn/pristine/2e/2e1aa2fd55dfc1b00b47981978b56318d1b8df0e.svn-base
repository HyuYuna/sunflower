package site.unp.cms.interceptor;

import java.text.SimpleDateFormat;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import site.unp.cms.util.UriUtil;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;

public class SiteConectStatsInterceptor extends HandlerInterceptorAdapter {
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDao;


	// controller의 handler가 끝나면 처리됨
	@Override
	public void postHandle(
			HttpServletRequest request, HttpServletResponse response,
			Object obj, ModelAndView mav)
			throws Exception {

		HttpSession session = request.getSession();
		String conectUrlad = request.getRequestURI();
		String beforeMenuNo = session.getAttribute("beforeMenuNo")==null ? null : session.getAttribute("beforeMenuNo").toString();
		String siteId = conectUrlad.split("/")[1];
		//System.out.println(siteId);
		// 행동 처리
		String ghvrSumry = UriUtil.getGhvrSumry(conectUrlad);

		ZValue param = new ZValue();
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String loginDt = formatter.format(session.getCreationTime());

		if (user != null) {
			param.put("userId", user.getUserId());
			param.put("userNm", user.getUserNm());
			param.put("loginDt", loginDt);
		} else {
			param.put("userId", request.getParameter("username"));
			param.put("userNm", request.getParameter("userNm"));
			param.put("loginDt", new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(new java.util.Date()));
		}
		
		param.put("menuNo", request.getParameter("menuNo")==null ? 0 : request.getParameter("menuNo"));
		param.put("siteId", siteId);
		param.put("sesionId", request.getSession().getId());
		param.put("conectUrlad", conectUrlad);
		param.put("conectOpersysmNm", HttpUtil.getClientOS(request));
		param.put("conectWbsrNm", HttpUtil.getClientBrowser(request));
		param.put("conectPcMobileSe", HttpUtil.getPcMobileSe(request));
		param.put("beforeMenuNo", beforeMenuNo);
		param.put("ghvrSumry", ghvrSumry);
		param.put("userIpad", request.getRemoteAddr());
		
		/*System.out.println("postHandle");*/
		

		sqlDao.save("saveSiteConectStats", param);
	}
}
