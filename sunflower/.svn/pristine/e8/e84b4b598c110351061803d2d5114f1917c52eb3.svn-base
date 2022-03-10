package site.unp.cms.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URI;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.text.Normalizer;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.dao.instance.CaseDAO;
import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.file.EkrFileMngService;
import site.unp.cms.service.file.FileBbsService;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.domain.UsersVO;
import site.unp.core.service.cs.CommonService;
import site.unp.core.service.file.FileMngService;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.MVUtils;
import site.unp.core.util.WebFactory;

@Controller
public class FileDwldController {

	@Resource(name = "fileMngService")
	private FileMngService fileMngService;

	@Resource(name = "ekrFileMngService")
	private EkrFileMngService ekrFileMngService;

	@Resource(name = "fileBbsService")
	private FileBbsService fileBbsService;

	@Resource(name = "globalsProperties")
	private GlobalsProperties globalsProperties;

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	@Resource(name="caseDAO")
	private CaseDAO caseDAO;

	@Value("#{prop['Globals.ucms.fileStorePath.zipDir']}") private String targetDir;
	@Value("#{prop['Globals.ucms.OsType']}") private String osType;
	@Value("#{prop['Globals.ucms.fileStorePath']}") private String fileStorePath;


	private static final Logger LOG = LoggerFactory.getLogger(FileDwldController.class.getName());

