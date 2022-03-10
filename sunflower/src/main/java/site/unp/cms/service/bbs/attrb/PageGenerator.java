package site.unp.cms.service.bbs.attrb;

import org.springframework.ui.ModelMap;

import site.unp.core.ZValue;

public interface PageGenerator {
	
	public void getPageAttrList(ZValue param, ModelMap model) throws Exception;
	
	public void addPageAttribute(ZValue param, ModelMap model) throws Exception;

	public void updatePageAttribute(ZValue param, ModelMap model) throws Exception;

	public void deletePageAttribute(ZValue param, ModelMap model) throws Exception;
	
	public void readPageInfo(ZValue param, ModelMap model) throws Exception;
	
	public void createPage(ZValue param, ModelMap model) throws Exception;

	public void selectAllFieldList(ZValue param, ModelMap model) throws Exception;

	public void addFieldAttribute(ZValue param, ModelMap model) throws Exception;
	
	public void updateFieldAttributeOrdr(ZValue param, ModelMap model) throws Exception;
}

