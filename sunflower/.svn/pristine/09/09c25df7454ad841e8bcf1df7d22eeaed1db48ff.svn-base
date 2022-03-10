package site.unp.cms.service.singl;

import site.unp.core.ParameterContext;

public interface CenterInfoService{

	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 부서정보 가져오기(cDeptId가 있는 경우 해당 부서에 대한 정보, 없을 경우 전체)
	 * @param paramCtx
	 * @throws Exception
	 */
	
	public void listJson(ParameterContext paramCtx) throws Exception ;
	/**
	 * 부서정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	
	public void update(ParameterContext paramCtx) throws Exception ;

	/**
	 * 부서정보 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	
	public void delete(ParameterContext paramCtx) throws Exception ;


	/**
	 * 부서명정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */

	public void updateDeptInfoNm(ParameterContext paramCtx) throws Exception ;

	/**
	 * 부서를 마우스 드래그로 이동 처리 ~
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateUpperDeptId(ParameterContext paramCtx) throws Exception ;

	/*
	public void listPop(ParameterContext paramCtx) throws Exception {
	}
	*/


	/**
	 * 부서 최상위/상위/하위/최하위 이동
	 * @param paramCtx
	 * @throws Exception
	 */
	
	public void updateMoveDeptId(ParameterContext paramCtx) throws Exception;

}
