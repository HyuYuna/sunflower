package site.unp.cms.pageQuery;

import java.net.URLEncoder;

import org.springframework.stereotype.Component;

import site.unp.core.ZValue;
import site.unp.core.paging.DefaultPageQuery;

@Component
public class CommonContentsPageQuery extends DefaultPageQuery {

	@Override
	public String getPageLinkQueryString(ZValue param, String pageQueryData) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchType=").append(param.getString("searchType"));
		queryString.append("&searchTxt=").append(URLEncoder.encode(param.getString("searchTxt"), "UTF-8" ));
		queryString.append("&menuNm=").append(URLEncoder.encode(param.getString("menuNm"), "UTF-8" ));
		queryString.append("&assigned=").append(param.getString("assigned"));
		queryString.append("&siteId=").append(param.getString("siteId"));
		queryString.append("&sMenuNo=").append(param.getString("sMenuNo"));
		queryString.append("&menuNo=").append(param.getString("menuNo"));
		queryString.append("&viewType=").append(param.getString("viewType"));
		return queryString.toString();
	}
}
