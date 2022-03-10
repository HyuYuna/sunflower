package site.unp.cms.service.file;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Scanner;
import java.util.UUID;

import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import site.unp.cms.service.file.ThumbnailMakeStrategy.ImageInfo;
import site.unp.core.ZValue;
import site.unp.core.util.StrUtils;

public class FileParser {

	private static Logger log = LoggerFactory.getLogger(FileParser.class);

	public static final String FILE_CN_PREFIX = "fileCn_";

	private ThumbnailMakeStrategy thumbnailMakeStrategy = new ThumbnailatorMakeStrategy();

	public List<ZValue> parseFileInf(Map<String, MultipartFile> files, String fileStreCours, String folderPath, String prefix, Map<String, String> fileCnMap, ZValue param) throws Exception {
		File saveFolder = new File(fileStreCours);
		if (!saveFolder.exists()) {
			if (!saveFolder.mkdirs()){
				log.error(saveFolder + " :: Unable to create path!!");
			}
		}

		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		String filePath = "";
		List<ZValue> resultList = new ArrayList<ZValue>();
		ZValue fvo;

		int fileSn = 0;
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			String orignlFileNm = file.getOriginalFilename();

			// --------------------------------------
			// 원 파일명이 없는 경우 처리
			// (첨부가 되지 않은 input file type)
			// --------------------------------------
			if ("".equals(orignlFileNm)) {
				continue;
			}
			//// ------------------------------------

			int index = orignlFileNm.lastIndexOf(".");
			// String fileName = orginFileName.substring(0, index);
			String fileExtsnNm = orignlFileNm.substring(index + 1);
			/**
			 * 2019.12.26 : 보안상 getTimeStamp에서 UUID.randomUUID()로 변경...z
			 */
			String streFileNm = UUID.randomUUID().toString().replace("-","")+ "." + fileExtsnNm;
			//String streFileNm = prefix + getTimeStamp() + String.valueOf(fileSn) + "." + fileExtsnNm;
			long fileSize = file.getSize();
			String fileFieldNm = file.getName();
			String fileCn = null;
			if (MapUtils.isNotEmpty(fileCnMap)) {
				fileCn = fileCnMap.get(FILE_CN_PREFIX + fileFieldNm);
			}

			fvo = new ZValue();
			
			fvo.put("fileExtsnNm", fileExtsnNm);
			fvo.put("fileStreCours", folderPath);
			fvo.put("fileSize", fileSize);
			fvo.put("orignlFileNm", orignlFileNm);
			fvo.put("streFileNm", streFileNm);
			fvo.put("fileSn", fileSn);
			fvo.put("fileFieldNm", file.getName());
			
			fvo.put("bfextension", fileExtsnNm);
			fvo.put("bfuploadfolder", folderPath);
			fvo.put("bffilesize", fileSize);
			fvo.put("bforiginalfilename", orignlFileNm);
			fvo.put("bffilename", streFileNm);
			fvo.put("bfimagewidth", "0");
			
			fvo.put("uflFilenameSaved", streFileNm);
			fvo.put("uflFilenameOriginal", orignlFileNm);
			fvo.put("uflFilenameExtension", fileExtsnNm);
			fvo.put("uflFilesize", fileSize);
			fvo.put("urlFileLocation", folderPath);
			
			if(param.getString("uflMimetype").length() == 0){
				fvo.put("uflMimetype", fileExtsnNm);
			}
			
			if (fileCn != null) {
				fvo.put("fileCn", fileCn);
				fvo.put("bffilememo", fileCn);
			}
			resultList.add(fvo);

			File newFile = null;
			if (!"".equals(orignlFileNm)) {
				filePath = fileStreCours + File.separator + streFileNm;
				newFile = new File(filePath);
				file.transferTo(newFile);

				thumbnailMakeStrategy.make(newFile, getImageInfo(param, fvo));
			}

			fileSn++;

		}
		return resultList;
	}

	protected ImageInfo getImageInfo(ZValue param, ZValue fvo) {
		int width = param.getInt("width");
		int height = param.getInt("height");
		double scale = param.getDouble("scale");
		if (width == 0 && height == 0 && scale == 0) {
			scale = 0.25;
		}

		List<String> _angles = param.getList("angle");
		double[] angles = new double[_angles.size()];
		int i = 0;
		for (String a : _angles) {
			angles[i] = StrUtils.parseDouble(a);
		}

		ImageInfo imageInfo = new ImageInfo(width, height, scale);
		return imageInfo;
	}

	public static String getTimeStamp() {
		String rtnStr = null;
		// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
		String pattern = "yyyyMMddhhmmssSSS";
		try {
			SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
			Timestamp ts = new Timestamp(System.currentTimeMillis());
			rtnStr = sdfCurrent.format(ts.getTime());
		} catch (IllegalArgumentException iie){
			log.debug("IllegalArgumentException: " + iie.getMessage());
		} catch (Exception e) {
			log.debug("IGNORED: " + e.getMessage());
		}

		return rtnStr;
	}

    /**
     * 해당 파일 읽어서 스트링으로 변환하기
     * @param filePath
     * @return
     * @throws FileNotFoundException
     */
    public static String getFileToString(String filePath){
    	StringBuffer content=null;
    	FileInputStream fis=null;
    	try {
	    	content = new StringBuffer();
	    	fis = new FileInputStream(filePath);

        	@SuppressWarnings("resource")
    		Scanner s = new Scanner(fis,"utf-8");
        	while (s.hasNext()) {
        		content.append(s.nextLine()).append("\n");
        	}
		} catch (FileNotFoundException fne) {
			log.error("FileNotFoundException: " + fne.getMessage());
		} catch (Exception e) {
			log.error("Exception: " + e.getMessage());
		} finally {
			if (fis!=null){ try { fis.close();} catch (IOException e) {	e.printStackTrace();}}
		}

    	return content.toString();
    }

	public ThumbnailMakeStrategy getThumbnailMakeStrategy() {
		return thumbnailMakeStrategy;
	}

	public void setThumbnailMakeStrategy(ThumbnailMakeStrategy thumbnailMakeStrategy) {
		this.thumbnailMakeStrategy = thumbnailMakeStrategy;
	}

}
