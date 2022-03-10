package site.unp.cms.dao.file;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("cmmnFileDAO")
public class CmmnFileDAO extends SqlDAO<ZValue> {
	
	public ZValue findCmmnFileDetail(String atchFileId, int fileSn) throws Exception {
		ZValue param = new ZValue();
		param.put("atchFileId", atchFileId);
		param.put("fileSn", fileSn);
		return findOne("findOneCommnFileDetail", param);
	}
	
	public ZValue findBbsFileDetail(String bid, int bfidx) throws Exception {
		ZValue param = new ZValue();
		param.put("bffilecode", bid);
		param.put("bfidx", bfidx);
		
		return findOne("findOneFileMngDetail", param);
	}

	public void deleteCmmnFileDetail(String atchFileId, int fileSn) throws Exception {
		ZValue param = new ZValue();
		param.put("atchFileId", atchFileId);
		param.put("fileSn", fileSn);
		deleteOne("deleteCmmnFileDetail", param);
	}

	public void deleteBbsFile(String bfidx) throws Exception {
		ZValue param = new ZValue();
		param.put("bfidx", bfidx);
		deleteOne("deleteBbsFile", param);
	}
	
	public ZValue findFileDetail(String bid, int bfidx) throws Exception {
		ZValue param = new ZValue();
		
		param.put("bfidx", bfidx);
		param.put("bid", bid);
		return findOne("findOneFileMngDetail", param);
	}
	
}
