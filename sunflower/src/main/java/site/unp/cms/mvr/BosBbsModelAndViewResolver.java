package site.unp.cms.mvr;

import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.util.StrUtils;

public class BosBbsModelAndViewResolver extends BbsModelAndViewResolver {

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
		StringBuffer result = new StringBuffer();
		String pageQueryString = param.getString("pageQueryString");
		if( StringUtils.hasLength(pageQueryString) ) pageQueryString = StrUtils.replace(pageQueryString, "&amp;", "&");
		else{
			pageQueryString = "menuNo="+param.getString("menuNo");
		}
		if( SUCCESS.equals(resultCode) || FAIL.equals(resultCode) ) {
			result.append("/bos/bbs/").append(bbsId).append("/list.do?").append(pageQueryString);
		}
		else if( REPLY_SUCCESS.equals(resultCode) ) {
			result.append("/bos/bbs/").append(bbsId).append("/view.do?nttId=").append(param.getString("parntsNo")).append("&").append(pageQueryString);
		}
		else if( MODIFY_FAIL.equals(resultCode) ) {
			result.append("/bos/bbs/").append(bbsId).append("/forUpdate.do?nttId=").append(param.getString("nttId")).append("&").append(pageQueryString);
		}
		else if( ERROR.equals(resultCode)  ) {
			result.append("javascript:history.back();");
		}
		return result.toString();
	}

}
