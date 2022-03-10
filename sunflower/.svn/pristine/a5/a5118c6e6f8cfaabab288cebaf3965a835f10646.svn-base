package site.unp.cms.dao.file;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("ekrFileDAO")
public class EkrFileDAO extends SqlDAO<ZValue> {
	public ZValue findCmmnFileDetail(int uflSeq, int uflFilesize) throws Exception {
		ZValue param = new ZValue();
		
		param.put("uflSeq", uflSeq);
		param.put("uflFilesize", uflFilesize);
		return findOne("ekrFileDownload", param);
	}

	public void deleteCmmnFileDetail(String atchFileId, int fileSn) throws Exception {
		ZValue param = new ZValue();
		param.put("atchFileId", atchFileId);
		param.put("fileSn", fileSn);
		deleteOne("deleteCmmnFileDetail", param);
	}

}
