package site.unp.cms.conf;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.ArrayUtils;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.remoting.rmi.RmiProxyFactoryBean;
import org.springframework.remoting.rmi.RmiServiceExporter;
import org.springframework.util.StringUtils;

import site.unp.core.service.menu.MasterMenuManager;
import site.unp.core.service.menu.MenuLoader;
import site.unp.core.util.StrUtils;

/**
 * RMI방식을 이용한 다른 서버간의 '메뉴적용' 동기화
 * 예를 들어 서버가 3대가 있을경우
 * 1대는 RMI Server가 되고 나머지 2대는 Client가 됨
 * RMI Server는 JVM옵션 -Drmi.registryPort 를 등록 
 * 나머지 2대는 ','를 구분자로하는 -Drmi.serverPorts, -Drmi.serverHosts를 등록함
 * -Drmi.serverHosts값이 없을 경우 localhost로 초기화 한다.
 * @author khd
 *
 */
@Configuration
@Profile({"mode"})
public class MenuLoaderConf  {
	
	@Resource(name="masterMenuManagerService")
	private MasterMenuManager masterMenuManager;

	@Bean
	public RmiServiceExporter menuLoader() {
		int registryPort = StrUtils.parseInt(System.getProperty("rmi.registryPort"));
		if (registryPort == 0) {
			return null;
		}
		RmiServiceExporter rse = new RmiServiceExporter();
		rse.setServiceInterface(MenuLoader.class);
		rse.setService(masterMenuManager);
		rse.setServiceName("menuLoader");
		rse.setRegistryPort(registryPort);
		return rse;
	}
	
	public List<RmiProxyFactoryBean> menuLoaderClientBeans() {
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
		List<RmiProxyFactoryBean> menuLoaderClientBeans = new ArrayList<>();
		if (ArrayUtils.isNotEmpty(ports)) {
			for (int i=0; i<ports.length; i++) {
				String port = ports[i];
				String host = hosts[i];
				RmiProxyFactoryBean rpfb = new RmiProxyFactoryBean();
				rpfb.setServiceInterface(MenuLoader.class);
				String serviceUrl = "rmi://" + host + ":" + port + "/menuLoader";
				rpfb.setServiceUrl(serviceUrl);
				rpfb.setLookupStubOnStartup(false);
				rpfb.afterPropertiesSet();
				menuLoaderClientBeans.add(rpfb);
			}
		}
		return menuLoaderClientBeans;
	}
	
	@Bean
	public List<MenuLoader> menuLoaderClients() {
		List<MenuLoader> clients = new ArrayList<>();
		List<RmiProxyFactoryBean> beans = menuLoaderClientBeans();
		if (CollectionUtils.isNotEmpty(beans)) {
			for (RmiProxyFactoryBean bean : menuLoaderClientBeans()) {
				clients.add((MenuLoader)bean.getObject());
			}
		}
		return clients;
	}
	
	@Configuration
	@Profile({"real","test","dev","local","junit"})
	public static class DevMenuLoaderConf {
		
		@Bean
		public List<MenuLoader> menuLoaderClients() {
			List<MenuLoader> clients = new ArrayList<>();
			return clients;
		}
	}
}
