package site.unp.cms.dao.bbs;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Repository;

import site.unp.cms.service.main.MainService;
import site.unp.core.ZValue;
import site.unp.core.dao.bbs.AbstractBbsEstnDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@Repository("bbsEstnDAO")
public class BbsEstnDAO extends AbstractBbsEstnDAO {

	public ZValue findOneBbsEstnReByBbsIdAndNttId(String tableNm, String bbsId, long nttId) throws Exception {
		ZValue param = new ZValue();
		param.putObject("tableNm", tableNm);
		param.putObject("bbsId", bbsId);
		param.putObject("nttId", nttId);
		return findOne("findOneBbsEstnReByBbsIdAndNttId", param);
	}

	public int modifyBbsEstnAnswerAt(String tableNm, String bbsId, long nttId) throws Exception {
		ZValue param = new ZValue();
		param.putObject("tableNm", tableNm);
		param.putObject("bbsId", bbsId);
		param.putObject("parntsNo", nttId);

		long count = count("countBbsEstnReply", param);
		if (count > 0) {
			param.putObject("answerAt", "Y");
		}
		else {
			param.putObject("answerAt", "N");
		}
		param.putObject("nttId", nttId);
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.putObject("updtId", user.getUserId());
		return modify("modifyBbsEstnAnswerAt", param);
	}

	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	@Override
	public Object save(String queryId, ZValue param) throws Exception {
		return super.save(queryId, param);
	}

	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	@Override
	public int modify(String queryId, ZValue param) throws Exception {
		return super.modify(queryId, param);
	}

	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	@Override
	public int deleteOne(String queryId, ZValue param) throws Exception {
		return super.deleteOne(queryId, param);
	}

}
