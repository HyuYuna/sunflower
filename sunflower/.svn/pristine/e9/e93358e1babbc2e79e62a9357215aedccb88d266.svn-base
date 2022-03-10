package site.unp.core.paging;

import org.junit.Test;

import site.unp.core.ZValue;
import site.unp.core.paging.DefaultPageQuery;

public class DefaultPageQueryTest {

	@Test
	public void testGetPageQueryString() throws Exception {
		DefaultPageQuery dpq = new DefaultPageQuery();
		ZValue param = new ZValue();
		param.put("p1", "1");
		param.put("p2", "2");
		param.put("obj", new ZValue());
		System.out.println(dpq.getPageQueryString(param, "p1,p2"));
	}

}
