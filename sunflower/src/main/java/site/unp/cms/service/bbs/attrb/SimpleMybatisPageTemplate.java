package site.unp.cms.service.bbs.attrb;

import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.util.Assert;

import site.unp.core.ZValue;

@Component
public class SimpleMybatisPageTemplate extends MybatisPageTemplate {

	@Override
	public ZValue getPageInfo(ZValue param) throws Exception{
		return param;
	}

	@Override
	public List<ZValue> selectAllFieldList(ZValue param) throws Exception {
		Assert.hasText(param.getString("tableNm"));
		List<ZValue> attrbTableInfos = pageGeneratorDAO.findAll("findAttrbTableInfoByTableNm", param);
		return attrbTableInfos;
	}

}
