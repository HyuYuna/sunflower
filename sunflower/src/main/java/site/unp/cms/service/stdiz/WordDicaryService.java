package site.unp.cms.service.stdiz;


import site.unp.core.ParameterContext;

public interface WordDicaryService {
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;
	

}
