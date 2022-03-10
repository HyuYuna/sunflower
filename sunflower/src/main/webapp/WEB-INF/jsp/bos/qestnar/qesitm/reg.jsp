<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/qestnar/qesitm/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/qestnar/qesitm/update.do" />
</c:if>

<sec:authorize access="hasRole('ROLE_SUPER')">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>


<script>

var idx = 0;
var etcIdx = 0;


$(function(){
	$("input[name='qesitmTyCd']").on('click',function(){
		var cd = this.value;
		if (cd == '1' || cd == '2') {
			$('#qesitmTyCd12Tr').show();
			$('#qesitmTyCd3Tr').hide();
			$('#qesitmTyCd4Tr').hide();
			$('#etcChoiseQyTr').hide();
			$('#essntlChoiseQyTr').hide();

			if (cd == '1') {
				$('#etcChoiseQyTr').show();
			}
			if (cd == '2') {
				$('#essntlChoiseQyTr').show();
			}
		}
		else if (cd == '3') {
			$('#qesitmTyCd12Tr').hide();
			$('#qesitmTyCd3Tr').show();
			$('#qesitmTyCd4Tr').hide();
			$('#etcChoiseQyTr').hide();
			$('#essntlChoiseQyTr').hide();
		}
		else {
			$('#qesitmTyCd12Tr').hide();
			$('#qesitmTyCd3Tr').hide();
			$('#qesitmTyCd4Tr').show();
			$('#etcChoiseQyTr').hide();
			$('#essntlChoiseQyTr').hide();
		}
	});

});

function checkForm() {
	var form = $("#board")[0];
	var v = new MiyaValidator(form);

    v.add("qesitmTyCd", {
        required: true
    });
    v.add("qesitmSj", {
        required: true
    });
    v.add("essntlAnswerAt", {
        required: true
    });

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}

	var c = true;
	var tyCd = $(':radio[name="qesitmTyCd"]:checked').val();
	if (tyCd == '1' || tyCd == '2') {
		$('input[name=answerCn]').not(':last').each(function(){
			if (!this.value) {
				alert('답변은 필수사항입니다.');
				this.focus();
				c = false;
				return false;
			}
		});
	}
	return c;
}


function addAnswer() {
	if(etcIdx > 0){
		alert("기타항목 추가한 경우에는 더이상 항목을 추가하실 수 없습니다.");
		return false;
	}else{
		var answerHtml = $('#dummy').html().replace('_id', idx);
		answerHtml = answerHtml.replace('answerCn_value', '');
		$('#fieldList').append(answerHtml);
		idx++;
	}

}
function addEtcAnswer() {

	if(etcIdx == 0){

		var answerHtml = $('#dummy').html().replace('_id', idx).replace('_id', idx);
		answerHtml = answerHtml.replace('class="w100p"', 'class="w100p" readonly="readonly"').replace('answerCn_value', '기타').replace('removeAnswer','removeEtcAnswer');
		$('#fieldList').append(answerHtml);

		idx++;
		etcIdx++;
	}else{
		alert("기타항목은 하나만 추가하실 수 있습니다.");
		return false;
	}
}

function removeAnswer(obj) {

	if ($("#fieldList").children().length > 1 ) {
		if (($("#fieldList").children().length > 1 && etcIdx == 0 ) || ($("#fieldList").children().length > 2 && etcIdx > 0)) {
			$(obj).parent().parent().remove();
		}
	}

}
function removeEtcAnswer(obj) {

	if ($("#fieldList").children().length > 1) {
		$(obj).parent().parent().remove();
		etcIdx--;
	}
}

function saveQesitm() {
	if (!checkForm()) {
		return;
	}
	if (!confirm('등록하시겠습니까?')) {
		return;
	}

	var data = $("#board").serialize();
	$.post(
		"/bos/qestnar/qesitm/insert.json",
		data,
		function(data) {
			var resultCode = data.resultCode;
			if(resultCode == "success"){
				alert("정상처리했습니다.");
				location.reload();
			}else {
				alert("등록에 실패하였습니다.");
			}
		},"json"
	);
}

function deleteQesitm(qesitmSn) {
	if (!confirm('삭제하시겠습니까?')) {
		return;
	}

	$.post(
		"/bos/qestnar/qesitm/delete.json",
		{qesitmSn: qesitmSn},
		function(data) {
			var resultCode = data.resultCode;
			if(resultCode == "success"){
				alert("정상처리했습니다.");
				$('#qesitmDl_'+qesitmSn).remove();
			}else {
				alert("삭제에 실패하였습니다.");
			}
		},"json"
	);
}

function updateQesitm() {
	if (!checkForm()) {
		return;
	}
	if (!confirm('수정하시겠습니까?')) {
		return;
	}

	var data = $("#board").serialize();
	$.post(
		"/bos/qestnar/qesitm/update.json",
		data,
		function(data) {
			var resultCode = data.resultCode;
			if(resultCode == "success"){
				alert("정상처리했습니다.");
				location.reload();
			}else {
				alert("등록에 실패하였습니다.");
			}
		},"json"
	);
}

