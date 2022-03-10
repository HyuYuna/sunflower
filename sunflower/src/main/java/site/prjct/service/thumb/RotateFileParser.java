package site.prjct.service.thumb;

import site.prjct.service.thumb.RotateThumbnailatorMakeStrategy.RotateImageInfo;
import site.unp.cms.service.file.FileParser;
import site.unp.cms.service.file.ThumbnailMakeStrategy.ImageInfo;
import site.unp.core.ZValue;
import site.unp.core.util.StrUtils;
 
public class RotateFileParser extends FileParser {

	@Override
	protected ImageInfo getImageInfo(ZValue param, ZValue fvo) {
		int width = param.getInt("width");
		int height = param.getInt("height");
		double scale = param.getDouble("scale");
		if (width == 0 && height == 0 && scale == 0) {
			scale = 0.25;
		}

		String fileFieldNm = fvo.getString("fileFieldNm");
		double angle = param.getDouble("angle" + StrUtils.replace(fileFieldNm, "file", ""));
		ImageInfo imageInfo = new RotateImageInfo(width, height, scale, angle);
		return imageInfo;
	}

}
