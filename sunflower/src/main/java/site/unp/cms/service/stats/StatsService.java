package site.unp.cms.service.stats;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;

public interface StatsService {

	public void passView(ParameterContext paramCtx) throws Exception;
	public void casestats(ParameterContext paramCtx) throws Exception;
	public void casestatsSearch(ParameterContext paramCtx) throws Exception;
	public void casejoin(ParameterContext paramCtx) throws Exception;
	public void spass(ParameterContext paramCtx) throws Exception;
	public void vpass(ParameterContext paramCtx) throws Exception;
	public void serv(ParameterContext paramCtx) throws Exception;
	public void ageSetting(ParameterContext paramCtx) throws Exception;
	public void caseAgeSetting(ParameterContext paramCtx) throws Exception;
    public void insertDownloadHistory(ParameterContext param) throws Exception;
	
	
	/*public void caseReg(ParameterContext paramCtx) throws Exception;*/
	/*public void findCasePassList(ParameterContext paramCtx) throws Exception;
	public void caseAttkrRegPopup(ParameterContext paramCtx) throws Exception;
	public void insertAttkr(ParameterContext paramCtx) throws Exception;
	public void updateAttkr(ParameterContext paramCtx) throws Exception;
	public void deleteAttkr(ParameterContext paramCtx) throws Exception;
	public void findCdListJson(ParameterContext paramCtx) throws Exception;
	public void findCdDetailListJson(ParameterContext paramCtx) throws Exception;*/
}
