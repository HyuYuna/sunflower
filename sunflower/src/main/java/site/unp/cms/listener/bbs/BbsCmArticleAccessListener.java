package site.unp.cms.listener.bbs;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import site.unp.cms.listener.ArticleAccessListener;
import site.unp.core.ZValue;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@Component
public class BbsCmArticleAccessListener extends ArticleAccessListener {

	@Override
	@Value("findOneBbsCmAccessInfo")
	public void setQueryId(String queryId) {
		super.setQueryId(queryId);
	}

	@Override
	@Resource(name="SqlDAO")
	public void setSqlDAO(ISqlDAO<ZValue> sqlDAO) {
		super.setSqlDAO(sqlDAO);
	}

	@Override
	protected boolean canAccess(UsersVO user, ZValue result) {
		if (UnpUserDetailsHelper.isAuthenticated("ROLE_ADMINKEY")) {
			return true;
		}

		boolean condition = false;
		if (StringUtils.hasText(result.getString("ntcrId")) && StringUtils.hasText(user.getUserId())) {
			if (result.getString("ntcrId").equals(user.getUserId())) {
				condition = true;
			}
		}
		if (StringUtils.hasText(result.getString("ntcrPin")) && StringUtils.hasText(user.getUserPin())) {
			if (result.getString("ntcrPin").equals(user.getUserPin())) {
				condition = true;
			}
		}
		return condition;
	}
}
