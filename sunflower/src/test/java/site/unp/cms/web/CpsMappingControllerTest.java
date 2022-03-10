package site.unp.cms.web;

import java.io.File;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.ui.ModelMap;
import org.springframework.util.ReflectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.context.WebApplicationContext;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.member.UserMemberService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.service.cs.impl.CommonServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = { "classpath*:egovframework/spring/unp/*.xml", })
@ActiveProfiles("dev")
public class CpsMappingControllerTest {

	@Autowired
    private WebApplicationContext wac;

	@Resource(name="userMemberService")
	UserMemberService memberService;
	
	@Resource(name="globalsProperties")
	GlobalsProperties globalsProperties;

	@Before
    public void setUp() throws Exception {

		//스프링 시큐러티관련 로그인정보 세팅
		MemberVO vo = new MemberVO();
		vo.setUserSn(0);
		vo.setUserNm("테스트");
		vo.setUserId("test");
		vo.setPassword("test");
		memberService.setAuthentication(vo, new MockHttpServletRequest());
    }
	
	@Test
	public void test() {
		String path = globalsProperties.getWebRootPath() + "/META-INF/";
		Map<String, CommonServiceImpl> m = wac.getBeansOfType(CommonServiceImpl.class);
		Iterator<String> it = m.keySet().iterator();
		while (it.hasNext()) {
			String serviceName = it.next();
			CommonServiceImpl service = m.get(serviceName);
			String resourceLocation = path + serviceName + ".txt";
			try {
				File file = new File(resourceLocation);
				if (file.exists()) {
					System.out.println(file.getAbsolutePath());
					List<ZValue> params = new ArrayList<>();
					List<String> lines = FileUtils.readLines(file, "UTF-8");
					ZValue param = new ZValue();
					params.add(param);
					for (String line : lines) {
						String l = StringUtils.trimAllWhitespace(line);
						if ("/".equals(l)) {
							param = new ZValue();
							params.add(param);
						}
						else {
							String[] data = StringUtils.delimitedListToStringArray(l, "=");
							if (ArrayUtils.isNotEmpty(data)) {
								param.put(data[0], data[1]);
							}
						}
					}
					for (ZValue p : params) {
						ParameterContext paramCtx = new ParameterContext();
						ModelMap model = new ModelMap();
						paramCtx.setParam(p);
						paramCtx.setModel(model);
						String methodKey = service.getClass().getName() + "." + p.getString("targetMethod");
						System.out.println(methodKey + " is invoking...");
						Method method = ReflectionUtils.findMethod(service.getClass(), p.getString("targetMethod"), ParameterContext.class);
						ReflectionUtils.invokeJdbcMethod(method, service, new Object[]{paramCtx});
						
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
