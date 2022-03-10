package site.unp.cms.listener.member;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import site.unp.cms.domain.MemberVO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@Component
public class UserInitParamListener extends CommonListenerSupport {

	@Override
	public void before(ParameterContext paramCtx) throws Exception {

		MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		ZValue param = paramCtx.getParam();
		HttpServletRequest request = paramCtx.getRequest();
		if (UnpUserDetailsHelper.isAuthenticated()) {
			param.put("registId", user.getUserId());
			param.put("updtId", user.getUserId());
			//param.put("userId", user.getUserId());
			param.put("userIpad", request.getRemoteAddr());
		}

		String userEmad = param.getString("userEmad");
		if (!StringUtils.hasText(userEmad)) {
			userEmad = param.getString("userEmad1") + "@" + param.getString("userEmad2");
		}
		param.put("userEmad", userEmad);

		String userCpno = param.getString("userCpno");
		if (!StringUtils.hasText(userCpno)) {
			userCpno = param.getString("userCpno1") + "-" + param.getString("userCpno2") + "-" + param.getString("userCpno3");
		}
		param.put("userCpno", userCpno);

		String userTelno = param.getString("userTelno");
		if (!StringUtils.hasText(userTelno)) {
			userTelno = param.getString("userTelno1") + "-" + param.getString("userTelno2") + "-" + param.getString("userTelno3");
		}
		param.put("userTelno", userTelno);

		String brthdy = param.getString("brthdy");
		if (!StringUtils.hasText(brthdy)) {
			brthdy = param.getString("brthdy1") + "-" + param.getString("brthdy2") + "-" + param.getString("brthdy3");
		}
		param.put("brthdy", brthdy);


		if ("".equals(param.getString("pageUnit",""))) {
			param.put("pageUnit", "10");
		}
		if ("".equals(param.getString("pageSize",""))) {
			param.put("pageSize", "10");
		}
	}
}
