package site.unp.cms.dao.siteManage;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("siteGuideMenuDAO")
public class SiteGuideMenuDAO extends SqlDAO<ZValue> {

	public static final String SITE_GUIDE_MENU_INFO_CACHE_NAME = "storedSiteGuideMenuInfo";

	public List<ZValue> getSiteGuideMenuBySiteId(ZValue param) throws Exception{
		List<ZValue> resultList = super.findAll("findSiteGuideMenuBySiteId",param);
		return resultList;
	}

	@CacheEvict(value=SITE_GUIDE_MENU_INFO_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int deleteSiteGuideMenuBySiteId(ZValue param) throws Exception {
		return getSqlSession().delete("deleteSiteGuideMenuBySiteId", param);
	}

	public void saveSiteGuideMenu(ZValue param) throws Exception {
		getSqlSession().insert("saveSiteGuideMenu", param);
	}

	/**
	 * 사이트별 사이트가이드메뉴정보 조회(캐쉬처리)
	 * @return
	 * @throws Exception
	 */
	@Cacheable(value=SITE_GUIDE_MENU_INFO_CACHE_NAME)
	public List<ZValue> getSiteGuideMenuList() throws Exception{
		List<ZValue> resultList = super.findAll("findAllSiteGuideMenuInfo");
		if( CollectionUtils.isNotEmpty(resultList) ){
			for(ZValue site : resultList ){
				site.put("siteDomain", getDomain(site.getString("siteUrl")));
			}
		}
		return resultList;
	}

	private String getDomain(String siteUrl){
		String result = null;
		if( siteUrl == null ){
			return null;
		}

		result = siteUrl.replaceAll("(http|https)://", "");
		if( result.endsWith("/") ){
			result = result.substring(0, result.length()-1);
		}
		return result;
	}
}

