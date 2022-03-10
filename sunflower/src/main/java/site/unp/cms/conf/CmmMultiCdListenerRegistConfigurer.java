package site.unp.cms.conf;

import java.util.List;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.ConfigurableListableBeanFactory;
import org.springframework.beans.factory.support.BeanDefinitionBuilder;
import org.springframework.beans.factory.support.BeanDefinitionRegistry;
import org.springframework.beans.factory.support.BeanDefinitionRegistryPostProcessor;

import site.unp.cms.listener.cmmnCd.CmmnCdMultiAddListener;
import site.unp.cms.listener.cmmnCd.CmmnCdMultiViewListener;
import site.unp.core.util.StrUtils;

/**
 * 공통코드 Multi 리스너빈 프로그램적으로 등록
 * 코드아이디를 기준으로 모델에 카멜케이스로 변환된 코드목록 모델에 담김
 * 코드아이디와 쿼리컬럼명과 같으면 result, reulstList에 카멜케이스 코드값이 담김
 * 예: 코드아이디가 STTUS_CD이면 'sttusCdListener'인 리스너명  'sttusCdCodeList' 모델에 담김, result.put("sttusCdNm", "코드값")
 * @author khd
 *
 */
public class CmmMultiCdListenerRegistConfigurer implements BeanDefinitionRegistryPostProcessor {

	private List<String> cdIdData;

	@Override
	public void postProcessBeanFactory(ConfigurableListableBeanFactory beanFactory) throws BeansException {
		// TODO Auto-generated method stub
	}

	@Override
	public void postProcessBeanDefinitionRegistry(BeanDefinitionRegistry registry) throws BeansException {
		for (String cdArrStr : cdIdData) {
			if (cdArrStr.split("-").length != 3) {
				break;
			}
			String[] cdArr = cdArrStr.split("-");
			String c = cdArr[0];
			String ccCd = StrUtils.convert2CamelCase(c);
			String progrmId = cdArr[1];
			String progrmSn = cdArr[2];


			BeanDefinitionBuilder bdb = BeanDefinitionBuilder.rootBeanDefinition(CmmnCdMultiViewListener.class);
			bdb.addConstructorArgValue(c);
			bdb.addConstructorArgValue(ccCd);
			bdb.addConstructorArgValue(ccCd + "Nm");
			bdb.addConstructorArgValue(progrmId);
			bdb.addConstructorArgValue(progrmSn);
			registry.registerBeanDefinition(ccCd + progrmId + progrmSn + "MultiListener", bdb.getBeanDefinition());


			BeanDefinitionBuilder bdb2 = BeanDefinitionBuilder.rootBeanDefinition(CmmnCdMultiAddListener.class);
			bdb2.addConstructorArgValue(c);
			bdb2.addConstructorArgValue(ccCd);
			bdb2.addConstructorArgValue(progrmId);
			bdb2.addConstructorArgValue(progrmSn);
			registry.registerBeanDefinition(ccCd + progrmId + progrmSn + "MultiAddListener", bdb2.getBeanDefinition());
		}

	}

	public List<String> getCdIdData() {
		return cdIdData;
	}

	public void setCdIdData(List<String> cdIdData) {
		this.cdIdData = cdIdData;
	}

}
