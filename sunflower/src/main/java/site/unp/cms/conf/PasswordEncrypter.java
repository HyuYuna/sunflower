/**
 * 
 */
package site.unp.cms.conf;

import java.security.MessageDigest;



/**
  * @FileName : PasswordEncrypter.java
  * @Date : 2021. 1. 22. 
  * @작성자 : 이상훈
  * @변경이력 : 
  * @프로그램 설명 : 패스워드 SHA-256암호화 모듈
  */
public class PasswordEncrypter {
	public static String encrypt(String pwd) {
		
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(pwd.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();
			
			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if(hex.length() == 1) hexString.append('0');
				hexString.append(hex);
			}
			
			return hexString.toString();
			
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}
		
	};
}
