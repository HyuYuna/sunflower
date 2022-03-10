package site.unp.cms.service.survey;

import site.unp.core.ParameterContext;

public interface SurveyService {

	public void list(ParameterContext paramCtx) throws Exception;

	public void view(ParameterContext paramCtx) throws Exception;

	public void forInsert(ParameterContext paramCtx) throws Exception;

	public void insert(ParameterContext paramCtx) throws Exception;

	public void forUpdate(ParameterContext paramCtx) throws Exception;

	public void update(ParameterContext paramCtx) throws Exception;

	public void delete(ParameterContext paramCtx) throws Exception;

	public void stats(ParameterContext paramCtx) throws Exception;

	public void statsCenter(ParameterContext paramCtx) throws Exception;
}
