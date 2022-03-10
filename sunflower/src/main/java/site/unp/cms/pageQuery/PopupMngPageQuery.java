package site.unp.cms.pageQuery;

import java.net.URLEncoder;

import org.springframework.stereotype.Component;

import site.unp.core.ZValue;
import site.unp.core.paging.DefaultPageQuery;

@Component
public class PopupMngPageQuery extends DefaultPageQuery {

	@Override
	public String getPageLinkQueryString(ZValue param, String pageQueryData) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchCnd=").append(param.getString("searchCnd"));
		queryString.append("&searchWrd=").append(URLEncoder.encode(param.getString("searchWrd"), "UTF-8" ));
		queryString.append("&menuNo=").append(param.getString("menuNo"));
		queryString.append("&sdate=").append(param.getString("sdate"));
		queryString.append("&edate=").append(param.getString("edate"));
		queryString.append("&siteId=").append(param.getString("siteId"));
		return queryString.toString();
	}
}
