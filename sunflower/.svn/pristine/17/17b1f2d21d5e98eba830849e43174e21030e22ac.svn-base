package site.unp.cms.service.captcha;

import static org.junit.Assert.*;

import java.io.IOException;

import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

public class CaptChaTest {

	CaptCha c = new CaptCha();

	MockHttpServletRequest req = new MockHttpServletRequest();
	MockHttpServletResponse resp = new MockHttpServletResponse();

	@Test
	public void testGetCaptCha() throws IOException, Exception {
		c.getCaptCha(req, resp);
	}

}
