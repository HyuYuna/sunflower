package site.unp.cms.service.qestnar.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import site.unp.cms.service.qestnar.UserAnswerService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition
@CommonServiceLink(desc="사용자 설문 참여 관리", linkType=LinkType.NONE)
@Service
public class UserAnswerServiceImpl extends DefaultCrudServiceImpl implements UserAnswerService {

	@Resource(name="ucmsQustnrUserPinIdGnrService")
    protected EgovIdGnrService idgenService;

	@Override
	@UnpJsonView
	public void list(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}
	
	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));

		UsersVO user = (UsersVO) UnpUserDetailsHelper.getAuthenticatedUser();
		String userId = null;
		if (user != null) {
			userId = user.getUserId();
		}
		else {
			userId = idgenService.getNextStringId();
		}
		param.putObject("userId", userId);

		List<String> qesitmSnList = param.getStartWithList("qesitmSn_");
		for (String q : qesitmSnList) {
			List<String> answerSnList = param.getList("answerSn_" + q);
			ZValue val = new ZValue();
			val.putObject("userId", param.getString("userId"));
			val.putObject("qesitmSn", q);
			for (String a : answerSnList) {
				val.putObject("answerSn", a);
				sqlDao.save("saveUserAnswer", val);
			}
			String answerCn = param.getString("answerCn_" + q);
			if (StringUtils.hasText(answerCn)) {
				val.putObject("answerCn", answerCn);
				sqlDao.save("saveUserAnswer", val);
			}
			String etcAnswerCn = param.getString("etcAnswerCn_" + q);
			if (StringUtils.hasText(etcAnswerCn)) {
				val.putObject("etcAnswerCn", etcAnswerCn);
				sqlDao.save("saveUserEtcAnswer", val);
			}
		}
		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, "설문에 참여해주셔서 감사합니다.");
	}
}