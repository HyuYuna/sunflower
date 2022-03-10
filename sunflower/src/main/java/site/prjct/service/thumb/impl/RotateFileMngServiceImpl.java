package site.prjct.service.thumb.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import site.prjct.service.thumb.RotateFileParser;
import site.prjct.service.thumb.RotateThumbnailatorMakeStrategy;
import site.unp.cms.dao.file.CmmnFileDAO;
import site.unp.cms.service.file.FileParser;
import site.unp.cms.service.file.impl.FileMngServiceImpl;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.util.WebFactory;

@Service("rotateFileMngService")
public class RotateFileMngServiceImpl extends FileMngServiceImpl implements InitializingBean {

	@Resource(name = "globalsProperties")
	private GlobalsProperties globalsProperties;

	@Resource(name="cmmnFileDAO")
	private CmmnFileDAO cmmnFileDAO;

	@Override
	public String upload(Map<String, MultipartFile> files, ZValue param, Set<String> delFileFieldNames) throws Exception {

		checkFileExtensition(files, param);

		checkFileLimitSize(files, param);

		String prefix = StringUtils.hasText(param.getString("prefix")) ? "FILE_" : param.getString("prefix");
		Map<String, String> fileCnMap = param.getStartWithParam(FileParser.FILE_CN_PREFIX);
		String path = globalsProperties.getFileStorePath();
		//param.put("path",path);
		String folderPath = getFilePath(param);

		List<ZValue> fileList = getFileParser().parseFileInf(files, path+folderPath, folderPath, prefix, fileCnMap, param);
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
				cmmnFileDAO.save("saveCmmnFile", param);
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
				file.putObject("atchFileId", atchFileId);
				cmmnFileDAO.save("saveCmmnFileDetail", file);
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
						cmmnFileDAO.update("updateFileCn", param);
						n++;
					}
				}
			}
		}
		return atchFileId;

	}

	@Override
	public void afterPropertiesSet() throws Exception {
		FileParser fileParser = new RotateFileParser();
		fileParser.setThumbnailMakeStrategy(new RotateThumbnailatorMakeStrategy());
		setFileParser(fileParser);
	}

}
