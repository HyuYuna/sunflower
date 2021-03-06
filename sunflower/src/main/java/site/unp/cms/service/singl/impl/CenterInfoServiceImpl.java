package site.unp.cms.service.singl.impl;


import java.net.URLDecoder;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.service.singl.CenterInfoService;
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
@CommonServiceLink(desc="센터관리", linkType=LinkType.BOS)
@Service
public class CenterInfoServiceImpl extends DefaultCrudServiceImpl implements CenterInfoService{

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
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		List<ZValue> result = sqlDao.findAll("findAllCenterInfo", param);
		model.addAttribute("resultList", result);
		
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

		if (StringUtils.hasText(param.getString("cCenterCode"))) {
			ZValue result = sqlDao.findOneById("findOneByIdCenterInfo", param);
			model.addAttribute("singleJsonData", result);
		}
		else {
			List<ZValue> listMenu = sqlDao.findAll("findAllCenterInfo", param);
			model.addAttribute("singleJsonData", listMenu);
		}
		
	}
	
	public void view(ParameterContext paramCtx) throws Exception {
	    ZValue param = paramCtx.getParam();
	    ModelMap model = paramCtx.getModel();

		ZValue result = sqlDao.findOne("findOneByIdCenterInfo", param);

		model.put("result", result);
	}

	/**
	 * 부서정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		model.put("center", param.get("cntrCod"));
		
		sqlDao.modify("updateCenterInfo", param);
		sqlDao.modify("updateCenterInfoUseYn", param);
		
		MVUtils.goUrl("/bos/singl/centerInfo/view.do?cntrCod="+ param.get("cntrCod"), null, model);
    	
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

    	long cnt = sqlDao.count("countCenterInfoMngr", param);
    	/*if (cnt > 0) {
    		MVUtils.setResultProperty(model, ERROR, "관리자에 부서가 지정되어 있어 삭제가 불가능합니다.\n해당관리자에 부서를 변경 하신 후 삭제해 주시기 바랍니다.");
    		return;
    	}*/
    	
    	/*System.out.println(paramCtx);
    	System.out.println(param);
    	System.out.println(model);*/

    	sqlDao.modify("updateCenterInfoUseAt", param);
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

		sqlDao.modify("updateCenterInfoNm", param);
		model.addAttribute("cDeCenter", param.getString("cDeptId"));
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
    	sqlDao.modify("updateMenuForUpperCenterId", param);
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
			sqlDao.modify("updateMoveCenterId", param);
		}

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

}