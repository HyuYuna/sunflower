package site.unp.cms.service.member.sec;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.provisioning.JdbcUserDetailsManager;
import org.springframework.util.StringUtils;

import site.unp.cms.domain.MemberVO;
import site.unp.core.service.sec.UnpUserDetails;

public class JnBosJdbcUserDetailsManager extends JdbcUserDetailsManager {
	private String hierarchicalRolesQuery;

    private RoleHierarchyImpl roleHierarchy = new RoleHierarchyImpl();

    private RowMapper<UserDetails> mapper;
    private AuthorityMapping authorityMapping = new AuthorityMapping();
    private String roleHierarchyStringRepresentation = null;
    private List<Map<String, Object>> roleHierarchyList = null;

    @Override
    protected void initDao() {
    	super.initDao();
    	roleHierarchyList = getJdbcTemplate().queryForList(hierarchicalRolesQuery);
    }

    public void setMapper(RowMapper<UserDetails> mapper){
    	this.mapper = mapper;
    }

	public void setHierarchicalRolesQuery(String hierarchicalRolesQuery) {
		this.hierarchicalRolesQuery = hierarchicalRolesQuery;
	}

	@Override
    protected List<UserDetails> loadUsersByUsername(String username) {
        return getJdbcTemplate().query(getUsersByUsernameQuery(), new String[] {username}, mapper);
    }

	@Override
    protected List<GrantedAuthority> loadUserAuthorities(String username) {
		List<GrantedAuthority> authorities = getJdbcTemplate().query(getAuthoritiesByUsernameQuery(), new String[] {username}, authorityMapping);
		if (mapper instanceof BosUserMapping) {
			authorities.add(new SimpleGrantedAuthority("ROLE_ADMINKEY"));
		}
		return authorities;
    }

	@Override
    protected UserDetails createUserDetails(String username, UserDetails userFromUserQuery,
            List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();
        UnpUserDetails userDetails = (UnpUserDetails)userFromUserQuery;
        MemberVO usersVO = (MemberVO)userDetails.getUsersVO();
        return new UnpUserDetails(returnUsername, userFromUserQuery.getPassword(), userFromUserQuery.isEnabled(),
                true, true, true, combinedAuthorities, usersVO);
    }

	@Override
	public void addCustomAuthorities(String username, List<GrantedAuthority> authorities) {
		if( !StringUtils.hasText(roleHierarchyStringRepresentation) ){
	        Iterator<Map<String, Object>> itr = roleHierarchyList.iterator();
	        StringBuffer concatedRoles = new StringBuffer();
	        Map<String, Object> tempMap;
	        while (itr.hasNext()) {
	            tempMap = itr.next();
	            concatedRoles.append(tempMap.get("child"));
	            concatedRoles.append(" > ");
	            concatedRoles.append(tempMap.get("parent"));
	            concatedRoles.append("\n");
	        }
	        roleHierarchyStringRepresentation = concatedRoles.toString();
		}
		roleHierarchy.setHierarchy(roleHierarchyStringRepresentation);
		List<GrantedAuthority> reachableRoleList = (List<GrantedAuthority>)roleHierarchy.getReachableGrantedAuthorities(authorities);

		authorities.clear();
		authorities.addAll(reachableRoleList);
	}
}
