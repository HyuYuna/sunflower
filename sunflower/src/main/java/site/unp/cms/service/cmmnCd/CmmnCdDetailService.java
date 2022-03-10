package site.unp.cms.service.cmmnCd;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.service.cs.CrudService;


public interface CmmnCdDetailService{
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
	 * 카테고리 상세 목록을 조회
	 * @param paramCtx
	 * @throws Exception
	 */
	public void listCdDetailPop(ParameterContext paramCtx) throws Exception;
	
	/**
	 * 공통상세코드 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateCdDetail(ParameterContext paramCtx) throws Exception;

	/**
	 * 공통 상세코드 등록
	 * @param paramCtx
	 * @throws Exception
	 */
	public void insertCdDetail(ParameterContext paramCtx) throws Exception;

	public void listJson(ParameterContext paramCtx) throws Exception;

	/**
	 * 공통상세코드 삭제
	 * @param paramCtx
	 * @throws Exception
	 */
	public void deleteCdDetail(ParameterContext paramCtx) throws Exception;

	/**
	 * 공통상세코드 정렬순서 가져오기
	 * @param paramCtx
	 * @throws Exception
	 */
	public void getSortOrdr(ParameterContext paramCtx) throws Exception;

	/**
	 * 코드명정보 수정
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateCdNm(ParameterContext paramCtx) throws Exception ;


	/**
	 * 코드 최상위/상위/하위/최하위 이동
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateMoveCd(ParameterContext paramCtx) throws Exception ;


	/**
	 * 공통코드 (등록/수정 /삭제) 등등 리턴페이지 쿼리 만드는 메소드
	 * @param cmmnCodeUrl
	 * @param param
	 * @return
	 */
	public String returnUrlQueryCmmnCd(String cmmnCodeUrl,ZValue param) throws Exception ;
	
	
	/*public void listDetail(ParameterContext paramCtx) throws Exception ;*/

}
