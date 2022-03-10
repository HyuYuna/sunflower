package site.unp.cms.dao.member;

import org.springframework.stereotype.Repository;

import site.unp.core.ZValue;
import site.unp.core.dao.SqlDAO;

@Repository("memberDAO")
public class MemberDAO extends SqlDAO<ZValue> {

	public long countUserMemberByUserId(String userId) {
		return (Long)getSqlSession().selectOne("countUserMemberByUserId", userId);
	}

	public long countUserMemberByUserPinId(String userPin) {
		return (Long)getSqlSession().selectOne("countUserMemberByUserPinId", userPin);
	}

	public long countUserMemberByUserPin(String userPin) {
		return (Long)getSqlSession().selectOne("countUserMemberByUserPin", userPin);
	}

	public ZValue findOneUserMemberByUserPinInfo(String userPin) throws Exception{
		ZValue param = new ZValue();
		param.put("userPin", userPin);
		return findOne("findOneUserMemberByUserPinInfo", param);
	}

	public ZValue findOneUserMemberByUserPin(String userPin) throws Exception{
		ZValue param = new ZValue();
		param.put("userPin", userPin);
		return findOne("findOneUserMemberByUserPin", param);
	}

	public int updatePassword(String userId, String encodedPassword) {
		ZValue param = new ZValue();
		param.put("userId", userId);
		param.put("encodedPassword", encodedPassword);
		return update("updateUserMemberPassword", param);
	}

	public int updateUserMemberPasswordByUserSn(long userSn, String encodedPassword) {
		ZValue param = new ZValue();
		param.put("userSn", userSn);
		param.put("encodedPassword", encodedPassword);
		return update("updateUserMemberPasswordByUserSn", param);
	}

	public int deleteMemberSaltInfo(String userId, String userSe) throws Exception {
		ZValue param = new ZValue();
		param.put("userId", userId);
		param.put("userSe", userSe);
		return delete("deleteMemberSaltInfo", param);
	}

	public int saveMemberSalfInfo(long userSn, String userId, String userNm, String userSe, String salt) {
		ZValue param = new ZValue();
		param.put("userSn", userSn);
		param.put("userId", userId);
		param.put("userNm", userNm);
		param.put("userSe", userSe);
		param.put("salt", salt);
		return insert("saveMemberSalfInfo", param);
	}


	public int updateSttusCd(String userId, String sttusCd) {
		ZValue param = new ZValue();
		param.put("userId", userId);
		param.put("sttusCd", sttusCd);
		return update("updateUserMemberSttusCd", param);
	}

	public ZValue idSearchFinish(String userPin) throws Exception {
		ZValue param = new ZValue();
		param.put("userPin", userPin);
		return findOne("findOneUserMemberIdSearchFinish", param);
	}

	public ZValue idPwdSearchRequest(String userNm, String userId, String userEmad, String userPin) throws Exception {
		ZValue param = new ZValue();
		param.put("userNm", userNm);
		param.put("userId", userId);
		param.put("userEmad", userEmad);
		param.put("userPin", userPin);
		return findOne("findOneUserMemberIdPwdSearchRequest", param);
	}

	public ZValue findOneUserMemberLoginInfo(String username) throws Exception {
		ZValue param = new ZValue();
		param.put("username", username);
		return findOne("findOneUserMemberLoginInfo", param);
	}

}
