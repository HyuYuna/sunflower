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
	 * ????????? ???????????? ?????? ??????????????? ????????? ????????? ????????? ????????????.
	 * ????????? ???????????? ?????? ????????? ????????? ????????? ????????? ????????????.
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
	 * ??????????????? ?????? ????????? ??????
	 * globalsProperties?????? ?????? ????????? ??????????????? ?????????(Service.serviceName.allowExt)??? ???????????? ??? ???????????????
	 * ??????????????? ???????????? ???????????? ????????? ??????????????? ?????????(Globals.allowExt) ??????
	 * ????????? ?????? ???????????? ????????? ??????????????????
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
					throw new UnSupportedFileException("?????????????????? ???????????? ?????? ??????????????? ?????????.");
				}
			}
			// portal ????????? pdf??? ???????????? ??????
			else if ( "portal".equals(param.getString("siteId")) ){
				if (ext!=null && !extData.contains(ext)) {
					throw new UnSupportedFileException("???????????? ?????? ??????????????? ?????????. ???????????? ????????? [" + allowFileExt + "]");
				}
			}
			else if (StringUtils.hasText(allowFileExt)){
				if (ext!=null && !extData.contains(ext)) {
					throw new UnSupportedFileException("???????????? ?????? ??????????????? ?????????. ???????????? ????????? [" + allowFileExt + "]");
				}
			}
		}
		//}
	}


	/**
	 * ??????????????? ?????????????????? ??????
	 * globalsProperties?????? ?????? ????????? ??????????????? ?????????(Service.[serviceName].limitSize)??? ???????????? ???????????? ??????
	 * limitSize??? byte????????? ??????
	 * ??????????????? ??????????????? ???????????? ??
	 * ????????? ?????? ???????????? ??????????????????
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
		if (limitSize==0L) limitSize = ATCH_LIMIT_SIZE; //????????? ?????? ????????? ??????

		if (limitSize > 0) {
			Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
			while (itr.hasNext()) {
				Entry<String, MultipartFile> entry = itr.next();
				MultipartFile file = entry.getValue();
				long fileSize = file.getSize();

				if (fileSize > limitSize) {
					throw new UnSupportedFileException("????????? ????????????[" +this.readableFileSize(fileSize)+ "]??? ??????????????? ????????? ?????????????????????. (" + this.readableFileSize(limitSize) + " ????????? ????????? ????????? ????????????.)");
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
		/* ATCH_FILE_ID ????????? ?????? ??????????????? ??????????????? ????????? ??? ???????????????.
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
	 * ????????? ????????? ????????? ??????????????? ????????????
	 * @param resultList - ????????? ?????????
	 * @param fileMap - ?????????????????? ?????? ????????? ?????? ??????????????? ???????????????
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