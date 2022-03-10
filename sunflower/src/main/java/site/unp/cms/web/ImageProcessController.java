package site.unp.cms.web;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;

import site.unp.cms.domain.MemberVO;
import site.unp.cms.service.file.ThumbnailatorMakeStrategy;
import site.unp.cms.util.Seed256Util;
import site.unp.core.ZValue;
import site.unp.core.conf.GlobalsProperties;
import site.unp.core.dao.ISqlDAO;
import site.unp.core.service.file.FileMngService;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.HttpUtil;
import site.unp.core.util.StrUtils;
import site.unp.core.util.WebFactory;
import site.unp.core.util.WebUtil;

@SuppressWarnings("serial")
@Controller
public class ImageProcessController extends HttpServlet {

	@Resource(name = "fileMngService")
	private FileMngService fileService;

	@Resource(name = "globalsProperties")
	private GlobalsProperties globalsProperties;

	@Resource(name = "SqlDAO")
	private ISqlDAO<ZValue> sqlDAO;

	private static final Logger LOG = LoggerFactory.getLogger(ImageProcessController.class.getName());

	/**
	 * 첨부된 이미지에 대한 미리보기 기능을 제공한다.
	 *
	 * @param atchFileId
	 * @param fileSn
	 * @param sessionVO
	 * @param model
	 * @param response
	 * @throws Exception
	 */

