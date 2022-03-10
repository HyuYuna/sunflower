package site.unp.cms.web.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.web.DefaultCommonControllerBase;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;


@Controller
@RequestMapping("/{siteId}/member/{programId}")
public class MemberController extends DefaultCommonControllerBase {

	@Override
	protected String getProgramId(ParameterContext paramCtx){
		ZValue param = paramCtx.getParam();
		param.put("groupId", "member");
		return param.getString("programId")+ "Member";
	}
}
