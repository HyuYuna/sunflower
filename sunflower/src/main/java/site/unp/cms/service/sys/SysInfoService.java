package site.unp.cms.service.sys;

import java.util.List;
import java.util.Map;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;

public interface SysInfoService{
	
	public void list(ParameterContext paramCtx) throws Exception;

	public Map<String, Object> getSystemInfo();

	public Map<String, Object> getJvmInfo();

	public List<ZValue> getHddInfo();

}