	@RequestMapping("/cmmn/file/imageSrc.do")
	public void imageView(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String fileStreCours = request.getParameter("fileStreCours");
		String streFileNm = request.getParameter("streFileNm");
		String path = globalsProperties.getFileStorePath();


		//ZValue fileVal = fileService.getFile(atchFileId, StrUtils.parseInt(request.getParameter("fileSn")));
		if (fileStreCours == null || streFileNm==null || fileStreCours.equals("") || streFileNm.equals("")) {
			return;
		}
		//LOG.debug("fileVal : {}", fileVal);
		// String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

		// 2011.10.10 보안점검 후속조치
		File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

		BufferedImage gray;
		BufferedImage image;
		String grayTp = request.getParameter("grayTp") == null ? "" : request.getParameter("grayTp");
		String thumb = request.getParameter("thumb") == null ? "" : request.getParameter("thumb");
		final ByteArrayOutputStream output = new ByteArrayOutputStream() {
			@Override
			public synchronized byte[] toByteArray() {
				return this.buf;
			}
		};

		try {
			fileStreCours = WebUtil.filePathBlackList(Seed256Util.Decrypt(fileStreCours));
			streFileNm = Seed256Util.Decrypt(streFileNm);
			if ("Y".equals(thumb)) {
				path = path + fileStreCours;
				if (fileStreCours.endsWith("/")) {
					path += ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME;
				}
				else {
					path += "/" + ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME;
				}
				file = new File(WebUtil.filePathBlackList(path), WebUtil.filePathReplaceAll(streFileNm));
			}
			else {
				file = new File(WebUtil.filePathBlackList(path + fileStreCours), WebUtil.filePathReplaceAll(streFileNm));
			}
			LOG.debug(file.toString());
			if (file.exists()) {
				if ("Y".equals(grayTp)) { //이미지 흑백처리

					image = ImageIO.read(file);

					// create a grayscale image the same size
					gray = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_BYTE_GRAY);

					// convert the original colored image to grayscale
					// ColorConvertOp op = new
					// ColorConvertOp(image.getColorModel().getColorSpace(),
					// gray.getColorModel().getColorSpace(), null);
					// op.filter(image, gray);

					// Get the graphics context for the black-and-white image.
					// 여기서 이미지 효과를 저장 해서 만든다.
					Graphics2D g2d = gray.createGraphics();

					// Render the input image on it.
					g2d.drawImage(image, 0, 0, null);
					ImageIO.write(gray, "jpg", output);
					output.flush();
					image.flush();

				} else {
					// 2017.10.30 보안약점 : 예외에 따르 종료 처리
					try {
						fis = new FileInputStream(file);

						in = new BufferedInputStream(fis);
						bStream = new ByteArrayOutputStream();

						int imgByte;
						while ((imgByte = in.read()) != -1) {
							bStream.write(imgByte);
						}
						bStream.flush();
					} catch (IOException ioe) {
						ioe.printStackTrace();
					} finally {
						if(fis != null) try { fis.close(); } catch(Exception e) {
							LOG.debug("FileInputStream close Exception.");
						}
						if(in != null) try { in.close(); } catch(Exception e) {
							LOG.debug("BufferedInputStream close Exception.");
						}
					}

				}

				String type = "";
				String fileExtsnNm = streFileNm.substring(streFileNm.lastIndexOf(".")+1,streFileNm.length());
				if (StringUtils.hasText(fileExtsnNm)) {
					if ("jpg".equals(fileExtsnNm.toLowerCase())) {
						type = "image/jpeg";
					} else {
						type = "image/" + fileExtsnNm.toLowerCase();
					}
				} else {
					LOG.debug("Image fileType is null.");
				}

				response.setHeader("Content-Type", WebUtil.removeCRLF(type));
				if ("Y".equals(grayTp)) {
					response.setContentLength(output.size());
					output.writeTo(response.getOutputStream());
					output.flush();
				} else {
					if (bStream!=null){
						response.setContentLength(bStream.size());
						bStream.writeTo(response.getOutputStream());
						bStream.flush();
					}
				}

				if (response.getOutputStream()!=null) {
					response.getOutputStream().flush();
					response.getOutputStream().close();
				}
			}

			// 2011.10.10 보안점검 후속조치 끝
			// 2017.10.30 보안약점 : 부적잘한 예외처리
		} finally {
			if (output != null) {
				try {
					output.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
			if (bStream != null) {
				try {
					bStream.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
		}
	}

	/**
	 * 첨부 이미지 뷰 기능
	 * @description 보안관련 노출에 민감한 이미지를  사용하는 경우 해당 URL 사용
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/{siteId}/file/getImage.do")
	public void getImageInf(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ZValue param = WebFactory.getAttributes(request);

		/**
		 * 사용자 or 관리자 접속시 첨부파일 체크 로직 추가
		 */
		if (!"bos".equals(param.getString("siteId"))) {
			MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
			// 1. 공통게시판 여부 && 비공개일 경우 (자기 id체크)
			// 2. 공통게시판 여부 && 삭제된 게시글인 경우
			//ZValue bbsVO = sqlDAO.findOne("findOneBbsEstnAtchFileIdAt", param);
			ZValue vo = sqlDAO.findOne("findOneCmmnFile", param);
			if (vo != null) {
				/*
				if (!"0".equals(bbsVO.getString("deleteCd"))) {
					HttpUtil.back(response, "접근권한이 없습니다.");
					return;
				}
				else if ("N".equals(bbsVO.getString("useAt"))){
					HttpUtil.back(response, "접근권한이 없습니다.");
					return;
				}
				*/
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

		String atchFileId = request.getParameter("atchFileId");
		String path = globalsProperties.getFileStorePath();

		ZValue fileVal = fileService.getFile(atchFileId, StrUtils.parseInt(request.getParameter("fileSn")));
		if (fileVal == null) {
			return;
		}
		LOG.debug("fileVal : {}", fileVal);
		// String fileLoaction = fvo.getFileStreCours() + fvo.getStreFileNm();

		// 2011.10.10 보안점검 후속조치
		File file = null;
		FileInputStream fis = null;

		BufferedInputStream in = null;
		ByteArrayOutputStream bStream = null;

		BufferedImage gray;
		BufferedImage image;
		String grayTp = request.getParameter("grayTp") == null ? "" : request.getParameter("grayTp");
		String thumb = request.getParameter("thumb") == null ? "" : request.getParameter("thumb");
		final ByteArrayOutputStream output = new ByteArrayOutputStream() {
			@Override
			public synchronized byte[] toByteArray() {
				return this.buf;
			}
		};

		try {
			String fileStreCours = fileVal.getString("fileStreCours");
			if ("Y".equals(thumb)) {
				path = path + fileStreCours;
				if (fileStreCours.endsWith("/")) {
					path += ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME;
				}
				else {
					path += "/" + ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME;
				}
				file = new File(WebUtil.filePathReplaceAll(path), WebUtil.filePathReplaceAll(fileVal.getString("streFileNm")));
			}
			else {
				file = new File(WebUtil.filePathReplaceAll(path + fileStreCours), WebUtil.filePathReplaceAll(fileVal.getString("streFileNm")));
			}
			if (file.exists()) {
				if ("Y".equals(grayTp)) { //이미지 흑백처리

					image = ImageIO.read(file);

					// create a grayscale image the same size
					gray = new BufferedImage(image.getWidth(), image.getHeight(), BufferedImage.TYPE_BYTE_GRAY);

					// convert the original colored image to grayscale
					// ColorConvertOp op = new
					// ColorConvertOp(image.getColorModel().getColorSpace(),
					// gray.getColorModel().getColorSpace(), null);
					// op.filter(image, gray);

					// Get the graphics context for the black-and-white image.
					// 여기서 이미지 효과를 저장 해서 만든다.
					Graphics2D g2d = gray.createGraphics();

					// Render the input image on it.
					g2d.drawImage(image, 0, 0, null);
					ImageIO.write(gray, "jpg", output);
					output.flush();
					image.flush();

				} else {
					// 2017.10.30 보안약점 : 예외에 따르 종료 처리
					try {
						fis = new FileInputStream(file);

						in = new BufferedInputStream(fis);
						bStream = new ByteArrayOutputStream();

						int imgByte;
						while ((imgByte = in.read()) != -1) {
							bStream.write(imgByte);
						}
						bStream.flush();
					} catch (IOException ioe) {
						ioe.printStackTrace();
					} finally {
						if(fis != null) try { fis.close(); } catch(Exception e) {LOG.error(e.toString());}
						if(in != null) try { in.close(); } catch(Exception e) {LOG.error(e.toString());}
					}

				}

				String type = "";
				String fileExtsnNm = fileVal.getString("fileExtsnNm");
				if (StringUtils.hasText(fileExtsnNm)) {
					if ("jpg".equals(fileExtsnNm.toLowerCase())) {
						type = "image/jpeg";
					} else {
						type = "image/" + fileExtsnNm.toLowerCase();
					}
					type = "image/" + fileExtsnNm.toLowerCase();
				} else {
					LOG.debug("Image fileType is null.");
				}

				response.setHeader("Content-Type", WebUtil.removeCRLF(type));
				if ("Y".equals(grayTp)) {
					response.setContentLength(output.size());
					output.writeTo(response.getOutputStream());
					output.flush();
				} else {
					if (bStream!=null){
						response.setContentLength(bStream.size());
						bStream.writeTo(response.getOutputStream());
						bStream.flush();
					}
				}

				if (response.getOutputStream()!=null) {
					response.getOutputStream().flush();
					response.getOutputStream().close();
				}
			}

			// 2011.10.10 보안점검 후속조치 끝
			// 2017.10.30 보안약점 : 부적잘한 예외처리
		} finally {
			if (output != null) {
				try {
					output.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
			if (bStream != null) {
				try {
					bStream.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
			if (in != null) {
				try {
					in.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
			if (fis != null) {
				try {
					fis.close();
				} catch (IllegalArgumentException iae) {
					LOG.debug("IllegalArgumentException: " + iae.getMessage());
				} catch (IOException ioe) {
					LOG.debug("IOException: " + ioe.getMessage());
				} catch (Exception ignore) {
					LOG.debug("IGNORE: " + ignore.getMessage());
				}
			}
		}
	}
}
