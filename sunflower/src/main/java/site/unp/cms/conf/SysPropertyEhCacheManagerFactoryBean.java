package site.unp.cms.conf;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

/**
 * jvm 옵션 -Dehcache.configFileNm 으로 캐시설정 분리
 * ehcache의 레플리케이션을 이용하기 위해서
 * http://www.ehcache.org/documentation/2.7/replication/rmi-replicated-caching.html
 * @author khd
 *
 */
public class SysPropertyEhCacheManagerFactoryBean extends EhCacheManagerFactoryBean {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	public SysPropertyEhCacheManagerFactoryBean() {
		Resource configLocation = null;
		String configFileNm = System.getProperty("ehcache.configFileNm");
		log.error(configFileNm);
		if (configFileNm == null) {
			configLocation = new ClassPathResource("ehcache.xml");
		}
		else {
			configLocation = new ClassPathResource(configFileNm);
		}
		super.setConfigLocation(configLocation);

	}
}
