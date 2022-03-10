import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


public class TestZip {
	public static byte[] makeTaskFilesZip(ArrayList<String> fileList, ArrayList<String> taskTitleList) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ZipOutputStream zos = new ZipOutputStream(baos);
        byte bytes[] = new byte[2048];

        for (int i = 0 ; i < fileList.size(); i++) {
        	String fileName = fileList.get(i);
        	String taskTitle = taskTitleList.get(i);
        	//
            FileInputStream fis = new FileInputStream(fileName);
            BufferedInputStream bis = new BufferedInputStream(fis);
            
            zos.putNextEntry(new ZipEntry(taskTitle));

            int bytesRead;
            while ((bytesRead = bis.read(bytes)) != -1) {
                zos.write(bytes, 0, bytesRead);
            }
            zos.closeEntry();
            bis.close();
            fis.close();
        }
        zos.flush();
        baos.flush();
        zos.close();
        baos.close();

        return baos.toByteArray();
        
        /*
         * 용례
         * fileList.add(resultPath);
			taskTitleList.add(taskTitle + "_(" + taskNum + ")_" + typeName + ".hwp");
         * 
         * byte[] zip = CommonUtil.makeTaskFilesZip(fileList, taskTitleList);
            response.setContentType("application/zip");
            response.setHeader("Content-Disposition", "attachment; filename=GIA_ZIP.zip");
            sos.write(zip);
         */
        
    }
}

