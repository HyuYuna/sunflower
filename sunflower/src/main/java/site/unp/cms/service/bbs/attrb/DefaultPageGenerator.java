package site.unp.cms.service.bbs.attrb;

import java.io.File;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;

import site.unp.core.ZValue;
import site.unp.core.util.StrUtils;

public class DefaultPageGenerator extends AbstractPageGenerator {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	public void doCreatePage(PageTemplate template, ZValue param, ModelMap model) throws Exception {
		//String newLine = System.getProperty("line.separator");

		Map<String, String> fieldContents = template.getFieldContents();
		String templatePath = template.getTemplatePath();
		File templateFile = new File(templatePath.replaceAll("\\p{Space}", ""));
		String templateContents = FileUtils.readFileToString(templateFile);

		StringBuffer addedColgroupContents = new StringBuffer();
		StringBuffer addedTheadContents = new StringBuffer();
		StringBuffer addedTbodyContents = new StringBuffer();
		String theadContents = template.getTheadContents();
		List<ZValue> fieldList = template.selectFieldAttributeList(param);
		for( ZValue fieldVal : fieldList ){
			if( "nttSj".equals(fieldVal.getString("fieldNm")) )
				addedColgroupContents.append("\t\t\t\t<col width=\"*\" />\n");
			else
				addedColgroupContents.append("\t\t\t\t<col width=\"10\" />\n");
			String _theadContents = StrUtils.replace(theadContents, REPLACE_NAME_MARK, fieldVal.getString("fieldNm"));
			_theadContents = StrUtils.replace(_theadContents, REPLACE_TEXT_MARK, fieldVal.getString("fieldDc"));
			addedTheadContents.append(_theadContents);
			//addedTheadContents.append(newLine);

			String contents = fieldContents.get(fieldVal.getString("fieldNm"));
			if( contents == null )
			{
				if( "text".equals(fieldVal.getString("fieldTyCd")) ) contents = fieldContents.get("default");
				else if( "select".equals(fieldVal.getString("fieldTyCd")) ) contents = fieldContents.get("defaultSelect");
				else if( "radio".equals(fieldVal.getString("fieldTyCd"))
						|| "checkbox".equals(fieldVal.getString("fieldTyCd")) ) contents = fieldContents.get("defaultCheck");
				if( contents == null ) contents = fieldContents.get("default");

			}
			String _contents = StrUtils.replace(contents, REPLACE_NAME_MARK, fieldVal.getString("fieldNm"));
			_contents = StrUtils.replace(_contents, REPLACE_TEXT_MARK, fieldVal.getString("fieldDc"));
			_contents = StrUtils.replace(_contents, REPLACE_TYPE_MARK, fieldVal.getString("fieldTyCd"));
			addedTbodyContents.append(_contents);
			//addedTbodyContents.append(newLine);
		}

		templateContents = StrUtils.replace(templateContents, REPLACE_COLGROUP_MARK, addedColgroupContents.toString());
		templateContents = StrUtils.replace(templateContents, REPLACE_THEAD_MARK, addedTheadContents.toString());
		templateContents = StrUtils.replace(templateContents, REPLACE_TBODY_MARK, addedTbodyContents.toString());
		templateContents = StrUtils.replace(templateContents, CONFLICT_PROPERTY_MARK, REPLACE_CONFLICT_PROPERTY_MARK);

		String outputPath = StrUtils.replace(template.getOutputPath(), REPLACE_PAGE_CODE_MARK, param.getString("attrbCd"));
		File outputFile = new File(outputPath);
		FileUtils.writeStringToFile(outputFile, templateContents);
	}

}
