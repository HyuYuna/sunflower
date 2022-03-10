<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script>
	function goSearch() {

		var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨

		var sDate = $('#sdate').val();
		var eDate = $('#edate').val();
		if (sDate != "" && eDate != "") {

			var arr1 = sDate.split('-');
			var arr2 = eDate.split('-');
			var date1 = new Date(arr1[0], arr1[1], arr1[2]);
			var date2 = new Date(arr2[0], arr2[1], arr2[2]);

			// 날짜 차이 알아 내기
			var diff = date2 - date1;

			if (parseInt(diff / currDay) < 0) {
				alert("기간을 올바르게 선택해 주세요.");
				return false;
			} else if (parseInt(diff / currDay) > 30) {
				alert("최대검색기간은 31일입니다.");
				return false;
			}

		}
		document.frm.submit();
	}
</script>

<ul class="nav nav-tabs">
	<li role="presentation"><a href="/bos/singl/errorLog/list.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">에러로그</a></li>
	<li role="presentation" class="active"><a href="/bos/singl/errorLog/listDate.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">기간별 통계</a></li>
	<li role="presentation"><a href="/bos/singl/errorLog/listType.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">유형별 통계</a></li>
	<li role="presentation"><a href="/bos/singl/errorLog/listUrlAd.do?menuNo=${paramVO.menuNo}&viewType=${paramVO.viewType}">URL별 통계</a></li>
</ul>

<form name="frm" id="frm" method="get" action="/bos/singl/errorLog/listDate.do" onsubmit="return goSearch(this);">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
	<div class="sh">
		<span class="shDate">
		<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${paramVO.sdate}" type="text" readonly="readonly">
		~
		<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${paramVO.edate}" type="text" readonly="readonly">
		</span>
		<button type="submit" class="b-sh">통계보기</button>
	</div>
</form>

<!-- Load c3.css -->
<link href="/static/jslibrary/c3/c3.css" rel="stylesheet" type="text/css">
<!-- Load d3.js and c3.js -->
<script src="/static/jslibrary/c3/d3.v3.min.js" charset="utf-8"></script>
<script src="/static/jslibrary/c3/c3.min.js"></script>

<h2>기간별 에러통계</h2>
<div id="chart"></div>

<script>
	$(document).ready(function() {

		var conectDeData = [];
		var conectItem = [ "x" ];
		var conectCntItem = [ "에러(건)" ];

		<c:forEach var="result" items="${result}" >
		conectItem.push('${result.conectDe}');
		conectCntItem.push('${result.cnt}');
		</c:forEach>

		conectDeData.push(conectItem);
		conectDeData.push(conectCntItem);

		var chart = c3.generate({
			data : {
				x : 'x',
				columns : conectDeData,
				labels : {
					format : function(v, id, i, j) {
						return v;
					},
				}
			},
			axis : {
				x : {
					label : {
						text : '날짜(일)',
						position : 'outer-right'
					},
					type : 'timeseries'
				},
				y : {
					label : {
						text : '단위:건',
						position : 'outer-right'
					}
				}
			}
		});
	});
</script>

<form id="form2" name="form2" method="post" action="">
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
<input type="hidden" id="sdate" name="sdate" value="${paramVO.sdate}" />
<input type="hidden" id="edate" name="edate" value="${paramVO.edate}" />
	<table class="table table-bordered">
		<caption>기간별 에러통계 결과</caption>
		<thead>
			<tr>
				<th scope="col">날짜</th>
				<th scope="col">에러(건)</th>
			</tr>
		</thead>
		<tbody>
			<c:set var="cntTot" value="0"/>
			<c:set var="urlTot" value="0"/>
			<c:forEach var="result" items="${result}" varStatus="status">
			<tr>
				<th scope="row">${result.conectDe}</th>
				<td>
					<c:choose>
						<c:when test="${result.cnt > 0}">
							<a href="/bos/singl/errorLog/list.do?menuNo=${paramVO.menuNo}&sdate=${result.conectDe}&edate=${result.conectDe}&viewType=BODY" target="_blank" onclick="window.open(this.href, 'errorLog', 'resizable=1, scrollbars=1, width=1200,height=600'); return false;">
							<fmt:formatNumber value="${result.cnt}" pattern="#,###" /></a>
						</c:when>
						<c:otherwise>
							<fmt:formatNumber value="${result.cnt}" pattern="#,###" />
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<c:set var="cntTot" value="${cntTot+result.cnt}"/>
			</c:forEach>
			<tr>
				<th scope="row">계</th>
				<td><fmt:formatNumber value="${cntTot}" pattern="#,###" /></td>
			</tr>
		</tbody>
	</table>
</form>