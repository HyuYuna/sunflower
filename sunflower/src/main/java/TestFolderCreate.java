import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;


public class TestFolderCreate {
	//소스경로
	static String sorceFolder = "C:/eGovFrameDev-3.9.0-64bit/workspace/sunflower";
	//static String sorceFolder = "C:/eGovFrameDev-2.7.1-64bit/workspace";	

	public static void main(String[] args) {
		
		String mkFolder = "";
		String tmpStr  = "";
		int idx = 0;
		int totCnt = 0;
		
		String targetFileName = null;
		String targetFileName2 = null;
		BufferedReader in = null;
		
		Calendar cal = Calendar.getInstance();
		String year = ""+cal.get(cal.YEAR);
		String month = cal.get(cal.MONTH)+1<10?"0"+(cal.get(cal.MONTH)+1):""+(cal.get(cal.MONTH)+1);
		String date = cal.get(cal.DATE)<10?"0"+cal.get(cal.DATE):""+cal.get(cal.DATE);
		
		String fileDate = "_"+year+month+date;
		
		try{
			in = new BufferedReader(new FileReader("C:/Temp/test.txt"));
			
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyyMMddHHmmss");
			String str =  dayTime.format(new Date());
			System.out.println("현재시간: "+str);
			
			while ((targetFileName = in.readLine()) != null) {
				
				targetFileName2 = targetFileName;
				
/*				targetFileName = targetFileName.replaceAll("/sunflower/src/main/webapp/", "/").replaceAll("/sunflower/src/main/resources/", "/target/classes/")
						.replaceAll("/sunflower/src/main/java/", "/target/classes/").replaceAll(".java", ".class");
*/				
				//원본파일 경로 및 파일
				targetFileName = targetFileName.replaceAll("/sunflower/src/main/webapp/", "/src/main/webapp/").replaceAll("/sunflower/src/main/resources/", "/target/classes/")
						.replaceAll("/sunflower/src/main/java/", "/target/classes/").replaceAll(".java", ".class");
				
				//출력될 파일 경로
				targetFileName2 = targetFileName2.replaceAll("/sunflower/src/main/webapp/", "/").replaceAll("/sunflower/src/main/resources/", "/WEB-INF/classes/")
					.replaceAll("/sunflower/src/main/java/", "/WEB-INF/classes/").replaceAll(".java", ".class");
				
				System.out.println(targetFileName);
				
				
				tmpStr = "C:/Temp/해바라기_반영소스"+fileDate+targetFileName2;
            	idx = tmpStr.lastIndexOf("/");
            	mkFolder = tmpStr.substring(0,idx);
            	
            	System.out.println(sorceFolder + targetFileName); 
				
				fileCopy(sorceFolder+targetFileName, mkFolder, "C:/Temp/해바라기_반영소스"+fileDate+targetFileName2);				
				totCnt++;
	         }    

		}catch(IOException e){
			e.printStackTrace();
		}finally{
			try {
				in.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("작업건수: "+totCnt);
		
	}
	
	 
	 public static void fileCopy(String inFileName, String tagetFoler, String outFileName) {
	   try {
		   
		   File targetFoler = new File(tagetFoler);
		   
		   if(!targetFoler.exists()){
			   targetFoler.mkdirs();
		   }
		   
		   File file = new File(outFileName);
		   file.createNewFile();
		   
		   
		   FileInputStream fis = new FileInputStream(inFileName);
		   FileOutputStream fos = new FileOutputStream(outFileName);
	    
		   int data = 0;
		   while((data=fis.read())!=-1) {
			   fos.write(data);
		   }
		   fis.close();
		   fos.close();		
		   
		  
	    
	   } catch (IOException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
	   }
	}	

}
