package site.unp.cms.service.bbs.attrb;

import java.util.List;
import java.util.Map;

import site.unp.core.ZValue;

public interface PageTemplate {
	
	public String getTemplatePath();

	public String getOutputPath();
	
	public String getTheadContents();
	
	public String getTbodyContents();
	
	public ZValue getPageInfo(ZValue param) throws Exception;
	
	public Map<String, String> getFieldContents() throws Exception;
	
	public List<ZValue> selectFieldAttributeList(ZValue param) throws Exception;
	
	public List<ZValue> selectAllFieldList(ZValue param) throws Exception;
	
	public String getTableNm(ZValue param);
}
