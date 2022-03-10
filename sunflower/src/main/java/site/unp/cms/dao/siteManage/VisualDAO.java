package site.unp.cms.dao.siteManage;

import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.cms.service.main.MainService;
import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;


@Repository("visualDAO")
public class VisualDAO extends SqlDAO<ZValue>{

	//@Cacheable(value=MainService.PORTAL_MAIN_CACHE_NAME)
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public List<ZValue> findUserVisual() throws Exception {
		return findAll("findUserVisual");
	}

	//캐쉬를 저장하는 것들을 항상 지워야 한다. 그래야지 배너와 겹치지 않게 한다.
	/*@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public List<ZValue> findPublishListByVisualSe(ZValue param) throws Exception {
		return getSqlSession().selectList("findPublishListByVisualSe",param);
	}*/

}
