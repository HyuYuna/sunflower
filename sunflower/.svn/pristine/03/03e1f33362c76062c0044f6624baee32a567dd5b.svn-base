package site.unp.cms.service.siteManage;

import static org.junit.Assert.*;

import java.util.List;

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
import site.unp.core.service.cs.CommonService;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {
    "classpath*:egovframework/spring/unp/*.xml",
})
@ActiveProfiles("dev")
public class SiteInfoServiceTest {

	@Resource(name="siteInfoService")
	SiteInfoService service;

	@Resource(name="userMemberService")
	UserMemberService memberService;
	
	ParameterContext paramCtx;
	ModelMap model;
	ZValue param;

    /**
     * 해당 테스트 클래스 안에 메소드들이 테스트 되기 전과 후에 각각 실행되게 지정하는 어노테이션
     * @throws Exception
     */
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

	@SuppressWarnings("unchecked")
	@Test
	public void testList() throws Exception {
		service.list(paramCtx);
		List<ZValue> resultList = (List<ZValue>)model.get("resultList");
		assertTrue(resultList.size() > 0);
		
	}

	@Test
	public void testInsert() throws Exception {
		param.put("pSiteId", "test");
		service.delete(paramCtx);
		
		param.put("pSiteId", "test");
		param.put("registId", "test");
		param.put("siteNm", "테스트");
		param.put("useAt", "N");
		service.insert(paramCtx);
		String resultCode = (String)model.get(CommonService.RESULT_CODE_KEY);
		assertEquals(CommonService.SUCCESS, resultCode);
	}

	@Test
	public void testForUpdate() throws Exception {
		param.put("pSiteId", "ucms");
		service.forUpdate(paramCtx);
		ZValue result = (ZValue)model.get(CommonService.RESULT);
		assertTrue(result != null);
	}

	@Test
	public void testUpdate() throws Exception {
		param.put("pSiteId", "test");
		param.put("registId", "test");
		param.put("siteNm", "테스트");
		param.put("useAt", "N");
		service.update(paramCtx);
		String resultCode = (String)model.get(CommonService.RESULT_CODE_KEY);
		assertEquals(CommonService.SUCCESS, resultCode);
	}

	@Test
	public void testView() throws Exception {
		param.put("pSiteId", "ucms");
		service.view(paramCtx);
		ZValue result = (ZValue)model.get(CommonService.RESULT);
		assertTrue(result != null);
	}

	@Test
	public void testDelete() throws Exception {
		param.put("pSiteId", "test");
		service.delete(paramCtx);
		String resultCode = (String)model.get(CommonService.RESULT_CODE_KEY);
		assertEquals(CommonService.SUCCESS, resultCode);
	}

	@Test
	public void testCnfirmSiteId() throws Exception {
		param.put("pSiteId", "ucms");
		service.cnfirmSiteId(paramCtx);
		Long resultCnt = (Long)model.get("resultCnt");
		assertTrue(resultCnt != null);
	}

	@Test
	public void testGetSiteBySiteName() throws Exception {
		ZValue result = service.getSiteBySiteName("ucms");
		assertTrue(result != null);
	}

	@Test
	public void testGetSiteGuideMenuListBySiteId() throws Exception {
		List<ZValue> resultList = service.getSiteGuideMenuListBySiteId("ucms", "01");
		assertTrue(resultList.size() > 0);
	}

	@Test
	public void testUseYnChange() throws Exception {
		param.put("pSiteId", "ucms");
		param.put("fieldNm", "faxnoUseAt");
		param.put("val", "Y");
		service.useYnChange(paramCtx);
		String resultCode = (String)model.get(CommonService.RESULT_CODE_KEY);
		assertEquals(CommonService.SUCCESS, resultCode);
	}

}
