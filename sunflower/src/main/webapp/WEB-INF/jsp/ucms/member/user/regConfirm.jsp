<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<script>
var title = document.title;
document.title = title.replace("쓰기","비밀번호입력");
function pwchk(argument) {
	if ($("#chkPwd").val() == "") {
		alert("비밀번호를 입력해 주세요.");
		$("#chkPwd").focus();
		return false;
	}
}
</script>
<form onsubmit="return pwchk()" action="/ucms/member/user/forUpdateMy.do?menuNo=${param.menuNo }" method="post" name="pwdConfirmForm" id="pwdConfirmForm">
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<p class="infor">회원님의 개인정보를 수정할 수 있는 공간입니다.</p>
	<div class="ptbox pwCheck">
		<p>비밀번호를 입력해 주시기 바랍니다.</p>
		<label>
			<span class="title">비밀번호</span>
			<input type="password" name="chkPwd" id="chkPwd" autocomplete="off" value="" title="비밀번호" tabindex="1">
			<input type="submit" value="비밀번호확인" class="b-lg ">
		</label>
	</div>
</form>