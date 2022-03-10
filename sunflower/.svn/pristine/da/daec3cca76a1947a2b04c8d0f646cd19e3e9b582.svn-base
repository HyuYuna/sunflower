package site.unp.cms.service.singl.impl;


import java.net.URLDecoder;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.singl.DeptInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
		pageQueryData="menuNo,searchCnd,searchKwd",
		listenerAndMethods={
			"initParamsListener=insert,update",
			"telno1CdListener=list"
		}
)
@CommonServiceLink(desc="홈페이지 관리자 부서관리", linkType=LinkType.BOS)
@Service
public class DeptInfoServiceImpl extends DefaultCrudServiceImpl implements DeptInfoService{

	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
    	String deptKorNm = URLDecoder.decode(param.getString("deptKorNm"), "UTF-8");
    	param.put("deptKorNm", URLDecoder.decode(deptKorNm, "UTF-8"));

		super.insert(paramCtx);

		paramCtx.getModel().addAttribute("cDeptId", param.getString("deptId"));
	}

	/**
	 * 부서목록
	 * @param paramCtx
	 * @throws Exception
	 */
	@Override
	public void list(ParameterContext paramCtx) throws Exception {

	}

	/**
	 * 부서정보 가져오기(cDeptId가 있는 경우 해당 부서에 대한 정보, 없을 경우 전체)
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void listJson(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (StringUtils.hasText(param.getString("cDeptId"))) {
			ZValue result = sqlDao.findOneById("findOneByIdDeptInfo", param);
			model.addAttribute("singleJsonData", result);
		}
		else {
			List<ZValue> listMenu = sqlDao.findAll("findAllDeptInfo", param);
			model.addAttribute("singleJsonData", listMenu);
		}
	}

	/**
	 * 부서정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void update(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	super.update(paramCtx);
    	String useAt = param.getString("useAt");

    	/* 미사용일 경우 하위 뎁스전부 미사용처리 */
    	if ("N".equals(useAt)) {
    		String subDeptIdStr = param.getString("subDeptIdStr","");
        	String[] subDeptIds = null;
        	if (!"".equals(subDeptIdStr)) {
        		subDeptIds = subDeptIdStr.split(",");
        	}

        	if (subDeptIds!=null){
	        	for (String item : subDeptIds) {
	        		param.put("cDeptId", item);
	        		sqlDao.modify("updateDeptInfoUseAt", param);
	        	}
        	}
    	}

	}

	/**
	 * 부서정보 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void delete(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	long cnt = sqlDao.count("countDeptInfoMngr", param);
    	if (cnt > 0) {
    		MVUtils.setResultProperty(model, ERROR, "관리자에 부서가 지정되어 있어 삭제가 불가능합니다.\n해당관리자에 부서를 변경 하신 후 삭제해 주시기 바랍니다.");
    		return;
    	}

    	super.delete(paramCtx);
	}


	/**
	 * 부서명정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateDeptInfoNm(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

		sqlDao.modify("updateDeptInfoNm", param);
		model.addAttribute("cDeptId", param.getString("cDeptId"));
		model.addAttribute("useAt", param.getString("useAt"));

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 부서를 마우스 드래그로 이동 처리 ~
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateUpperDeptId(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();
    	sqlDao.modify("updateMenuForUpperDeptId", param);
    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/*
	public void listPop(ParameterContext paramCtx) throws Exception {
	}
	*/


	/**
	 * 부서 최상위/상위/하위/최하위 이동
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateMoveDeptId(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	String[] listDept = param.getString("deptData").split(",");
		int ordr = 0;
		for (String deptId : listDept) {
			param.put("sortOrdr", ordr += 10);
			param.put("cDeptId", deptId);
			sqlDao.modify("updateMoveDeptId", param);
		}

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

}