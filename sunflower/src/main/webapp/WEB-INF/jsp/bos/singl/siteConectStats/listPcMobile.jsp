<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
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
	function search() {

		var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
		var currMonth = currDay * 30;// 월 만듬

		var gubun = $('#searchCnd').val();

		if(gubun == 'D'){

			var sDate = $('#sdate').val();
			var eDate = $('#edate').val();
			if(sDate != "" && eDate != ""){

				var arr1 = sDate.split('-');
				var arr2 = eDate.split('-');
				var date1 = new Date(arr1[0], arr1[1], arr1[2]);
				var date2 = new Date(arr2[0], arr2[1], arr2[2]);

				// 날짜 차이 알아 내기
				var diff = date2 - date1;

				if(parseInt(diff/currDay) < 0){
					alert("기간을 올바르게 선택해 주세요.");
					return;
				}else if(parseInt(diff/currDay) > 30){
					alert("최대검색기간은 31일입니다.");
					return;
				}

			}
		}else if(gubun == 'M'){

			var v = new MiyaValidator(document.frm);


			var sMonth1 = $('#smonthY').val();
			var sMonth2 = $('#smonthM').val();

			var eMonth1 = $('#emonthY').val();
			var eMonth2 = $('#emonthM').val();


			if(sMonth1 != "" && eMonth1 != ""){

				v.add("smonthM", {
					required : true
				});

				v.add("emonthM", {
					required : true
				});

				var result = v.validate();
				if (!result) {
					alert(v.getErrorMessage());
					v.getErrorElement().focus();
					return false;
				}

				var date1 = new Date(sMonth1, sMonth2);
				var date2 = new Date(eMonth1, eMonth2);

				// 날짜 차이 알아 내기
				var diff = date2 - date1;

				if(parseInt(diff/currMonth) < 0){
					alert("기간을 올바르게 선택해 주세요");
					return;
				}else if(parseInt(diff/currMonth) < 1){
					alert("최소검색기간은 2개월 입니다.");
					return;
				}else if(parseInt(diff/currMonth) > 11){

					alert("최대검색기간은 1년(12개월)입니다.");
					return;
				}

				$('#smonth1').val($('#smonthY').val() + "-" + $('#smonthM').val());
				$('#emonth1').val($('#emonthY').val() + "-" + $('#emonthM').val());

			}
		}

		document.frm.submit();
	}

	$(function() {
			$("title").text("PC/모바일별 홈페이지 접속통계");
			$("select[name='searchCnd']").on('change',function() {

				if($(this).val() =='D'){

					$('#smonthY').val(""); $('#smonthM').val("");$('#emonthY').val(""); $('#emonthM').val("");
					$('#smonth1').val(""); $('#emonth1').val(""); $('#smonth2').val(""); $('#emonth2').val(""); $('#sdate').val(""); $('#edate').val("");
					$('.shMonth').hide(); $('.shDate').show();

				}else if($(this).val() =='M'){

					$('#smonthY').val(""); $('#smonthM').val("");$('#emonthY').val(""); $('#emonthM').val("");
					$('#smonth1').val(""); $('#emonth1').val(""); $('#smonth2').val(""); $('#emonth2').val(""); $('#sdate').val(""); $('#edate').val("");
					$('.shDate').hide(); $('.shMonth').show();

				}
			});
	})

	function excelDown() {
		var form = document.form2;
		form.action = "/bos/singl/siteConectStats/excelDown.do";
		form.viewType.value = "CONTBODY";
		form.submit();
	}

</script>

<c:set var="calDate" value="" />
<c:set var="calMonth" value="" />
<c:choose>
	<c:when test="${empty paramVO.searchCnd or paramVO.searchCnd == 'D'}">
		<c:set var="calDate" value="style='display:'" />
		<c:set var="calMonth" value="style='display: none;'" />
	</c:when>
	<c:otherwise>
		<c:set var="calDate" value="style='display: none;'" />
		<c:set var="calMonth" value="style='display:'" />
	</c:otherwise>
</c:choose>

