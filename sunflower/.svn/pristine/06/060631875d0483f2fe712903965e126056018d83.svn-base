package site.unp.cms.listener;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import site.unp.core.ParameterContext;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.util.CacheUtil;

public class CacheRemoveListener extends CommonListenerSupport {

	Logger log = LoggerFactory.getLogger(this.getClass());

	private String cacheName = "";

	@Resource(name = "cacheUtil")
	private CacheUtil cacheUtil;

	@Override
	public void after(ParameterContext paramCtx) throws Exception {
		cacheUtil.remove(cacheName);
		log.debug("["+cacheName+"] 캐시가 삭제 되었습니다.");
	}

	public String getCacheName() {
		return cacheName;
	}

	public void setCacheName(String cacheName) {
		this.cacheName = cacheName;
	}

}
