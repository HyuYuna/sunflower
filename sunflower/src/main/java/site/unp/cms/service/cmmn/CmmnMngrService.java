package site.unp.cms.service.cmmn;


import site.unp.core.ParameterContext;

public interface CmmnMngrService {

	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 공통 관리자팝업 선택
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listPop(ParameterContext paramCtx) throws Exception;

	/**
	 * 괸라자 공통 내정보수정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void forUpdateMy(ParameterContext paramCtx) throws Exception;

	/**
	 * 관리자 공통 내정보수정 처리
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateMy(ParameterContext paramCtx) throws Exception;

	/**
	 * 비밀번호 금지단어 체크
	 * @param paramCtx
	 * @throws Exception
	 */
	public void checkPrhibtWrd(ParameterContext paramCtx) throws Exception;

}