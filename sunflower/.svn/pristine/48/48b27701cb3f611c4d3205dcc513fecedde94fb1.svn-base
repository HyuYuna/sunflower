<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
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
					alert("검색기간을 올바르게 지정해 주십시요.");
					return;
				}else if(parseInt(diff/currDay) > 30){
					alert("일간 검색은 최대 31일을 초과할 수 없습니다.");
					return;
				}

				$('#searchYn').val('Y');

			}
		}else if(gubun == 'M'){

			var sMonth = $('#smonth').val();
			var eMonth = $('#emonth').val();

			if(sMonth != "" && eMonth != ""){

				var arr1 = sMonth.split('-');
				var arr2 = eMonth.split('-');
				var date1 = new Date(arr1[0], arr1[1], "01");
				var date2 = new Date(arr2[0], arr2[1], "01");

				// 날짜 차이 알아 내기
				var diff = date2 - date1;

				if(parseInt(diff/currMonth) < 0){
					alert("검색기간을 올바르게 지정해 주십시요.");
					return;
				}else if(parseInt(diff/currMonth) > 11){

					alert("월간 검색은 최대 12개월을 초과할 수 없습니다.");
					return;
				}

				$('#searchYn').val('Y');

			}
		}


		document.frm.submit();
	}

	$(function() {

			$("select[name='searchCnd']").on('change',function() {

				$('#searchYn').val('N');

				if($(this).val() =='D'){

					$('#smonth').val(""); $('#emonth').val(""); $('#sdate').val(""); $('#edate').val("");
					$('.shMonth').hide(); $('.shDate').show();

				}else if($(this).val() =='M'){

					$('#smonth').val(""); $('#emonth').val(""); $('#sdate').val(""); $('#edate').val("");
					$('.shDate').hide(); $('.shMonth').show();

				}
			});
	})

	function excelDown() {
		var form = document.form2;
		form.action = "/bos/singl/cmmnFileDwldStats/excelDown.do";
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

<form name="frm" method="get" action="/bos/singl/cmmnFileDwldStats/list.do" class="sh" >
	<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
	<input type="hidden" name="pSiteId" value="ucms"/>
	<input type="hidden" name="searchYn" id="searchYn" value="${paramVO.searchYn }"/>
	<div class="set">
		<span class="select">
			<select name="searchCnd" id="searchCnd" title="검색 구분">
				<option value="D" <c:if test="${empty paramVO.searchCnd or paramVO.searchCnd == 'D'}">selected="selected"</c:if>>일간</option>
				<option value="M" <c:if test="${paramVO.searchCnd == 'M'}">selected="selected"</c:if>>월간</option>
			</select>
		</span>
		<span class="shDate" ${calDate}>
		<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${paramVO.sdate}" type="text">
		~
		<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${paramVO.edate}" type="text">
		</span>
		<span class="shMonth" ${calMonth}>
		<input id="smonth" name="smonth" class="month" title="검색기간 시작일" value="${paramVO.smonth}" type="text">
		~
		<input id="emonth" name="emonth" class="month" title="검색기간 시작일" value="${paramVO.emonth}" type="text">
		</span>
		<button type="button" class="b-sh" onclick="search();">검색</button>
	</div>
</form>

<h2>첨부파일 다운로드 TOP 20</h2>
<!-- Load c3.css -->
<link href="/static/jslibrary/c3/c3.css" rel="stylesheet" type="text/css">
<!-- Load d3.js and c3.js -->
<script src="/static/jslibrary/c3/d3.v3.min.js" charset="utf-8"></script>
<script src="/static/jslibrary/c3/c3.min.js"></script>
<div id="chart"></div>
<script>

var t_url = "/bos/singl/cmmnFileDwldStats/list.json?searchYn=${paramVO.searchYn}&pSiteId=ucms&searchCnd=${paramVO.searchCnd}&sdate=${paramVO.sdate}&edate=${paramVO.edate}&smonth=${paramVO.smonth}&emonth=${paramVO.emonth}";
$.ajax({ url :t_url, dataType : "json" , async: false}).done(function (data) {
// console.log(data);
//d3.json("/bos/singl/siteConectStats/findAllBySiteConectCount.json", function(data) {

	var conectDeData = [];
	var conectItem = ["x"];
	var conectCntItem = ["파일명"];
	//var conectVisitItem = ["방문"];
	// console.log(data);
	var len = 0;
	data.resultList.forEach(function(d, i) {

		conectItem.push(d.orignlFileNm+"("+d.nttSj+")");
		conectCntItem.push(d.dwldCo);
		//conectVisitItem.push(d.dwldCo);
		len++;
	});

	conectDeData.push(conectItem);
	conectDeData.push(conectCntItem);
	//conectDeData.push(conectVisitItem);

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
	chart.resize({
			height: len*75
		});
	});


</script>
<c:if test="${fn:length(resultList) > 0}">

<div class="tar mb20">
		<a href="javascript:excelDown();" class="b-xls">엑셀 다운로드</a>
</div>

<form id="form2" name="form2" method="post" action="">
<input type="hidden" name="menuNo" value="${paramVO.menuNo}" />
<input type="hidden" name="searchYn" value="${paramVO.searchYn}" />
<input type="hidden" name="searchCnd" id="searchCnd" value="${paramVO.searchCnd}" />
<input type="hidden" id="sdate" name="sdate" value="${paramVO.sdate}" />
<input type="hidden" id="edate" name="edate" value="${paramVO.edate}" />
<input type="hidden" id="smonth" name="smonth" value="${paramVO.smonth}" />
<input type="hidden" id="emonth" name="emonth" value="${paramVO.emonth}" />
<input type="hidden" id="viewType" name="viewType" value="" />
<input type="hidden" name="pSiteId" value="ucms"/>
	<div class="ovx">
			<table class="table table-bordered">
					<caption>첨부파일 다운로드 TOP 20 목록</caption>
					<thead>
							<tr>
									<th scope="col">파일명</th>
									<th scope="col">메뉴경로</th>
									<th scope="col">글제목</th>
									<th scope="col">다운로드수</th>
							</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
							<tr>
									<th scope="row">${result.orignlFileNm}</th>
									<td>${fn:replace(result.relateMenuNmList,'|',' > ' )}</td>
									<td>${result.nttSj}</td>
									<td>${result.dwldCo}</td>
							</tr>
							</c:forEach>
					</tbody>
			</table>
	</div>
</form>
</c:if>
