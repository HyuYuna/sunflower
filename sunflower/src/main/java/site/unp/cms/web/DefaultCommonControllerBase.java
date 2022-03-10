package site.unp.cms.web;

import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;
import org.springframework.web.util.WebUtils;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.view.UnpJsonViewFinder;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.conf.CommonServiceFactory;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.service.cs.CommonService;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.WebFactory;
import site.unp.core.web.AbstractCommonControllerBase;
/**
 * 타입이 ZValue인 CRUD를 위한 모든 컨트롤러는 이 컨트롤러를 확장한다.
 * @author KHD
 *
 */
public class DefaultCommonControllerBase extends AbstractCommonControllerBase {

	Logger log = LoggerFactory.getLogger(this.getClass());
	
	private ISqlDAO<ZValue> sqlDAO;
	
	private UnpJsonViewFinder unpJsonViewFinder;

	private final UrlPathHelper urlPathHelper = new UrlPathHelper();
	
	@Override
	@Resource(name="defaultCommonServiceFactory")
	public void setCommonServiceFactory(CommonServiceFactory commonServiceFactory) {
		super.setCommonServiceFactory(commonServiceFactory);
	}

	@Resource(name="SqlDAO")
	public void setSqlDAO(ISqlDAO<ZValue> sqlDAO) {
		this.sqlDAO = sqlDAO;
	}

	public UnpJsonViewFinder getUnpJsonViewFinder() {
		return unpJsonViewFinder;
	}

	@Resource(name="unpJsonViewFinder")
	public void setUnpJsonViewFinder(UnpJsonViewFinder unpJsonViewFinder) {
		this.unpJsonViewFinder = unpJsonViewFinder;
	}

	@RequestMapping("/{targetMethod}")
	public ModelAndView invoke(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue paramVO = WebFactory.getAttributes(request);
		ModelAndView mv =null;
		mv = invoke(paramVO, request, response, model);
		return mv;
	}

	@Override
	protected void doInvoke(CommonService service, ParameterContext paramCtx) throws Exception {
		String path = urlPathHelper.getLookupPathForRequest(paramCtx.getRequest());
		String filename = WebUtils.extractFullFilenameFromUrlPath(path);
		String extension = StringUtils.getFilenameExtension(filename);
		extension = (StringUtils.hasText(extension)) ? extension.toLowerCase(Locale.ENGLISH) : null;
		if ("json".equals(extension)) {
			if (!getUnpJsonViewFinder().hasUnpJsonViewModel(paramCtx.getModel())) {
				ZValue param = paramCtx.getParam();
				log.debug("[{}.{}] Cannot find @UnpJsonView", param.getString("targetName"), param.getString("targetMethod"));
				paramCtx.getResponse().sendRedirect("/cmmn/error.jsp");
				return;
			}
		}
		super.doInvoke(service, paramCtx);
	}

	@Override
	protected ParameterContext setProperty(HttpServletRequest request, HttpServletResponse response, ZValue param, ModelMap model) throws Exception {
		ParameterContext paramCtx = super.setProperty(request, response, param, model);
		//패스버라이어블을 파라미터에 담기 VO형은 기본적으로 담겨져 있음
		@SuppressWarnings("unchecked")
		Map<String, String> uriTemplateVars = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
		if( uriTemplateVars != null ){
			param.putAll(uriTemplateVars);
		}
		model.addAttribute("paramVO", param);

		//사용자정보
		MemberVO memberVO = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute(CommonService.USER_INFO, memberVO);

		return paramCtx;
	}

	@Override
	protected String getProgramId(ParameterContext paramCtx){
		return paramCtx.getParam().getString(CommonService.PROGRAM_ID);
	}

	@Override
	protected String getTargetMethod(ParameterContext paramCtx) {
		return paramCtx.getParam().getString("targetMethod");
	}

	public ISqlDAO<ZValue> getSqlDAO() {
		return sqlDAO;
	}

}
