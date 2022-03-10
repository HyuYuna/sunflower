package site.unp.cms.service.bbs.attrb;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.io.FileUtils;
import org.jdom.CDATA;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.Text;
import org.jdom.input.SAXBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;

import site.unp.core.ZValue;
import site.unp.core.util.StrUtils;

@Component
public class XmlPageGenerator extends AbstractPageGenerator implements ApplicationContextAware {

	Logger log = LoggerFactory.getLogger(this.getClass());

	protected ApplicationContext context;

	public void setApplicationContext(ApplicationContext applicationContext)
			throws BeansException {
		this.context = applicationContext;
	}

	@Override
	public PageTemplate[] getPageTemplates(ZValue param){
		List<String> siteIds = param.getList("siteIds");
		String attrbTyCd = param.getString("attrbTyCd");
		if( CollectionUtils.isEmpty(siteIds) ) {
			siteIds.add("bos");
		}
		List<PageTemplate> _templates = new ArrayList<PageTemplate>();
		for(String siteId : siteIds) {
			String[] beanNames = StrUtils.split(param.getString(attrbTyCd), ",");
			for(String name : beanNames) {
				String beanName = siteId + name;
				try {
					PageTemplate template = (PageTemplate)context.getBean(beanName);
					_templates.add(template);
				} catch (BeansException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

		PageTemplate[] templates = (PageTemplate[])_templates.toArray(new PageTemplate[_templates.size()]);
		return templates;
	}

	@Override
	public void doCreatePage(PageTemplate template, ZValue param, ModelMap model) throws Exception {
		//String newLine = System.getProperty("line.separator");

		SAXBuilder builder = new SAXBuilder();
		List<ZValue> fieldList = template.selectFieldAttributeList(param);
		Document document = builder.build(template.getTemplatePath());
		Element root = document.getRootElement();
		@SuppressWarnings("unchecked")
		Iterator<Object> it = root.getContent().iterator();
		StringBuffer result = new StringBuffer();
		while(it.hasNext()) {
			Object o = it.next();
			if ( o instanceof CDATA || o instanceof Text ) {
				String txt = ((Text)o).getText();
				if( StringUtils.hasText(txt) )
					result.append(txt);
			}
			else if( o instanceof Element ) {
				Element e = (Element)o;
				processForEachTag(e, result, fieldList, template.getTemplatePath().toLowerCase().indexOf("list")>-1 ? true : false);
			}
		}

		String outputPath = StrUtils.replace(template.getOutputPath(), REPLACE_PAGE_CODE_MARK, param.getString("attrbCd"));
		File outputFile = new File(outputPath);
		if (outputFile.isFile()){
			boolean flag = outputFile.renameTo(new File(outputPath.replaceAll("\\.jsp", "_" + new java.text.SimpleDateFormat("yyyyMMddHHmmss").format(new java.util.Date())+"\\.jsp")));
			if (!flag){
				log.error("renameTo error!!");
			}
		} else { //2017.10.30 보안약점 처리 : 메서드 실행 결과 반환 값 무시
			throw new FileNotFoundException();
		}
		FileUtils.writeStringToFile(outputFile, result.toString());
		log.debug("<<" + outputPath + " file created!");
	}

	private void processForEachTag(Element e, StringBuffer result, List<ZValue> fieldList, boolean listFlag) {
		String forEachTxt = e.getText();
		if ( StringUtils.hasText(forEachTxt) ) {
			for ( ZValue val : fieldList ) {
				String fieldNm = val.getString("fieldNm");
				String fieldDc = val.getString("fieldDc");
				String fieldTyCd = val.getString("fieldTyCd");
				String listUseAt = val.getString("listUseAt");
				if (listFlag==false || (listFlag && (StringUtils.hasText(fieldNm) && listUseAt.equals("Y")))){
				String _contents = StrUtils.replace(forEachTxt, REPLACE_NAME_MARK, fieldNm);
				_contents = StrUtils.replace(_contents, REPLACE_TEXT_MARK, fieldDc);
				_contents = StrUtils.replace(_contents, REPLACE_TYPE_MARK, fieldTyCd);
				//System.out.println(_contents);
				result.append(_contents);
				}
			}
		}
		else {
			processIsEqualTag(e, result, fieldList, listFlag);
		}
	}

	private void processIsEqualTag(Element parentEle, StringBuffer result, List<ZValue> fieldList, boolean listFlag) {
		Map<String, String> valueMap = new HashMap<String, String>();
		@SuppressWarnings("unchecked")
		Iterator<Element> _it = parentEle.getChildren().iterator();
		while( _it.hasNext() ) {
			Element isEqualEle = _it.next();
			String isEqualTxt = isEqualEle.getText();
			String value = isEqualEle.getAttribute("value").getValue();
			valueMap.put(value, isEqualTxt);
		}
		for(ZValue val : fieldList) {
			String listUseAt = val.getString("listUseAt");
			String fieldNm = val.getString("fieldNm");
			String fieldDc = val.getString("fieldDc");
			String fieldTyCd = val.getString("fieldTyCd");
			if (listFlag==false || (listFlag && (listUseAt.equals("Y")))){
				String isEqualTxt = valueMap.get(fieldNm);
				if( isEqualTxt == null ) {
					isEqualTxt = valueMap.get("default-" + fieldTyCd);
					if( isEqualTxt == null ) isEqualTxt = valueMap.get("default");
				}
				String _contents = StrUtils.replace(isEqualTxt, REPLACE_NAME_MARK, fieldNm);
				_contents = StrUtils.replace(_contents, REPLACE_TEXT_MARK, fieldDc);
				_contents = StrUtils.replace(_contents, REPLACE_TYPE_MARK, fieldTyCd);
				result.append(_contents);
			}
		}
	}

}
