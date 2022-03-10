package site.unp.cms.listener.bbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.MapUtils;
import org.springframework.stereotype.Component;

import site.unp.cms.service.bbs.acl.AclUtils;
import site.unp.cms.service.bbs.acl.BbsAclService;
import site.unp.cms.service.bbs.acl.BbsPermission;
import site.unp.cms.service.siteManage.SiteInfoService;
import site.unp.core.ParameterContext;
import site.unp.core.ZValue;
import site.unp.core.domain.UsersVO;
import site.unp.core.exception.UnpBizException;
import site.unp.core.listener.CommonListenerSupport;
import site.unp.core.service.sec.UnpUserDetailsHelper;

@Component
public class AclBbsAccessListener extends CommonListenerSupport {

	public static final Map<String, BbsPermission> METHOD_MAP = new HashMap<>();
	static {
		METHOD_MAP.put("insert", BbsPermission.WRITE);
		METHOD_MAP.put("list", BbsPermission.LIST);
		METHOD_MAP.put("delete", BbsPermission.DELETE);
		METHOD_MAP.put("delPermanently", BbsPermission.DELETE);
		METHOD_MAP.put("deleteAll", BbsPermission.DELETE);
		METHOD_MAP.put("deleteAllPermanently", BbsPermission.DELETE);
		METHOD_MAP.put("answer", BbsPermission.ANSWER);
		METHOD_MAP.put("view", BbsPermission.READ);
		METHOD_MAP.put("forUpdate", BbsPermission.UPDATE);
		METHOD_MAP.put("update", BbsPermission.UPDATE);
		METHOD_MAP.put("fileUpload", BbsPermission.FILE_UPLOAD);
		METHOD_MAP.put("fileDownload", BbsPermission.FILE_DOWNLOAD);
		METHOD_MAP.put("gongji", BbsPermission.GONGJI);
	}

	@Resource(name="bbsAclService")
	private BbsAclService bbsAclService;

	@Override
	public void before(ParameterContext paramCtx) throws Exception {
		ZValue param = paramCtx.getParam();
		String bbsId = param.getString("bbsId");
		param.put("id", AclUtils.getId(bbsId));

		String siteId = paramCtx.getParam().getString("siteId");
		if (!SiteInfoService.BOS_SITE_ID.equals(siteId)) {
			return;
		}
		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		if (user != null && !UnpUserDetailsHelper.isAuthenticated("ROLE_SUPER")) {

			Map<String, List<ZValue>> roleMap = bbsAclService.readAcesById(bbsId);
			if (MapUtils.isNotEmpty(roleMap)) {
				BbsPermission p = METHOD_MAP.get(param.getString("targetMethod"));
				if (p!=null && !bbsAclService.hasPermission(param, p)) {
					throw new UnpBizException("권한이 없습니다.");

				}
			}

		}
	}
}
