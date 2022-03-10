package site.unp.cms.service.bbs.acl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.security.acls.AclPermissionEvaluator;
import org.springframework.security.acls.domain.GrantedAuthoritySid;
import org.springframework.security.acls.domain.ObjectIdentityImpl;
import org.springframework.security.acls.domain.PrincipalSid;
import org.springframework.security.acls.jdbc.JdbcMutableAclService;
import org.springframework.security.acls.model.AccessControlEntry;
import org.springframework.security.acls.model.Acl;
import org.springframework.security.acls.model.MutableAcl;
import org.springframework.security.acls.model.ObjectIdentity;
import org.springframework.security.acls.model.Sid;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import site.unp.core.ZValue;
import site.unp.core.domain.UsersVO;
import site.unp.core.exception.UnpBizException;
import site.unp.core.service.sec.UnpUserDetailsHelper;
import site.unp.core.util.UnpCollectionUtils;

@Service
public class BbsAclService {

	@Resource(name="aclService")
	private JdbcMutableAclService aclService;

	@Resource(name="permissionEvaluator")
	private AclPermissionEvaluator permissionEvaluator;

	public BbsAclService() {
	}

	public Acl readAclById(String bbsId) throws Exception {

		ObjectIdentity oid = new ObjectIdentityImpl(ZValue.class, AclUtils.getId(bbsId));

		Acl acl = null;

		try {
			acl = aclService.readAclById(oid);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return acl;
	}

	public Map<String, List<ZValue>> readAcesById(String bbsId) throws Exception {
		Acl acl = readAclById(bbsId);

		List<AccessControlEntry> result = null;
		List<ZValue> newList = new ArrayList<>();
		if ( acl != null ) {
			result = acl.getEntries();
			if ( CollectionUtils.isNotEmpty(result) ) {
				for (AccessControlEntry entry : result) {
					if ( entry.getSid() instanceof GrantedAuthoritySid ) {
						BbsPermission cp = (BbsPermission)entry.getPermission();
						GrantedAuthoritySid gsid = (GrantedAuthoritySid)entry.getSid();
						ZValue val = new ZValue();
						val.put("role", gsid.getGrantedAuthority());
						val.put("pm", Character.toString(cp.getCode()));
						newList.add(val);
					}
				}
			}
		}
		return UnpCollectionUtils.convertMap(newList, "", "role");
	}

	public void save(ZValue param) throws Exception {
		String id = param.getString("bbsId");

		ObjectIdentity oid = new ObjectIdentityImpl( ZValue.class , AclUtils.getId(id));

		aclService.deleteAcl(oid, true);

		MutableAcl acl = null;
		if(oid != null){
			 acl = aclService.createAcl(oid);
		}

		UsersVO user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
		PrincipalSid sid = new PrincipalSid(user.getUserId());
		acl.setOwner(sid);

		List<String> roleList = param.getStartWithList("role_");
		int i = 0;
		for (String r : roleList) {
			List<String> pmList = param.getStartWithList("pm_" + r);
			for (String p : pmList) {
				BbsPermission bp = BbsPermission.getBbsPermission(p);
				acl.insertAce(i++, bp, new GrantedAuthoritySid(r), true);
			}
		}
		aclService.updateAcl(acl);
	}

	public void deleteAcl(String bbsId) throws Exception {
		ObjectIdentity oid = new ObjectIdentityImpl(ZValue.class, AclUtils.getId(bbsId));
		aclService.deleteAcl(oid, true);
	}

	public boolean hasPermission(ZValue param, Object permission) throws Exception {
		SecurityContext context = SecurityContextHolder.getContext();
		Authentication authentication = context.getAuthentication();
		return permissionEvaluator.hasPermission(authentication, param, permission);
	}

	public void hasPermissionRole(Acl acl) throws UnpBizException {
		Sid ownerSid = acl.getOwner();
		UsersVO user = new UsersVO();
		try {
			user = (UsersVO)UnpUserDetailsHelper.getAuthenticatedUser();
			if ( ownerSid.equals(new PrincipalSid(user.getUserId())) ) {
				return;
			}
		} catch (Exception e) {
			throw new UnpBizException("잘못된 접근입니다.");
		}

        final List<AccessControlEntry> aces = acl.getEntries();
        boolean result = false;
		List<String> auths = UnpUserDetailsHelper.getAuthorities();
		for (String a : auths) {
			GrantedAuthoritySid gsid = new GrantedAuthoritySid(a);
	        for (AccessControlEntry ace : aces) {
	        	Sid sid = ace.getSid();
				if ( sid.equals(gsid) ) {
					result = true;
					break;
				}
	        }
		}

		if (!result) {
			throw new UnpBizException("해당 게시판에 대한 권한이 없습니다.");
		}

	}
}
