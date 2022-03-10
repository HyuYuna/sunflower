<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<input type="hidden" id="go_comment_chk" value="go_comment_chk">
<input type="hidden" id="alert_comment_msg" value="alert_comment_msg">

<div class="comment">
	<dl id="cmList"></dl>
	<input type="hidden" id="abcMemoAuthorityName" value="abcMemoAuthorityName">

	<form name="commentFrm" id="commentFrm" class="pure-form">
		<input type="hidden" name="bcboidx" value="${result.boidx }"> 
		<input type="hidden" name="task" value="ins">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input type="hidden" name="bcboabcboardcode" value="${paramVO.bcboabcboardcode}" />
		<input type="hidden" name="bcboidx" value="${paramVO.boidx}" />
		<input type="hidden" name="viewType" value="CONTBODY" />
		<input type="hidden" name="bcname" value="${userVO.userNm }" />
		<input type="hidden" name="bcuserid" value="${userVO.userId }" />
		<input type="hidden" name="bcuid" value="0" />
		<input type="hidden" name="bcno" value="0" />
		<ul>
			<li>이름 <input type="text" value="" name="bcName" id="bcName"></li>
			<li>비밀번호 <input type="password" value="" name="bcPassword" id="bcPassword"></li>
		</ul>
		<p class="clsButton">
			<textarea name="bcContents" id="bcContents" style="height: 116px"></textarea>
			<button class="pure-button pure-button-save2" id="btnCommentIn"
				class="" style="width: 80px">
				<span class="f_bold">등록</span>
			</button>
		</p>
	</form>
</div>

	<%-- <div class="reComentSubmit view">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input type="hidden" name="bcboabcboardcode" value="${paramVO.bcboabcboardcode}" />
		<input type="hidden" name="bcboidx" value="${paramVO.boidx}" />
		<input type="hidden" name="cmSe" value="${paramVO.cmSe}" />
		<input type="hidden" name="viewType" value="CONTBODY" />
		<input type="hidden" name="bcname" value="${userVO.userNm }" />
		<input type="hidden" name="bcuserid" value="${userVO.userId }" />
		<input type="hidden" name="bcuid" value="0" />
		<input type="hidden" name="bcno" value="0" />
		<dl>
			<dt><label for="bccontents">댓글쓰기</label></dt>
			<dd>
				<textarea class="w100p characterLen" name="bccontents" id="bccontents" data-lensize="2000" cols="30" rows="3" title="댓글입력" placeholder="댓글입력"></textarea>
				<span class="characterLenDeco"></span>
				<button class="b-reg w100p mt5" id="comentBtn">등록</button>
			</dd>
		</dl>
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
	</div>
	<h2 class="screen_out">전체 댓글</h2>
	<div class="reComentList" id="commentList">
	</div> --%>

<script>
var v_bbsId = "${paramVO.bbsId}";
var v_nttId = "${paramVO.nttId}";
var v_boidx	= "${paramVO.boidx}";

function commentList(p_bbsId, p_nttId, p_boidx) {
	alert("commentList");
	var url = "/${paramVO.siteId}/bbs/bbsCm/list.do";
	var params = $("#commentFrm").serialize();
	$.post(url,params,function(data) {
		$("#cmList").html(data);
		btnclassSetting();
	},"html");
}

commentList(v_bbsId, v_nttId, v_boidx);


$("#comentBtn").on('click',function() {
	if ($("#bocontents").val() == "") {
		alert("댓글 내용을 입력해주세요.");
		$("#bocontents").focus();
		return false;
	}
	if (!confirm("댓글을 등록하시겠습니까?")) return false;
	var url = "/${paramVO.siteId}/bbs/bbsCm/insert.json";
	var params = $("#commentFrm").serialize();
	$.post(url,params,function(data) {
		if (data.resultCode == "success") {
			alert("댓글이 등록되었습니다.");
			$("#cmmntForm")[0].reset();
			commentList(v_bbsId, v_nttId, v_boidx);
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