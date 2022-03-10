package site.unp.cms.service.singl;

import java.io.File;

public interface FileServer {

	public void download(File file, String contentsPath) throws Exception;
}
