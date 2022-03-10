package site.unp.cms.dao.singl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("cmmnFileDwldStatsDAO")
public class CmmnFileDwldStatsDAO extends SqlDAO<ZValue> {

	public static final String SITE_CMMN_FILE_DWLD_STATS_CACHE_NAME = "storedCmmnFileDwldStats";

	@Cacheable(value = SITE_CMMN_FILE_DWLD_STATS_CACHE_NAME)
	public List<ZValue> listDwld(ZValue param) throws Exception{

		// 날짜 검색 했을때만 조회
		if ("Y".equals(param.getString("searchYn"))) {
			List<ZValue> resultList = super.findAll("findAllByIdCmmnFileDwldSm", param);
			return resultList;
		}

		return new ArrayList<ZValue>();
	}
}
