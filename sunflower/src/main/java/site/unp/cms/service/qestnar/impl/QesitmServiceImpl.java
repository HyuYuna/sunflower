package site.unp.cms.service.qestnar.impl;


import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import site.unp.cms.service.qestnar.QesitmService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.UnpCollectionUtils;

@CommonServiceDefinition(
	pageQueryData="searchCnd,searchWrd,menuNo,pageUnit",
	listenerAndMethods={
		"qustnrTrgetCdListener=list,forInsert,forUpdate,view",
		"qesitmTyCdListener=forUpdate,view",
		"bosAccessListener=forInsert,insert,forUpdate,update,delete,updateAnswer"
	}
)
@Service
public class QesitmServiceImpl extends DefaultCrudServiceImpl implements QesitmService{

	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));
		
		super.insert(paramCtx);
		Assert.hasText(param.getString("qesitmSn"));

		updateAnswer(param);
	}

	@Override
	@UnpJsonView
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qesitmSn"));
		
		super.view(paramCtx);
		
		ModelMap model = paramCtx.getModel();
		List<ZValue> answerList = sqlDao.findById("findAnswerByQesitmSn", param.getLong("qesitmSn"));
		model.addAttribute("answerList", answerList);
	}
	
	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));
		
		ZValue result = sqlDao.findOneById("findOneQustnr", param.getLong("qustnrSn"));
		ModelMap model = paramCtx.getModel();
		model.addAttribute(RESULT, result);
		
		List<ZValue> qesitmList = sqlDao.findById("findQesitmByQustnrSn", param.getLong("qustnrSn"));
		model.addAttribute("qesitmList", qesitmList);
		
		if (CollectionUtils.isNotEmpty(qesitmList)) {
			List<String> qesitmSnList = UnpCollectionUtils.extractPropertyList(qesitmList, "qesitmSn");
			List<ZValue> answerList = sqlDao.findAllByIds("findAnswerByQesitmSnData", qesitmSnList);
			Map<String, List<ZValue>> answerMap = UnpCollectionUtils.convertMap(answerList, "qesitmSn_", "qesitmSn");
			model.addAttribute("answerMap", answerMap);
		}
	}

	@Override
	@UnpJsonView
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qesitmSn"));
		
		super.update(paramCtx);
		updateAnswer(param);
	}
	
	private void updateAnswer(ZValue param) throws Exception {
		long qesitmSn = param.getLong("qesitmSn");
		sqlDao.deleteById("deleteAnswerByQesitmSn", qesitmSn);
		int sortOrdr = 0;
		List<String> answerCnList = param.getList("answerCn");
		for (String answerCn : answerCnList) {
			if (StringUtils.hasText(answerCn)) {
				ZValue val = new ZValue();
				val.putObject("answerCn", answerCn);
				val.putObject("qesitmSn", qesitmSn);
				val.putObject("sortOrdr", ++sortOrdr);
				sqlDao.save("saveAnswer", val);
			}
		}
	}
	
	@Override
	@UnpJsonView
	public void delete(ParameterContext paramCtx) throws Exception {
		super.delete(paramCtx);
	}

}