	/**
	 * 브라우저 구분 얻기.
	 *
	 * @param request
	 * @return
	 */
	public static String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1 || header.indexOf("Trident") > -1) {
			return "MSIE";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}

	/**
	 * Disposition 지정하기.
	 *
	 * @param filename
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public static void setDisposition(String filename, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);

		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;

		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = new String(filename.getBytes("UTF-8"), "8859_1");
		} else if (browser.equals("Opera")) {
			encodedFilename =  new String(filename.getBytes("UTF-8"), "8859_1") ;
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			// throw new RuntimeException("Not supported browser");
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix + "\"" + encodedFilename + "\"");

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/{siteId}/cmmn/file/fileDown")
	public void cvplFileDownload(HttpServletRequest request, HttpServletResponse response, @PathVariable String siteId) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		String path = globalsProperties.getFileStorePath();
		String atchFileId = param.getString("atchFileId");
		ZValue fVal = fileMngService.getFile(atchFileId, param.getInt("fileSn"));

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if ("N".equals(vo.getString("othbcAt")) &&
						(user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId"))))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}


		File uFile = new File(path + fVal.getString("fileStreCours"), fVal.getString("streFileNm"));
		if (!uFile.exists()) {
			uFile = new File(path + fVal.getString("fileStreCours"), fVal.getString("streFileNm") + "." + fVal.getString("fileExtsnNm"));
		}
		int fSize = (int) uFile.length();

		if (fSize > 0) {
			String orignlFileNm = fVal.getString("orignlFileNm");
			if (orignlFileNm.indexOf(".") == -1) {
				orignlFileNm = orignlFileNm + "." + fVal.getString("fileExtsnNm");
			}
			String mimetype = "application/x-msdownload";

			// response.setBufferSize(fSize); // OutOfMemeory 발생
			response.setContentType(mimetype);
			// response.setHeader("Content-Disposition", "attachment;
			// filename=\"" + URLEncoder.encode(fvo.getString("OrignlFileNm"), "utf-8")
			// + "\"");
			setDisposition(orignlFileNm, request, response);
			response.setContentLength(fSize);

			/*
			 * FileCopyUtils.copy(in, response.getOutputStream()); in.close();
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());

				FileCopyUtils.copy(in, out);
				out.flush();

				// 공통파일 다운로드 이력정보 저장
				UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
				if (user!=null && user.getUserId()!=null) param.put("userId", user.getUserId());
				param.put("siteId", siteId);
				sqlDAO.save("saveCommFileDwldHist", param);

			} catch (Exception ex) {
				// ex.printStackTrace();
				// 다음 Exception 무시 처리
				// Connection reset by peer: socket write error
				LOG.debug("IGNORED: " + ex.getMessage());
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
			}

		} else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fVal.getString("orignlFileNm") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}

	}

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/{siteId}/cmmn/file/bfFileDown")
	public void bfFileDownload(HttpServletRequest request, HttpServletResponse response, @PathVariable String siteId) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		String path = globalsProperties.getFileStorePath() + "/FileData/";
		ZValue fVal = fileBbsService.getFile2(param.getString("bffilecode"), param.getInt("bfidx"));

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if ("N".equals(vo.getString("othbcAt")) &&
						(user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId"))))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}

		File uFile = new File(path + fVal.getString("bfuploadfolder"), fVal.getString("bffilename"));
		if (!uFile.exists()) {
			uFile = new File(path + fVal.getString("bfuploadfolder"), fVal.getString("bffilename") + "." + fVal.getString("bfextension"));
		}
		int fSize = (int) uFile.length();

		if (fSize > 0) {
			String bforiginalfilename = fVal.getString("bforiginalfilename");
			if (bforiginalfilename.indexOf(".") == -1) {
				bforiginalfilename = bforiginalfilename + "." + fVal.getString("bfextension");
			}
			String mimetype = "application/x-msdownload";

			// response.setBufferSize(fSize); // OutOfMemeory 발생
			response.setContentType(mimetype);
			// response.setHeader("Content-Disposition", "attachment;
			// filename=\"" + URLEncoder.encode(fvo.getString("OrignlFileNm"), "utf-8")
			// + "\"");
			setDisposition(bforiginalfilename, request, response);
			response.setContentLength(fSize);

			/*
			 * FileCopyUtils.copy(in, response.getOutputStream()); in.close();
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());

				FileCopyUtils.copy(in, out);
				out.flush();

				// 공통파일 다운로드 이력정보 저장
				UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
				if (user!=null && user.getUserId()!=null) param.put("userId", user.getUserId());
				param.put("siteId", siteId);
				//sqlDAO.save("saveCommFileDwldHist", param);
				
				//파일 다운로드 COUNT
				sqlDAO.save("updateFileDownloadCount", param);

			} catch (Exception ex) {
				// ex.printStackTrace();
				// 다음 Exception 무시 처리
				// Connection reset by peer: socket write error
				LOG.debug("IGNORED: " + ex.getMessage());
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
			}

		} else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fVal.getString("bforiginalfilename") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}

	}

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 *
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/{siteId}/cmmn/file/ekrFileDown")
	public void ekrFileDownload(HttpServletRequest request, HttpServletResponse response, @PathVariable String siteId) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		if("CASE".equals(param.getString("chGroup"))){
		    param.put("chGroup", "FILE");
		    param.put("chMemo", "첨부파일 다운로드 사유 : "+ param.getString("chMemo"));
			caseDAO.save("saveCaseHistory", param);
			param.put("chGroup", "CASE");
		}

		if(param.getString("codnum").equals("boardDemand")){
			//아이디, 센터코드 불러오기
			sqlDAO.modify("ekrUploadFileListInsertCenterJaryo", param);
		}

		String path = globalsProperties.getFileStorePath();
		ZValue fVal = ekrFileMngService.getFile(param.getInt("uflSeq"), param.getInt("uflFilesize"));

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if ("N".equals(vo.getString("othbcAt")) &&
						(user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId"))))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}

		//이전 파일 경로 수정
		String location = fVal.getString("urlFileLocation").replace("\\","/");
		String[] locationSplit = location.split("/");
		if(locationSplit.length >= 3){
			location = "/" + locationSplit[1] + "/" + locationSplit[2];
		}
		
		File uFile = new File(path + location, fVal.getString("uflFilenameSaved"));
		if (!uFile.exists()) {
			uFile = new File(path + location, fVal.getString("uflFilenameSaved") + "." + fVal.getString("uflFilenameExtension"));
		}
		int fSize = (int) uFile.length();

		if (fSize > 0) {
			String uflFilenameOriginal = fVal.getString("uflFilenameOriginal");
			if (uflFilenameOriginal.indexOf(".") == -1) {
				uflFilenameOriginal = uflFilenameOriginal + "." + fVal.getString("uflFilenameExtension");
			}
			String mimetype = "application/x-msdownload";
			// response.setBufferSize(fSize); // OutOfMemeory 발생
			response.setContentType(mimetype);
			// response.setHeader("Content-Disposition", "attachment;
			// filename=\"" + URLEncoder.encode(fvo.getString("OrignlFileNm"), "utf-8")
			// + "\"");
			setDisposition(uflFilenameOriginal, request, response);
			response.setContentLength(fSize);

			/*
			 * FileCopyUtils.copy(in, response.getOutputStream()); in.close();
			 * response.getOutputStream().flush();
			 * response.getOutputStream().close();
			 */
			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
				in = new BufferedInputStream(new FileInputStream(uFile));
				out = new BufferedOutputStream(response.getOutputStream());

				FileCopyUtils.copy(in, out);
				out.flush();

				// 공통파일 다운로드 이력정보 저장
				UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
				if (user!=null && user.getUserId()!=null) param.put("userId", user.getUserId());
				param.put("siteId", siteId);
				//sqlDAO.save("saveCommFileDwldHist", param);

			} catch (Exception ex) {
				// ex.printStackTrace();
				// 다음 Exception 무시 처리
				// Connection reset by peer: socket write error
				LOG.debug("IGNORED: " + ex.getMessage());
			} finally {
				if (in != null) {
					try {
						in.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
				if (out != null) {
					try {
						out.close();
					} catch (Exception ignore) {
						// no-op
						LOG.debug("IGNORED: " + ignore.getMessage());
					}
				}
			}

		} else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fVal.getString("uflFilenameOriginal") + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
		}

	}

	@RequestMapping("/{siteId}/cmmn/file/deleteFileInfs")
	public ModelMap deleteFileInf(HttpServletRequest request, HttpServletResponse response, ModelMap model, @PathVariable String siteId) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
			// 1. 공통게시판 여부 && 비공개일 경우 (자기 id체크)
			// 2. 공통게시판 여부 && 삭제된 게시글인 경우
			//ZValue bbsVO = sqlDAO.findOne("findOneBbsEstnAtchFileIdAt", param);

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if (user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId")))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return null;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}

		if(param.getString("bfidx").length() != 0){
			fileBbsService.deleteOne(param, false);
		} else {
			fileMngService.deleteOne(param, false);
		}
		MVUtils.setResultProperty(model, CommonService.SUCCESS, "정상처리하였습니다.");
		return model;
	}

	/**
	 * 다중 파일 다운로드 (zip파일로 압축)
	 * @param request
	 * @param response
	 * @param model
	 * @throws Exception
	 */
	@RequestMapping({"/{siteId}/cmmn/file/zipFileDown.do"})
    public void fileExcelDownload(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
      ZValue param = WebFactory.getAttributes(request);
      String fileSnListStr = param.getString("fileSnListStr");
      String atchFileId = param.getString("atchFileId");
      String siteId = param.getString("siteId");

      if ("".equals(fileSnListStr) || "".equals(atchFileId)) return;

      /**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if ("N".equals(vo.getString("othbcAt")) &&
						(user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId"))))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}


      String[] fileSnArr = fileSnListStr.split(",");
      param.putObject("fileSnArr",fileSnArr);

      List<ZValue> list = sqlDAO.findAll("selectFileListByFileSnArr",param);

	  	String fileNm = "img_download.zip";
	  	//if (list.size() > 0) prgNm = list.get(0).getString("prgNm") + "." + "zip";

	  	final String filePath = targetDir + File.separator + "img_download.zip";
	    final Path path = Paths.get(targetDir);
	    Files.createDirectories(path);

	    //압축 파일 생성 옵션(새로생성, 파일명 캐릭터셋등)
	    final Map<String, String> zipProp = new HashMap<String,String>();
	    zipProp.put("create", Boolean.toString(true));
	    zipProp.put("encoding", Charset.defaultCharset().displayName());

	    //압축파일 경로
	    URI zipFileUri = null;
	    if ("UNIX".equals(osType)) {
	    	zipFileUri = URI.create("jar:file:" + targetDir + "/" + "img_download.zip");
	    }
	    else {
	    	zipFileUri = URI.create("jar:file:///" + targetDir + "/" + "img_download.zip");
	    }

	    //압축파일 파일 시스템생성
	    try (FileSystem zipfs = FileSystems.newFileSystem(zipFileUri, zipProp)) {

	    	for (ZValue fileVO : list) {
	    		String orignlFileNm = fileVO.getString("orignlFileNm");
	    		String itemPath = fileStorePath + fileVO.getString("fileStreCours") + File.separator + (fileVO.getString("streFileNm"));
        		Path targetFile = Paths.get(itemPath);

        		Normalizer.normalize(orignlFileNm, Normalizer.Form.NFC);
    	        Path targetPath = zipfs.getPath(File.separator+fileVO.getString("orignlFileNm"));

	        	//압축 파일안에 압축할 파일 넣기
	        	Files.copy(targetFile, targetPath, StandardCopyOption.REPLACE_EXISTING);
        	}

	    } catch (Exception  e) {
	        e.printStackTrace();
	    }

	    File uFile = new File(filePath);
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			setDisposition(fileNm, request, response);
			response.setContentLength(fSize);

			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
			    in = new BufferedInputStream(new FileInputStream(uFile));
			    out = new BufferedOutputStream(response.getOutputStream());

			    FileCopyUtils.copy(in, out);
			    out.flush();

			    uFile.delete();

			} catch (Exception ex) {
			    //ex.printStackTrace();
				LOG.debug(ex.toString());
			} finally {
			    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
						LOG.debug(ignore.toString());
					}
			    }
			    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
						LOG.debug(ignore.toString());
					}
			    }
			}

	    } else {
			response.setContentType("application/x-msdownload");

			PrintWriter printwriter = response.getWriter();
			printwriter.println("<html>");
			printwriter.println("<br><br><br><h2>Could not get file name:<br>" + fileNm + "</h2>");
			printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
			printwriter.println("<br><br><br>&copy; webAccess");
			printwriter.println("</html>");
			printwriter.flush();
			printwriter.close();
	    }
    }

	@RequestMapping("/{siteId}/cmmn/file/fileUploadDelete")
	public ModelMap fileUploadDelete(HttpServletRequest request, HttpServletResponse response, ModelMap model, @PathVariable String siteId) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
			// 1. 공통게시판 여부 && 비공개일 경우 (자기 id체크)
			// 2. 공통게시판 여부 && 삭제된 게시글인 경우
			//ZValue bbsVO = sqlDAO.findOne("findOneBbsEstnAtchFileIdAt", param);

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if (user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId")))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return null;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user!=null && user.getUserId()!=null) param.put("userId", user.getUserId());

		sqlDAO.deleteOne("ekrFileUploadDelete", param);

		model.addAttribute("resultCode", "true");
		model.addAttribute("resultMessage", "자료를 삭제했습니다.");

		return model;
	}

	@RequestMapping("/{siteId}/cmmn/file/fileUploadList")
	public ModelMap fileUploadList(HttpServletRequest request, HttpServletResponse response, ModelMap model, @PathVariable String siteId) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(siteId)) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
			// 1. 공통게시판 여부 && 비공개일 경우 (자기 id체크)
			// 2. 공통게시판 여부 && 삭제된 게시글인 경우
			//ZValue bbsVO = sqlDAO.findOne("findOneBbsEstnAtchFileIdAt", param);

			// 프로그램 전체 적용
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				if (user == null || (user !=null && !(user.getUserId()).equals(vo.getString("registId")))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return null;
				}
			}
		}
		else {
			//관리자는 다 조회함.
		}

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user!=null && user.getUserId()!=null) param.put("userId", user.getUserId());

		List<ZValue> fileList = sqlDAO.findAll("findAllEkrFile", param);
		model.addAttribute("fileList", fileList);

		return model;
	}

	@RequestMapping({"/bos/cmmn/file/zipFileDown2.do"})
    public void zipFileDown2(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		if("CASE".equals(param.getString("chGroup"))){
		    param.put("chGroup", "FILE");
			param.put("chMemo", "첨부파일 다운로드 사유 : "+ param.getString("chMemo"));
			caseDAO.save("saveCaseHistory", param);
			param.put("chGroup", "CASE");
		}

		List<ZValue> resultList = sqlDAO.findAll("findUploadZip", param);

		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		String resultMessage = sdf.format(today);

	  	String fileNm = param.getString("zipName")+ resultMessage +".zip";

	  	final String filePath = targetDir + File.separator + fileNm;
	    final Path path = Paths.get(targetDir);
	    Files.createDirectories(path);

	    //압축 파일 생성 옵션(새로생성, 파일명 캐릭터셋등)
	    final Map<String, String> zipProp = new HashMap<String,String>();
	    zipProp.put("create", Boolean.toString(true));
	    zipProp.put("encoding", Charset.defaultCharset().displayName());

	    //압축파일 경로
	    URI zipFileUri = null;
	    if ("UNIX".equals(osType)) {
	    	zipFileUri = URI.create("jar:file:" + targetDir + "/" + fileNm);
	    }
	    else {
	    	zipFileUri = URI.create("jar:file:///" + targetDir + "/" + fileNm);
	    }
	    //압축파일 파일 시스템생성
	    try (FileSystem zipfs = FileSystems.newFileSystem(zipFileUri, zipProp)) {
	    	if( resultList.size() != 0){
	    		for(int i=0; i<resultList.size(); i++) {
	    			ZValue fileVO = resultList.get(0);
	    			fileVO.put("orignlFileNm", resultList.get(i).get("uflFilenameOriginal").toString());
	    			
	    			//이전 파일 경로 수정
	    			String location = resultList.get(i).get("urlFileLocation").toString().replace("\\","/");
	    			String[] locationSplit = location.split("/");
	    			if(locationSplit.length >= 3){
	    				location = "/" + locationSplit[1] + "/" + locationSplit[2];
	    			}
	    			
	    			fileVO.put("fileStreCours", location);
	    			fileVO.put("streFileNm", resultList.get(i).get("uflFilenameSaved").toString());
	    			String orignlFileNm = fileVO.getString("orignlFileNm");
	    			String itemPath = fileStorePath + fileVO.getString("fileStreCours") + File.separator + (fileVO.getString("streFileNm"));

	    			Path targetFile = Paths.get(itemPath);

	    			Normalizer.normalize(orignlFileNm, Normalizer.Form.NFC);
	    			Path targetPath = zipfs.getPath(File.separator+fileVO.getString("orignlFileNm"));

	    			//압축 파일안에 압축할 파일 넣기
	    			Files.copy(targetFile, targetPath, StandardCopyOption.REPLACE_EXISTING);
	    		}
	    	}
	    } catch (Exception  e) {
	        e.printStackTrace();
	    }
	    File uFile = new File(filePath);
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			setDisposition(fileNm, request, response);
			response.setContentLength(fSize);

			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
			    in = new BufferedInputStream(new FileInputStream(uFile));
			    out = new BufferedOutputStream(response.getOutputStream());

			    FileCopyUtils.copy(in, out);
			    out.flush();
			    uFile.delete();
			} catch (Exception ex) {
			    //ex.printStackTrace();
				LOG.debug(ex.toString());
			} finally {
			    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
						LOG.debug(ignore.toString());
					}
			    }
			    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
						LOG.debug(ignore.toString());
					}
			    }
			}
	    }
    }

	@RequestMapping({"/bos/cmmn/file/zipBbsFileDown.do"})
    public void zipBbsFileDown(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		ZValue param = WebFactory.getAttributes(request);
		List<ZValue> resultList = sqlDAO.findAll("findUploadBbsZip", param);

		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

		String resultMessage = sdf.format(today);

	  	String fileNm = param.getString("boidx")+ resultMessage +".zip";

	  	final String filePath = targetDir + File.separator + fileNm;
	    final Path path = Paths.get(targetDir);
	    Files.createDirectories(path);

	    //압축 파일 생성 옵션(새로생성, 파일명 캐릭터셋등)
	    final Map<String, String> zipProp = new HashMap<String,String>();
	    zipProp.put("create", Boolean.toString(true));
	    zipProp.put("encoding", Charset.defaultCharset().displayName());

	    //압축파일 경로
	    URI zipFileUri = null;
	    if ("UNIX".equals(osType)) {
	    	zipFileUri = URI.create("jar:file:" + targetDir + "/" + fileNm);
	    }
	    else {
	    	zipFileUri = URI.create("jar:file:///" + targetDir + "/" + fileNm);
	    }
	    //압축파일 파일 시스템생성
	    try (FileSystem zipfs = FileSystems.newFileSystem(zipFileUri, zipProp)) {
	    	if( resultList.size() != 0){
	    		for(int i=0; i<resultList.size(); i++) {
	    			ZValue fileVO = resultList.get(0);
	    			fileVO.put("orignlFileNm", resultList.get(i).get("bforiginalfilename").toString());
	    			fileVO.put("fileStreCours", resultList.get(i).get("bfuploadfolder").toString());
	    			fileVO.put("streFileNm", resultList.get(i).get("bffilename").toString());
	    			String orignlFileNm = fileVO.getString("orignlFileNm");
	    			String itemPath = fileStorePath + "/FileData/" + fileVO.getString("fileStreCours") + File.separator + (fileVO.getString("streFileNm"));

	    			Path targetFile = Paths.get(itemPath);

	    			Normalizer.normalize(orignlFileNm, Normalizer.Form.NFC);
	    			Path targetPath = zipfs.getPath(File.separator+fileVO.getString("orignlFileNm"));

	    			//압축 파일안에 압축할 파일 넣기
	    			Files.copy(targetFile, targetPath, StandardCopyOption.REPLACE_EXISTING);
	    		}
	    	}
	    } catch (Exception  e) {
	        e.printStackTrace();
	    }
	    File uFile = new File(filePath);
	    int fSize = (int)uFile.length();

	    if (fSize > 0) {
			String mimetype = "application/x-msdownload";

			//response.setBufferSize(fSize);	// OutOfMemeory 발생
			response.setContentType(mimetype);
			//response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fvo.getOrignlFileNm(), "utf-8") + "\"");
			setDisposition(fileNm, request, response);
			response.setContentLength(fSize);

			BufferedInputStream in = null;
			BufferedOutputStream out = null;

			try {
			    in = new BufferedInputStream(new FileInputStream(uFile));
			    out = new BufferedOutputStream(response.getOutputStream());

			    FileCopyUtils.copy(in, out);
			    out.flush();
			    uFile.delete();
			} catch (Exception ex) {
			    //ex.printStackTrace();
				LOG.debug(ex.toString());
			} finally {
			    if (in != null) {
					try {
					    in.close();
					} catch (Exception ignore) {
						LOG.debug(ignore.toString());
					}
			    }
			    if (out != null) {
					try {
					    out.close();
					} catch (Exception ignore) {
						LOG.debug(ignore.toString());
					}
			    }
			}
	    }
    }
}
