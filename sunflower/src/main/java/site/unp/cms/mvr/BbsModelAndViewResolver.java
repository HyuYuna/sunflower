package site.unp.cms.mvr;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.service.cs.CommonService;
import site.unp.core.util.StrUtils;

public class BbsModelAndViewResolver extends UriModelAndViewResolver {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public String determineTargetUri(ParameterContext paramCtx) throws Exception
	{
		ModelMap model = paramCtx.getModel();
		
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) {
    		return null;
    	}

    	ZValue param = paramCtx.getParam();
    	String bbsId = param.getString("bbsId");
		String siteId = param.getString(CommonService.SITE_ID);
		StringBuilder result = new StringBuilder();
		String pageQueryString = param.getString(CommonService.PAGE_QUERY_STRING);

		if( StringUtils.hasLength(pageQueryString) ) {
			pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		}
		else {
			pageQueryString = "menuNo="+param.getString("menuNo");
		}
		if( ERROR.equals(resultCode) ) {
			result.append("javascript:history.back();");
		}
		else {
			result.append("/").append(siteId).append("/bbs/").append(bbsId).append("/list.do");
			result.append("?").append(pageQueryString);
		}
		return result.toString();
	}

	@Override
	protected String setAdditionalOperation(String includePage, ParameterContext paramCtx){
		ModelMap model = paramCtx.getModel();
		ZValue master = (ZValue) model.get("masterVO");
		if( master != null ) {
			includePage = StrUtils.replace(includePage, "[bbsAttrbCd]", master.getString("bbsAttrbCd"));
		}
		return includePage;
	}
}
