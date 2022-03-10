package site.unp.cms.service.qestnar.impl;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import site.unp.cms.service.qestnar.AnswerService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.UnpCollectionUtils;

@CommonServiceDefinition (
	listenerAndMethods={
		"qustnrTrgetCdListener=downloadExcel,downloadUserAnswerExcel,view",
		"bosAccessListener=forInsert,insert,forUpdate,update,delete,updateAnswer"
	}
)
@UnpJsonView
@Service
public class AnswerServiceImpl extends DefaultCrudServiceImpl implements AnswerService {

	@Override
	@CommonServiceLink(desc="설문조사 결과 통계 보기")
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));
		
		ZValue result = sqlDao.findOneById("findOneQustnr", param.getLong("qustnrSn"));
		ModelMap model = paramCtx.getModel();
		model.addAttribute(RESULT, result);
		
		List<ZValue> qesitmList = sqlDao.findById("findQesitmStatusByQustnrSn", param.getLong("qustnrSn"));
		model.addAttribute("qesitmList", qesitmList);
		
		if (CollectionUtils.isNotEmpty(qesitmList)) {
			List<String> qesitmSnList = UnpCollectionUtils.extractPropertyList(qesitmList, "qesitmSn");
			List<ZValue> answerList = sqlDao.findAllByIds("findAnswerStatusByQesitmSnData", qesitmSnList);
			Map<String, List<ZValue>> answerMap = UnpCollectionUtils.convertMap(answerList, "qesitmSn_", "qesitmSn");
			model.addAttribute("answerMap", answerMap);
		}
	}
	
	@CommonServiceLink(desc="설문조사 결과")
	public void userView(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));
		
		ZValue result = sqlDao.findOneById("findOneQustnr", param.getLong("qustnrSn"));
		ModelMap model = paramCtx.getModel();
		model.addAttribute(RESULT, result);
		
		List<ZValue> qesitmList = sqlDao.findById("findQesitmStatusByQustnrSn", param.getLong("qustnrSn"));
		model.addAttribute("qesitmList", qesitmList);
		
		if (CollectionUtils.isNotEmpty(qesitmList)) {
			List<String> qesitmSnList = UnpCollectionUtils.extractPropertyList(qesitmList, "qesitmSn");
			List<ZValue> answerList = sqlDao.findAllByIds("findAnswerStatusByQesitmSnData", qesitmSnList);
			Map<String, List<ZValue>> answerMap = UnpCollectionUtils.convertMap(answerList, "qesitmSn_", "qesitmSn");
			model.addAttribute("answerMap", answerMap);
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	@CommonServiceLink(desc="설문조사 결과 통계 엑셀다운로드", linkType=LinkType.NONE)
	public void downloadExcel(ParameterContext paramCtx) throws Exception {
		view(paramCtx);
		
		ModelMap model = paramCtx.getModel();
		List<ZValue> qesitmList = (List<ZValue>)model.get("qesitmList");
		if (CollectionUtils.isNotEmpty(qesitmList)) {
			List<String> qesitmSnData = UnpCollectionUtils.extractPropertyList(qesitmList, "qesitmSn");
			if (CollectionUtils.isNotEmpty(qesitmSnData)) {
				List<ZValue> userAnswerList = sqlDao.findAllByIds("findlUserAnswerByQesitmSnData", qesitmSnData);
				Map<String, List<ZValue>> userAnswerMap = UnpCollectionUtils.convertMap(userAnswerList, "qesitmSn_", "qesitmSn");
				model.addAttribute("userAnswerMap", userAnswerMap);
			}
		}
	}

	@CommonServiceLink(desc="설문조사 참여현황 통계 엑셀다운로드", linkType=LinkType.NONE)
	public void downloadUserAnswerExcel(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));
		
		ZValue result = sqlDao.findOneById("findOneQustnr", param.getLong("qustnrSn"));
		ModelMap model = paramCtx.getModel();
		model.addAttribute(RESULT, result);

		List<ZValue> qesitmList = sqlDao.findById("findQesitmStatusByQustnrSn", param.getLong("qustnrSn"));
		model.addAttribute("qesitmList", qesitmList);
		List<ZValue> userAnswerList = sqlDao.findById("findUserAnswerByQustnrSn", param.getLong("qustnrSn"));
		if (CollectionUtils.isNotEmpty(userAnswerList)) {
			List<ZValue> resultList = new ArrayList<ZValue>();
			Map<String, List<ZValue>> userAnswerMap = UnpCollectionUtils.convertMap(userAnswerList, "", "userSn");
			for (Map.Entry<String, List<ZValue>> entry : userAnswerMap.entrySet()) {
				List<ZValue> uaList = entry.getValue();
				ZValue val = new ZValue();
				int q = 0;
				for (ZValue qesitmVal : qesitmList) {
					q++;
					int qesitmTyCd = qesitmVal.getInt("qesitmTyCd");
					String ua = "";
					for (ZValue uaVal : uaList) {
						if ( uaVal.getString("qesitmSn").equals(qesitmVal.getString("qesitmSn")) ) {
							if (qesitmTyCd == 1 || qesitmTyCd == 2) {
								ua += ("".equals(ua) ? "" : ",") + uaVal.getString("sortOrdr");
							}
							else {
								ua = uaVal.getString("answerCn");
							}
							val.putObject("userId", uaVal.getString("userId"));
							val.putObject("userNm", uaVal.getString("userNm"));
						}
					}
					if (!StringUtils.hasText(ua)) {
						ua = "-";
					}
					else if (ua.endsWith(",") && qesitmTyCd == 2) {
						ua = ua.substring(0, ua.length()-1);
					}
					val.putObject("Q"+q, ua);
				}
				resultList.add(val);
			}
			model.addAttribute(RESULT_LIST, resultList);
		}
	}
}