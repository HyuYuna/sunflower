package site.unp.cms.interceptor;

import java.util.Enumeration;
import java.util.List;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import site.unp.cms.dao.sys.PrhibtWrdFlterDAO;
import site.unp.core.util.HttpUtil;

/**
 * 금지단어 필터링 처리 dispatcher-servlet.xml에 정의됨
 *
 */
public class WordFilterInterceptor extends HandlerInterceptorAdapter {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "prhibtWrdFlterDAO")
	private PrhibtWrdFlterDAO prhibtWrdFlterDAO;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		// ParameterMap 을 사용하는것이 더 권장사항임.
		@SuppressWarnings("unchecked")
		Enumeration<String> names = request.getParameterNames();
		String word = null;
		while (names.hasMoreElements()) {
			String a = names.nextElement();
			String value = request.getParameter(a);
			word = isValidInput(value);
			if (word != null) {
				// response.sendRedirect("/common/detect.jsp");
				log.debug("[" + word + "]는(은) 사용하실 수 없은 단어입니다.");
				HttpUtil.back(response, "[" + word + "]는(은) 사용하실 수 없은 단어입니다.");
				return false;
			}
		}
		return true;
	}

	private String isValidInput(String value) throws Exception {
		if (value != null) {
			List<String> workFilterList = prhibtWrdFlterDAO.findAllWord();
			if (workFilterList != null) {
				for (String ptn : workFilterList) {
					Pattern scriptPattern = Pattern.compile(ptn, Pattern.CASE_INSENSITIVE);
					if (scriptPattern.matcher(value).find()) {
						return ptn;
					}
				}
			}
			return null;
		}
		return null;
	}
}
