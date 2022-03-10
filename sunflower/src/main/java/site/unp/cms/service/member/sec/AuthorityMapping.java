package site.unp.cms.service.member.sec;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

public class AuthorityMapping implements RowMapper<GrantedAuthority> {

	@Override
	public GrantedAuthority mapRow(ResultSet rs, int rowNum) throws SQLException {
        String roleName = rs.getString(2);
        return new SimpleGrantedAuthority(roleName);
    }

}
