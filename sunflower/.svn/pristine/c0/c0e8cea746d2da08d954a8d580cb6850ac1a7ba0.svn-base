<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<script>
$(function() {
	deptIdSet();
	menuNoSet();

    $("select[name='deptId1']").on('change',function() {
    	deptIdSet();
    });
    $("select[name='menuNo1']").on('change',function() {
    	menuNoSet();
    });
})

function deptIdSet() {
	$("#deptId2").empty();
	$("#deptId2").append("<option value='' selected='selected'>전체</option>");
   	var upperDeptId = $("#deptId1").val();
   	if (upperDeptId != "") {
   		$.post(
			"/bos/singl/deptInfo/listJson.json",
			{upperDeptId : upperDeptId},
			function(data) {
				for (var i in data) {
	 				$("#deptId2").append("<option value='"+data[i].deptId+"'>"+data[i].deptKorNm+"</option>");

	 				if (data[i].deptId == "${param.deptId2}") {
	 					$("#deptId2").val("${param.deptId2}");
	 				}
				}
			}
		);
	}
}

function menuNoSet() {
	$("#menuNo2").empty();
	$("#menuNo2").append("<option value='' selected='selected'>전체</option>");
	var upperMenuNo = $("#menuNo1").val();
   	if (upperMenuNo != "") {
   		$.post(
			"/bos/singl/menu/listJson.json",
			{upperMenuNo : upperMenuNo, pSiteId : "ucms"},
			function(data) {
				for (var i in data) {
					$("#menuNo2").append("<option value="+data[i].menuNo+">"+data[i].menuNm+"</option>");

					if (data[i].menuNo == "${param.menuNo2}") {
						$("#menuNo2").val("${param.menuNo2}");
					}
				}
			}
		);
	}
}

function goSearch(frm2) {
	if(frm2.sdate.value > frm2.edate.value) {
		alert("기간을 올바르게 선택해주세요.");
		frm2.sdate.value = "";
		frm2.edate.value = "";
		return false;
	}

	var sdate = frm2.sdate.value;
	var edate = frm2.edate.value;
	var arr1 = sdate.split('-');
	var arr2 = edate.split('-');
	var date1 = new Date(arr1[0], arr1[1]-1, arr1[2]);
	var date2 = new Date(arr2[0], arr2[1]-1, arr2[2]);

	var date = (date2.getTime() - date1.getTime()) / (1000*60*60*24);
	if (date > 31) {
		alert("기간을 최대 31일로 선택해주세요.");
		return false;
	}
}

function goView(sMenuNo) {
	var form = document.form2;
 	if (form.sdate.value == "" || form.edate.value == "") {
 		alert("기간을 선택해주세요.");
 		return false;
	}

 	form.action = "/bos/singl/stsfdg/view.do";
 	form.sMenuNo.value = sMenuNo;
 	form.viewType.value = "";
 	form.submit();
}

function excelDown(form) {
	var form = document.form2;
	form.action = "/bos/singl/stsfdg/excelDown.do";
	form.sMenuNo.value = "";
	form.viewType.value = "CONTBODY";
	form.submit();
}
</script>
<form id="form" name="form" method="get" action="/bos/singl/stsfdg/list.do" onsubmit="return goSearch(this);">
<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
<input type="hidden" id="pSiteId" name="pSiteId" value="${param.pSiteId}" />

	<div class="sh">
		<div class="row">
			<div class="col-sm-6">
				<span class="title">기간</span>
				<span class="shDate">
					<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${empty param.sdate ? date.sdate : param.sdate}" type="text" readonly="readonly">
					~
					<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${empty param.edate ?  date.edate : param.edate}" type="text" readonly="readonly">
				</span>
			</div>
			<div class="col-sm-6">
				<span class="title">부서</span>
				<select name="deptId1" id="deptId1">
					<option value="">전체</option>
					<c:forEach var="result" items="${deptList}">
						<option value="${result.deptId }" <c:if test="${param.deptId1 eq result.deptId}">selected="selected"</c:if>>${result.deptKorNm }</option>
					</c:forEach>
				</select>
				<select name="deptId2" id="deptId2">
					<option value="">전체</option>
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-12">
				<span class="title">메뉴</span>
				<select name="menuNo1" id="menuNo1">
					<option value="">전체</option>
					<c:forEach var="result" items="${menuList}">
						<option value="${result.menuNo }" <c:if test="${param.menuNo1 eq result.menuNo}">selected="selected"</c:if>>${result.menuNm }</option>
					</c:forEach>
				</select>
				<select name="menuNo2" id="menuNo2">
					<option value="">전체</option>
				</select>
				<button class="b-sh">검색</button>
			</div>
		</div>
	</div>
