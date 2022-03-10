package site.unp.cms.service.bbs.attrb;

import javax.annotation.Resource;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.ui.ModelMap;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.member.UserMemberService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "classpath*:egovframework/spring/unp/*.xml",
})
@ActiveProfiles("junit")
public class AttrbServiceTest {

	@Resource(name="attrbService")
	AttrbService service;

	@Resource(name="userMemberService")
	UserMemberService memberService;
	
	ParameterContext paramCtx;
	ModelMap model;
	ZValue param;

	@Before
    public void setUp() throws Exception {
		paramCtx = new ParameterContext();
		model = new ModelMap();
		param = new ZValue();
		paramCtx.setParam(param);
		paramCtx.setModel(model);

		//스프링 시큐러티관련 로그인정보 세팅
		MemberVO vo = new MemberVO();
		vo.setUserSn(0);
		vo.setUserNm("테스트");
		vo.setUserId("test");
		vo.setPassword("test");
		memberService.setAuthentication(vo, new MockHttpServletRequest());
    }
	
	@Test
	public void testCreatePage() throws Exception {
		param.putObject("tableNm", "TN_CVPL_MASTR");
		param.putObject("attrbTyCd", "simpleMybatis");
		service.createPage(paramCtx);
	}

}
