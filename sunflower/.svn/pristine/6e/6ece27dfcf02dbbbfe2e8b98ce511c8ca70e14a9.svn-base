import java.security.MessageDigest;

import site.unp.cms.conf.PasswordEncrypter;



public class TestEncryptPassword {
	
	public static void main(String[] args) {
		
		
		String pwd = "unpl7471!@#";
		
		String test = PasswordEncrypter.encrypt(pwd);
		
		System.out.println("pwd = " + pwd + "\r\n" + test);
		
		/*try {
			
			MessageDigest digest = MessageDigest.getInstance("SHA-256");
			byte[] hash = digest.digest(pwd.getBytes("UTF-8"));
			StringBuffer hexString = new StringBuffer();
			
			for (int i = 0; i < hash.length; i++) {
				String hex = Integer.toHexString(0xff & hash[i]);
				if(hex.length() == 1) hexString.append('0');
				hexString.append(hex);
			}
			
			System.out.println("pwd = " + pwd + "\r\n" + hexString.toString());
			
		} catch (Exception ex) {
			throw new RuntimeException(ex);
		}*/
		
	}

	/*
	* 지정한 범위내에서 난수발생	
	*/
	public static  int randomRange(int min, int max){
		return (int)Math.random()*(max-min)+min;
	}
}
