package site.unp.cms.dao.cmmnCd;

import java.util.List;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("cmmnCdCtgryDAO")
public class CmmnCdCtgryDAO extends SqlDAO<ZValue> {

	public List<String> findAllCdId() throws Exception {
		return getSqlSession().selectList("findAllCdId");
	}
}