<ul class="nav nav-tabs">
	<li role="presentation"><a href="/bos/singl/siteConectStats/listDate.do?menuNo=${paramVO.menuNo}">사이트 기간별 통계</a></li>
	<li role="presentation"><a href="/bos/singl/siteConectStats/listMenu.do?menuNo=${paramVO.menuNo}">메뉴별</a></li>
	<li role="presentation"><a href="/bos/singl/siteConectStats/listOs.do?menuNo=${paramVO.menuNo}">운영체제별</a></li>
	<li role="presentation"><a href="/bos/singl/siteConectStats/listBrowser.do?menuNo=${paramVO.menuNo}">브라우저별</a></li>
	<li role="presentation" class="active"><a href="/bos/singl/siteConectStats/listPcMobile.do?menuNo=${paramVO.menuNo}">PC/모바일별</a></li>
</ul>

<form name="frm" method="get" action="/bos/singl/siteConectStats/listPcMobile.do" class="sh" >
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
	<input type="hidden" name="pSiteId" value="${paramVO.pSiteId}" />
	<input type="hidden" id="smonth1" name="smonth" value="${paramVO.smonth}" />
	<input type="hidden" id="emonth1" name="emonth" value="${paramVO.emonth}" />
	<div class="set">
		<span class="select">
			<select name="searchCnd" id="searchCnd" title="검색어 구분">
				<option value="D" <c:if test="${empty paramVO.searchCnd or paramVO.searchCnd == 'D'}">selected="selected"</c:if>>일간</option>
				<option value="M" <c:if test="${paramVO.searchCnd == 'M'}">selected="selected"</c:if>>월간</option>
			</select>
		</span>
		<span class="shDate" ${calDate}>
		<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${paramVO.sdate}" type="text" readonly="readonly">
		~
		<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${paramVO.edate}" type="text" readonly="readonly">
		</span>
		<c:if test="${not empty paramVO.smonth }">
				<c:set var="smonthData" value="${fn:split(paramVO.smonth,'-')}" />
		</c:if>
		<c:if test="${not empty paramVO.emonth }">
				<c:set var="emonthData" value="${fn:split(paramVO.emonth,'-')}" />
		</c:if>
		<span class="shMonth" ${calMonth}>
			<select name="smonthY" id="smonthY" title="검색 시작기간 년도">
				<option value="">년도선택</option>
				<c:forEach begin="0" end="${yearToday - 99 }" var="year"  varStatus="status" >
					<option value="${yearToday - year }" <c:if test="${(yearToday - year) eq smonthData[0]}">selected="selected"</c:if>>${yearToday - year }년</option>
				</c:forEach>
			</select>
			<select name="smonthM" id="smonthM" title="검색 시작기간 월">
				<option value="">월선택</option>
				<c:forEach begin="1" end="12" var="month"  varStatus="status" >
					<option value="<util:fz source='${month}' resultLen='2' isFront='true' />" <c:if test="${month eq smonthData[1]}">selected="selected"</c:if>>${month}월</option>
				</c:forEach>
			</select> ~
			<select name="emonthY" id="emonthY" title="검색 종료기간 년도">
				<option value="">년도선택</option>
				<c:forEach begin="0" end="${yearToday - 99 }" var="year"  varStatus="status" >
					<option value="${yearToday - year }" <c:if test="${(yearToday - year) eq emonthData[0]}">selected="selected"</c:if>>${yearToday - year }년</option>
				</c:forEach>
			</select>
			<select name="emonthM" id="emonthM" title="검색 종료기간 월">
				<option value="">월선택</option>
				<c:forEach begin="1" end="12" var="month"  varStatus="status" >
					<option value="<util:fz source='${month}' resultLen='2' isFront='true' />" <c:if test="${month eq emonthData[1]}">selected="selected"</c:if>>${month}월</option>
				</c:forEach>
			</select>
		</span>
		<button type="button" class="b-sh" onclick="search();">통계보기</button>
	</div>
</form>

<h2>PC/모바일 접속통계</h2>
<!-- Load c3.css -->
<link href="/static/jslibrary/c3/c3.css" rel="stylesheet" type="text/css">
<!-- Load d3.js and c3.js -->
<script src="/static/jslibrary/c3/d3.v3.min.js" charset="utf-8"></script>
<script src="/static/jslibrary/c3/c3.min.js"></script>

<div id="chart"></div>
<script>

