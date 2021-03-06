<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<input type="hidden" id="goCommentChk" value="${paramVO.goCommentChk }" />
<input type="hidden" id="alertCommentMsg" value="${paramVO.alertCommentMsg }" />

<div class="comment">
	<dl>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<dt>${result.bcname }<span>[${fn:substring(result.bccreatedate,0,19)}]</span>
				<c:choose>
					<c:when test="${userVO.userId eq result.bcuserid }">
						<img class="btnCommentDelete" id="btnCommentDelete_<fmt:parseNumber integerOnly='true' value='${result.bcidx }' />" title="" alt="del" style="cursor: pointer" src="/static/bos/image/btn_del.gif" alt="" />
					</c:when>
					<c:when test="${param.abcmemoauthorityname eq '비회원 '}">
						<img class="btnCommentDelete" id="btnCommentDelete_<fmt:parseNumber integerOnly='true' value='${result.bcidx }' />" title="secret" alt="del" style="cursor: pointer" src="/static/bos/image/btn_del.gif" alt="" />
					</c:when>
				</c:choose>
			</dt>
			<dd><c:out value="${fn:replace(result.bccontents, newLineChar, '<br/>')}" escapeXml="false"/></dd>
		</c:forEach>
	</dl>
	<input type="hidden" id="abcmemoauthorityname" value="${param.abcmemoauthorityname }"/>
	<!-- 댓글 고유값 비밀번호확인을 통한 삭제용-->
	<input type="hidden" name="bcidx" id="bcidx">
	
	<form name="commentFrm" id="commentFrm" class="pure-form">
		<input type="hidden" name="boidx" value="${result.boidx }"> 
		<input type="hidden" name="task" value="ins">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input type="hidden" name="bid" value="${paramVO.bid}" />
		<input type="hidden" name="bcboidx" value="${paramVO.boidx}" />
		<input type="hidden" name="cmSe" value="${paramVO.cmSe}" />
		<input type="hidden" name="viewType" value="CONTBODY" />
		<input type="hidden" name="bcname" value="${userVO.userNm }" />
		<input type="hidden" name="bcuserid" value="${userVO.userId }" />
		<input type="hidden" name="bcuid" value="0" />
		<input type="hidden" name="bcno" value="0" />
		
		<c:if test="${param.abcmemoauthorityname eq '비회원'}">
			<ul>
				<li>이름 <input type="text" value="" name="bcname" id="bcname"></li>
				<li>비밀번호 <input type="password" value="" name="bcpassword" id="bcpassword"></li>
			</ul>
		</c:if>
		
		<p class="clsButton">
			<textarea name="bccontents" id="bccontents" style="height: 116px"></textarea>
			<button class="pure-button pure-button-save2" id="btnCommentIn" class="" style="width: 80px">
				<span class="f_bold">등록</span>
			</button>
		</p>
	</form>
</div>

<!-- 메모 비밀번호 체크 -->
<div class="layer_pop_memo" id="commentPasswordCheck" style="display: none;">
	<div>
		<strong>비밀번호 확인</strong>
		<p>
			<span>비밀번호</span><input type="password" name="strpassworldcheckmemo" id="strpassworldcheckmemo" />
		</p>
		<span><img style="cursor: pointer;" src="/static/bos/image/btn_layerpop_ok.gif" alt="확인" id="btnPassworldCheckMemo" /></span>
		<span><img style="cursor: pointer;" src="/static/bos/image/btn_layerpop_cancel.gif" id="btnPassworldCheckCancelMemo" alt="취소" /></span>
	</div>
</div>
<!-- //메모 비밀번호 체크 -->

<!-- 글 수정 비밀번호 체크 -->
<div class="layer_pop" id="updatePasswordCheck" style="display: none;">
	<div>
		<strong>비밀번호 확인</strong>
		<p>
			<span>비밀번호</span><input type="password" name="strpassworldcheckupdate" id="strpassworldcheckupdate" />
		</p>
		<span><img style="cursor: pointer;" src="/static/bos/image/btn_layerpop_ok.gif" alt="확인" id="btnPassworldCheckUpdate" /></span> 
		<span><img style="cursor: pointer;" src="/static/bos/image/btn_layerpop_cancel.gif" id="btnPassworldCheckCancelUpdate" alt="취소" /></span>
	</div>
</div>
<!-- // 글 수정 비밀번호 체크 -->

<!-- 글 삭제 비밀번호 체크 -->
<div class="layer_pop" id="delPasswordCheck" style="display: none;">
	<div>
		<strong>비밀번호 확인</strong>
		<p>
			<span>비밀번호</span><input type="password" name="strpassworldcheckdel" id="strpassworldcheckdel" />
		</p>
		<span><img style="cursor: pointer;" src="/static/bos/image/btn_layerpop_ok.gif" alt="확인" id="btnPassworldCheckDel" /></span> 
		<span><img style="cursor: pointer;" src="/static/bos/image/btn_layerpop_cancel.gif" id="btnPassworldCheckCancelDel" alt="취소" /></span>
	</div>
