package site.unp.cms.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import site.unp.cms.domain.MemberVO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;


@Component
public class InitParamsListener extends CommonListenerSupport {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void before(ParameterContext paramCtx) throws Exception {

		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		ZValue param = paramCtx.getParam();

		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("registId", user.getUserId());
			param.put("updtId", user.getUserId());
			//param.put("userId", user.getUserId());
		}

		String email = param.getString("email1") + "@" + param.getString("email2");
		if (StringUtils.hasText(param.getString("email"))) email = param.getString("email");
		param.put("email", email);

		String mbtlnum = param.getString("mbtlnum1") + "-" + param.getString("mbtlnum2") + "-" + param.getString("mbtlnum3");
		if (StringUtils.hasText(param.getString("mbtlnum"))) mbtlnum = param.getString("mbtlnum");
		param.put("mbtlnum", mbtlnum);

		String telno = param.getString("telno1") + "-" + param.getString("telno2") + "-" + param.getString("telno3");
		if (StringUtils.hasText(param.getString("telno"))) mbtlnum = param.getString("telno");
		param.put("telno", telno);
		
		String faxno = param.getString("faxno1") + "-" + param.getString("faxno2") + "-" + param.getString("faxno3");
		if (StringUtils.hasText(param.getString("faxno"))) mbtlnum = param.getString("faxno");
		param.put("faxno", faxno);


		if ("".equals(param.getString("pageUnit",""))) {
			param.put("pageUnit", "10");
		}
		if ("".equals(param.getString("pageSize",""))) {
			param.put("pageSize", "10");
		}
	}
}
