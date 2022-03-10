package site.unp.cms.mvr;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.ModelMap;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.mvr.UriModelAndViewResolver;
import site.unp.core.util.StrUtils;

public class CommentModelAndViewResolver extends UriModelAndViewResolver{

	@Override
	public String determineTargetUri(ParameterContext paramCtx) throws Exception
	{
		HttpServletRequest request = paramCtx.getRequest();
		ModelMap model = paramCtx.getModel();
		String requestUri = request.getRequestURI();
    	String dir[] = StrUtils.split(requestUri, "/");
    	String resultCode = (String)model.get(ModelAndViewResolver.RESULT_CODE_KEY);
    	if( resultCode == null ) return null;
    	
    	ZValue boardVO = (ZValue)model.get("boardVO");
		StringBuffer result = new StringBuffer();
		long nttId = boardVO.getLong("nttId");
		if( ERROR.equals(resultCode) )
			result.append("javascript:history.back();");
		else if( MODIFY_FAIL.equals(resultCode) || REPLY_SUCCESS.equals(resultCode) || SUCCESS.equals(resultCode) )
			result.append("/").append(dir[1]).append("/bbs/view.do?");
			result.append("nttId=").append(nttId)
			.append("&amp;bbsId=").append(boardVO.getString("bbsId"))
			.append("&amp;pageIndex=").append(boardVO.getString("pageIndex"))
			.append("&amp;menuNo=").append(boardVO.getString("menuNo"));

		//model.addAttribute(GO_URL_KEY, result.toString());
		return null;
	}

}
