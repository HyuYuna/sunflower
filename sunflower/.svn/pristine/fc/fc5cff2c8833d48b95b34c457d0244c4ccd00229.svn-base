package site.unp.cms.service.member.sec;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.userdetails.UserDetails;

import site.unp.cms.domain.MemberVO;
import site.unp.core.service.sec.UnpUserDetails;

public class UserMapping implements RowMapper<UserDetails> {

	@Override
	public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
		String username = rs.getString("username");
    	String password = rs.getString("password");

    	MemberVO memberVO = new MemberVO();
    	memberVO.setUserSn(rs.getInt("USER_SN"));
    	memberVO.setUserId(username);
    	memberVO.setPassword(password);
    	memberVO.setUserNm(rs.getString("USER_NM"));
    	memberVO.setUserEmad(rs.getString("USER_EMAD"));
    	memberVO.setUserCpno(rs.getString("USER_CPNO"));
    	memberVO.setAuthorCd(rs.getString("AUTHOR_CD"));
    	memberVO.setUserPin(rs.getString("USER_PIN"));
    	memberVO.setCrtfcSeCd(rs.getString("CRTFC_SE_CD"));
    	memberVO.setChldCrtfcAt(rs.getString("CHLD_CRTFC_AT"));
    	memberVO.setBrthdy(rs.getString("BRTHDY"));
    	memberVO.setSexCd(rs.getString("SEX_CD"));
    	memberVO.setCenterCode(rs.getString("CENTER_CODE"));
    	memberVO.setCenterName(rs.getString("CENTER_NAME"));

        return new UnpUserDetails(username, password, true, true, true, true, AuthorityUtils.NO_AUTHORITIES, memberVO);
    }

}