$( document ).ready(function() {

	var conectDeData = [];
	var conectItem = ["x"];
	var conectCntItem = ["페이지뷰"];
	var conectVisitItem = ["방문자수"];

	<c:forEach var="result" items="${resultList}">
		conectItem.push('${result.smSeValue}');
		conectCntItem.push('${result.pcnt}');
		conectVisitItem.push('${result.vcnt}');
	</c:forEach>

	conectDeData.push(conectItem);
	conectDeData.push(conectCntItem);
	conectDeData.push(conectVisitItem);

	var chart = c3.generate({
		data: {
			x:'x',
					columns: conectDeData,
					groups: [
								//['페이지뷰', '방문']
						],
						type: 'bar',
						labels: {
								format: function (v, id, i, j) { return v; },
						}
			} ,
			axis: {
					rotated: true,
					x: {
						label: {
									text: '종류',
									position: 'outer-right'
							},
							type: 'category'
					},
					y: {
						label: {
									text: '단위:건/명',
									position: 'outer-right'
							}
					}
			}
		});

});


/* var t_url = "/bos/singl/siteConectStats/findAllBySitePcMobileConectCount.json?searchCnd=${paramVO.searchCnd}&sdate=${paramVO.sdate}&edate=${paramVO.edate}&smonth=${paramVO.smonth}&emonth=${paramVO.emonth}&pSiteId=${paramVO.pSiteId}";
$.ajax({ url :t_url, dataType : "json" , async: false}).done(function (data) {

	var conectDeData = [];
	var conectItem = ["x"];
	var conectCntItem = ["페이지뷰"];
	var conectVisitItem = ["방문자수"];

	data.resultList.forEach(function(d, i) {
		conectItem.push(d.smSeValue);
		conectCntItem.push(d.pcnt);
		conectVisitItem.push(d.vcnt);

	});

	conectDeData.push(conectItem);
	conectDeData.push(conectCntItem);
	conectDeData.push(conectVisitItem);

	var chart = c3.generate({
		data: {
			x:'x',
					columns: conectDeData,
					groups: [
								//['페이지뷰', '방문']
						],
						type: 'bar',
						labels: {
								format: function (v, id, i, j) { return v; },
						}
			} ,
			axis: {
					rotated: true,
					x: {
							type: 'category'
					}
			}
		});
	}); */


</script>

<form id="form2" name="form2" method="post" action="">
<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<input type="hidden" name="excelTp" value="pcMobile" />
<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
<input type="hidden" name="pSiteId" value="${paramVO.pSiteId}" />
<input type="hidden" name="searchCnd" id="searchCnd" value="${paramVO.searchCnd}" />
<input type="hidden" id="sdate" name="sdate" value="${paramVO.sdate}" />
<input type="hidden" id="edate" name="edate" value="${paramVO.edate}" />
<input type="hidden" id="smonth2" name="smonth" value="${paramVO.smonth}" />
<input type="hidden" id="emonth2" name="emonth" value="${paramVO.emonth}" />
<input type="hidden" id="viewType" name="viewType" value="" />

<c:if test="${fn:length(resultList) > 0}">
	<div class="tar mb20">
			<a href="javascript:excelDown();" class="b-xls">엑셀 다운로드</a>
	</div>
		<table class="table table-bordered">
				<caption>PC/모바일별 접속통계 결과</caption>
				<thead>
						<tr>
								<th scope="col">PC/모바일</th>
								<th scope="col">페이지뷰(건)</th>
								<th scope="col">방문자수(명)</th>
						</tr>
				</thead>

				<tbody>
					<c:set var="pcntTot" value="0"/>
					<c:set var="vcntTot" value="0"/>
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
								<th scope="row">${result.smSeValue}</th>
								<td><fmt:formatNumber value="${result.pcnt}" pattern="#,###" /></td>
								<td><fmt:formatNumber value="${result.vcnt}" pattern="#,###" /></td>
						</tr>
						<c:set var="pcntTot" value="${pcntTot+result.pcnt}"/>
						<c:set var="vcntTot" value="${vcntTot+result.vcnt}"/>
						</c:forEach>
				</tbody>
				<tfoot>
					<tr>
							<th scope="row">계</th>
							<td><fmt:formatNumber value="${pcntTot}" pattern="#,###" /></td>
							<td><fmt:formatNumber value="${vcntTot}" pattern="#,###" /></td>
					</tr>
				</tfoot>
		</table>
</c:if>
</form>