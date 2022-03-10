package site.unp.cms.dao.auth;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("authDAO")
public class AuthDAO extends SqlDAO<ZValue> {

}
