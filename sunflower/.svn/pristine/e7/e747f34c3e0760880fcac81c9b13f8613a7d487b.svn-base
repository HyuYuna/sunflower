package site.unp.cms.mvr;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.util.StrUtils;

public class NtcnAlertModelAndViewResolver extends UriModelAndViewResolver {

	@Override
	protected String setAdditionalOperation(String includePage, ParameterContext paramCtx){
		ZValue param = paramCtx.getParam();
		String type = param.getString("type", "01");
		includePage = StrUtils.replace(includePage, "[type]", type);
		return includePage;
	}

	@Override
	public String determineTargetUri(ParameterContext paramCtx) throws Exception
	{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
    	String resultCode = (String)model.get(RESULT_CODE_KEY);
    	if( resultCode == null ) return null;

		String type = param.getString("type");
		String siteId = param.getString("siteId");
		if( "".equals(siteId) ) siteId = SiteInfoService.BOS_SITE_ID;

		StringBuilder result = new StringBuilder();
		String pageQueryString = param.getString("pageQueryString");
		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getString("menuNo");
		}
		if( ERROR.equals(resultCode) ){
			result.append("javascript:history.back();");
		}
		else{
			result.append("/").append(siteId).append("/ntcnAlert/list.do?type=").append(type).append("&siteId=").append(siteId).append("&").append(pageQueryString);
		}
		return result.toString();
	}
}
