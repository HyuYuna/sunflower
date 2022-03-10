package site.unp.cms.service.main;

import site.unp.core.ParameterContext;
import site.unp.core.annotation.UnpJsonView;

public interface MngrMainEstbsService{
	
	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void uploadExcel(ParameterContext paramCtx) throws Exception;
	
	public void downloadExcel(ParameterContext paramCtx) throws Exception;

	//jsp 페이지 호출용
	public void iconSelectList(ParameterContext paramCtx) throws Exception;

	//jsp 페이지 호출용
	public void main(ParameterContext paramCtx) throws Exception;

	//jsp 페이지 호출용
	public void gridstack(ParameterContext paramCtx) throws Exception;

	public void saveMngrMainLcEstbs(ParameterContext paramCtx) throws Exception;
	
	public void bbsIdCheck(ParameterContext paramCtx) throws Exception;

	
}
