<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<c:set var="siteId" value="${paramVO.siteId }"/>
<script>
$(function() {
	secsnRequest = function() {
		if ($("#password").val() == "") {
			alert("비밀번호를 입력하세요.");
			$("#password").focus();
			return false;
		}
		if (!checkPwd0Fc()) {
			alert("기존 비밀번호가 일치하지 않습니다.");
			$("#password").focus();
			return false;
		}
		if (!confirm("탈퇴 하시겠습니까?")) {
			return false;
		}
		$.post(
			"/${siteId }/member/user/secsnRequest.json",
			{userId : "${member.userId}", userNm : "${member.userNm}"},
			function(data) {
				if (data.resultCode == "success") {
					alert("탈퇴되었습니다. 이용해주셔서 대단히 감사합니다.");
					window.location.href = "/${siteId }/member/user/logout.do?menuNo=${param.menuNo}";
				}
			},"json"
		);
	};
});
function checkPwd0Fc() {
	$.ajaxSetup({
		async: false
	});
	var flag = true;
	$.post(
		"/${siteId }/member/user/pwdCheck.json",
		{username : "${member.userId}", password : $("#password").val()},
		function(data) {
			if (data.resultCode == "success") {
				flag = true;
			}
			else {
				flag = false;
			}
		},"json"
	);
	return flag;
}
</script>
<form action="#" method="post" onsubmit="return secsnRequest()">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<p class="infor">회원탈퇴를 하시기전에 다음 내용을 꼭 확인해주시기 바랍니다.</p>
	<ul class="plist">
		<li>회원탈퇴 시 회원정보는 즉시 삭제됩니다.</li>
		<li>탈퇴 시 현재 아이디로는 재가입을 하실 수 없습니다.</li>
		<li>탈퇴하셔도 회원님께서 작성하신 게시글 / 문의 / 신청 글은 삭제되지 않습니다.</li>
	</ul>
	<div class="ptbox secede">
		<p>회원탈퇴</p>
		<label>
			<span class="title">아이디</span>
			<span>${member.userId }</span>
		</label>
		<label>
			<span class="title">비밀번호</span>
			<input type="password" name="password0" id="password" autocomplete="off" title="비밀번호">
			<input type="submit" value="회원탈퇴" class="b-lg">
			<a href="/${siteId }/main/main.do" class="b-lg b-arr">취소</a>
		</label>
	</div>
</form>