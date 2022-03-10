package site.unp.cms.service.qestnar.impl;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.qestnar.QustnrService;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.MVUtils;
import site.unp.core.util.UnpCollectionUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
	pageQueryData="searchCnd,searchWrd,menuNo,pageUnit",
	listenerAndMethods={
		"qustnrTrgetCdListener=list,forInsert,forUpdate,view",
		"bosAccessListener=forInsert,insert,forUpdate,update,delete"
	}
)
@CommonServiceLink(desc="설문조사 관리")
@UnpJsonView
@Service
public class QustnrServiceImpl extends DefaultCrudServiceImpl implements QustnrService{

	private static final SimpleDateFormat DE_PATTERN = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initParam(param);

		super.insert(paramCtx);
	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		super.view(paramCtx);

		if (!SiteInfoService.BOS_SITE_ID.equals(param.getString("siteId"))) {
			ZValue result = (ZValue) model.get("result");
			Boolean flag = true;
			String msg = "";
			
			if ("W".equals(result.getString("status"))) {
				msg = "진행예정인 설문조사 입니다.";
				flag = false;
			} else if ("F".equals(result.getString("status"))) {
				//msg = "마감된 설문조사 입니다.";
				//flag = false;
				String goUrl = WebFactory.buildUrl("/bos/qestnar/qustnr/userAnswer.do", param, "qustnrSn", "menuNo", "pageIndex");
			}
			if (flag && ("M".equals(result.getString("qustnrTrgetCd"))) && !UnpUserDetailsHelper.isAuthenticated("ROLE_USERKEY")) {
				msg = "죄송합니다.\\n설문조사 대상자가 아닙니다.";
				flag = false;
			}
			MemberVO user = (MemberVO) UnpUserDetailsHelper.getAuthenticatedUser();
			if (user != null) {
				param.put("userPin", user.getUserPin());
				if (flag && (user.getUserPin().equals(sqlDao.findOne("findQustnrPartcptnUserPin", param)))) {
					//msg = "이미 설문조사에 참여하셨습니다.";
				//	flag = false;
				}
			}
			if (!flag) {
				MVUtils.goUrl("javascript:history.back()", msg, model);
			}
		}
		
		List<ZValue> qesitmList = sqlDao.findById("findQesitmByQustnrSn", param.getLong("qustnrSn"));
		model.addAttribute("qesitmList", qesitmList);

		if (CollectionUtils.isNotEmpty(qesitmList)) {
			List<String> qesitmSnList = UnpCollectionUtils.extractPropertyList(qesitmList, "qesitmSn");
			List<ZValue> answerList = sqlDao.findAllByIds("findAnswerByQesitmSnData", qesitmSnList);
			Map<String, List<ZValue>> answerMap = UnpCollectionUtils.convertMap(answerList, "qesitmSn_", "qesitmSn");
			model.addAttribute("answerMap", answerMap);
		}