function addQesitm() {
	etcIdx = 0;
	$('#myModal').modal();
	$(':radio[name=qesitmTyCd]').attr('checked', false);
	$(':radio[name=essntlAnswerAt]').attr('checked', false);
	$('#qesitmSj').val('');
	$('#fieldList').empty();
	$('#etcChoiseQyTr').hide();
	$('#essntlChoiseQyTr').hide();

	var answerHtml = $('#dummy').html().replace('_id', idx);
	answerHtml = answerHtml.replace('answerCn_value', '');
	$('#fieldList').append(answerHtml);
	$('#saveQesitmBtn').show();
	$('#updateQesitmBtn').hide();
	idx++;
}

function setQesitm(qesitmSn) {
	$('#qesitmSn').val(qesitmSn);
	$.post(
		"/bos/qestnar/qesitm/view.json",
		{qesitmSn : qesitmSn},
		function(data) {
			idx = 0;
			var result = data.result;
			$('#qesitmTyCd_'+result.qesitmTyCd).attr('checked', true);
			$('#essntlAnswerAt_'+result.essntlAnswerAt).attr('checked', true);
			$('#qesitmSj').val(result.qesitmSj);
			$('#essntlChoiseQy').val(result.essntlChoiseQy);

			if (result.qesitmTyCd == '1' || result.qesitmTyCd == '2') {
				$('#qesitmTyCd12Tr').show();
				$('#etcChoiseQyTr').hide();
				$('#essntlChoiseQyTr').hide();

				if (result.qesitmTyCd == '1') {
					$('#etcChoiseQyTr').show();
				}
				if (result.qesitmTyCd == '2') {
					$('#essntlChoiseQyTr').show();
				}
			}
			else {
				$('#qesitmTyCd12Tr').hide();
			}

			$('#fieldList').empty();
			var answerList = data.answerList;
			$.each(answerList, function(key, value) {
				var answerHtml = $('#dummy').html().replace('_id', idx);
				var answerHtml = answerHtml.replace('answerCn_value', value.answerCn);
				$('#fieldList').append(answerHtml);
				idx++;
			});

		},"json"
	);
	$('#myModal').modal();
	$('#saveQesitmBtn').hide();
	$('#updateQesitmBtn').show();
}
</script>

<c:if test="${result.status ne 'P'}">
<div class="tar mb10">
	<button type="button" class="b-add" onclick="addQesitm()">문제추가</button>
</div>
</c:if>

<div class="view">
	<p class="subject">게시물제목</p>
	<dl>
		<dt>설문대상</dt>
		<dd>
			<c:if test="${result.qustnrTrgetCd eq 'A'}">아무나</c:if>
			<c:if test="${result.qustnrTrgetCd eq 'M'}">회원</c:if>
		</dd>
		<dt>참여인원</dt>
		<dd>${result.appCnt}명</dd>
	</dl>
	<dl>
		<dt>조사기간</dt>
		<dd>
			<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~
			<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
		</dd>
		<dt>등록일</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
	</dl>
	<div class="dbData">
		<%-- <c:choose>
			<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.qestnarCn}</util:out></c:when>
			<c:otherwise>
				${result.qestnarCn}
			</c:otherwise>
		</c:choose> --%>
		<util:out escapeXml="false">${result.qestnarCn}</util:out>
	</div>
</div>

<div class="btnSet">
	<a class="b-list" href="/bos/qestnar/qustnr/list.do?${pageQueryString}">목록</a>
</div>
<h2>설문조사 문제</h2>

<form id="board1" name="board1" method="post" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="qustnrSn" value="${empty result.qustnrSn ? 0 : result.qustnrSn }" />
<div class="surveyList">
<c:forEach var="qesitm" items="${qesitmList}" varStatus="status">
	<c:set var="key" value="qesitmSn_${qesitm.qesitmSn}" />
	<c:set var="answerList" value="${answerMap[key]}" />
	<dl id="qesitmDl_${qesitm.qesitmSn}">
		<dt>
			<input type="hidden" name="qesitmSn_${qesitm.qesitmSn}" value="${qesitm.qesitmSn}" />
		<c:if test="${result.status ne 'P'}">
			<button type="button" id="setQesitmBtn_${qesitm.qesitmSn}" onclick="setQesitm('${qesitm.qesitmSn}')" class="b-edit btn-xs">수정</button>
			<button type="button" id="delQesitmBtn_${qesitm.qesitmSn}" onclick="deleteQesitm('${qesitm.qesitmSn}')" class="b-del btn-xs">삭제</button>
		</c:if>
			${qesitm.qesitmSj }
		</dt>
	<c:choose>
		<c:when test="${qesitm.qesitmTyCd eq 1 or qesitm.qesitmTyCd eq 2}">
		<dd>
			<ul>
			<c:forEach var="answer" items="${answerList}" varStatus="s">
				<li><label><input type="${qesitm.qesitmTyCd eq 1 ? 'radio' : 'checkbox'}" name="q" id="q${s.count}"> ${answer.answerCn}</label></li>
			</c:forEach>
			</ul>
		</dd>
		</c:when>
		<c:when test="${qesitm.qesitmTyCd eq 3}">
		<dd>
			<div><input type="text" name="q" id="q${s.count}" class="w100p"></div>
		</dd>
		</c:when>
		<c:when test="${qesitm.qesitmTyCd eq 4}">
		<dd>
			<div><textarea name="q" cols="30" rows="10" class="w100p" style="height: 100px"></textarea></div>
		</dd>
		</c:when>
	</c:choose>
	</dl>
