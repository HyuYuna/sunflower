package site.unp.cms.service.file.impl;

import java.io.File;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import site.unp.cms.dao.file.CmmnFileDAO;
import site.unp.cms.service.file.FileBbsService;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;

@Service("fileBbsService")
public class FileBbsServiceImpl extends FileMngServiceImpl implements FileBbsService {

	Logger log = LoggerFactory.getLogger(this.getClass());

	@Resource(name="ucmsFileIdGnrService")
	private EgovIdGnrService idgenService;

	@Resource(name = "globalsProperties")
	private GlobalsProperties globalsProperties;

	@Resource(name="cmmnFileDAO")
	private CmmnFileDAO cmmnFileDAO;

	@Override
	public ZValue getFile2(String bid, int bfidx) throws Exception {
		ZValue fileVal = cmmnFileDAO.findBbsFileDetail(bid, bfidx);
		setImgUrl(fileVal);
		return fileVal;
	}
	
	@Override
	public void deleteOne(ZValue param, boolean physicalFileDelete) throws Exception {
		String bfidx = param.getString("bfidx");

		cmmnFileDAO.deleteBbsFile(bfidx);
		if (physicalFileDelete) {
			ZValue fileDetail = cmmnFileDAO.findOne("findOneFileMngDetail", param);
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

}
