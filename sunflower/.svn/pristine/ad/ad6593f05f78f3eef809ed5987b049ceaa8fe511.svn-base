package site.unp.cms.service.bbs.attrb;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class MybatisPageTemplate extends PageTemplateImpl {

	@Override
	public String getOutputPath() {
		String result = globalsProperties.getWebRootPath().endsWith("/") ? globalsProperties.getWebRootPath() : globalsProperties.getWebRootPath() + "/";
		result = result + "output/mybatis";
		return result;
	}

	@Override
	@Value("template/vm/mybatis_xml.vm")
	public void setTemplatePath(String templatePath){
		this.templatePath = templatePath;
	}
}
