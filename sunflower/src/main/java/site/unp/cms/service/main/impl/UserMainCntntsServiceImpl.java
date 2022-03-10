package site.unp.cms.service.main.impl;


import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import site.unp.cms.dao.main.UserMainCntntsDAO;
import site.unp.cms.service.main.UserMainCntntsService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.handler.ListHandler;
import site.unp.core.mvr.ModelAndViewResolver;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
		sqlDaoRef="userMainCntntsDAO",
				pageQueryData="menuNo",
		serviceName="userMainCntntsService",
		insertQueryId="saveUserMainCntnts",
		updateQueryId="updateUserMainCntnts",
		deleteQueryId="deleteUserMainCntnts"
)
@Service
public class UserMainCntntsServiceImpl extends DefaultCrudServiceImpl implements UserMainCntntsService{

	@Resource(name="defaultListHandler")
	private ListHandler listHandler;

	/**
	 * 사용자 메인콘텐츠관리 화면
	 * @param paramCtx
	 * @throws Exception
	 */
	@CommonServiceLink(desc="사용자 메인관리", linkType=LinkType.BOS, paramString="pSiteId=ucms")
	public void main(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();
		List<ZValue> resultList = getSqlDao(UserMainCntntsDAO.class).findAll("findAllUserMainCntnts", param);
		model.addAttribute("fileMap", listHandler.getFileMap(param, resultList));
		for (ZValue vo : resultList) {
			model.addAttribute("relmSeCd"+vo.getString("relmSeCd"), vo);
		}
	}

	/**
	 * 사용자 메인콘텐츠 상세관리  팝업화면
	 * @param paramCtx
	 * @throws Exception
	 */
	public void mainPopup(ParameterContext paramCtx) throws Exception {
		super.view(paramCtx);
	}

	/**
	 * 사용자 메인콘텐츠 등록처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insert(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		super.insert(paramCtx);

		MVUtils.confirmUrl("/bos/main/userMainCntnts/main.do?pSiteId="+param.getString("pSiteId")+"&menuNo="+param.getString("menuNo"),"등록 처리되었습니다.", model);
		//model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
		//model.addAttribute(ModelAndViewResolver.MSG_KEY, "댓글이 등록되었습니다.");
	}

	/**
	 * 사용자 메인콘텐츠 수정처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void update(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		ZValue param = paramCtx.getParam();
		super.update(paramCtx);

		MVUtils.confirmUrl("/bos/main/userMainCntnts/main.do?pSiteId="+param.getString("pSiteId")+"&menuNo="+param.getString("menuNo"),"등록 처리되었습니다.", model);
		//MVUtils.winCloseReload("수정 처리되었습니다.", model);
	}

	/**
	 * 사용자 메인콘텐츠 삭제처리
	 * @param paramCtx
	 * @throws Exception
	 */
	@UnpJsonView
	public void delete(ParameterContext paramCtx) throws Exception {
		ModelMap model = paramCtx.getModel();
		super.delete(paramCtx);
		model.addAttribute(ModelAndViewResolver.RESULT_CODE_KEY, SUCCESS);
	}

	public void listPopup(ParameterContext paramCtx) throws Exception {
		super.doList(paramCtx,"findAllUserMainCntntsBbsMastr","countUserMainCntntsBbsMastr");
	}
}
