package site.unp.cms.dao.sys;

import java.util.ArrayList;
import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("prhibtWrdFlterDAO")
public class PrhibtWrdFlterDAO extends SqlDAO<ZValue> {

	public static final String PRHIBT_WRD_FILTER_CACHE_NAME = "storedPrhibtWrdFlter";

	@Override
	@CacheEvict(value=PRHIBT_WRD_FILTER_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public Object save(String queryId, ZValue param) throws Exception {
		return super.save(queryId, param);
	}

	@Override
	@CacheEvict(value=PRHIBT_WRD_FILTER_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int modify(String queryId, ZValue param) throws Exception {
		return super.modify(queryId, param);
	}

	@Override
	@CacheEvict(value=PRHIBT_WRD_FILTER_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int deleteOne(String queryId, ZValue param) throws Exception {
		return super.deleteOne(queryId, param);
	}

	@Cacheable(value=PRHIBT_WRD_FILTER_CACHE_NAME)
	public List<String> findAllWord() throws Exception {
		List<ZValue> tmpList =  super.findAll("findAllPrhibtWrdFlterString");
		List<String> resultList = new ArrayList<String>();
		for (ZValue vo : tmpList) {
			resultList.add(vo.getString("wrdNm"));
		}
		if (resultList.size() == 0 ) resultList = null;
		return resultList;
	}
}
