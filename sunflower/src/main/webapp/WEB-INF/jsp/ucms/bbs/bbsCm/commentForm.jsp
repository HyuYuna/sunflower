<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<div class="recomentList">
	<fieldset class="set">
		<legend class="hidden">댓글 작성</legend>
		<form name="cmmntForm" id="cmmntForm" method="post" action="">
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
			<input type="hidden" name="bbsId" value="${param.bbsId}" />
			<input type="hidden" name="nttId" value="${param.nttId}" />
			<input type="hidden" name="cmSe" value="${param.cmSe}" />
			<div class="i">
				<textarea class="characterLen" name="nttCn" data-lensize="2000" cols="100" rows="10" title="댓글입력" placeholder="댓글입력"></textarea>
				<p class="characterLenDeco"></p>
				<button type="submit" id="comentBtn" class="b-submit">등록</button>
			</div>
		</form>
		<script>
		$(function() {
			$('.characterLen').each(function(index, el) {
				$(this).on('keyup',function (e){
					var selfintroduction = $(this).val();
					var str = $(this).val();
					var limit = $(this).data().lensize;
					$(this).next().html(selfintroduction.length + '/'+limit+'자 이내 입력');
					if(selfintroduction.length >= 2000){
						alert("글자수는 "+limit+"자를 초과할수 없습니다.");
						$(this).val(str.substring(0,limit))
					}
				})
				.next().html($(this).data().lensize+'자 이내 입력')
			});
		});
		</script>
	</fieldset>

	<strong class="screen_out">전체 댓글</strong>
	<div id="commentList">
	</div>
</div>

<script>
var v_bbsId = "${paramVO.bbsId}";
var v_nttId = "${paramVO.nttId}";

function commentList(p_bbsId, p_nttId) {
	var url = "/${paramVO.siteId}/bbs/bbsCm/list.do?viewType=CONTBODY";
	var params = $("#cmmntForm").serialize();
	$.post(url,params,function(data) {
		$("#commentList").html(data);
	},"html");
}

commentList(v_bbsId, v_nttId);


$("#comentBtn").on('click',function() {
	<sec:authorize access="!hasRole('ROLE_USERKEY')">
		alert("로그인 후 이용해 주시기 바랍니다.");
		return false;
	</sec:authorize>

	if ($("#nttCn").val() == "") {
		alert("댓글 내용을 입력해주세요.");
		$("#nttCn").focus();
		return false;
	}
	if (!confirm("댓글을 등록하시겠습니까?")) return false;
	var url = "/${paramVO.siteId}/bbs/bbsCm/insert.json";
	var params = $("#cmmntForm").serialize();
	$.post(url,params,function(data) {
		if (data.resultCode == "success") {
			alert("댓글이 등록되었습니다.");
			$("#cmmntForm")[0].reset();
			commentList(v_bbsId, v_nttId);
			return false;
		}
		else {
			alert("댓글등록이 실패하였습니다.");
			return false;
		}
	},"json");
	return false;
});
</script>