package site.unp.cms.service.cmmn;

import site.unp.core.ParameterContext;


public interface CmmnMenuService {


	public void listMenuPop(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 메뉴목록 조회 - (json type으로 조회)
 	 * @param paramCtx
	 * @throws Exception
	 */
	public void listJson(ParameterContext paramCtx) throws Exception;

}
