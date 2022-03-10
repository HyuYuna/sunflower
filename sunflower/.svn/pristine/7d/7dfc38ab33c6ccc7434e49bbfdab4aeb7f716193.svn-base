package site.unp.cms.service.file.impl;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import site.unp.cms.dao.file.EkrFileDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.file.EkrFileMngService;
import site.unp.cms.service.file.FileParser;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.CommonServiceLink;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.annotation.CommonServiceLink.LinkType;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.exception.UnSupportedFileException;
import site.unp.core.service.cs.CommonService;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.WebFactory;

@Service("ekrFileMngService")
public class EkrFileMngServiceImpl extends EgovAbstractServiceImpl implements EkrFileMngService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name = "globalsProperties")
	private GlobalsProperties globalsProperties;
	
	@Resource(name="ekrFileDAO")
	private EkrFileDAO ekrFileDAO;

	private FileParser fileParser = new FileParser();

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM");

	@Override
	public ZValue getFile(int uflSeq, int uflFilesize) throws Exception {
		ZValue fileVal = ekrFileDAO.findCmmnFileDetail(uflSeq, uflFilesize);
		setImgUrl(fileVal);
		return fileVal;
	}
	
	@Override
	public boolean uploadFile(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		Map files = paramCtx.getFiles();
		if (files != null && files.size() > 0)
			upload(files, param);
		return true;
	}

	public String upload(Map<String, MultipartFile> files, ZValue param) throws Exception {
		Set<String> newData = new HashSet<>();
		Set<String> data = null;
		String fileFieldNmData = param.getString("fileFieldNm");
		if (StringUtils.hasText(fileFieldNmData)) {
			data = StringUtils.commaDelimitedListToSet(fileFieldNmData);
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				MultipartFile file = entry.getValue();
				String orignlFileNm = file.getOriginalFilename();
				if ("".equals(orignlFileNm)) {
					continue;
				}
				String fileFieldNm = file.getName();
				if (data.contains(fileFieldNm)) {
					newData.add(fileFieldNm);
				}
			}
		}
		return upload(files, param, newData);
	}

	public String upload(Map<String, MultipartFile> files, ZValue param, Set<String> delFileFieldNames) throws Exception {
		checkFileExtensition(files, param);

		checkFileLimitSize(files, param);

		String prefix = StringUtils.hasText(param.getString("prefix")) ? "FILE_" : param.getString("prefix");
		Map<String, String> fileCnMap = param.getStartWithParam(FileParser.FILE_CN_PREFIX);
		String path = globalsProperties.getFileStorePath();
		//param.put("path",path);
		String folderPath = getFilePath(param);

		List<ZValue> fileList = fileParser.parseFileInf(files, path+folderPath, folderPath, prefix, fileCnMap, param);
		String atchFileId = param.getString("atchFileId");

		setOthbcAt(param);

		if (CollectionUtils.isNotEmpty(fileList) ) {
			WebFactory.setUserInfoParam(param);

			if (StringUtils.hasText(atchFileId)) {
			}
			else {
				//atchFileId = idgenService.getNextStringId();
				atchFileId = UUID.randomUUID().toString().replace("-","");
				param.putObject("atchFileId", atchFileId);
				//cmmnFileDAO.save("saveCmmnFile", param);
			}
			for (ZValue file : fileList) {
				if ( CollectionUtils.isNotEmpty(delFileFieldNames) ) {
					for (String ffn : delFileFieldNames) {
						if (file.getString("fileFieldNm").equals(ffn)) {
							ZValue p = new ZValue();
							p.put("atchFileId", atchFileId);
							p.put("fileFieldNm", ffn);
							ekrFileDAO.delete("deleteCmmnFileDetailByFileFieldNm", p);
						}
					}
				}
				file.putObject("uflCuser", param.getString("userId"));
				file.putObject("uflText", "");
				file.putObject("uflRelNumber", param.getString("uflRelNumber"));
				file.putObject("uflRelNumber2", param.getString("cmFileUploadCodeSub"));
				
				if(param.getString("subFileFolder").length() == 0){
					file.putObject("uflRelCode", "board");
				} else {
					file.putObject("uflRelCode", param.getString("subFileFolder"));
				}
				
				ekrFileDAO.save("ekrFileUploadSave", file);
				
				param.put("filesSeq", file.getString("uflSeq"));
				param.put("uflRelNumber", file.getString("uflRelNumber"));
				param.put("uflRelNumber2", file.getString("uflRelNumber2"));
			}
		}

		else {
			List<String> fileSnList = param.getStartWithList("fileSn");
			List<String> fileCnList = param.getStartWithList(FileParser.FILE_CN_PREFIX);
			if (fileSnList != null && fileSnList.size() > 0 && !"".equals(param.getString("atchFileId",""))) {
				int n = 0;
				if (fileCnList != null && fileCnList.size() > 0) {
					for (String fileSn : fileSnList) {
						String fileCn = fileCnList.get(n);
						param.put("nowAtchFileId", param.getString("atchFileId"));
						param.put("nowFileSn", fileSn);
						param.put("fileCn", fileCn);
						ekrFileDAO.update("updateFileCn", param);
						n++;
					}
				}
			}
		}

		return atchFileId;
	}

	@Override
    public void setImgUrl(ZValue val) {
    	//Assert.hasText(properties.getFileStreCours());
		if (val!=null){
			String fileStreCours = StringUtils.cleanPath(val.getString("fileStreCours"));
			String globalsFileStreCours = StringUtils.cleanPath(globalsProperties.getString("Globals.ucms.fileStorePath"));
			String url = StringUtils.replace(fileStreCours, globalsFileStreCours, "");
			url = url.startsWith("/") ? ROOT_IMG_URL + url : ROOT_IMG_URL + "/" + url;
			url = url.endsWith("/") ? url : url + "/";
			String imgUrl = url + val.getString("streFileNm");
			val.put("imgUrl", imgUrl);
			String thumbImgUrl = url + "thumb/" + val.getString("streFileNm");
			val.put("thumbImgUrl", thumbImgUrl);
			log.debug("imgUrl : {}", imgUrl);
			log.debug("thumbImgUrl : {}", thumbImgUrl);
		}
    }

	protected void setOthbcAt(ZValue param) throws Exception {
		if (StringUtils.hasText(param.getString("othbcAt"))) {
		}
		else if (StringUtils.hasText(param.getString("secretAt"))) {
			param.put("othbcAt", param.getString("secretAt").equals("Y") ? "N" : "Y");
		}
		else {
			param.put("othbcAt","Y");
		}
		String atchFileId = param.getString("atchFileId");
		if (StringUtils.hasText(atchFileId)) {
			ekrFileDAO.modify("updateCmmnFile", param);
		}
	}

	/**
	 * 허용가능한 파일 확장자 체크
	 * globalsProperties에서 개별 서비스 허용가능한 확장자(Service.serviceName.allowExt)가 존재하면 그 확장자체크
	 * 개별서비스 확장자가 없을경우 디폴트 허용가능한 확장자(Globals.allowExt) 체크
	 * 두경우 모두 없을경우 확장자 체크하지않음
	 * @param files
	 * @param param
	 * @throws UnSupportedFileException
	 */
	protected void checkFileExtensition(Map<String, MultipartFile> files, ZValue param) throws UnSupportedFileException {
		String serviceName = param.getString(CommonService.PROGRAM_ID);
		String allowFileExt = param.getString(ALLOW_FILE_EXT_KEY);
		allowFileExt = StringUtils.trimAllWhitespace(allowFileExt);
		if ( "portal".equals(param.getString("siteId")) ){
			allowFileExt = globalsProperties.getPropertyVal().getString("portal.allowExt");
		}
		if (!StringUtils.hasText(allowFileExt)) {
			allowFileExt = globalsProperties.getPropertyVal().getString("Service." + serviceName + ".allowExt");
		}
		if (!StringUtils.hasText(allowFileExt)) {
			allowFileExt = globalsProperties.getAllowExt();
			allowFileExt = StringUtils.trimAllWhitespace(allowFileExt);
		}
		//if (StringUtils.hasText(allowFileExt)) {
		Set<String> extData = StringUtils.commaDelimitedListToSet(allowFileExt);
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			MultipartFile file = entry.getValue();
			String orginFileNm = file.getOriginalFilename();
			String ext = StringUtils.getFilenameExtension(orginFileNm);
			if (ext != null) ext = ext.toLowerCase();
			String fieldNm = file.getName();
			if (fieldNm.indexOf(PREFIX_FILE_IMG_NAME) > -1) {
				Set<String> imgExtData = StringUtils.commaDelimitedListToSet(IMG_ALLOW_FILE_EXT);
				if (ext!=null && !imgExtData.contains(ext)) {
					throw new UnSupportedFileException("이미지첨부에 허용하지 않은 파일확장자 입니다.");
				}
			}
			// portal 에서는 pdf만 올리도록 추가
			else if ( "portal".equals(param.getString("siteId")) ){
				if (ext!=null && !extData.contains(ext)) {
					throw new UnSupportedFileException("허용하지 않은 파일확장자 입니다. 허용가능 확장자 [" + allowFileExt + "]");
				}
			}
			else if (StringUtils.hasText(allowFileExt)){
				if (ext!=null && !extData.contains(ext)) {
					throw new UnSupportedFileException("허용하지 않은 파일확장자 입니다. 허용가능 확장자 [" + allowFileExt + "]");
				}
			}
		}
		//}
	}


	/**
	 * 허용가능한 파일제한용량 체크
	 * globalsProperties에서 개별 서비스 허용가능한 확장자(Service.[serviceName].limitSize)가 존재하면 파일용량 체크
	 * limitSize는 byte단위로 입력
	 * 개별서비스 제한용량이 없을경우 ??
	 * 두경우 모두 없을경우 체크하지않음
	 * @param files
	 * @param param
	 * @throws UnSupportedFileException
	 */
	protected void checkFileLimitSize(Map<String, MultipartFile> files, ZValue param) throws UnSupportedFileException {
		String serviceName = param.getString(CommonService.PROGRAM_ID);
		long limitSize  = param.getLong(lIMIT_FILE_SIZE_KEY);
		if (limitSize==0L) {
			limitSize = globalsProperties.getPropertyVal().getLong("Service." + serviceName + ".limitSize");
		}
		if (limitSize==0L) limitSize = globalsProperties.getLimitFileSize();
		if (limitSize==0L) limitSize = ATCH_LIMIT_SIZE; //시스템 최대 업로드 용량

		if (limitSize > 0) {
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				MultipartFile file = entry.getValue();
				long fileSize = file.getSize();

				if (fileSize > limitSize) {
					throw new UnSupportedFileException("첨부한 파일용량[" +this.readableFileSize(fileSize)+ "]이 첨부가능한 용량을 초과하였습니다. (" + this.readableFileSize(limitSize) + " 이하로 첨부해 주시기 바랍니다.)");
				}
			}
		}
	}
	
	public String readableFileSize(long size) {
	    if(size <= 0) return "0";
	    final String[] units = new String[] { "B", "kB", "MB", "GB", "TB" };
	    int digitGroups = (int) (Math.log10(size)/Math.log10(1000));
	    return new DecimalFormat("#,##0.#").format(size/Math.pow(1000, digitGroups)) + "" + units[digitGroups];
	}

	protected String getFilePath(ZValue param) throws Exception{
		String folder = simpleDateFormat.format(new Date());
		String programId = param.getString(CommonService.PROGRAM_ID);
		StringBuilder result = new StringBuilder();
		//result.append(param.getString("path")).append("/");
		result.append("/");
		result.append(programId);
		result.append("/").append(folder).toString();
		return result.toString();
	}
}
