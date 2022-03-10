package site.unp.cms.mail;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.web.multipart.MultipartFile;

import egovframework.rte.fdl.string.EgovStringUtil;
import site.unp.cms.service.file.FileParser;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.mail.AbstractMessageSender;

public class AttachmentMessageSender extends AbstractMessageSender {

	Logger log = LoggerFactory.getLogger(this.getClass());

	protected FileParser fileParser = new FileParser();

	@Resource(name = "globalsProperties")
	protected GlobalsProperties globalsProperties;

	public void sendMessage() throws MessagingException {
		MimeMessage msg = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
		helper.setTo(to);
		helper.setFrom(from);
		helper.setSubject(subject);
		helper.setText(text, true);

		sender.send(msg);
	}

	public void sendMessage(ZValue zvl, Map<String, MultipartFile> files) throws Exception {
		MimeMessage msg = sender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true, "utf-8");
		helper.setTo(zvl.getString("to"));
		helper.setFrom(zvl.getString("from", from));
		helper.setSubject(zvl.getString("subject"));
		helper.setText(zvl.getString("text"), true);

		log.debug("mail text " + zvl.getString("text"));

		if (files != null && !files.isEmpty()) {
			String strPath = globalsProperties.getFileStorePath() + "/email";
			List<ZValue> fileList =  fileParser.parseFileInf(files, strPath, "/email", "EMAIL", null, null);
			for(ZValue vo : fileList) {
				String path = vo.getString("fileStreCours") + File.separator + vo.getString("streFileNm");
				String orgFileName = vo.getString("orignlFileNm");
				log.debug("Attatch file path " + path);
				log.debug("Attatch file orgFileName " + orgFileName);
				orgFileName = EgovStringUtil.toEng(orgFileName);
				FileSystemResource file = new FileSystemResource(new File(path));
				helper.addAttachment(orgFileName,file);
			}
		}
		sender.send(msg);
	}

    public boolean sndngEmail(ZValue param) throws Exception {
		try {
	    	this.sendMessage(param, null);
	    	return true;
    	}
		catch(Exception e) {
    		e.printStackTrace();
    		return false;
    	}
    }

}
