package site.unp.cms.service.sys.impl;


import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.sys.PrhibtWrdDicaryService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
	pageQueryData="menuNo,searchCnd,searchKwd,searchUseAt,searchWrdSe",
	listQueryId="findAllPrhibtWrdDicary",
	countQueryId="countPrhibtWrdDicary",
	viewQueryId="findOnePrhibtWrdDicary",
	insertQueryId="savePrhibtWrdDicary",
	updateQueryId="modifyPrhibtWrdDicary",
	deleteQueryId="deletePrhibtWrdDicary"
)
@CommonServiceLink(desc="금지 단어  사전 관리 프로그램", linkType=LinkType.BOS)
@Service
public class PrhibtWrdDicaryServiceImpl extends DefaultCrudServiceImpl implements PrhibtWrdDicaryService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.insert(paramCtx);
		MVUtils.setResultProperty(model, SUCCESS, "등록 정상처리 하였습니다.");

	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.update(paramCtx);
		MVUtils.setResultProperty(model, SUCCESS, "수정 정상처리 하였습니다.");

	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		try{

		if (("").equals(param.getString("wrdSns")) && !("").equals(param.getString("wrdSn"))) {
			param.put ("wrdSns", param.getString("wrdSn")+";");
		}

		String[] wrdSns = param.getString("wrdSns").split(";");
		for (int i = 0 ; i < wrdSns.length; i++){
			sqlDao.deleteById("deletePrhibtWrdDicary", wrdSns[i]);
		}
		MVUtils.setResultProperty(model, SUCCESS, "삭제 정상처리 하였습니다.");
		}catch(Exception e){
			MVUtils.setResultProperty(model, ERROR, "삭제 정상처리 실패하였습니다.");
		}
	}

	public String countWrdNm(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();

		List<ZValue> resultList = sqlDao.findAll("countPrhibtWrdDicaryString", param);
		List<String> workFilterList = new ArrayList<String>();

		for (ZValue vo : resultList) {
			workFilterList.add(vo.getString("wrdNm"));
		}
		if (workFilterList.size() != 0 ){

			for (String ptn : workFilterList) {
				Pattern scriptPattern = Pattern.compile(ptn, Pattern.CASE_INSENSITIVE);
				if (scriptPattern.matcher(param.getString("word")).find()) {
					return ptn;
				}
			}
		}
		return null;
	}

}
