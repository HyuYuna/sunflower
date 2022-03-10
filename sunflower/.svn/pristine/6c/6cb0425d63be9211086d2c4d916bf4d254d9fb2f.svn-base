package site.unp.cms.service.cmmn.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import site.unp.cms.service.cmmn.CmmnBbsMasterService;
import site.unp.core.ParameterContext;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.service.bbs.BoardMasterService;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;

@CommonServiceDefinition(
	pageQueryData="bbsAttrbCd,searchCnd,searchWrd,menuNo,pSiteId,viewType",
	listQueryId="findAllBbsMastr",
	countQueryId="countBbsMastr"
)
@Service
public class CmmnBbsMasterServiceImpl extends DefaultCrudServiceImpl implements CmmnBbsMasterService{

	@Resource(name = "boardMasterService")
    private BoardMasterService boardMasterService;


	public void listPop(ParameterContext paramCtx) throws Exception {
		boardMasterService.listPop(paramCtx);
	}
}
