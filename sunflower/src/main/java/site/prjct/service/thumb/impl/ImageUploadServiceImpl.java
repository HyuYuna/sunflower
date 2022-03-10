package site.prjct.service.thumb.impl;

import org.springframework.ui.ModelMap;

import site.prjct.service.thumb.ImageUploadService;
import site.unp.core.ParameterContext;
import site.unp.core.annotation.CommonServiceDefinition;
import site.unp.core.annotation.UnpJsonView;
import site.unp.core.service.cs.impl.DefaultCrudServiceImpl;
import site.unp.core.util.MVUtils;

@CommonServiceDefinition(
	fileMngServiceRef="rotateFileMngService"
)
public class ImageUploadServiceImpl extends DefaultCrudServiceImpl implements ImageUploadService {

	@Override
	@UnpJsonView
	public void insert(ParameterContext paramCtx) throws Exception {
		uploadFile(paramCtx);

		ModelMap model = paramCtx.getModel();
		MVUtils.setResultProperty(model, SUCCESS, null);
	}
}
