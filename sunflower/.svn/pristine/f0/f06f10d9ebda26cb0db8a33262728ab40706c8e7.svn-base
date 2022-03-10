package site.unp.cms.service.bbs.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import site.unp.cms.service.bbs.BbsMasterService;
import site.unp.cms.service.bbs.acl.BbsAclService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.dao.bbs.BoardMasterDAO;
import site.unp.core.service.bbs.impl.BoardMasterServiceImpl;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@CommonServiceDefinition(
	pageQueryData="bbsAttrbCd,searchCnd,searchWrd,menuNo,pSiteId,viewType,searchSiteId",
	sqlDaoRef="boardMasterDAO",
	listenerAndMethods={
		"bosAccessListener",
	}
)
public class BbsMasterServiceImpl extends BoardMasterServiceImpl implements BbsMasterService {

	@Resource(name = "bbsAclService")
	private BbsAclService bbsAclService;

	public void forUpdateRole(ParameterContext paramCtx) throws Exception {
		super.doList(paramCtx, "findAllAuth", "countAuth");
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		Map<String, List<ZValue>> roleMap = bbsAclService.readAcesById(param.getString("bbsId"));
		model.addAttribute("roleMap", roleMap);
	}

	@UnpJsonView
	public void updateRole(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		bbsAclService.save(param);
		String goUrl = WebFactory.buildUrl("/bos/bbs/authMaster/forUpdateRole.do", param, "bbsId", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "정상처리하였습니다.", model);
	}

	public void forUpdateFileUpload(ParameterContext paramCtx) throws Exception {
		super.view(paramCtx);
	}

	@UnpJsonView
	public void updateFileUpload(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Assert.hasLength(param.getString("bbsId"));

		WebFactory.setUserInfoParam(param);
		getSqlDao(BoardMasterDAO.class).modify("updateFileUpload", param);

		ModelMap model = paramCtx.getModel();
		String goUrl = WebFactory.buildUrl("/bos/bbs/authMaster/forUpdateFileUpload.do", param, "bbsId", "menuNo", "pageIndex");
		MVUtils.goUrl(goUrl, "정상처리하였습니다.", model);
	}



}
