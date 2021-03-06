package site.unp.cms.service.cmmnCd.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import site.unp.cms.service.cmmnCd.CmmnCdCtgryService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
		pageQueryData="menuNo,clCd,searchCnd,searchKwd",
		sqlDaoRef="cmmnCdCtgryDAO",
		listenerAndMethods={
			"initParamsListener=insert,update,insertCdDetail,updateCdDetail,deleteCdDetail"
		}
)
@CommonServiceLink(desc="공통코드카테고리 관리 프로그램")
@Service
public class CmmnCdCtgryServiceImpl extends CmmnCdDetailServiceImpl implements CmmnCdCtgryService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="ucmsCmmnCdIdGnrService")
    protected EgovIdGnrService idgenService;


	@Override
	public void list(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.list(paramCtx);


		List<ZValue> cmmnClCdList = sqlDao.findAll("findAllCmmnCdClByUse");
		model.addAttribute("cmmnClCdList", cmmnClCdList);

	}

	@Override
	public void forInsert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.forInsert(paramCtx);

		List<ZValue> cmmnClCdList = sqlDao.findAll("findAllCmmnCdClByUse");
		model.addAttribute("cmmnClCdList", cmmnClCdList);

	}

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		//param.put("cdId", idgenService.getNextStringId());
		ZValue resultAt =  sqlDao.findOne("findOneCmmnCdCtgry", param);
		if (resultAt == null) {
			super.insert(paramCtx);
			MVUtils.setResultProperty(model, SUCCESS, "등록 처리완료 하였습니다.");
		}
		else {
	       	MVUtils.setResultProperty(model, ERROR, "중복된 코드가 존재합니다.");
		}
	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.forUpdate(paramCtx);

		List<ZValue> cmmnClCdList = sqlDao.findAll("findAllCmmnCdClByUse");
		model.addAttribute("cmmnClCdList", cmmnClCdList);
	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.update(paramCtx);
		MVUtils.setResultProperty(model, SUCCESS, "수정 처리완료 하였습니다.");

	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		sqlDao.deleteOne("deleteCmmnCdDetailAll", param);
		super.delete(paramCtx);
		MVUtils.setResultProperty(model, SUCCESS, "삭제 처리완료 하였습니다.");
	}

}