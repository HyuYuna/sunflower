package site.unp.cms.service.bbs.attrb;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.util.Assert;

import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.util.StrUtils;

public class PageTemplateImpl implements PageTemplate {

	protected String templatePath;
	protected String outputPath;
	protected String tbodyContents;
	protected String theadContents;
	protected Map<String, String> fieldContents;

	@Resource(name="globalsProperties")
	protected GlobalsProperties globalsProperties; 
	
	@Resource(name = "SqlDAO")
	protected ISqlDAO<ZValue> pageGeneratorDAO;
		
	public String getOutputPath() {
		String result = "";
		String path = globalsProperties.getWebRootPath().endsWith("/") ? globalsProperties.getWebRootPath() : globalsProperties.getWebRootPath() + "/";
		if (outputPath.startsWith("/")) {
			result = path + outputPath.substring(1); 
		}
		else {
			result = path + outputPath;
		}
		return result;
	}

	public void setOutputPath(String outputPath) {
		this.outputPath = outputPath;
	}

	public void setTemplatePath(String templatePath){
		this.templatePath = templatePath;
	}

	public void setTbodyContents(String tbodyContents){
		this.tbodyContents = tbodyContents;
	}

	public void setTheadContents(String theadContents){
		this.theadContents = theadContents;
	}
	
	public String getTemplatePath() {
		return this.templatePath;
	}

	public String getTheadContents() {
		return this.theadContents;
	}

	public String getTbodyContents() {
		return this.tbodyContents;
	}

	public ZValue getPageInfo(ZValue param) throws Exception{
		return pageGeneratorDAO.findOneById("findOneAttrbInfoByAttrbCd", param.getString("attrbCd"));
	}

	public Map<String, String> getFieldContents() {
		return fieldContents;
	}

	public void setFieldContents(Map<String, String> fieldContents) {
		this.fieldContents = fieldContents;
	}

	public List<ZValue> selectFieldAttributeList(ZValue param) throws Exception {
		Assert.hasText(param.getString("attrbCd"));
		List<ZValue> attrbTableInfos = pageGeneratorDAO.findAll("findAttrbTableInfo", param);
		if (CollectionUtils.isNotEmpty(attrbTableInfos)) {
			List<ZValue> fieldInfos = pageGeneratorDAO.findAll("findAllFieldInfo", param);
			for (ZValue attrb : attrbTableInfos) {
				String columnName = attrb.getString("columnName");
				String comments = attrb.getString("comments");
				attrb.put("fieldIemNm", StrUtils.convert2CamelCase(columnName));
				attrb.put("fieldDc", comments);
				if (CollectionUtils.isNotEmpty(fieldInfos)) {
					for (ZValue field : fieldInfos) {
						String fieldIemNm = field.getString("fieldIemNm");
						if (fieldIemNm.equals(attrb.getString("fieldIemNm"))) {
							attrb.put("fieldTyCd", field.getString("fieldTyCd"));
							attrb.put("listUseAt", field.getString("listUseAt"));
							attrb.put("readUseAt", "Y");
							attrb.put("fieldDc", field.getString("fieldDc"));
						}
					}
				}
			}
		}
		return attrbTableInfos;
	}

	public List<ZValue> selectAllFieldList(ZValue param) throws Exception {
		return selectFieldAttributeList(param);
	}

	@Override
	public String getTableNm(ZValue param) {
		return param.getString("tableNm");
	}
	
}
