package site.unp.cms.listener.bbs;

import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import site.unp.cms.domain.MemberVO;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.domain.SearchVO;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.StrUtils;

@Component
public class BbsInitParamsListener extends CommonListenerSupport {

	@Override
	public void before(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		MemberVO memberVO = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if(memberVO != null) {
			param.put("userSn", memberVO.getUserSn());
			param.put("ntcrId", memberVO.getUserId());
			param.put("ntcrPin", memberVO.getUserPin());
			param.put("updtId", memberVO.getUserId());
			param.put("registId", memberVO.getUserId());
			if ( !StringUtils.hasText(param.getString("ntcrNm")) ) {
				param.put("ntcrNm", memberVO.getUserNm());
			}
			if ( !StringUtils.hasText(param.getString("password")) ) {
				param.put("password", memberVO.getPassword());
			}
		}

		if ( !StringUtils.hasText(param.getString("secretAt")) ) {
			param.put("secretAt", SearchVO.PUBLIC);
		}
		if ( !StringUtils.hasText(param.getString("htmlAt")) ) {
			param.put("htmlAt", "Y");
		}
		if ( !StringUtils.hasText(param.getString("nttTyCd")) ) {
			param.put("nttTyCd", SearchVO.BASIC_NTT_TYPE);
		}
		if ( !StringUtils.hasText(param.getString("useAt")) ) {
			param.put("useAt", SearchVO.USE);
		}
		if ( !StringUtils.hasText(param.getString("deleteCd")) ) {
			param.put("deleteCd", SearchVO.NON_DELETION);
		}
		if ( !StringUtils.hasText(param.getString("replyLc")) ) {
			param.put("replyLc", "0");
		}
		if ( !StringUtils.hasText(param.getString("replyAt")) ) {
			param.put("replyAt", "N");
		}
		if ( !StringUtils.hasText(param.getString("parntsNo")) ) {
			param.put("parntsNo", "0");
		}

		if ( StringUtils.hasText(param.getString("nttCn")) ) {
			param.put("nttCn", StrUtils.unscript(param.getString("nttCn")));
		}

		if ( StringUtils.hasText(param.getString("ntcrZip1")) && StringUtils.hasText(param.getString("ntcrZip2")) ){
	    	String ntcrZip = param.getString("ntcrZip1") + "-" + param.getString("ntcrZip2");
	    	param.put("ntcrZip", ntcrZip);
		}
		if ( StringUtils.hasText(param.getString("ntcrCpno1")) && StringUtils.hasText(param.getString("ntcrCpno2")) && StringUtils.hasText(param.getString("ntcrCpno3"))) {
	    	String ntcrCpno = param.getString("ntcrCpno1") + "-" + param.getString("ntcrCpno2") + "-" + param.getString("ntcrCpno3");
	    	param.put("ntcrCpno", ntcrCpno);
		}
		if ( StringUtils.hasText(param.getString("ntcrTelno1")) && StringUtils.hasText(param.getString("ntcrTelno2")) && StringUtils.hasText(param.getString("ntcrTelno3"))) {
	    	String ntcrTelno = param.getString("ntcrTelno1") + "-" + param.getString("ntcrTelno2") + "-" + param.getString("ntcrTelno3");
	    	param.put("ntcrTelno", ntcrTelno);
		}
		if ( StringUtils.hasText(param.getString("ntcrEmad1")) && StringUtils.hasText(param.getString("ntcrEmad2")) ) {
	    	String ntcrEmad = param.getString("ntcrEmad1") + "@" + param.getString("ntcrEmad2");
	    	param.put("ntcrEmad", ntcrEmad);
		}
	}
}
