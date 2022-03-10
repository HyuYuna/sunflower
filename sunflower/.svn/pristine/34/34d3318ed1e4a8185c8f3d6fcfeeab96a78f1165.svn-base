package site.unp.cms.conf;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.remoting.rmi.RmiProxyFactoryBean;
import org.springframework.util.StringUtils;

import site.unp.cms.service.singl.FileServer;

/**
 * RMI방식을 이용한 컨텐츠배포
 * 예를 들어 서버가 3대가 있을경우
 * 1대는 RMI Server가 되고 나머지 2대는 Client가 됨
 * RMI Server는 JVM옵션 -Drmi.registryPort 를 등록 
 * 나머지 2대는 -Drmi.serverPorts, -Drmi.serverHosts를 등록함
 * -DmenuLoader.serverHosts값이 없을 경우 localhost로 초기화 한다.
 * @author khd
 *
 */
@Configuration
@Profile({"mode"})
public class FilerServerConf { 

	public List<RmiProxyFactoryBean> fileServerClientBeans() {
		String serverPorts = System.getProperty("rmi.serverPorts");
		if (!StringUtils.hasText(serverPorts)) {
			return null;
		}
		String serverHosts = System.getProperty("rmi.serverHosts");
		String[] ports = StringUtils.delimitedListToStringArray(serverPorts, ",");
		String[] hosts = StringUtils.delimitedListToStringArray(serverHosts, ",");
		if (ArrayUtils.isEmpty(hosts)) {
			hosts = new String[ports.length];
			for (int i=0; i<ports.length; i++) {
				hosts[i] = "localhost";
			}
		}
		List<RmiProxyFactoryBean> fileServerClientBeans = new ArrayList<>();
		if (ArrayUtils.isNotEmpty(ports)) {
			for (int i=0; i<ports.length; i++) {
				String port = ports[i];
				String host = hosts[i];
				RmiProxyFactoryBean rpfb = new RmiProxyFactoryBean();
				rpfb.setServiceInterface(FileServer.class);
				String serviceUrl = "rmi://" + host + ":" + port + "/fileServer";
				rpfb.setServiceUrl(serviceUrl);
				rpfb.setLookupStubOnStartup(false);
				rpfb.afterPropertiesSet();
				fileServerClientBeans.add(rpfb);
			}
		}
		return fileServerClientBeans;
	}
	
	@Bean
	public List<FileServer> fileServerClients() {
		List<FileServer> clients = new ArrayList<>();
		List<RmiProxyFactoryBean> beans = fileServerClientBeans();
		if (CollectionUtils.isNotEmpty(beans)) {
			for (RmiProxyFactoryBean bean : fileServerClientBeans()) {
				clients.add((FileServer)bean.getObject());
			}
		}
		return clients;
	}
	
	@Configuration
	@Profile({"real","test","dev","local","junit"})
	public static class DevFileServerConf {
		
		@Bean
		public List<FileServer> fileServerClients() {
			List<FileServer> clients = new ArrayList<>();
			return clients;
		}
	}
}
