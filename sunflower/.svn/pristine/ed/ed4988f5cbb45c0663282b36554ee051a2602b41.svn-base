package site.unp.cms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class CaptchaController {

	/**
	 * captcha 이미지를 생성한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/captcha/image")
	public String image(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "cmmn/captcha/image";
	}

	/**
	 * captcha 사운드를 생성한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/captcha/sound")
	public String sound(HttpServletRequest request, HttpServletResponse response) throws Exception {

		return "cmmn/captcha/sound";
	}
}
