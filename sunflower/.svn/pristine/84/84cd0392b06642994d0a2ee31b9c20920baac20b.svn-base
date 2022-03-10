package site.unp.cms.service.member.sec;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;
import org.springframework.util.CollectionUtils;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.menu.MasterMenuManager;
import site.unp.core.service.sec.UnpUserDetails;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.WebFactory;

public class BosSessionSavedRequestAwareAuthenticationHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	private Log log = LogFactory.getLog(this.getClass());

	@Resource(name = "masterMenuManagerService")
	private MasterMenuManager masterMenuManagerService;

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            Authentication authentication) throws ServletException, IOException {

			EgovMap param = new EgovMap();

			Object principal = authentication.getPrincipal();
			if( principal != null ){
				if( principal instanceof UnpUserDetails){
					UnpUserDetails details = (UnpUserDetails) authentication.getPrincipal();
					UsersVO user = (UsersVO)details.getUsersVO();
					if( user!= null ){
						param.put("userId", user.getUserId());

						//egov 호환성
/*						LoginVO loginVO = new LoginVO();
						loginVO.setId(user.getUserId());
						loginVO.setName(user.getUserNm());
						loginVO.setUserSe("USR");
						loginVO.setOrgnztId("-");
						loginVO.setUniqId(user.getUserId());
						request.getSession().setAttribute("LoginVO", loginVO);*/
					}
				}
			}


    	if (!menuLoad(request, response)) {
    		return;
    	}
    	HttpSession session = request.getSession();
    	session.setAttribute("userIp", HttpUtil.getUserIpBrowserCheck(request)); //Session Hijacking 방지 = ip 비교하기 위해 세션에 처리

		super.onAuthenticationSuccess(request, response, authentication);

    }

    @SuppressWarnings("unchecked")
    public boolean menuLoad(HttpServletRequest request, HttpServletResponse response) {

    	HttpSession session = request.getSession();
		ZValue zvl = WebFactory.getAttributes(request);

		HashMap<String, List<ZValue>> map = (HashMap<String, List<ZValue>>) session.getAttribute("adminMenuMap");
		// 로그인후이거나 로그인한후 메뉴요청이 아닌경우(매번 권한별메뉴 불러올 필요가없음) 권한별메뉴 새로 불러옴
		if (map == null || "L".equals(zvl.getString("flag"))) {
			List<ZValue> menuStructure = null;
			if (UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {

				ZValue vo = new ZValue();
				vo.put("pSiteId",SiteInfoService.BOS_SITE_ID);
				try {
					menuStructure = sqlDAO.findAll("findAllMenuBySiteId", vo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				List<String> authorities = UnpUserDetailsHelper.getAuthorities();
				log.debug("################authorities : " + authorities);
				if (authorities == null) {
					HttpUtil.goUrl(response, "/bos/member/admin/forLogin.do", "권한이 없습니다.");
					return false;
				}

				try {
					ZValue vo = new ZValue();
					vo.put("authorities",authorities);
					menuStructure = sqlDAO.findAll("findAllMenuByAuthor", vo);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			if (CollectionUtils.isEmpty(menuStructure)) {
				HttpUtil.goUrl(response, "/bos/member/admin/forLogin.do", "담당자 권한별메뉴가 등록되어있지 않습니다. 관리자에게 문의하세요.");
				return false;
			}

			HashMap<String, List<ZValue>> menuCategoryMap = masterMenuManagerService.getMenuCategories(menuStructure);
			map = masterMenuManagerService.setMenuCategory(menuCategoryMap, "menu_0", 0, new String[6]);
			map = masterMenuManagerService.setNullLinkMenuCategory(menuCategoryMap, MasterMenuManager.PREFIX+"0", 0);
			session.setAttribute("adminMenuMap", map);
		}

		return true;
    }
}
