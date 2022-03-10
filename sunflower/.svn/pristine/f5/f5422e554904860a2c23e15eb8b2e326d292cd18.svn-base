package site.unp.cms.service.myPage.impl;


import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.Assert;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.myPage.QnaService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.dao.bbs.BoardMasterDAO;
import site.unp.core.service.bbs.BbsEstnService;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@CommonServiceDefinition(
	sqlDaoRef="bbsEstnDAO",
	countQueryId="countBbsEstn",
	listQueryId="findAllBbsEstn",
	viewQueryId="findOneBbsEstn",
	updateQueryId="updateBbsEstn",
	pageQueryData="searchCnd,searchWrd,sdate,edate,bbsId,menuNo,viewType",
	listenerAndMethods={
		"bbsInitParamsListener=insert,update",
		"checkBbsListener=restore,delPermanently,delete,insert,update,forInsert,forInsertRe,forUpdate,forUpdateRe",
		"bbsArticleAccessListener=restore,delPermanently,delete,insert,update,forUpdate"
	}
)

@CommonServiceLink(desc="내 게시물")
@Service
public class QnaServiceImpl extends DefaultCrudServiceImpl implements QnaService
{
	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "boardMasterDAO")
	private BoardMasterDAO boardMasterDAO;
	@Resource(name = "bbsEstnService")
	private BbsEstnService bbsEstnService;

	public QnaServiceImpl(){
	}

	@CommonServiceLink(desc="Qna", paramString="pSiteId=ucms")
	@Override
	public void list(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();

		ZValue masterVO = getMasterVAL(paramCtx);

		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		param.put("userPin", member.getUserPin());
		if(masterVO !=null) param.put("tableNm", masterVO.getString("tableNm"));
		bbsEstnService.list(paramCtx);

	}

	@Override
	public void view(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("userVO", member);

		ZValue masterVO = getMasterVAL(paramCtx);
		if(masterVO !=null) param.put("tableNm", masterVO.getString("tableNm"));
		bbsEstnService.view(paramCtx);

	}

	@Override
	public void forUpdate(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("userVO", member);

		ZValue masterVO = getMasterVAL(paramCtx);
		if(masterVO !=null) param.put("tableNm", masterVO.getString("tableNm"));
		bbsEstnService.forUpdate(paramCtx);

	}

	@Override
	public void update(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();

		ZValue masterVO = getMasterVAL(paramCtx);
		if(masterVO !=null) param.put("tableNm", masterVO.getString("tableNm"));
		bbsEstnService.update(paramCtx);
	}

	@Override
	public void delete(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		MemberVO member = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		model.addAttribute("userVO", member);

		ZValue masterVO = getMasterVAL(paramCtx);
		if(masterVO !=null) param.put("tableNm", masterVO.getString("tableNm"));
		bbsEstnService.delete(paramCtx);

	}
	public ZValue getMasterVAL(ParameterContext paramCtx) throws Exception {

		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		ZValue masterVO = boardMasterDAO.findAllBbsMastrDesc().get(param.getString("bbsId"));
		Assert.notNull(masterVO);
		log.debug("masterVO : " + masterVO);
		model.addAttribute("masterVO", masterVO);

		return masterVO;
	}

}
