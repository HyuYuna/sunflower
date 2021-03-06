<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

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
$(function(){
	$("input[name='qesitmTyCd']").on('click',function(){
		var cd = this.value;
		if (cd == '1' || cd == '2') {
			$('#qesitmTyCd12Tr').show();
			$('#qesitmTyCd3Tr').hide();
			$('#qesitmTyCd4Tr').hide();
		}
		else if (cd == '3') {
			$('#qesitmTyCd12Tr').hide();
			$('#qesitmTyCd3Tr').show();
			$('#qesitmTyCd4Tr').hide();
		}
		else {
			$('#qesitmTyCd12Tr').hide();
			$('#qesitmTyCd3Tr').hide();
			$('#qesitmTyCd4Tr').show();
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
    v.add("essntlChoiseQy", {
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
				alert('????????? ?????????????????????.');
				this.focus();
				c = false;
				return false;
			}
		});
	}
	return c;
}

function addAnswer() {
	var answerHtml = $('#dummy').html().replace('#answerCn', value.answerCn);
	$('#fieldList').append(answerHtml);
}

function removeAnswer(obj) {
	if ($("#fieldList").children().length > 1) {
		$(obj).parent().parent().remove();
	}
}

function saveQesitm() {
	if (!checkForm()) {
		return;
	}

	var data = $("#board").serialize();
	$.post(
		"/bos/qestnar/qesitm/insert.json",
		data,
		function(data) {
			var resultCode = data.resultCode;
			if(resultCode == "success"){
				alert("????????????????????????.");
				location.reload();
			}else {
				alert("????????? ?????????????????????.");
			}
		},"json"
	);
}

function updateQesitm() {
	if (!checkForm()) {
		return;
	}

	var data = $("#board").serialize();
	$.post(
		"/bos/qestnar/qesitm/update.json",
		data,
		function(data) {
			var resultCode = data.resultCode;
			if(resultCode == "success"){
				alert("????????????????????????.");
				location.reload();
			}else {
				alert("????????? ?????????????????????.");
			}
		},"json"
	);
}

function addQesitm() {
	$('#myModal').modal();
	$(':radio[name=qesitmTyCd]').attr('checked', false);
	$(':radio[name=essntlAnswerAt]').attr('checked', false);
	$('#qesitmSj').val('');
	$('#fieldList').empty();
	var answerHtml = $('#dummy').html().replace('#answerCn', '');
	$('#fieldList').append(answerHtml);
	$('#saveQesitmBtn').show();
	$('#updateQesitmBtn').hide();
}

function setQesitm(qesitmSn) {
	$.post(
		"/bos/qestnar/qesitm/view.json",
		{qesitmSn : qesitmSn},
		function(data) {
			var result = data.result;
			$('#qesitmTyCd_'+result.qesitmTyCd).attr('checked', true);
			$('#essntlAnswerAt_'+result.essntlAnswerAt).attr('checked', true);
			$('#qesitmSj').val(result.qesitmSj);
			$('#essntlChoiseQy').val(result.essntlChoiseQy);

			if (result.qesitmTyCd == '1' || result.qesitmTyCd == '2') {
				$('#qesitmTyCd12Tr').show();
			}
			else {
				$('#qesitmTyCd12Tr').hide();
			}

			$('#fieldList').empty();
			var answerList = data.answerList;
			$.each(answerList, function(key, value) {
				var answerHtml = $('#dummy').html().replace('#answerCn', value.answerCn);
				$('#fieldList').append(answerHtml);
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
	<button type="button" class="b-add" onclick="addQesitm()">????????????</button>
</div>
</c:if>

<div class="view">
	<h2 class="subject">???????????????</h2>
	<dl>
		<dt>${result.deptKorNm}</dt>
		<dd>${result.telno}</dd>
		<dt>?????????</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
	</dl>
	<dl>
		<dt>????????????</dt>
		<dd>${result.trgetCdNm}</dd>
		<dt>????????????</dt>
		<dd>${result.appCnt}???</dd>
	</dl>
	<dl>
		<dt>????????????</dt>
		<dd>
			<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~
			<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
		</dd>
	</dl>
	<div class="dbData">
		<c:choose>
			<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.qestnarCn}</util:out></c:when>
			<c:otherwise>
				${result.qestnarCn}
			</c:otherwise>
		</c:choose>
	</div>
</div>

<div class="btnSet">
	<a class="b-list" href="/bos/qestnar/qustnr/list.do?${pageQueryString}">??????</a>
</div>
<h2>???????????? ??????</h2>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="qustnrSn" value="${empty result.qustnrSn ? 0 : result.qustnrSn }" />
<div class="surveyList">
<c:forEach var="qesitm" items="${qesitmList}" varStatus="status">
	<input type="hidden" name="qesitmSn" value="${qesitm.qesitmSn}" />
	<c:set var="key" value="qesitmSn_${qesitm.qesitmSn}" />
	<c:set var="answerList" value="${answerMap[key]}" />
	<dl>
		<dt>
			${qesitm.qesitmSj }
		<c:if test="${result.status ne 'P'}">
			<button type="button" id="setQesitmBtn_${qesitm.qesitmSn}" onclick="setQesitm('${qesitm.qesitmSn}')" class="b-edit btn-xs">??????</button>
			<button type="button" id="delQesitmBtn_${qesitm.qesitmSn}" class="b-del btn-xs">??????</button>
		</c:if>
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
			<input type="text" name="q" id="q${s.count}">
		</dd>
		</c:when>
		<c:when test="${qesitm.qesitmTyCd eq 4}">
		<dd>
			<textarea name="q" cols="30" rows="10" class="w100p" style="height: 150px"></textarea>
		</dd>
		</c:when>
	</c:choose>
	</dl>
</c:forEach>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
				<h4 class="modal-title" id="myModalLabel">???????????? ????????????</h4>
			</div>
			<div class="modal-body">
				<div class="bdView">
					<table>
						<tr>
							<th scope="row">????????????</th>
							<td>
							<c:forEach var="code" items="${qesitmTyCdCodeList}" varStatus="s">
								<label><input type="radio" id="qesitmTyCd_${code.cd}" name="qesitmTyCd" value="${code.cd}"> ${code.cdNm}</label>
							</c:forEach>
							</td>
						</tr>
						<tr>
							<th scope="row">????????????</th>
							<td><input type="text" class="w100p" id="qesitmSj" name="qesitmSj" value=""></td>
						</tr>
						<tr>
							<th scope="row">??????????????????</th>
							<td>
								<label><input type="radio" id="essntlAnswerAt_Y" name="essntlAnswerAt" value="Y" /> ??????</label>
								<label><input type="radio" id="essntlAnswerAt_N" name="essntlAnswerAt" value="N" /> ??????</label>
								<p class="help">??? ????????? ?????? ??? ????????? ?????? ??? ????????? ???????????????.</p>
							</td>
						</tr>
						<tr>
							<th scope="row">???????????? ???</th>
							<td>
								<select name="essntlChoiseQy" id="essntlChoiseQy">
									<option value="1">1</option>
									<option value="2">2</option>
									<option value="3">3</option>
									<option value="4">4</option>
								</select>
							</td>
						</tr>
						<tr id="qesitmTyCd12Tr" style="display:none">
							<th scope="row">????????????</th>
							<td>
								<div id="fieldList" class="fieldList">
									<div class="row">
										<div class="col-xs-8">
											<input type="text" id="answerCn" name="answerCn" value="" class="w100p" title="?????? 1">
										</div>
										<div class="col-xs-2">
											<button type="button" onclick="addAnswer(this)" class="b-add btn-xs">??????</button>
											<button type="button" onclick="removeAnswer(this)" class="b-del btn-xs">??????</button>
										</div>
									</div>
								</div>
							</td>
						</tr>
						<!--
						<tr id="qesitmTyCd3Tr" style="display:none">
							<th scope="row">????????????</th>
							<td><input type="text" name="a" class="w100p"></textarea></td>
						</tr>
						<tr id="qesitmTyCd4Tr" style="display:none">
							<th scope="row">????????????</th>
							<td><textarea name="a" cols="30" rows="10" class="w100p" style="height: 150px"></textarea></td>
						</tr>
						 -->
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button id="saveQesitmBtn" type="button" onclick="saveQesitm();" class="b-save" style="display:none">??????</button>
				<button id="updateQesitmBtn" type="button" onclick="updateQesitm();" class="b-save" style="display:none">??????</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<div id="dummy" style="display:none">
	<div id="answerDiv" class="row">
		<div class="col-xs-8">
			<input type="text" id="answerCn" name="answerCn" value="#answerCn" class="w100p" title="?????? 1">
		</div>
		<div class="col-xs-2">
			<button type="button" onclick="addAnswer(this)" class="b-add btn-xs">??????</button>
			<button type="button" onclick="removeAnswer(this)" class="b-del btn-xs">??????</button>
		</div>
	</div>
</div>
</form>