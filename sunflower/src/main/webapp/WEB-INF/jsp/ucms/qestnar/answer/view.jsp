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
		$('tbody[id^=resultTbody_]').each(function(){
			var qesitmSn = this.id.replace('resultTbody_', '');
			getUserAnswer(qesitmSn);
		});
		$('ol[id^=resultOl_]').each(function(){
			var qesitmSn = this.id.replace('resultOl_', '');
			getUserAnswer(qesitmSn);
		});
	});

	function getUserAnswer(qesitmSn) {
		var pageIndex = $('#pageIndex_'+qesitmSn).val();
		var pageUnit = $('#pageUnit_'+qesitmSn).val();
		$('#resultTbody_'+qesitmSn).empty();
		$('#resultOl_'+qesitmSn).empty();
		$.post(
			"/ucms/qestnar/userAnswer/list.json",
			{qesitmSn: qesitmSn, pageUnit: pageUnit, pageIndex: pageIndex},
			function(data) {
				var r = data.resultList;
				var idx = 1;
				$.each(r, function(i, item) {
					var userNm = item.userNm;
					if (userNm == null || userNm == '') {
						userNm = '-';
					}
					$('#resultTbody_'+item.qesitmSn).append('<tr><td>'+userNm+'</td><td>'+item.sortOrdr+'</td></tr>');
					$('#resultOl_'+item.qesitmSn).append('<li>' +idx+ '.'+item.answerCn+'</li>');
					$('#totPageSpan_'+item.qesitmSn).html(data.paginationInfo.totalPageCount);
					idx++;
                });
			},"json"
		);
	}
</script>

<div class="view">
	<p class="subject">
		${result.qustnrSj}
	</p>
	<dl class="deco">
	<dt>${result.deptKorNm}</dt>
		<dd class="ico-tel">${result.telno}</dd>
		<dt>등록일</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></dd>
	</dl>
	<dl>
		<dt>설문대상</dt>
		<dd>${result.qustnrTrgetCdNm}</dd>
		<dt>참여인원</dt>
		<dd>${result.appCnt}</dd>
	</dl>
	<dl>
		<dt>조사기간</dt>
		<dd>
			<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~ 
			<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
		</dd>
		<dt>진행상태</dt>
		<dd>
			<c:choose>
				<c:when test="${result.status eq 'P'}">진행중</c:when>
				<c:when test="${result.status eq 'F'}">종료</c:when>
				<c:otherwise>대기</c:otherwise>
			</c:choose>
		</dd>
	</dl>
	<div class="dbData"><util:out escapeXml="false">${result.qestnarCn}</util:out></div>
</div>

<div class="btnSet">
	<a href="/ucms/qestnar/qustnr/list.do?menuNo=${param.menuNo}" class="b-list">목록</a>
</div>
<h2>설문결과</h2>
<c:forEach var="qesitm" items="${qesitmList}" varStatus="status">
	<c:if test="${qesitm.qesitmTyCd eq 1 or qesitm.qesitmTyCd eq 2}">
<div class="bdList mb30">
	<table class="table table-survey">
		<caption>${status.count}. ${qesitm.qesitmSj }</caption>
		<thead>
			<tr>
				<th scope="col">응답항목</th>
				<th scope="col" style="width:12%">사례수(건)</th>
				<th scope="col" style="width:12%">비율(%)</th>
				<th scope="col" style="width:40%">그래프</th>
			</tr>
		</thead>
		<tbody>
		<c:set var="key" value="qesitmSn_${qesitm.qesitmSn}" />
		<c:set var="answerList" value="${answerMap[key]}" />
		<c:forEach var="answer" items="${answerList}" varStatus="s">
			<tr>
				<td class="tal">${s.count}. ${answer.answerCn}</td>
				<td>${answer.answerCnt}/${qesitm.appCnt}</td>
				<td>
					<fmt:formatNumber var="answerPercent" type="number" minFractionDigits="0" maxFractionDigits="0" value="${qesitm.appCnt eq 0 ? 0 : answer.answerCnt*100/qesitm.appCnt}" />
					${answerPercent}%
				</td>
				<td class="graph"><span class="graph1" style="width:${answerPercent}%"></span></td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</div>
<div class="surveyRsult" style='display:none;'></div>
	</c:if>
	<c:if test="${qesitm.qesitmTyCd eq 3 or qesitm.qesitmTyCd eq 4}">
<div class="surveyRsult">
	<p>${status.count}. ${qesitm.qesitmSj }</p>
	<div class="sh">
		<input type="text" id="pageIndex_${qesitm.qesitmSn}" name="pageIndex_${qesitm.qesitmSn}" title="현재 페이지 및 이동할 페이지" value="1" class="tac" size="4"> /
		<span id="totPageSpan_${qesitm.qesitmSn}">0</span>
		<button type="button" onclick="getUserAnswer('${qesitm.qesitmSn}')" class="b-move">이동</button>
		<select id="pageUnit_${qesitm.qesitmSn}" name="pageUnit_${qesitm.qesitmSn}" title="페이지 표시 개수">
			<option value="10">10</option>
			<option value="20">20</option>
			<option value="30">30</option>
			<option value="40">40</option>
			<option value="60">60</option>
			<option value="80">80</option>
			<option value="100">100</option>
		</select>
		<button type="button" onclick="getUserAnswer('${qesitm.qesitmSn}')" class="b-ok">확인</button>
	</div>
	<ol id="resultOl_${qesitm.qesitmSn}">
	</ol>
</div>
	</c:if>
</c:forEach>