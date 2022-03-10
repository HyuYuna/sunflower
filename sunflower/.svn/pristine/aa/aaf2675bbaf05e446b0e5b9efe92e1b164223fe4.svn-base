package site.unp.cms.service.cmmnCd.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.cms.dao.cmmnCd.CmmnCdDetailDAO;
import site.unp.cms.service.cmmnCd.CmmnCdDetailService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
		pageQueryData="menuNo,searchCnd,searchKwd,viewType,cdId",
		sqlDaoRef="cmmnCdDetailDAO",
		listenerAndMethods={
			"initParamsListener=insertCdDetail,updateCdDetail,deleteCdDetail"
		}
)
@CommonServiceLink(desc="공통코드상세 관리 프로그램")
@Service
public class CmmnCdDetailServiceImpl extends DefaultCrudServiceImpl implements CmmnCdDetailService {


	@Resource(name="cmmnCdDetailDAO")
    private CmmnCdDetailDAO cmmnCdDetailDAO;

	Logger log = LoggerFactory.getLogger(this.getClass());

	/**
	 * 카테고리 상세 목록을 조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listCdDetailPop(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		
		ModelMap model = paramCtx.getModel();
		ZValue cdCtgryVO=  sqlDao.findOne("findOneCmmnCdCtgry", param);
    	model.addAttribute("cdCtgryVO", cdCtgryVO);
    	
    	
    	//List<ZValue> cmmnCdList = cmmnCdDetailDAO.findAllCmmnCdDetail(param.getString("cdId"), param.getString("upperCd"));
    	//model.addAttribute("list", cmmnCdList);
    	if (!"".equals(param.getString("codeCode",""))) {
    		ZValue detailCdVO = sqlDao.findOne("findOneCmmnCdDetail", param);
        	model.addAttribute("result", detailCdVO);
    	}
	}
	
	
	/*public void listDetail(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		ZValue cdCtgryVO=  sqlDao.findOne("findOneCmmnCdCtgry", param);
    	model.addAttribute("cdCtgryVO", cdCtgryVO);
    	//List<ZValue> cmmnCdList = cmmnCdDetailDAO.findAllCmmnCdDetail(param.getString("cdId"), param.getString("upperCd"));
    	//model.addAttribute("list", cmmnCdList);
    	if (!"".equals(param.getString("cd",""))) {
    		ZValue detailCdVO = sqlDao.findOne("findOneCmmnCdDetail", param);
        	model.addAttribute("result", detailCdVO);
    	}
	}*/
	
	

	/**
	 * 공통상세코드 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateCdDetail(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		
		cmmnCdDetailDAO.modify("updateCmmnCdDetail", param);
		
		String url = returnUrlQueryCmmnCd("/bos/cmmnCd/cmmnCdCtgry/listCdDetailPop.do", param);
		
       	model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
       	MVUtils.setResultProperty(model, SUCCESS, "수정 처리완료 하였습니다.");

	}

	/**
	 * 공통 상세코드 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void insertCdDetail(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		String url = returnUrlQueryCmmnCd("/bos/cmmnCd/cmmnCdCtgry/listCdDetailPop.do", param);
		ZValue resultAt =  sqlDao.findOne("findOneCmmnCdDetail", param);
		if(resultAt == null){
			cmmnCdDetailDAO.save("saveCmmnCdDetail", param);
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
	       	MVUtils.setResultProperty(model, SUCCESS, "등록 처리완료 하였습니다.");
		}else{
			model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
	       	MVUtils.setResultProperty(model, ERROR, "중복된 코드가 존재합니다.");
		}
	}

	@UnpJsonView
	public void listJson(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		if (StringUtils.hasText(param.getString("codeCode"))) {
			ZValue result = sqlDao.findOneById("findOneCmmnCdDetail", param);
			model.addAttribute("singleJsonData", result);
		}
		else {
			/*System.out.println("====================================================================================");
			System.out.println(param);
			System.out.println("====================================================================================");*/
			List<ZValue> cmmnCodeList = cmmnCdDetailDAO.findAllCmmnCdDetail(param);
			model.addAttribute("singleJsonData", cmmnCodeList);
		}



	}

	/**
	 * 공통상세코드 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void deleteCdDetail(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		String url = returnUrlQueryCmmnCd("/bos/cmmnCd/cmmnCdCtgry/listCdDetailPop.do", param);
		cmmnCdDetailDAO.deleteOne("deleteCmmnCdDetail", param);

		model.addAttribute(ModelAndViewResolver.GO_URL_KEY, url);
       	MVUtils.setResultProperty(model, SUCCESS, "삭제 처리완료 하였습니다.");
	}

	/**
	 * 공통상세코드 정렬순서 가져오기
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void getSortOrdr(ParameterContext paramCtx) throws Exception{
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		long cnt = sqlDao.count("countMaxSortOrdr", param);
		model.addAttribute("maxSortOrdr",cnt);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	/**
	 * 코드명정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateCdNm(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

    	cmmnCdDetailDAO.modify("updateDeptInfoNm", param);
		model.addAttribute("cDeptId", param.getString("cDeptId"));
		model.addAttribute("useAt", param.getString("useAt"));

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}


	/**
	 * 코드 최상위/상위/하위/최하위 이동
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void updateMoveCd(ParameterContext paramCtx) throws Exception {
    	ZValue param = paramCtx.getParam();
    	ModelMap model = paramCtx.getModel();

		String[] listCd = param.getString("cdData").split(",");
		int ordr = 0;
		for (String codeCode : listCd) {
			param.put("sortOrdr", ordr += 10);
			param.put("codeCode", codeCode);
			cmmnCdDetailDAO.modify("updateMoveCd", param);
		}

    	model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}


	/**
	 * 공통코드 (등록/수정 /삭제) 등등 리턴페이지 쿼리 만드는 메소드
	 * @param cmmnCodeUrl
	 * @param param
	 * @return
	 */
	public String returnUrlQueryCmmnCd(String cmmnCodeUrl,ZValue param) throws Exception {
		return WebFactory.buildUrl(cmmnCodeUrl, param, "menuNo", "viewType", "codegCode");
	}

}
