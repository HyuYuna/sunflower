package site.unp.cms.service.file;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.apache.sanselan.ImageReadException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.Thumbnails.Builder;
import net.coobird.thumbnailator.geometry.Positions;
import site.unp.core.exception.UnpBizException;

public class ThumbnailatorMakeStrategy implements ThumbnailMakeStrategy {

	Logger log = LoggerFactory.getLogger(this.getClass());
	public static final String THUMB_FOLDER_NAME = "thumb";
	private static final String IMAGE_PATTERN = "([^\\s]+(\\.(?i)(jpg|png|gif|bmp))$)";

	@Override
	public void make(File orgFile, ImageInfo imageInfo) throws Exception {
    	if (orgFile.exists()) {
    		if (orgFile.getName().matches(IMAGE_PATTERN)) {
        		String fileExt = StringUtils.getFilenameExtension(orgFile.getName());

        		File thumbnailDir = new File(orgFile.getParent(), ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME+"/");
        		if (!thumbnailDir.exists()) {
        			if (!thumbnailDir.mkdirs()){
        				log.error(thumbnailDir + " :: Unable to create path!!");
        			}
        		}

        		File thumbnail = new File(orgFile.getParent(), ThumbnailatorMakeStrategy.THUMB_FOLDER_NAME+"/"+orgFile.getName());

        		if (imageInfo.getScale() > 0) {
        			try {
            			Thumbnails.of(orgFile).scale(imageInfo.getScale()).outputFormat(fileExt).toFile(thumbnail);
					} catch (IllegalArgumentException ile) {
						throw new UnpBizException("IllegalArgumentException : " + ile.getMessage());
					} catch (IllegalStateException ise) {
						throw new UnpBizException("IllegalStateException : " + ise.getMessage());
					} catch (IOException ioe) {
						throw new UnpBizException("IOException : " + ioe.getMessage());
					} catch (Exception e) {
						throw new UnpBizException("형식에 맞지않는 파일타입이 존재합니다.");
					}
        		}
        		else {
        			// crop
        			try {
        				crop(orgFile, thumbnail, imageInfo.getWidth(), imageInfo.getHeight());
					} catch (IllegalArgumentException ile) {
						throw new UnpBizException("IllegalArgumentException : " + ile.getMessage());
					} catch (IllegalStateException ise) {
						throw new UnpBizException("IllegalStateException : " + ise.getMessage());
					} catch (IOException ioe) {
						throw new UnpBizException("IOException : " + ioe.getMessage());
					} catch (Exception e) {
						throw new UnpBizException("형식에 맞지않는 파일타입이 존재합니다.");
					}

        			// 썸네일 작업
        			//makeThumbImg(orgFile.getPath(), thumbnailDir.getPath(), orgFile.getName(), imageInfo.getWidth(), imageInfo.getHeight(), 100, true, false);
        		}
            	log.debug("thumbnail is created : {}", thumbnail.getAbsolutePath());
        	}
        }
	}

	protected void crop(File orgFile, File outFile, int width, int height) throws IOException {
		String fileExt = StringUtils.getFilenameExtension(orgFile.getName());
		BufferedImage image = null;
		JpegReader reader = new JpegReader();

		try { // CMYK인경우  javax.imageio.IIOException: Unsupported Image Type 오류 발생
			image = ImageIO.read(orgFile);
		} catch (Exception e) {
			try { //CMYK인 경우 RGB 변환 후 같은 이름으로 저장 후 다시 읽어 들임
				image = reader.readImage(orgFile);
	            ImageIO.write(image, "jpg", orgFile);//동일한 명으로 이미지를 변경한다. 복사본을 남기려면  별도의 파일명으로 변경
	            image.flush(); //메모리 누수 대처

	            image = ImageIO.read(orgFile); // 다시 읽어 들임
			} catch (ImageReadException e1) {
				e1.printStackTrace();
			}
		}


		Builder<BufferedImage> builder = null;
		if (image!=null){
			int imageWidth = image.getWidth();
			int imageHeitht = image.getHeight();
			if ((float)height / width != (float)imageWidth / imageHeitht) {
				if (imageWidth > imageHeitht) {
					image = Thumbnails.of(orgFile).height(height).asBufferedImage();
				} else {
					image = Thumbnails.of(orgFile).width(width).asBufferedImage();
				}
				builder = Thumbnails.of(image).sourceRegion(Positions.CENTER, width, height).size(width, height);
			} else {
				builder = Thumbnails.of(image).size(width, height);
			}
			builder.outputFormat(fileExt).toFile(outFile);
			image.flush();
		}
	}



}
