package site.unp.cms.service.siteManage;

import java.util.List;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;

public interface BannerService{

	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	public List<ZValue> getBanner(ZValue param) throws Exception;

	/**
	 * 배너관리 노출순서 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	public void updateSortOrdr(ParameterContext paramCtx) throws Exception;

	/**
	 * 배너관리 사용여부 변경
	 * @param paramCtx
	 * @throws Exception
	 */
	
	public void updateUseAt(ParameterContext paramCtx) throws Exception ;

}
