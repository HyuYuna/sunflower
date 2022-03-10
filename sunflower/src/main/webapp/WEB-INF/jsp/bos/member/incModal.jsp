<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<div class="modal fade" id="changeMberModal">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">회원전환</h4>
			</div>
			<div class="modal-body tac">
				<form action="" name="changeMberForm" id="changeMberForm" method="post">
					<input type="hidden" name="csrfToken" value="${csrfToken}"/>
					<input type="hidden" name="userId" value="${result.userId }" />
					<input type="hidden" name="confmSttus" value="" />
					<label>회원변경 선택
					<select name="mberSe">
						<c:forEach var="item" items="${COM062CodeList }">
						<option value="${item.code }" <c:if test="${item.code eq result.mberSe }">selected="selected"</c:if>>${item.codeNm }회원</option>
						</c:forEach>
					</select>
					</label>
					<button type="button" id="changeMberConfirmBtn" class="btn btn-success btn-sm">회원전환하기</button>
				</form>
			</div>
			<div class="modal-footer">
				<div class="tac">
				<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
//<![CDATA[
	$("#changeMberConfirmBtn").on('click',function() {

		if (!confirm("회원을 전환하시겠습니까?")) return false;

		var $mberSe = $("#changeMberForm").find("select[name=mberSe]");
		var confmSttus = "CONFM01";
		if ($mberSe.val() == "USER" || $mberSe.val() == "CREATOR")
			confmSttus = "CONFM02";

		$("#changeMberForm").find("input[name=confmSttus]").val(confmSttus);

		var url = "/bos/member/user/changeMberSeProc.json";
		var param = $("#changeMberForm").serialize();
		$.post(url, param, function(data) {
			if (data.resultCode == "success") {
				alert($mberSe.find("option:selected").text() +"으로 전환되었습니다.");
				var userId = "${result.userId}";
				var menuNo = "${param.menuNo}";
				window.location.href = "/bos/member/"+ $mberSe.val().toLowerCase() + "/view.do?userId=" + userId + "&menuNo=" + menuNo;
			}
			else {
				alert("회원전환에 실패했습니다.");
			}
		},"json");
		return false;
	});

	// 비밀번호 초기화
	$("#pwdInitl").on('click',function(){
		var mbtlnum = "${result.mbtlnum}";
		var telno = "";
		if (!confirm('비밀번호를 초기화 하시겠습니까?\n[휴대폰번호 뒷번호로 초기화 됩니다.]')) {
			return false;
		}
		if (mbtlnum == "") {
			alert("등론된 휴대폰번호가 없습니다.");
			return false;
		}
		else {
			telno = mbtlnum.split("-")[2];
		}
		$.post(
			"/bos/member/user/pwdInitl.json",
			{userSn : "${result.userSn}", telno : telno, userId : "${result.userId}"},
			function(data)
			{
				var resultCode = data.resultCode;
				alert("휴대폰 뒷번호로 초기화 되었습니다.");
				if(resultCode == "success") location.reload();
			},"json"
		)
	});


	//승인변경 처리
	$("#confmSttusBtn").on('click',function() {
		if (!confirm("승인변경 처리 하시겠습니까??")) return false;

		if ($("#confmSttus").val() == "") {
			alert("승인상태를 선택해주세요.");
			return false;
		}

		var v_userId = "${result.userId}";


		var url = "/bos/member/user/confmSttusProc.json";
		var param = {
				userId : v_userId,
				mberSe : "${result.mberSe}",
				confmSttus : $("#confmSttus").val()
		}
		$.post(url, param, function(data) {
			if (data.resultCode == "success") {
				alert("승인상태가 " + $("#confmSttus").find("option:selected").text() +"로 변경되었습니다.");
				window.location.reload();
			}
			else {
				alert("승인상태변경이 실패했습니다.");
			}
		},"json");
		return false;
	});
//]]>
</script>