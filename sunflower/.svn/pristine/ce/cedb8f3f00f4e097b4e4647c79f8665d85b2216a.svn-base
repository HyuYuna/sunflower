package site.unp.cms.service.main;

import site.unp.core.ParameterContext;

public interface MainService{
	
	public static final String PORTAL_MAIN_CACHE_NAME = "storedMain";

	public void main(ParameterContext paramCtx) throws Exception;

	/*
	public void main(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		ModelMap model = paramCtx.getModel();

		//실명인증 처리후 실명인증 비 종료 시 남은 인증삭제
		UsersVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null && "ROLE_VNAME".equals(user.getAuthorCd())) {
			SecurityContextHolder.clearContext();
		}
		if (paramCtx.getRequest().getSession() != null) paramCtx.getRequest().getSession().removeAttribute(AUTH_SESSION_KEY);

		// 공통게시판
		for (String bbsId : MAIN_BBS_IDS) {
			int num = 4; // 게시물 갯수
			if ("B0000240".equals(bbsId)) num = 4;
			else if ("B0000238".equals(bbsId)) num = 1;
			List<ZValue> boardList = getBbs(bbsId, num);
			model.addAttribute(bbsId + "List", boardList);
		}


		List<ZValue> ntcnRelmList = ntcnRelmDAO.selectPublishList(SiteInfoService.UCMS_SITE_ID, null);
		model.addAttribute("ntcnRelmList", ntcnRelmList);

		model.addAttribute("popupList", popupDAO.findPopupBySiteIdSe(SiteInfoService.UCMS_SITE_ID));
	}
	*/

	public void preview(ParameterContext paramCtx) throws Exception;

	public void contents(ParameterContext paramCtx) throws Exception;

	public void forPrint(ParameterContext paramCtx) throws Exception;

	public void siteGo(ParameterContext paramCtx) throws Exception;

	public void removeCache(ParameterContext paramCtx) throws Exception;

	public void removeCacheAll(ParameterContext paramCtx) throws Exception;


}