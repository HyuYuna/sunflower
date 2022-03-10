package site.unp.cms.dao.siteManage;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.cms.service.main.MainService;
import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("bannerDAO")
public class BannerDAO extends SqlDAO<ZValue> {

	@Override
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public Object save(String queryId, ZValue param) throws Exception {
		return super.save(queryId, param);
	}

	@Override
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int modify(String queryId, ZValue param) throws Exception {
		return getSqlSession().update(queryId, param);
	}

	@Override
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int deleteOne(String queryId, ZValue param) throws Exception {
		return getSqlSession().delete(queryId, param);
	}

	@Cacheable(value=MainService.PORTAL_MAIN_CACHE_NAME)
	public List<ZValue> findPublishListByBannerSe(ZValue param) throws Exception {
		return getSqlSession().selectList("findPublishListByBannerSe",param);
	}

}