</form>
<form id="form2" name="form2" method="post" action="">
<input type="hidden" id="menuNo" name="menuNo" value="${param.menuNo}" />
<input type="hidden" id="pSiteId" name="pSiteId" value="${param.pSiteId }" />
<input type="hidden" id="sdate" name="sdate" value="${empty param.sdate ? date.sdate : param.sdate}" />
<input type="hidden" id="edate" name="edate" value="${empty param.edate ?  date.edate : param.edate}" />
<input type="hidden" id="deptId1" name="deptId1" value="${param.deptId1}" />
<input type="hidden" id="deptId2" name="deptId2" value="${param.deptId2}" />
<input type="hidden" id="menuNo1" name="menuNo1" value="${param.menuNo1}" />
<input type="hidden" id="menuNo2" name="menuNo2" value="${param.menuNo2}" />
<input type="hidden" id="sMenuNo" name="sMenuNo" value="" />
<input type="hidden" id="viewType" name="viewType" value="" />

	<h2 class="fl">메뉴별 만족도 참여자수</h2>
	<div class="tar mb10"><a href="javascript:excelDown();" class="b-xls">엑셀 다운로드</a></div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">메뉴명</th>
				<th scope="col">매우만족</th>
				<th scope="col">만족</th>
				<th scope="col">보통</th>
				<th scope="col">불만족</th>
				<th scope="col">매우불만족</th>
				<th scope="col">총계</th>
			</tr>
		</thead>
	 	<c:forEach var="result" items="${resultList }">
	 		<tfoot>
				<c:if test="${empty result.menuNo }">
					<tr>
						<td>총계</td>
						<td>${result.stsfdg5Co}</td>
						<td>${result.stsfdg4Co}</td>
						<td>${result.stsfdg3Co}</td>
						<td>${result.stsfdg2Co}</td>
						<td>${result.stsfdg1Co}</td>
						<td>${result.prtcpntCo}</td>
					</tr>
				</c:if>
			</tfoot>
			<tbody>
				<c:if test="${not empty result.menuNo }">
					<tr>
						<td class="tit"><a href="javascript:goView('${result.menuNo }');">${result.menuNm }</a></td>
						<td>${result.stsfdg5Co}</td>
						<td>${result.stsfdg4Co}</td>
						<td>${result.stsfdg3Co}</td>
						<td>${result.stsfdg2Co}</td>
						<td>${result.stsfdg1Co}</td>
						<td>${result.prtcpntCo}</td>
					</tr>
				</c:if>
			</tbody>
		</c:forEach>
		<c:if test="${fn:length(resultList) eq 0}" >
			<tbody>
				<tr><td colspan="7">데이터가 없습니다.</td></tr>
			</tbody>
		</c:if>
	</table>
</form>
<h2 class="fl">메뉴별 만족도 평균 그래프</h2>
<div class="tar">
	<button type="button" class="b-sort-up"><i class="fa fa-sort-amount-asc" aria-hidden="true"></i> 내림차순 정렬</button>
	<button type="button" class="b-sort-down"><i class="fa fa-sort-amount-desc" aria-hidden="true"></i> 오름차순 정렬</button>
</div>
<link rel="stylesheet" href="/static/jslibrary/rumcaJS/src/css/rumca.css">
<div id="chart-1"></div>


