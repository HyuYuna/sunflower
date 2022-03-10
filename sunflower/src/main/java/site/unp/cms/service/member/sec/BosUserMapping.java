package site.unp.cms.service.member.sec;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;

import site.unp.cms.domain.MemberVO;
import site.unp.core.service.sec.UnpUserDetails;

public class BosUserMapping implements RowMapper<UserDetails> {

	@Override
	public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
    	String userId = rs.getString("USER_ID");
    	String password = rs.getString("PASSWORD");

    	MemberVO memberVO = new MemberVO();
    	memberVO.setMngrAt("Y");
    	/*memberVO.setUserSn(rs.getLong("USER_SN"));*/
    	memberVO.setUserId(userId);
    	memberVO.setUserPin(userId);
    	memberVO.setPassword(password);
    	memberVO.setUserNm(rs.getString("USER_NAME"));
    	memberVO.setAuthorCd(rs.getString("AUTHOR_CD"));
    	memberVO.setCenterCode(rs.getString("CENTER_CODE"));
    	memberVO.setCenterCode2(rs.getString("CENTER_CODE2"));
    	memberVO.setCenterCode3(rs.getString("CENTER_CODE3"));
    	memberVO.setCenterName(rs.getString("CENTER_NAME"));
    	memberVO.setCenterName2(rs.getString("CENTER_NAME2"));
    	memberVO.setCenterName3(rs.getString("CENTER_NAME3"));
    	memberVO.setUserGroup(rs.getString("USER_GROUP"));
        return new UnpUserDetails(userId, password, true, true, true, true, AuthorityUtils.NO_AUTHORITIES, memberVO);
    }

}
