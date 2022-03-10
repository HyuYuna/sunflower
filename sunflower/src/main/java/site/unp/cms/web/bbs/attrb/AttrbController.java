package site.unp.cms.web.bbs.attrb;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.web.DefaultCommonControllerBase;
import site.unp.core.ParameterContext;

@Controller
@RequestMapping("/bos/bbs/attrb")
public class AttrbController extends DefaultCommonControllerBase {

	@Override
	protected String getProgramId(ParameterContext paramCtx){
		return "attrb";
	}
}
