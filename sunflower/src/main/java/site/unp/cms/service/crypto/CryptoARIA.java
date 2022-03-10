package site.unp.cms.service.crypto;

import java.io.UnsupportedEncodingException;

import javax.annotation.Resource;

import org.apache.commons.net.util.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import egovframework.rte.fdl.cryptography.EgovCryptoService;

@Component("cryptoARIA")
public class CryptoARIA {

	private Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="ARIACryptoService")
	EgovCryptoService cryptoService;

	/* 해당 프로젝트 설정된 패스워드 */
	public String plainPassword = "unpl";

	/* 해당 프로젝트 설정된 암호화 알고리즘 */
	@Value("#{prop['crypto.password.algorithm']}")
	private String passwdAlgorithm;


	public String encryptData(String plainText) {

		String encodeText = null;

		try {
			byte[] encrypted = cryptoService.encrypt(plainText.getBytes("UTF-8"), plainPassword);
			encodeText = Base64.encodeBase64String(encrypted);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return encodeText;
	}


	public String decryptData(String encodeText) {
		String plainText = null;

		try {
			byte[] base64dec = Base64.decodeBase64(encodeText);
			byte[] decrypted = cryptoService.decrypt(base64dec, plainPassword);
			plainText = new String(decrypted, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		return plainText;
	}

}
