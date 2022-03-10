package site.unp.cms.dao.cmmnCd;

import java.util.ArrayList;
import java.util.List;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;
import site.unp.core.util.StrUtils;

@Repository("cmmnCdDetailDAO")
public class CmmnCdDetailDAO extends SqlDAO<ZValue> {

	public static final String CMMN_CD_CACHE_NAME = "storedCmmnCd";

	@Override
	@CacheEvict(value=CMMN_CD_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public Object save(String queryId, ZValue param) throws Exception {
		return super.save(queryId, param);
	}

	@Override
	@CacheEvict(value=CMMN_CD_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int modify(String queryId, ZValue param) throws Exception {
		return super.modify(queryId, param);
	}

	@Override
	@CacheEvict(value=CMMN_CD_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int deleteOne(String queryId, ZValue param) throws Exception {
		return super.deleteOne(queryId, param);
	}
	
	@Cacheable(value=CMMN_CD_CACHE_NAME)
	public List<ZValue> findAllCmmnCdDetail(ZValue param) throws Exception {
		return findAll("findAllCmmnCdDetailByCdId", param);
	}

	@Cacheable(value=CMMN_CD_CACHE_NAME)
	public List<ZValue> findAllCmmnCdDetail(String codegCode) throws Exception {
		ZValue param = new ZValue();
		param.put("codegCode", codegCode);
		/*param.put("upperCd", upperCd);*/
		return findAll("findAllCmmnCdDetailByCdId", param);
	}
	@Cacheable(value=CMMN_CD_CACHE_NAME)
	public List<ZValue> findAllCmmnCdDetail2(String cdId,String upperCd) throws Exception {
		ZValue param = new ZValue();
		param.put("cdId", cdId);
		return findAll("findAllCmmnCdDetailByCdId", param);
	}

	public String getCodeName(ZValue vo, List<ZValue> codeList, String propertyName) {
		String result = "";
		String code = vo.getString(propertyName);
		if ( StringUtils.hasText(code) ) {
			for(ZValue cmmnCode : codeList) {
				if(code.equals(cmmnCode.getString("cd"))) {
					result = cmmnCode.getString("cdNm");
					break;
				}
			}
		}
		return result;
	}

	public List<String> getCodeNames(List<ZValue> codeList, ZValue val, String propertyName, String dellim) {
		List<String> result = null;
		String codes = val.getString(propertyName);
		if( StringUtils.hasText(codes) ){
			String[] data = StrUtils.split(codes, dellim);
			result = new ArrayList<String>();
			for(String code : data){
				for(ZValue cmmnCode : codeList)
				{
					if(code.equals(cmmnCode.getString("code")))
					{
						result.add(cmmnCode.getString("codeNm"));
						break;
					}
				}
			}
		}
		return result;
	}
}