		ZValue result = (ZValue)model.get(RESULT);
		model.addAttribute("canAnswer", canAnswer(result));

	}
	
	public void userView(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		super.view(paramCtx);

		
		ZValue result = (ZValue) model.get("result");
		
		MemberVO user = (MemberVO) UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userId", user.getUserId());
		
		/*System.out.println("1번 result : " + result);*/
		
		/* flag = 0 진행중(userview)
		 * flag = 1 완료 or 참여후 (userAnswer)
		 * flag = 2 진행예정 or 대상아님 (list)
		 */
		int flag = 0;
		String msg = "";
		String goUrl = "";
		
		if ("W".equals(result.getString("status"))) {
			msg = "진행예정인 설문조사 입니다.";
			flag = 2;	// list
		} else if ("F".equals(result.getString("status"))) {
			//msg = "마감된 설문조사 입니다.";
			flag = 1;	// userAnswer
			goUrl = WebFactory.buildUrl("/bos/qestnar/qustnr/userAnswer.do", param, "qustnrSn", "menuNo", "pageIndex");
		}
		
		if (flag==0 && ("M".equals(result.getString("qustnrTrgetCd"))) && user.getUserId() == "") {
			msg = "죄송합니다.\\n설문조사 대상자가 아닙니다.";
			flag = 2;	// list
		}
		
		if (user != null) {
			
			if (flag==0 && (user.getUserId().equals(sqlDao.findOne("findQustnrPartcptnUserId", param)))) {
				//msg = "이미 설문조사에 참여하셨습니다.";
				flag = 1;	// userAnswer
				goUrl = WebFactory.buildUrl("/bos/qestnar/qustnr/userAnswer.do", param, "qustnrSn", "menuNo", "pageIndex");
			}
		}
		if (flag==2) {
			MVUtils.goUrl("javascript:history.back()", msg, model);
		}else if (flag==1) {
			model.addAttribute("goUrl", goUrl);
		}
		
		List<ZValue> qesitmList = sqlDao.findById("findQesitmByQustnrSn", param.getLong("qustnrSn"));
		model.addAttribute("qesitmList", qesitmList);

		if (CollectionUtils.isNotEmpty(qesitmList)) {
			List<String> qesitmSnList = UnpCollectionUtils.extractPropertyList(qesitmList, "qesitmSn");
			List<ZValue> answerList = sqlDao.findAllByIds("findAnswerByQesitmSnData", qesitmSnList);
			Map<String, List<ZValue>> answerMap = UnpCollectionUtils.convertMap(answerList, "qesitmSn_", "qesitmSn");
			model.addAttribute("answerMap", answerMap);
		}

		//ZValue result = (ZValue)model.get(RESULT);
		model.addAttribute("canAnswer", canAnswer(result));

	}
	
	public void userAnswer(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasText(param.getString("qustnrSn"));
		
		System.out.println("========================================================");
		System.out.println(param.getLong("qustnrSn"));
		
		ZValue result = sqlDao.findOneById("findOneQustnr", param.getLong("qustnrSn"));

		if(!result.getString("resultOthbcAt").equals("Y")){
			HttpUtil.goUrl(paramCtx.getResponse(), "javascript:history.back();", "결과보기가 공개되지 않은 설문입니다.");
		}
		
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
	
	

	public void userList(ParameterContext paramCtx) throws Exception {
		super.list(paramCtx);
	}
	
	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		super.forUpdate(paramCtx);

		ModelMap model = paramCtx.getModel();
		ZValue result = (ZValue)model.get(RESULT);
		Date bgnde = (Date)result.get("bgnde");
		if (bgnde != null) {
			String bgndeStr = DE_PATTERN.format(bgnde);
			formatDe("bgnde", bgndeStr, result);
		}

		Date endde = (Date)result.get("endde");
		if (endde != null) {
			String enddeStr = DE_PATTERN.format(endde);
			formatDe("endde", enddeStr, result);
		}
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		initParam(param);

		super.update(paramCtx);
	}

	private void formatDe(String attrName, String de, ZValue param) {
		String[] data1 = StringUtils.delimitedListToStringArray(de, " ");
		if (ArrayUtils.isNotEmpty(data1) && data1.length == 2) {
			String bgnde1 = data1[0];
			param.putObject(attrName+"1", bgnde1);
			String[] data2 = StringUtils.delimitedListToStringArray(data1[1], ":");
			if (ArrayUtils.isNotEmpty(data2) && data2.length == 2) {
				String bgnde2 = data2[0];
				String bgnde3 = data2[1];
				param.putObject(attrName+"2", bgnde2);
				param.putObject(attrName+"3", bgnde3);
			}
		}
	}

	private void initParam(ZValue param) throws Exception {
		if(!"".equals(param.getString("bgnde1","")) && !"".equals(param.getString("bgnde2","")) && !"".equals(param.getString("bgnde3",""))){
			String bgnde = param.getString("bgnde1") + " " + param.getString("bgnde2") + ":" + param.getString("bgnde3");
			Date bgndeDate = DE_PATTERN.parse(bgnde);
			param.putObject("bgnde", bgndeDate);
		}

		if(!"".equals(param.getString("endde1","")) && !"".equals(param.getString("endde2","")) && !"".equals(param.getString("endde3",""))){
			String endde = param.getString("endde1") + " " + param.getString("endde2") + ":" + param.getString("endde3");
			Date enddeDate = DE_PATTERN.parse(endde);
			param.putObject("endde", enddeDate);
		}
	}

	private boolean canAnswer(ZValue result) {
		String status = result.getString("status");
		if (!"P".equals(status)) {
			return false;
		}

		boolean view = true;
		String qustnrTrgetCd = result.getString("qustnrTrgetCd");
		if ("M".equals(qustnrTrgetCd)) { //회원
			if (!UnpUserDetailsHelper.isAuthenticated("ROLE_USERKEY")) {
				view = false;
			}
		}
		return view;
	}
}
