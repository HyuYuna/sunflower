<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
//<![CDATA[
$(function(){

	$("#idSearchBtn").on('click',function(){
		var userNm = $("#userNmId").val();
		var userEmad = $("#userEmadId1").val()+"@"+$("#userEmadId2").val();

		if (userNm == "") {
			alert("이름을 입력해 주세요.");
			$("#userNmId").focus();
			return;
		}
		if ($("#userEmadId1").val() == "" || $("#userEmadId2").val() == "") {
			alert("이메일을 입력해 주세요.");
			$("#userEmadId1").focus();
			return;
		}
		$.post(
			"/${paramVO.siteId}/member/user/idSearchRequest.json",
			{userNm : userNm, userEmad : userEmad},
			function(data) {
				if (data.resultCode == "success") {
					alert("요청하신 정보는 다음과 같습니다.\n 아이디 : "+data.userId)
				}
				else {
					alert(data.msg);
				}
			},"json"
		);
		return false;
	});

	$("#pwdSearchBtn").on('click',function(){
		var userNm = $("#userNmPwd").val();
		var userId = $("#userIdPwd").val();
		var userEmad = $("#userEmadPwd1").val()+"@"+$("#userEmadPwd2").val();

		if (userNm == "") {
			alert("이름을 입력해 주세요.");
			$("#userNmPwd").focus();
			return;
		}
		if (userId == "") {
			alert("이름을 입력해 주세요.");
			$("#userIdPwd").focus();
			return;
		}
		if ($("#userEmadPwd1").val() == "" || $("#userEmadPwd2").val() == "") {
			alert("이메일을 입력해 주세요.");
			$("#userEmadPwd1").focus();
			return;
		}
		$.post(
			"/${paramVO.siteId}/member/user/pwdSearchRequest.json",
			{userNm : userNm, userId : userId, userEmad : userEmad},
			function(data) {
				alert(data.msg)
			},"json"
		);
		return false;
	});

});

//]]>
</script>

<p>접속정보를 잊어버리셨나요? 회원님의 접속정보를 알려드립니다</p>
<div class="plist">
	<p>비밀번호의 경우 회원가입 시 등록하셨던 메일주소로 임시비밀번호를 전송해 드리오니, 로그인 후 반드시 비밀번호를 변경하여 주시기 바랍니다.</p>
</div>

<div class="row certify">
	<div class="col-xs-6">
		<h2 class="bu_t1">아이디 찾기</h2>
		<div class="s">
			<p class="l">
				<label class="fieldW"><span>이름</span><input type="text" id="userNmId"></label>
				<label class="fieldemail">
					<span>이메일</span>
					<input id="userEmadId1" type="text" title="이메일 아이디" >
					<i>@</i>
					<input id="userEmadId2" type="text" title="이메일 주소" value="">
				</label>
			</p>
			<button type="button" class="b-" id="idSearchBtn">아이디찾기</button>
		</div>
	</div>
	<div class="col-xs-6">
		<h2 class="bu_t1">비밀번호찾기</h2>
		<div class="s">
			<p>
				<label class="fieldW"><span>이름</span><input type="text" id="userNmPwd"></label>
				<label class="fieldW"><span>아이디</span><input type="text" id="userIdPwd"></label>
				<label class="fieldemail">
					<span>이메일</span>
					<input id="userEmadPwd1" type="text" title="이메일 아이디" >
					<i>@</i>
					<input id="userEmadPwd2" type="text" title="이메일 주소" value="">
				</label>
			</p>
			<button type="button" class="b-" id="pwdSearchBtn">비밀번호찾기</button>
		</div>
	</div>
</div>