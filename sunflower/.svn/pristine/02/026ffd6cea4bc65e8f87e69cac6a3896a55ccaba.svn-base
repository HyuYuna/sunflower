package site;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

import javax.activation.MimetypesFileTypeMap;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.ArrayUtils;
import org.junit.Test;
import org.springframework.util.StringUtils;

import net.coobird.thumbnailator.Thumbnails;
import site.unp.cms.service.file.ThumbnailatorMakeStrategy;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.util.WebFactory;

public class SimpleTest {

	@Test
	public void test() throws Exception {
		/*
		File xFile = new File("D:/Project/stsWorkspace/ucms-2.0.8/src/main/resources/egovframework/sqlmap/mybatis/site/unp/mysql");
		for (String s : xFile.list()) {
			System.out.println(s);
		}
		*/
		List<String> list1 = new ArrayList<>();
		List<String> list2 = new ArrayList<>();
		File t = new File("D:/Temp/sql.txt");
		List<String> lines = FileUtils.readLines(t, "UTF-8");
		for (String l : lines) {
			String[] data = StringUtils.delimitedListToStringArray(l, "=");
			if (StringUtils.hasText(data[0])) {
				list1.add(data[0]);
			}
			if (StringUtils.hasText(data[1])) {
				list2.add(data[1]);
			}
		}
		for (String s : list1) {
			if (list2.contains(s)) {
				list2.remove(s);
			}
		}
		System.out.println(list2);
		
	}
	
	@Test
	public void stringUtilsTest() {
		String s = null;
		System.out.println(StringUtils.trimAllWhitespace(s));
		s = "s=";
		System.out.println(ArrayUtils.toString(StringUtils.delimitedListToStringArray(s, "=")));
		
		System.out.println(StringUtils.cleanPath("/a/b//cc/d//e"));
		

		String groupId = "";
		String className = SiteInfoService.class.getName();
		String[] packageData = StringUtils.delimitedListToStringArray(className, ".");
		int groupIdIndex = 0;
		int index = 0;
		for (String p : packageData) {
			if ("service".equals(p)) {
				groupIdIndex = index + 1;
			}
			index++;
		}
		if (packageData.length-1 <= groupIdIndex) {
			groupId = "singl";
		}
		else {
			groupId = packageData[groupIdIndex];
		}
		System.out.println("groupId : " + groupId);
	}

	@Test
	public void buildUrlTest() throws UnsupportedEncodingException {
		ZValue param = new ZValue();
		String link = WebFactory.buildUrl("/bos/bbs/attrb/view.do", param, "menuNo", "attrbCd", "attrbTyCd", "bbsId");
		System.out.println(link);
	}
	
	@Test
	public void fileTest() throws Exception {
		File orgFile = new File("E:/Down/other/innoedu.zip");
    	if (orgFile.exists()) {
			String mimetype= new MimetypesFileTypeMap().getContentType(orgFile);
	        String type = mimetype.split("/")[0];
	        if (type.equals("image")) {
        		File thumbnail = new File(orgFile.getParent(), ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME+"/"+orgFile.getName());
        		thumbnail.getParentFile().mkdir();
        		String fileExt = StringUtils.getFilenameExtension(orgFile.getName());
            	Thumbnails.of(orgFile).size(190, 150).outputFormat(fileExt).toFile(thumbnail);
            	System.out.println("thumbnail is created : {}" + thumbnail.getAbsolutePath());
        	}
        }
	}
	

	@Test
	public void testAnnotation() throws Exception {
		Class<?> clz = SiteInfoService.class;
		Method[] ms = clz.getDeclaredMethods();
		for (Method m : ms) {
			if (m.isAnnotationPresent(CommonServiceLink.class)) {
				System.out.println(m);
			}
		}
	}
}