</div>
<!-- // 글 삭제 비밀번호 체크 -->

<script>
jQuery(document).ready(function() {
var articleComment = {
		setContentCheck : function(){
			var abcMemoAuthorityName = $('#abcmemoauthorityname').val();
			if (abcMemoAuthorityName=="비회원") {
				if($('#bcname').val() == "" ){
					alert("이름은 입력 필수사항입니다.");
					$('#bcname').focus();
					return false;
				}
				if($('#bcpassword').val() == "" ){
					alert("비밀번호는 입력 필수사항입니다.");
					$('#bcpassword').focus();
					return false;
				}
			}
			// 댓글 내용 체크
			if($('#bccontents').val() == "" ){
				alert("댓글 내용은 입력 필수사항입니다.");
				$('#bccontents').focus();
				return false;
			}
				return true;
		},
		setCommentSend : function(){					// @ 댓글 정보 보내기
			if (articleComment.setContentCheck() == true){	// 전송 전 유효성 체크
				var msgjs = "입력하신 내용을 등록 하시겠습니까?";
				
				if(confirm(msgjs)) {
					var url = "/${paramVO.siteId}/bbs/bbsCm/insert.json";
					var params = $("#commentFrm").serialize();
					
					$.post(url,params,function(data) {
						if (data.resultCode == "success") {
							alert("모든 내용들이 정상적으로 등록되었습니다!");
							$("#commentFrm")[0].reset();
							location.reload();
							//commentList(v_bbsId, v_nttId, v_boidx);
							return false;
						}
						else {
							alert("주의! 정상적으로 등록되지 않았습니다.\n다시 시도해 주세요!");
							return false;
						}
					},"json");
					return false;
				}
				else{
					return false;
				}
			}
		},
		setCommentDelete : function(bcIdx){					// @ 댓글 정보 보내기
			var msgjs = "댓글을 삭제하시겠습니까?"
			if(confirm(msgjs)) {
				var bid = $('#bid').val();
				var params={"bcidx":bcIdx,"task":"del","bid":bid};
				var url = '/${paramVO.siteId}/bbs/bbsCm/delete.json';

				$.post(url,params,function(data) {
					if (data.resultCode == "success") {
						alert("댓글삭제가 정상적으로 이루어졌습니다!");
						location.reload();
						return false;
					}
					else {
						alert("주의! 댓글 삭제가 정상적으로 이루어 지지 않았습니다.\n다시 시도해 주세요!");
						return false;
					}
				},"json");
			}else{
				return false;
			}
		},
		setPassworldSend : function(){					// @ 일반 텍스트 정보 보내기
			var strPassworldCheckMemo=$('#strpassworldcheckmemo').val()
			if (strPassworldCheckMemo==""){
				alert("비밀번호는 필수 입력 사항입니다!");
				$('#strpassworldcheckmemo').focus();
				return false;
			}
			var bcidx=$('#bcidx').val();
			var params={"bcidx":bcidx,"strPassworldCheckMemo":strPassworldCheckMemo}
			var reqUrl = '/bbs/userSite/comment_exec.asp';
			var returnMsg = jQuery.parseJSON(jQuery.ajax({ url: reqUrl, type: 'post', data: params, async: false }).responseText);
			if(returnMsg.srtIsSuccess=="true"){
				article.setCommentDelete(bcIdx);
			}else{
				article.setMessage("비밀번호가 일치하지 않습니다!");
				return false;
			}
		}

	}
	
	//########################## 댓글 관련 Click Event ##########################

	$('#btnCommentIn').click(function(){
		if ($('#go_comment_chk').val()=="False"){
			alert($('#alert_comment_msg').val());
			return false;
		}else{
			articleComment.setCommentSend(); // @ 코멘트(게시물에 댓글달기)
		}
	});
	$('.btnCommentDelete').click(function(){
			var bcIdx=$(this).attr('id').replace('btnCommentDelete_','');
			var boIsSecret = $(this).attr('title');
			if (boIsSecret=="secret"){
				$('#bcidx').val(bcIdx);
				$('#commentPasswordCheck').show();
				$("#strpassworldcheckmemo").focus();
			}else{
				articleComment.setCommentDelete(bcIdx);
			}
	});
	$('#btnPassworldCheckMemo').click(function(){
		articleComment.setPassworldSend();
	});

	$('#trPassworldCheckMemo').keyup(function(e) {		
		if(e.keyCode == 13){		
		   articleComment.setPassworldSend();
		}
	});

	$('#btnPassworldCheckCancelMemo').click(function(){
		$("#commentPasswordCheck").hide();	
		$("#strpassworldcheckmemo").val('');
	});
});
</script>