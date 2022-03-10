package site.unp.cms.view;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.AbstractView;

import site.unp.core.ZValue;
import site.unp.core.util.WebUtil;

@Service
public class ApplicationImageView extends AbstractView {

    Logger log = LoggerFactory.getLogger(this.getClass());

	@Override
	protected void renderMergedOutputModel(Map<String, Object> model, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		FileInputStream fis = null;
		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;
		try {
			ZValue data = (ZValue) model.get("data");
			//ZValue data = applyDAO.selectFileByFileId(zvl.getString("fileId"));

			File file = new File(data.getString("filePath"), data.getString("fileName"));
			fis = new FileInputStream(file);

			in = new BufferedInputStream(fis);
			bStream = new ByteArrayOutputStream();

			int imgByte;
			while ((imgByte = in.read()) != -1) {
				bStream.write(imgByte);
			}
			in.close();

			String type = "";
			String fileExt = data.getString("fileExt");
			if (fileExt != null && !"".equals(fileExt)) {
				String _fileExt = fileExt.toLowerCase();
				if ("jpg".equals(_fileExt)) {
					type = "image/jpeg";
				} else {
					type = "image/" + _fileExt;
				}
				type = "image/" + _fileExt;

			} else {
			}

			response.setHeader("Content-Type", WebUtil.removeCRLF(type));
			response.setContentLength(bStream.size());

			bStream.writeTo(response.getOutputStream());

			response.getOutputStream().flush();
		} catch (Exception e) {
			log.debug( e.getMessage() );
		} finally {
			try { if (fis!=null) fis.close(); } catch (Exception e2) { log.error(e2.getMessage());  }
			try { if (in!=null) in.close(); } catch (Exception e3) { log.error(e3.getMessage());  }
			try { if (bStream!=null) {bStream.flush(); bStream.close();} } catch (Exception e4) { log.error(e4.getMessage());  }
		}
	}

}
