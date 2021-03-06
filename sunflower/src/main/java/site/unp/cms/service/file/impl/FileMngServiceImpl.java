package site.unp.cms.service.file.impl;


import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
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
import org.apache.commons.collections.MapUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import site.unp.cms.dao.file.CmmnFileDAO;
import site.unp.cms.service.file.FileParser;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.exception.UnSupportedFileException;
import site.unp.core.service.cs.CommonService;
import site.unp.core.service.file.FileMngService;
import site.unp.core.util.UnpCollectionUtils;
import site.unp.core.util.WebFactory;


@Service("fileMngService")
public class FileMngServiceImpl extends EgovAbstractServiceImpl implements FileMngService{

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="ucmsFileIdGnrService")
	private EgovIdGnrService idgenService;

	@Resource(name = "globalsProperties")
	private GlobalsProperties globalsProperties;

	@Resource(name="cmmnFileDAO")
	private CmmnFileDAO cmmnFileDAO;

	private FileParser fileParser = new FileParser();

	private SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMM");

	@Override
	public ZValue getFile(String atchFileId, int fileSn) throws Exception {
		ZValue fileVal = cmmnFileDAO.findCmmnFileDetail(atchFileId, fileSn);
		setImgUrl(fileVal);
		return fileVal;
	}

	@Override
	public List<ZValue> getFiles(String atchFileId) throws Exception {
		ZValue param = new ZValue();
		param.put("atchFileId", atchFileId);
		List<ZValue> files = cmmnFileDAO.findAll("findAllFileMngByAtchFileId", param);
		setImgUrl(files);
		return files;
	}
	
	@Override
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
	
	/**
	 * 기존에 등록되어 있는 첨부파일을 지우고 새로운 파일로 교체한다.
	 * 기존에 등록되어 있는 파일이 없으면 새로운 파일을 추가한다.
	 */
	@Override
	public String upload(Map<String, MultipartFile> files, ZValue param, Set<String> delFileFieldNames) throws Exception {
		checkFileExtensition(files, param);

		checkFileLimitSize(files, param);

		String prefix = StringUtils.hasText(param.getString("prefix")) ? "FILE_" : param.getString("prefix");
		Map<String, String> fileCnMap = param.getStartWithParam(FileParser.FILE_CN_PREFIX);
		String path = globalsProperties.getFileStorePath();
		//param.put("path",path);
		//String folderPath = getFilePath(param);
		
		String folderPath;
		if(param.getString("bfuploadfolder").length() != 0){
			path +=  "/FileData/";
			folderPath = param.getString("bfuploadfolder");
		} else {
			folderPath = getFilePath(param);
		}

		List<ZValue> fileList = fileParser.parseFileInf(files, path+folderPath, folderPath, prefix, fileCnMap, param);
		String atchFileId = param.getString("atchFileId");

		setOthbcAt(param);

		if (CollectionUtils.isNotEmpty(fileList) ) {
			WebFactory.setUserInfoParam(param);

			if (StringUtils.hasText(atchFileId)) {
			} else {
				//atchFileId = idgenService.getNextStringId();
				atchFileId = UUID.randomUUID().toString().replace("-","");
				param.putObject("atchFileId", atchFileId);
				
				if(param.getString("bid").length() == 0){
					cmmnFileDAO.save("saveCmmnFile", param);
				}
			}
			for (ZValue file : fileList) {
				if ( CollectionUtils.isNotEmpty(delFileFieldNames) ) {
					for (String ffn : delFileFieldNames) {
						if (file.getString("fileFieldNm").equals(ffn)) {
							ZValue p = new ZValue();
							p.put("atchFileId", atchFileId);
							p.put("fileFieldNm", ffn);
							cmmnFileDAO.delete("deleteCmmnFileDetailByFileFieldNm", p);
						}
					}
				}
				
				if(param.getString("bid").length() != 0){
					file.putObject("boidx", param.getString("boidx"));
					file.putObject("task", param.getString("task"));
					file.putObject("bffilecode", param.getString("bid"));
					file.putObject("bfisdownload", "Y");
					file.putObject("bfisinsertview", "Y");
					cmmnFileDAO.save("saveBbsCmmnFile", file);
				} else {
					file.putObject("atchFileId", atchFileId);
					cmmnFileDAO.save("saveCmmnFileDetail", file);
				}
			}
		} else {
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
						cmmnFileDAO.update("updateFileCn", param);
						n++;
					}
				}
			}
		}

		return atchFileId;
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
			cmmnFileDAO.modify("updateCmmnFile", param);
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

	@Override
	public void deleteAll(ZValue param, boolean physicalFileDelete) throws Exception {
		String atchFileId = param.getString("atchFileId");
		Assert.hasText(atchFileId);

		if (physicalFileDelete) {
			List<ZValue> fileDetails = cmmnFileDAO.findAll("findAllFileMngByAtchFileId", param);
			if (CollectionUtils.isNotEmpty(fileDetails)) {
				for (ZValue fileDetail : fileDetails) {
					deletePhysicalFile(fileDetail);
				}
			}
		}
		cmmnFileDAO.deleteById("deleteCmmnFileDetailByAtchFileId", atchFileId);
		cmmnFileDAO.deleteById("deleteCmmnFileByAtchFileId", atchFileId);
	}

	@Override
	public void deleteOne(ZValue param, boolean physicalFileDelete) throws Exception {
		String atchFileId = param.getString("atchFileId");
		Assert.hasText(atchFileId);
		Assert.hasText(param.getString("fileSn"));

		cmmnFileDAO.deleteCmmnFileDetail(atchFileId, param.getInt("fileSn"));
		if (physicalFileDelete) {
			ZValue fileDetail = cmmnFileDAO.findOne("findCommnFileDetail", param);
			deletePhysicalFile(fileDetail);
		}
		/* ATCH_FILE_ID 컬럼에 값이 존재하는데 지워버려서 오류가 남 주석처리함.
		if ( cmmnFileDAO.count("countCmmnFileDetailByAtchFileId", param) == 0 ) {
			cmmnFileDAO.deleteById("deleteCmmnFileByAtchFileId", atchFileId);
		}
		*/
	}

	private void deletePhysicalFile(ZValue fileDetail) {
		if (fileDetail == null) {
			return;
		}
    	String path = globalsProperties.getFileStorePath() + fileDetail.getString("fileStreCours") + File.separator + fileDetail.getString("streFileNm");
    	log.debug(">>delete file path : " + path);
    	File file = new File(path);
    	if ( file.delete() ) {
        	log.debug(">>file delete successfully (" + path + ")");
    	}
	}

	/**
	 * 게시글 리스트 첫번째 첨부화일를 저장한다
	 * @param resultList - 게시글 리스트
	 * @param fileMap - 파일아이디를 키로 가지고 있는 게시글건당 파일리스트
	 */
	@Override
	public void setFirstProperties(List<ZValue> resultList, Map<String, List<ZValue>> fileMap) {
		if ( CollectionUtils.isEmpty(resultList) || MapUtils.isEmpty(fileMap) ) {
			return;
		}
    	for ( ZValue val : resultList ) {
    		String atchFileId = val.getString("atchFileId");
    		if( StringUtils.hasText(atchFileId) ){
    			List<ZValue> fileList = fileMap.get(atchFileId);
    			if( CollectionUtils.isNotEmpty(fileList) ){
    				ZValue fileVo = fileList.get(0);
    				val.put("imgUrl", fileVo.getString("imgUrl"));
    				val.put("thumbImgUrl", fileVo.getString("thumbImgUrl"));
    				val.put("orignlFileNm", fileVo.getString("orignlFileNm"));
    				val.put("fileCount", fileVo.getString("fileCount"));
    				val.put("fileSn", fileVo.getString("fileSn"));
    				val.put("fileExtsn", fileVo.getString("fileExtsn"));
    				val.put("streFileNm", fileVo.getString("streFileNm"));
    			}
    		}
    	}
	}

	@Override
	public List<ZValue> getFiles(List<String> atchFileIdList) throws Exception {
		List<ZValue> files = cmmnFileDAO.findAllByIds("findAllCmmnFileDetailByIds", atchFileIdList);
		setImgUrl(files);
		return files;
	}

	@Override
    public void setImgUrl(List<ZValue> list) throws Exception {
    	if ( CollectionUtils.isNotEmpty(list) ) {
        	for (ZValue val : list) {
        		setImgUrl(val);
        	}
    	}
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

	@Override
	public Map<String, List<ZValue>> getFileMap(ZValue param, List<ZValue> resultList) throws Exception {
		Map<String, List<ZValue>> fileMap = Collections.emptyMap();
    	if ( CollectionUtils.isNotEmpty(resultList) ){
        	ArrayList<String> _atchFileIdData = new ArrayList<String>();
        	for ( ZValue val : resultList ) {
        		if( StringUtils.hasText(val.getString(CommonService.ATCH_FILE_ID))) {
        			_atchFileIdData.add(val.getString(CommonService.ATCH_FILE_ID));
        		}
        	}
        	if ( CollectionUtils.isNotEmpty(_atchFileIdData) ) {
        		String[] atchFileIdData = _atchFileIdData.toArray(new String[]{""});
        		ZValue fileVal = new ZValue();
        		fileVal.putObject("atchFileIdData", atchFileIdData);
        		List<ZValue> fileList = cmmnFileDAO.findAll("selectFileListByAtchFileIdData", fileVal);
        		setImgUrl(fileList);
        		fileMap = UnpCollectionUtils.convertMap(fileList, "", CommonService.ATCH_FILE_ID);
        	}
    	}

    	return fileMap;
	}

	public FileParser getFileParser() {
		return fileParser;
	}

	public void setFileParser(FileParser fileParser) {
		this.fileParser = fileParser;
	}


	public String readableFileSize(long size) {
	    if(size <= 0) return "0";
	    final String[] units = new String[] { "B", "kB", "MB", "GB", "TB" };
	    int digitGroups = (int) (Math.log10(size)/Math.log10(1000));
	    return new DecimalFormat("#,##0.#").format(size/Math.pow(1000, digitGroups)) + "" + units[digitGroups];
	}

	public void updateFileCn(ZValue fVO) throws Exception{
		cmmnFileDAO.update("updateFileCn", fVO);
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