</c:forEach>
</div>
</form>

<!-- Modal -->
<form id="board" name="board" method="post" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="qustnrSn" value="${empty result.qustnrSn ? 0 : result.qustnrSn }" />
	<input type="hidden" id="qesitmSn" name="qesitmSn" value="" />
<div class="modal fade bs-example-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">설문조사 문제추가</h4>
			</div>
			<div class="modal-body">
				<div class="bdView">
					<table>
						<tr>
							<th scope="row">질문형식</th>
							<td>
								<label><input type="radio" id="qesitmTyCd_1" name="qesitmTyCd" value="1"> 단일선택 객관식</label>
								<label><input type="radio" id="qesitmTyCd_2" name="qesitmTyCd" value="2"> 복수선택 객관식</label>
								<label><input type="radio" id="qesitmTyCd_3" name="qesitmTyCd" value="3"> 단답형 주관식</label>
								<label><input type="radio" id="qesitmTyCd_4" name="qesitmTyCd" value="4"> 서술형 주관식</label>
							</td>
						</tr>
						<tr>
							<th scope="row">질문등록</th>
							<td><input type="text" class="w100p" id="qesitmSj" name="qesitmSj" value=""></td>
						</tr>
						<tr>
							<th scope="row">필수답변여부</th>
							<td>
								<label><input type="radio" id="essntlAnswerAt_Y" name="essntlAnswerAt" value="Y" /> 필수</label>
								<label><input type="radio" id="essntlAnswerAt_N" name="essntlAnswerAt" value="N" /> 선택</label>
								<p class="help"> 문제에 대해 꼭 답변을 해야 할 경우에 선택합니다.</p>
							</td>
						</tr>
						<tr id="essntlChoiseQyTr">
							<th scope="row">필수선택 수</th>
							<td>
								<select name="essntlChoiseQy" id="essntlChoiseQy">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
								</select>
							</td>
						</tr>
						<tr id="etcChoiseQyTr">
							<th scope="row">기타추가</th>
							<td>
								<button type="button" onclick="addEtcAnswer(this)" class="b-add btn-xs">기타 내용추가</button>
							</td>
						</tr>
						<tr id="qesitmTyCd12Tr" style="display:none">
							<th scope="row">답변등록</th>
							<td>
								<div id="fieldList" class="fieldList">
									<div class="row">
										<div class="col-xs-8">
											<input type="text" id="answerCn1" name="answerCn" value="" class="w100p" title="답변 1">
										</div>
										<div class="col-xs-4">
											<button type="button" onclick="addAnswer(this)" class="b-add btn-xs">추가</button>
											<button type="button" onclick="removeAnswer(this)" class="b-del btn-xs">삭제</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
						<!--
						<tr id="qesitmTyCd3Tr" style="display:none">
							<th scope="row">답변등록</th>
							<td><input type="text" name="a" class="w100p"></textarea></td>
						</tr>
						<tr id="qesitmTyCd4Tr" style="display:none">
							<th scope="row">답변등록</th>
							<td><textarea name="a" cols="30" rows="10" class="w100p" style="height: 150px"></textarea></td>
						</tr>
						 -->
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button id="saveQesitmBtn" type="button" onclick="saveQesitm();" class="b-save" style="display:none">저장</button>
				<button id="updateQesitmBtn" type="button" onclick="updateQesitm();" class="b-save" style="display:none">수정</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
</form>

<div id="dummy" style="display:none">
	<div id="answerDiv" class="row">
		<div class="col-xs-8">
			<input type="text" id="answerCn_id" name="answerCn" value="answerCn_value" class="w100p" title="답변 1"  />
		</div>
		<div class="col-xs-4">
			<button type="button" onclick="addAnswer(this)" class="b-add btn-xs">추가</button>
			<button type="button" onclick="removeAnswer(this)" class="b-del btn-xs">삭제</button>
		</div>
	</div>
</div>