<script src="/static/jslibrary/rumcaJS/src/js/rumca.js"></script>
<script>
$( document ).ready(function() {
    'use strict';

   	var axisY = new Array();
   	var axisX = ["0.5", "1", "1.5", "2", "2.5", "3", "3.5", "4", "4.5", "5"];
   	var axisXText = new Array(); // 합계
   	var barsValue = new Array(); // %

   	<c:forEach var="result" items="${resultList}">
    	<c:if test="${not empty result.menuNo}">
    		axisY.push('${result.menuNm}');
    		axisXText.push('${result.prtcpntCo}');
    		barsValue.push('${result.percent}');
    	</c:if>
    </c:forEach>

    // Data to charts
    var data = {
       "axisY": axisY,         // Data for axis Y labels
       "axisX": axisX,         // Data for axis X labels
       "axisXText": axisXText,         // Data for axis X labels
       "bars": barsValue       // Data for bars value
    };

    // My options
    var options = {
        data: data,
        showValues: true,
        showHorizontalLines: true,
        animation: true,
        animationOffset: 0,
        labelsAboveBars: true
    };

    var options2 = {
        data: data,
        showValues: true,
        showHorizontalLines: true,
        animation: true,
        animationOffset: 0,
        animationRepeat: false,
        showArrows: false,
        labelsAboveBars: false
    };

    var chart = $('#chart-1').rumcaJS(options2);
    $('.b-sort-up').on('click',function(event) {
    	chart.sortByValue();
    });
    $('.b-sort-down').on('click',function(event) {
    	chart.sortByValue(true);
    });


    //*************************************************************************
    //  Methods
    /**************************************************************************
    $myChart.horizontalChart(options);                          // Initialization horizontal chart.

    $myChart.resetAll();                                        // Remove all data.
    $myChart.resetBars();                                       // Remove all bars.
    $myChart.resetAxisY();                                      // Remove all data from axis Y.
    $myChart.resetAxisX();                                      // Remove all data from axis X.

    $myChart.removeItem(4);                                     // Remove single item. Parameter: int value (from the top, starting on 1).

    $myChart.appendAll(data);                                   // Insert all data. Parameter: object with data.
    $myChart.appendItem('new item', 33);                        // Insert an element to the end. Parameters: string value (for axis Y label), int value (for bar).
    $myChart.appendBars(barsValue);                             // Insert a bars to the end. Parameter: array with int value.
    $myChart.appendAxisY(axisY);                                // Insert an axis Y value to the end. Parameter: array with string value.
    $myChart.appendAxisX(axisX);                                // Insert an axis X value to the ending. Parameter: array with string value.

    $myChart.prependAll(data);                                  // Insert all data. Parameter: object with data.
    $myChart.prependItem('new item', 76);                       // Insert an element to the beginning. Parameters: string value (for axis Y label), int value (for bar).
    $myChart.prependBars(barsValue);                            // Insert a bars on the beginning. Parameter: array with int value.
    $myChart.prependAxisY(axisY);                               // Insert an axis Y value to the beginning. Parameter: array with string value.
    $myChart.prependAxisX(axisX);                               // Insert an axis X value to the beginning. Parameter: array with string value.

    $myChart.updateAll(data);                                   // Update chart with new data. Parameter: object with new data.
    $myChart.updateBars(barsValue);                             // Update a bars. Parameter: array with int value.
    $myChart.updateAxisY(axisY);                                // Update an axis Y. Parameter: array with string value.
    $myChart.updateAxisX(axisX);                                // Update an axis X. Parameter: array with string value.

    $myChart.sortByName(true);                                  // Sort by name. Parameter: boolean value (true - descending, false - ascending).
    $myChart.sortByValue(false);                                // Sort by value. Parameter: boolean value (true - descending, false - ascending).

    $myChart.selectMax();                                       // Select bar with maxiumum value.
    $myChart.selectMin();                                       // Select bar with minimum value.

    $myChart.runAnimation();                                    // Animation trigger.
    **************************************************************************/
});

</script>
