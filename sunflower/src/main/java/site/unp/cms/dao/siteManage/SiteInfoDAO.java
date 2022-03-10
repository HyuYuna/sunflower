package site.unp.cms.dao.siteManage;

import java.util.List;


import org.apache.commons.collections.CollectionUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("siteInfoDAO")
public class SiteInfoDAO extends SqlDAO<ZValue> {

	public static final String SITE_INFO_CACHE_NAME = "storedSiteInfo";

	@Cacheable(value=SITE_INFO_CACHE_NAME)
	public List<ZValue> getSiteList() throws Exception{
		List<ZValue> resultList = super.findAll("findAllSiteInfo");
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

	@Cacheable(key="'siteInfoDAO.getSiteBySiteId' + #siteId", value=SITE_INFO_CACHE_NAME)
	public ZValue getSiteBySiteId(String siteId) throws Exception{
		ZValue result = null;
		List<ZValue> resultList = getSiteList();
		if( CollectionUtils.isNotEmpty(resultList) ){
			for(ZValue val : resultList){
				if( val.getString("siteId").equals(siteId) ){
					result = val;
					break;
				}
			}
		}
		return result;
	}

	@Cacheable(key="'siteInfoDAO.getSiteBySiteName' + #siteId", value=SITE_INFO_CACHE_NAME)
	public ZValue getSiteBySiteName(String siteId) throws Exception{
		ZValue result = null;
		List<ZValue> resultList = getSiteList();
		if( CollectionUtils.isNotEmpty(resultList) ){
			for(ZValue val : resultList){
				if( val.getString("siteId").equals(siteId) ){
					result = val;
					break;
				}
			}
		}
		return result;
	}

	@CacheEvict(value=SITE_INFO_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int deleteBySiteId(String siteId) throws Exception {
		return getSqlSession().delete("deleteSiteInfoBySiteId", siteId);
	}

	@CacheEvict(value=SITE_INFO_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int modifySiteInfo(ZValue param) throws Exception {
		return getSqlSession().update("updateSiteInfo", param);
	}

	@CacheEvict(value=SITE_INFO_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public Object saveSiteInfo(ZValue param) throws Exception {
		return getSqlSession().insert("saveSiteInfo", param);
	}

	@CacheEvict(value=SITE_INFO_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int modifyUseYnChange(ZValue param) throws Exception {
		return getSqlSession().update("updateUseYnChange", param);
	}
}
