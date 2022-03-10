package site.unp.cms.service.bbs.attrb;

import site.unp.core.ParameterContext;


public interface AttrbService {
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	public void selectAllFieldList(ParameterContext paramCtx) throws Exception;

	public void addFieldAttr(ParameterContext paramCtx) throws Exception;
	
	public void createPage(ParameterContext paramCtx) throws Exception;

	public void sortFieldAttr(ParameterContext paramCtx) throws Exception;
}
