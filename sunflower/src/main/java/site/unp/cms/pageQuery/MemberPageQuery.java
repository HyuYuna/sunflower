package site.unp.cms.pageQuery;

import java.net.URLEncoder;

import org.springframework.stereotype.Component;

import site.unp.core.ZValue;
import site.unp.core.paging.DefaultPageQuery;

@Component
public class MemberPageQuery extends DefaultPageQuery {

	@Override
	public String getPageLinkQueryString(ZValue param, String pageQueryData) throws Exception
	{
		StringBuilder queryString = new StringBuilder();
		queryString.append("searchCnd=").append(param.getString("searchCnd"));
		queryString.append("&searchWrd=").append(URLEncoder.encode(param.getString("searchWrd"), "UTF-8" ));
        queryString.append("&searchCnd1=").append(param.getString("searchCnd1"));
        queryString.append("&searchCnd2=").append(param.getString("searchCnd2"));
        queryString.append("&searchCnd3=").append(param.getString("searchCnd3"));
        queryString.append("&searchCnd4=").append(param.getString("searchCnd4"));
        queryString.append("&searchCnd5=").append(param.getString("searchCnd5"));
        queryString.append("&orderName=").append(param.getString("orderName"));
        queryString.append("&orderBdate=").append(param.getString("orderBdate"));
		queryString.append("&searchMentorYn=").append(param.getString("searchMentorYn"));
		queryString.append("&searchEntScale=").append(param.getString("searchEntScale"));
		queryString.append("&searchCountryGb=").append(param.getString("searchCountryGb"));
		queryString.append("&searchVentureGb=").append(param.getString("searchVentureGb"));
		queryString.append("&searchAwardGb=").append(param.getString("searchAwardGb"));
		queryString.append("&searchEntYn=").append(param.getString("searchEntYn"));
		queryString.append("&mberSe=").append(param.getString("mberSe"));
		queryString.append("&email=").append(param.getString("email"));
		queryString.append("&confmSttus=").append(param.getString("confmSttus"));
		queryString.append("&searchBsnm=").append(URLEncoder.encode(param.getString("searchBsnm"), "UTF-8" ));
		queryString.append("&searchRprsntv=").append(URLEncoder.encode(param.getString("searchRprsntv"), "UTF-8" ));
		queryString.append("&menuNo=").append(param.getString("menuNo"));
		queryString.append("&sdate=").append(param.getString("sdate"));
		queryString.append("&edate=").append(param.getString("edate"));
		queryString.append("&targetId=").append(param.getString("targetId"));
		queryString.append("&confmDtSt=").append(param.getString("confmDtSt"));
		queryString.append("&confmDtEt=").append(param.getString("confmDtEt"));
		queryString.append("&chgReqSn=").append(param.getString("chgReqSn"));

		return queryString.toString();
	}
}
