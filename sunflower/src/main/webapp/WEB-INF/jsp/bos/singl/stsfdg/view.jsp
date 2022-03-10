<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<h2 class="bu_t1">만족도 기간(${param.sdate }~ ${param.edate })</h2>
<!-- Load c3.css -->
<link href="/static/jslibrary/c3/c3.css" rel="stylesheet" type="text/css">
<!-- Load d3.js and c3.js -->
<script src="/static/jslibrary/c3/d3.v3.min.js" charset="utf-8"></script>
<script src="/static/jslibrary/c3/c3.min.js"></script>
<div class="row">
	<div class="col-md-6">
		<div id="chart"></div>
		<script>
		var chart = c3.generate({
			data: {
				// iris data from R
				columns: [
					["매우만족",0],
					["만족",0],
					["보통",0],
					["불만",0],
					["매우불만",0]
				],
				type : 'pie',
				onclick: function (d, i) {
					//console.log("onclick", d, i);
				},
				onmouseover: function (d, i) {
					//console.log("onmouseover", d, i);
				},
				onmouseout: function (d, i) {
					//console.log("onmouseout", d, i);
				}
			},
			size: {
				height: 480
			}
		});
		setTimeout(function () {
			chart.load({
				columns: [
					["매우만족",'${result.stsfdg5Co}'],
					["만족","${result.stsfdg4Co}"],
					["보통","${result.stsfdg3Co}"],
					["불만","${result.stsfdg2Co}"],
					["매우불만","${result.stsfdg1Co}"]
				]
			});
		}, 500);
		</script>
	</div>
	<div class="col-md-6">
		<form id="form" name="form" method="post" action="/bos/singl/stsfdg/view.do">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input type="hidden" name="menuNo" value="${param.menuNo}" />
		<input type="hidden" name="pSiteId" value="${param.pSiteId}" />
		<input type="hidden" name="sMenuNo" value="${param.sMenuNo}" />
		<input type="hidden" name="sdate" value="${param.sdate}" />
		<input type="hidden" name="edate" value="${param.edate}" />

			<div class="sh">
				<select name="stsfdgIdex" title="만족도 검색 조건">
					<option value="" <c:if test="${empty param.stsfdgIdex}">selected="selected"</c:if>>전체</option>
					<option value="5" <c:if test="${param.stsfdgIdex eq '5'}">selected="selected"</c:if>>매우만족</option>
					<option value="4" <c:if test="${param.stsfdgIdex eq '4'}">selected="selected"</c:if>>만족</option>
					<option value="3" <c:if test="${param.stsfdgIdex eq '3'}">selected="selected"</c:if>>보통</option>
					<option value="2" <c:if test="${param.stsfdgIdex eq '2'}">selected="selected"</c:if>>불만</option>
					<option value="1" <c:if test="${param.stsfdgIdex eq '1'}">selected="selected"</c:if>>매우불만</option>
				</select>
				<!-- <button type="button" class="b-sh">검색</button> -->
				<button class="b-sh">검색</button>
			</div>
		</form>

		페이지경로 : <util:out escapeXml='false'>${fn:replace(result.relateMenuNmList,'|',' > ')}</util:out>

		<table class="table">
			<colgroup>
				<col width="50px"/>
				<col width="80px"/>
				<col width="*"/>
				<col width="95px"/>
				<col width="110px"/>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">만족도</th>
					<th scope="col">한줄평</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList }" varStatus="status">
					<tr>
						<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
						<td>
							<c:choose>
								<c:when test="${result.stsfdgIdex eq '5' }">매우만족</c:when>
								<c:when test="${result.stsfdgIdex eq '4' }">만족</c:when>
								<c:when test="${result.stsfdgIdex eq '3' }">보통</c:when>
								<c:when test="${result.stsfdgIdex eq '2' }">불만</c:when>
								<c:when test="${result.stsfdgIdex eq '1' }">매우불만</c:when>
							</c:choose>
						</td>
						<td>${result.opinionCn }</td>
						<td>${empty result.userNm ? result.userId : result.userNm}</td>
						<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) eq 0}" >
					<tr><td colspan="5">데이터가 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
		<c:if test="${fn:length(resultList) > 0}">
			${pageNav}
		</c:if>
	</div>
</div>