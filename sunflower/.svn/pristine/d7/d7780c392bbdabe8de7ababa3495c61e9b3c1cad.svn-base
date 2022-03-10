package org.springframework.security.authentication.encoding;

import org.junit.Before;
import org.junit.Test;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;

public class ShaPasswordEncoderTest {

	@Before
	public void setUp() throws Exception {
	}

	@Test
	public void test() {
		ShaPasswordEncoder encoder = new ShaPasswordEncoder(256);
		String ep = encoder.encodePassword("1234", null);
		System.out.println(ep);
	}

}
