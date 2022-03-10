package site.unp.cms.dao.siteManage;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import site.unp.cms.service.main.MainService;
import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;
import site.unp.core.service.file.FileMngService;

@Repository("ntcnRelmDAO")
public class NtcnRelmDAO extends SqlDAO<ZValue> {

	@Resource(name="fileMngService")
	private FileMngService fileMngService;

	@Override
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public Object save(String queryId, ZValue param) throws Exception {
		return super.save(queryId, param);
	}

	@Override
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int modify(String queryId, ZValue param) throws Exception {
		return getSqlSession().update(queryId, param);
	}

	@Override
	@CacheEvict(value=MainService.PORTAL_MAIN_CACHE_NAME, allEntries=true, beforeInvocation=true)
	public int deleteOne(String queryId, ZValue param) throws Exception {
		return getSqlSession().delete(queryId, param);
	}

	public List<ZValue> findAllMainList(String siteId, String ntcnTyCd) throws Exception {
		ZValue param = new ZValue();
		param.put("siteId", siteId);
		param.put("ntcnTyCd", ntcnTyCd);
		return findAll("findAllMainList", param);
	}

	@Cacheable(value=MainService.PORTAL_MAIN_CACHE_NAME)
	public List<ZValue> selectPublishList(String siteId, String ntcnTyCd) throws Exception {
		List<ZValue> resultList = findAllMainList(siteId, ntcnTyCd);
		if( CollectionUtils.isNotEmpty(resultList) ){
			Map<String, List<ZValue>> fileMap = fileMngService.getFileMap(null, resultList);
			if (MapUtils.isNotEmpty(fileMap)) {
				for (ZValue val : resultList) {
					List<ZValue> files = fileMap.get(val.getString("atchFileId"));
					if (CollectionUtils.isNotEmpty(files)) {
						val.put("fileSn", files.get(0).getString("fileSn"));
						val.put("fileCn", files.get(0).getString("fileCn"));
						val.put("fileStreFileNm", files.get(0).getString("streFileNm"));
						val.put("fileStreCours", files.get(0).getString("fileStreCours"));
					}
				}
			}
		}
		Collections.reverse(resultList);
		return resultList;
	}
}
