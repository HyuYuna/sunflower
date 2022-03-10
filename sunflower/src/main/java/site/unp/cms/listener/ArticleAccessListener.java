package site.unp.cms.listener;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.exception.UnpBizException;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;

public class ArticleAccessListener extends CommonListenerSupport {

	private String queryId;
	private ISqlDAO<ZValue> sqlDAO;

	@Override
	public void before(ParameterContext paramCtx) throws Exception {
		if ( UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY") ) {
			return;
		}

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		ZValue result = sqlDAO.findOne(queryId, paramCtx.getParam());
		boolean me = canAccess(user, result);
		if (!me) {
			throw new UnpBizException("잘못된 접근입니다.");
		}
		
	}
	
	protected boolean canAccess(UsersVO user, ZValue result) {
		return true;
	}

	public String getQueryId() {
		return queryId;
	}

	public void setQueryId(String queryId) {
		this.queryId = queryId;
	}

	public ISqlDAO<ZValue> getSqlDAO() {
		return sqlDAO;
	}

	public void setSqlDAO(ISqlDAO<ZValue> sqlDAO) {
		this.sqlDAO = sqlDAO;
	}
}
