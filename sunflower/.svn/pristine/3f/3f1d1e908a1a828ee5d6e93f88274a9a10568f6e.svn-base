package site.unp.cms.service.cmmnCd.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.service.cmmnCd.CmmnCdClService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
		pageQueryData="menuNo,searchCnd,searchKwd",
		sqlDaoRef="cmmnCdClDAO",
		listenerAndMethods={
			"initParamsListener=insert,update"
		}
)
@CommonServiceLink(desc="공통코드분류 관리 프로그램", linkType=LinkType.BOS)
@Service
public class CmmnCdClServiceImpl extends DefaultCrudServiceImpl implements CmmnCdClService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void insert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.insert(paramCtx);
		MVUtils.setResultProperty(model, SUCCESS, "등록 처리완료 하였습니다.");

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

		long duplCnt = sqlDao.count("countCmmnCdCtgryDuplicate", param);
		if (duplCnt > 0) {
			model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, ERROR);
			model.addAttribute(ModelAndViewResolver.MSG_KEY, "코드분류에 하위 코드ID가 존재하여 삭제할 수 없습니다.");
		}
		else {
			super.delete(paramCtx);
			MVUtils.setResultProperty(model, SUCCESS, "삭제 처리완료 하였습니다.");
		}
	}
}