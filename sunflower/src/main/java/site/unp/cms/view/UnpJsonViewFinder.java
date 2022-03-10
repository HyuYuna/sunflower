package site.unp.cms.view;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.MultivaluedHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.support.AopUtils;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.core.annotation.AnnotationUtils;
import org.springframework.util.ReflectionUtils;

import site.unp.core.ZValue;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.CommonServiceImpl;

public class UnpJsonViewFinder implements ApplicationContextAware {

	Logger log = LoggerFactory.getLogger(this.getClass());

	private MultivaluedHashMap<String, String> cache = new MultivaluedHashMap<>();

	private ApplicationContext applicationContext;

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
		this.applicationContext = applicationContext;
	}

	public boolean hasUnpJsonViewModel(Map<String, Object> model) {
		ZValue paramVO = (ZValue)model.get("paramVO");
		if (paramVO == null) {
			return true;
		}

		String targetName = paramVO.getString("targetName");
		String targetMethod = paramVO.getString("targetMethod");

		List<String> methods = cache.get(targetName);
		if (methods != null) {
			if (methods.contains("ALL_METHOD")) {
				log.debug("Find cached @UnpJsonView in class level - targetName : {}, targetMethod : {}", targetName, targetMethod);
				return true;
			}
			if (methods.contains(targetMethod)) {
				log.debug("Find cached @UnpJsonView in method level - targetName : {}, targetMethod : {}", targetName, targetMethod);
				return true;
			}
		}

		Map<String, CommonServiceImpl> m = applicationContext.getBeansOfType(CommonServiceImpl.class);
		CommonServiceImpl cs = m.get(targetName);
		if (cs != null) {
			Class<?> csClz = cs.getClass();
			if (AopUtils.isAopProxy(cs)) {
				csClz = AopUtils.getTargetClass(cs);
            }
			if (AnnotationUtils.findAnnotation(csClz, UnpJsonView.class) != null) {
				cache.putSingle(targetName, "ALL_METHOD");
				log.debug("Find @UnpJsonView in class level - targetName : {}, targetMethod : {}", targetName, targetMethod);
				return true;
			}

			Method[] methodData = ReflectionUtils.getAllDeclaredMethods(csClz);
            for (Method method : methodData) {
				if (targetMethod.equals(method.getName())) {
					if (AnnotationUtils.findAnnotation(method, UnpJsonView.class) != null) {
    					cache.putSingle(targetName, method.getName());
    					log.debug("Find @UnpJsonView in method level - targetName : {}, targetMethod : {}", targetName, targetMethod);
    					return true;
    				}
    			}
            }
		}
		return false;
	}

}
