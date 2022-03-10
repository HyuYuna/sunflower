package site.unp.cms.service.member.sec;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.access.AccessDeniedHandler;

import site.unp.cms.domain.MemberVO;
import site.unp.core.service.sec.UnpUserDetails;
import site.unp.core.util.HttpUtil;

public class UnpAccessDeniedHandler implements AccessDeniedHandler {

	private String defaultErrorPage;
	private String siteId;

	@Override
	public void handle(HttpServletRequest request,	HttpServletResponse response, AccessDeniedException accessDeniedException) throws IOException, ServletException {

		// Ajax를 통해 들어온것인지 파악한다
		String ajaxHeader = request.getHeader("X-Ajax-call");
		String result = "";

		response.setStatus(HttpServletResponse.SC_FORBIDDEN);
		response.setCharacterEncoding("UTF-8");

		if (ajaxHeader == null || "".equals(ajaxHeader)) {
			Authentication auth = SecurityContextHolder.getContext().getAuthentication();
			Object principal = auth.getPrincipal();
			if (principal instanceof UnpUserDetails) {
				UnpUserDetails ud = (UnpUserDetails) principal;
				String username = ud.getUsername();
				MemberVO user = (MemberVO)ud.getUsersVO();

				if (!"bos".equals(siteId) && "Y".equals(user.getMngrAt())) {
					try {
						//HttpUtil.back(response, "관리자 로그인 접속중 입니다.\\n관리자를 로그아웃하시고 접속해주시기 바랍니다."); // 안내문구만...
						HttpUtil.goUrl(response, "/", null);  // 강제 로그인 페이지 이동..
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				else if ("bos".equals(siteId) && !"Y".equals(user.getMngrAt())) {
					try {
						//HttpUtil.back(response, "사용자 로그인 접속중 입니다.\\n사용자를 로그아웃하시고 접속해주시기 바랍니다."); // 안내문구만...
						HttpUtil.goUrl(response, "/bos/member/admin/forLogin.do", "사용자로 로그인 하였거나 세션 타임아웃 되었습니다. 재 로그인 후 사용하여 주세요.");  // 강제 로그인 페이지 이동..
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}

				}
				else {
					try {
						String forwardUrl = "/bos/member/admin/forLogin.do";
						if ("ucms".equals(siteId)) {
							forwardUrl = "/ucms/member/user/forLogin.do?menuNo=300019";
						}
						HttpUtil.goUrl(response, forwardUrl, "접근 권한이 없습니다. 로그인 해주시기 바랍니다.");
						return;
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

				request.setAttribute("username", username);
			}
			request.setAttribute("errormsg", accessDeniedException);
			request.getRequestDispatcher(defaultErrorPage).forward(request, response);
		}
		else {
			if ("true".equals(ajaxHeader)) {
				result = "{\"result\" : \"fail\", \"msg\" : \"" + accessDeniedException.getMessage() + "\"}";
			}
			else {
				result = "{\"result\" : \"fail\", \"msg\" : \"Access Denied\"}";
			}
			response.getWriter().print(result);
			response.getWriter().flush();
		}
	}

	public void setDefaultErrorPage(String defaultErrorPage) {
        if ((defaultErrorPage != null) && !defaultErrorPage.startsWith("/")) {
            throw new IllegalArgumentException("errorPage must begin with '/'");
        }

        this.defaultErrorPage = defaultErrorPage;
    }

	public void setSiteId(String siteId) {
		this.siteId = siteId;
	}

}