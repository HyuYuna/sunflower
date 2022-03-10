package site.unp.cms.conf;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;

public class DaoExceptionResolver extends SimpleMappingExceptionResolver {

	private ISqlDAO<ZValue> sqlDAO;

	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		ex.printStackTrace();
		
		ZValue param = new ZValue();

		param.putObject("userId", request.getRemoteUser());
		param.putObject("userIpad", request.getRemoteAddr());
		param.putObject("errorUrlad", request.getRequestURI());
		param.putObject("beforeUrlad", request.getHeader("Referer"));
		param.putObject("errorSj", ex.getClass().getName());
		param.putObject("msg", ex.getMessage());
		try {
			sqlDAO.save("saveErrorLog", param);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return super.doResolveException(request, response, handler, ex);
	}

	public ISqlDAO<ZValue> getSqlDAO() {
		return sqlDAO;
	}

	public void setSqlDAO(ISqlDAO<ZValue> sqlDAO) {
		this.sqlDAO = sqlDAO;
	}

}
