package site.unp.cms.web.bbs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.web.DefaultCommonControllerBase;
import site.unp.core.ParameterContext;

@Controller
@RequestMapping("/{siteId}/bbs/bbsCm")
public class BbsCmController extends DefaultCommonControllerBase {

	@Override
	protected String getProgramId(ParameterContext paramCtx){
		return "bbsCm";
	}
}
