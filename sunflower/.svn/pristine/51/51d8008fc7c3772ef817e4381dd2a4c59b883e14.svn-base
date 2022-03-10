package site.unp.cms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.service.cs.CommonService;

@Controller
@RequestMapping("/{siteId}/{groupId}/{programId}")
public class CpsMappingController extends DefaultCommonControllerBase{

	@Override
	protected String getProgramId(ParameterContext paramCtx) {
		return paramCtx.getParam().getString(CommonService.PROGRAM_ID);
	}

	@Override
	protected ParameterContext setProperty(HttpServletRequest request, HttpServletResponse response, ZValue param, ModelMap model) throws Exception{
		ParameterContext paramCtx = super.setProperty(request, response, param, model);
		ZValue paramVO = paramCtx.getParam();

		return paramCtx;
	}
}
