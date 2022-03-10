package site.unp.cms.dao.stats;

import java.util.List;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("statsDAO")
public class statsDAO extends SqlDAO<ZValue> {
	public List<ZValue> findAllStats() throws Exception {
		return findAll("findAllStats");
	}
}
