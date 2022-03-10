<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<script>
	function join() {
		var v = true;
		$('input[id^=qesitmSn_]').each(function(){
			var q = this.value;
			var qesitmTyCd = $('#qesitmTyCd_' + q).val();
			var essntlAnswerAt = $('#essntlAnswerAt_' + q).val();
			var qesitmNo = $("#qesitmNo_" + q).val();
			if ('Y' == essntlAnswerAt) {
				var s = $('input[id^=answerSn_' +q+ ']:checked').length;
				if (qesitmTyCd == 1 || qesitmTyCd == 2) {
					if (s == 0) {
						v = false;
						alert('['+ qesitmNo +'번]은 필수항목입니다.');
						$('#answerSn_' + q + '_1').focus();
						return false;
					}
					if (qesitmTyCd == 2) {
						var qt = parseInt($('#essntlChoiseQy_' + q).val());
						if (qt > s) {
							v = false;
							alert('['+ qesitmNo +'번]은 ' + qt + '개 이상 선택하셔야 합니다.');
							$('#answerSn_' + q + '_1').focus();
							return false;
						}
					}
				}
				else {
					if (!$('#answerCn_' + q).val()) {
						v = false;
						alert('['+ qesitmNo +'번]은 필수항목입니다.');
						$('#answerCn_' + q).focus();
						return false;
					}
				}
			}
		});

		if (!v) {
			return;
		}

		if (!confirm('등록하시겠습니까?')) {
			return;
		}
		var data = $("#board").serialize();
		$.post(
			"/bos/qestnar/userAnswer/insert.json",
			data,
			function(data) {
				var resultCode = data.resultCode;
				if(resultCode == "success"){
					alert("정상처리했습니다.");
					location.href = "./userList.do?menuNo=${param.menuNo}";
				}else {
					alert("등록에 실패하였습니다.");
				}
			},"json"
		);
	}

	$(function(){
		$(".etCRadio").find(":input[id^=answerSn_]").on('click',function() {

			var hiddenId  = $(this).attr('id').replace('answerSn_','hiddenAnswerSn_');
			var textAreaId  = $(this).attr('name').replace('answerSn_','etcAnswerTextArea_');
			var etcAnswerId  = $(this).attr('name').replace('answerSn_','etcAnswerCn_');

			if("기타" == $('#'+hiddenId).val()){
				$('#'+textAreaId).show();
			}else{
				$('#'+etcAnswerId).val('');
				$('#'+textAreaId).hide();
			}
		});
	});

</script>

	<div class="view">
		<p class="subject">
			${result.qustnrSj}
		</p>
		<dl>
			<dt>등록일</dt>
			<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></dd>
			<dt>진행상태</dt>
			<dd>
				<c:choose>
					<c:when test="${result.status eq 'P'}">진행중</c:when>
					<c:when test="${result.status eq 'F'}">종료</c:when>
					<c:otherwise>대기</c:otherwise>
				</c:choose>
			</dd>
		</dl>
		<dl>
			<dt>설문대상</dt>
			<dd>
				<c:if test="${result.qustnrTrgetCd eq 'A'}">아무나</c:if>
				<c:if test="${result.qustnrTrgetCd eq 'M'}">회원</c:if>
			</dd>
			<dt>참여인원</dt>
			<dd>${result.appCnt} 명</dd>
		</dl>
		<dl>
			<dt>조사기간</dt>
			<dd>
				<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~ 
				<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
			</dd>
		</dl>
		<div class="dbData"><util:out escapeXml="false">${result.qestnarCn}</util:out></div>
	</div>
	<div class="btnSet">
		<a href="/bos/qestnar/qustnr/userList.do?${pageQueryString}" class="b-list">목록</a>
	</div>


	<h2>설문질의</h2>
<form id="board" name="board" method="post" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="qustnrSn" value="${result.qustnrSn}" />
	<div class="surbeyQ">
		<dl>
		<c:forEach var="qesitm" items="${qesitmList}" varStatus="status">
			<c:set var="key" value="qesitmSn_${qesitm.qesitmSn}" />
			<c:set var="answerList" value="${answerMap[key]}" />
			<dt>
				${status.count}. ${qesitm.qesitmSj }
				<input type="hidden" id="qesitmSn_${qesitm.qesitmSn}" name="qesitmSn_${qesitm.qesitmSn}" value="${qesitm.qesitmSn}" />
				<input type="hidden" id="qesitmTyCd_${qesitm.qesitmSn}" name="qesitmTyCd_${qesitm.qesitmSn}" value="${qesitm.qesitmTyCd}" />
				<input type="hidden" id="essntlAnswerAt_${qesitm.qesitmSn}" name="essntlAnswerAt_${qesitm.qesitmSn}" value="${qesitm.essntlAnswerAt}" />
				<input type="hidden" id="essntlChoiseQy_${qesitm.qesitmSn}" name="essntlChoiseQy_${qesitm.qesitmSn}" value="${qesitm.essntlChoiseQy}" />
				<input type="hidden" id="qesitmNo_${qesitm.qesitmSn}" value="${status.count}" />
			</dt>
			<c:choose>
			<c:when test="${qesitm.qesitmTyCd eq 1}">
				<dd>
					<div class="row">
					<c:forEach var="answer" items="${answerList}" varStatus="s">
						<div class="${s.count%2 == 1 && s.last ? 'col-sm-12 etCRadio' : 'col-sm-6 etCRadio' } ">
							<label>
								<input type="hidden" id="hiddenAnswerSn_${qesitm.qesitmSn}_${s.count}" name="hiddenAnswerSn_${qesitm.qesitmSn}" value="${answer.answerCn}">
								<input type="radio" id="answerSn_${qesitm.qesitmSn}_${s.count}" name="answerSn_${qesitm.qesitmSn}" value="${answer.answerSn}"> ${answer.answerCn}
							</label>
						</div>
					</c:forEach>
					</div>
				</dd>
				<dd class="textarea etctype" id="etcAnswerTextArea_${qesitm.qesitmSn}" style="display:none">
				<textarea name="etcAnswerCn_${qesitm.qesitmSn}" id="etcAnswerCn_${qesitm.qesitmSn}" cols="30" rows="10" title="기타 답변"></textarea>
				</dd>
			</c:when>
			<c:when test="${qesitm.qesitmTyCd eq 2}">
				<dd>
					<div class="row">
					<c:forEach var="answer" items="${answerList}" varStatus="s">
						<div class="${s.count%2 == 1 && s.last ? 'col-sm-12' : 'col-sm-6' } ">
							<label><input type="checkbox" id="answerSn_${qesitm.qesitmSn}_${s.count}" name="answerSn_${qesitm.qesitmSn}" value="${answer.answerSn}"> ${answer.answerCn}</label>
						</div>
					</c:forEach>
					</div>
				</dd>
			</c:when>
			<c:when test="${qesitm.qesitmTyCd eq 3}">
				<dd><input type="text" name="answerCn_${qesitm.qesitmSn}" id="answerCn_${qesitm.qesitmSn}" title="${status.count}번 질의 답변" class="w100p" /></dd>
					</c:when>
					<c:when test="${qesitm.qesitmTyCd eq 4}">
				<dd class="textarea">
				<textarea name="answerCn_${qesitm.qesitmSn}" id="answerCn_${qesitm.qesitmSn}" cols="30" rows="10" title="3번 질의 답변"></textarea>
				</dd>
				</c:when>
			</c:choose>
		</c:forEach>
		</dl>
	</div>
	<div class="btnSet">
		<button type="button" onclick="join();" class="b-">설문참여</button>
	</div>
</form>