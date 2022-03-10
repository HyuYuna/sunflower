package site.unp.cms.service.siteManage;

import site.unp.core.ParameterContext;

public interface PopupService {
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;
	

	//사용자 팝업
	public void userPopup(ParameterContext paramCtx) throws Exception;

	//관리자 팝업
	public void bosPopup(ParameterContext paramCtx) throws Exception;

	/**
	 * 팝업관리 사용여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	
	public void updateUseAt(ParameterContext paramCtx) throws Exception;
	

	public void menuListPop(ParameterContext paramCtx) throws Exception;
}
