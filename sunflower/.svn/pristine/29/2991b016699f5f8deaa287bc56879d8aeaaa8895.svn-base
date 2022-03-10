package site.unp.cms.conf;

import java.util.List;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.BeanDefinitionRegistryPostProcessor;

import site.unp.cms.listener.cmmnCd.CmmnCdViewDepthListener;
import site.unp.core.util.StrUtils;

/**
 * 공통코드 리스너빈 프로그램적으로 등록
 * 코드아이디를 기준으로 모델에 카멜케이스로 변환된 코드목록 모델에 담김 
 * 코드아이디와 쿼리컬럼명과 같으면 result, reulstList에 카멜케이스 코드값이 담김
 * 예: 코드아이디가 STTUS_CD이면 'sttusCdListener'인 리스너명  'sttusCdCodeList' 모델에 담김, result.put("sttusCdNm", "코드값")
 * @author khd
 *
 */
public class CmmCdListenerRegistConfigurer implements BeanDefinitionRegistryPostProcessor {

	private List<String> cdIdData;

	@Override
	public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
		// TODO Auto-generated method stub
	}

	@Override
	public void postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry) throws BeansException {
		for (String c : cdIdData) {
			String ccCd = StrUtils.convert2CamelCase(c);
			BeanDefinitionBuilder bdb = BeanDefinitionBuilder.rootBeanDefinition(CmmnCdViewDepthListener.class);
			bdb.addConstructorArgValue(c);
			bdb.addConstructorArgValue(ccCd);
			bdb.addConstructorArgValue(ccCd + "Nm");
			registry.registerBeanDefinition(ccCd + "Listener", bdb.getBeanDefinition());
		}

	}

	public List<String> getCdIdData() {
		return cdIdData;
	}

	public void setCdIdData(List<String> cdIdData) {
		this.cdIdData = cdIdData;
	}

}
