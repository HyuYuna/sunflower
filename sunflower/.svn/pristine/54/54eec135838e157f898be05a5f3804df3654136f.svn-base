package site.unp.cms.service.file;

import site.unp.core.ParameterContext;
import site.unp.core.ZValue;

public interface EkrFileMngService {
	
	public boolean uploadFile(ParameterContext paramCtx) throws Exception;
	
	public ZValue getFile(int uflSeq, int uflFilesize) throws Exception;
	
	public void setImgUrl(ZValue val);
	
    public static final String ROOT_IMG_URL = "/files";
    public static final String PREFIX_FILE_NORMAL_NAME = "normalFile";
    public static final String PREFIX_FILE_IMG_NAME = "imgFile";
    public static final String IMG_ALLOW_FILE_EXT = "jpg,jpeg,png,gif,bmp";
    public static final String lIMIT_FILE_SIZE_KEY = "limitFileSize";
    public static final String ALLOW_FILE_EXT_KEY = "allowFileExt";
    public static final long ATCH_LIMIT_SIZE = 30000000L;
}
