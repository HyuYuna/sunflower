<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<style>
.table-view{border-top:2px solid #585858;}
.table-view table{width:100%;}
.table-view table th{background:#f3f3f3;border-bottom:1px solid #dadada;border-left:1px solid #dadada;padding:12px 10px;text-align:center;}
.table-view table th:first-child{border-left:none;}
.table-view table td{border-bottom:1px solid #dadada;border-left:1px solid #dadada;padding:15px 10px;text-align:left;color:#666;}
.table-view.brd-add table th{border:1px solid #dadada}
.table-view.brd-add table td{border:1px solid #dadada}
.table-view .bld-none{border-left:none !important;}
.table-view.td-center table td{text-align:center;}
.table-view table td.bg01{background:#f5f5f5;}
.table-view.responsive {width:100%;border-top:2px solid #585858;border-collapse:collapse;border-spacing:0;box-sizing:border-box;border-left:none;border-right:none;}
.table-view.responsive table{width:100%;}
.table-view.responsive caption {overflow:hidden;position:absolute;width:0;height:0;line-height:0;text-indent:-9999px}
.table-view.responsive th {background:#f3f3f3;padding:12px 10px;border-bottom:1px solid #dbdbdb;border-right:1px solid #dbdbdb;height:45px;}
.table-view.responsive td {padding:10px 10px 11px 10px;border-bottom:1px solid #dbdbdb;height:45px;color:#666;}

.schdule-navi-warp{border:1px solid #dbdbdb;border-top:2px solid #333;padding:15px 15px 0 15px;margin:0 0 30px 0;}
.schdule-navi{position:relative;height:37px;line-height:37px;}
.schdule-navi .present{text-align:center;font-size:24px;color:#000;font-weight:500;}
.schdule-navi .prev-month{position:absolute;top:0;left:0;color:#666;}
.schdule-navi .prev-month img{margin:0 12px 0 0;}
.schdule-navi .next-month{position:absolute;top:0;right:0;color:#666;}
.schdule-navi .next-month img{margin:0 0 0 12px;}
.tab-list.schdule{margin:20px 0 0 0;border-top:1px dotted #ddd;}
.tab-list.schdule li a{background:none;}
.tab-list.schdule li a span{position:relative;z-index:100;height:50px;border-bottom:0;}
.tab-list.schdule li.on{border-bottom:0;}
.tab-list.schdule li.on span:after{content:"";background:#fff200;width:28px;margin-left:-14px;height:6px;position:absolute;bottom:15px;left:50%;z-index:-1;}
.tab-list.schdule li{border-bottom:0;position:relative;float:left;width:calc(100% / 6);}
.center-t{
	font-size:20px;
	font-weight:bold;
}
</style>
<script>
var today = new Date();
var date = new Date();

function prevCalendar() {//이전 달
	rowRemove();
	today = new Date(today.getFullYear()- 1, 0 , today.getDate());
	buildCalendar(); //달력 cell 만들어 출력 
}

function nextCalendar() {
	rowRemove();
    today = new Date(today.getFullYear() + 1, 0, today.getDate());
    buildCalendar();//달력 cell 만들어 출력
}

function buildCalendar(){
	//alert("실행은된다.");

    var prevY = document.getElementById("prevY");
    var nextY = document.getElementById("nextY");

    tbCalendarYM.innerHTML = today.getFullYear() + "년 "; 
    prevY.innerHTML = today.getFullYear()-1; 
    nextY.innerHTML = today.getFullYear()+1; 

    ajaxCntroller(today.getFullYear());

}
    
function ajaxCntroller(year){
	 	$.post(
        	"/bos/schdul/schdul/detailYearDate.json",
        	{year : year},
        	function(data){
        		if (data.resultCode == "success") {		
        			var yearDateList = data.yearDateList;
        			if(yearDateList!=""){
        			 	createTable(yearDateList);
        			}else{
        				rowColumn();
        			}
        		}else{
        			alert("일정관리를 가져오는 데 오류가 발생했습니다.");
        		}
			},"json"
		);   
}

/* 기타 */
function createTable(yearDateList){
	var show = "";
	$.each(yearDateList, function( index, value ) {
// 		var code = "";
// 		switch ( value.schdulClCd ){
// 		case 'M' :
// 			code = '문화학교';
// 			break;
// 		case 'E' :
// 			code = '교육';
// 			break;
// 		case 'C' :
// 			code = '기타';
// 			break;	
// 		}
		
		show += "<tr><td class='bld-none bg01'>"+value.month1+value.month2+"월</td><td class='bg01'>";
		show += value.bgnde+" ~ "+ value.endde +"</td>";
		show += "<td><a href='/bos/schdul/schdul/view.do?menuNo=${paramVO.menuNo}&schdulSn="+value.schdulSn+"'> "+value.lclas+"  "+value.mlsfc+"</a></td><td>"+value.placeNm+"</td></tr>";
	//alert( index + " : " + value.clCd ); //출려되는 지 확인하는 방법
	}); 
	$("#show").append(show);
}
function rowRemove(){
	$('#show').empty();
}
function rowColumn(){
	var show ="";
	$("#show").append("<td  colspan='4'>"+"등록된 일정이 없습니다."+"</td>");
	$("#show").append(show);
}
</script>
<form name="listForm" id="listForm" action="/bos/schdul/schdul/listSchdulYear.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="pageIndex" id="pageIndex" value="${paramVO.pageIndex}"/>
</form>
<p class="align-right mb10">
	<a class="pure-button btnList" href="/bos/schdul/schdul/list.do?menuNo=${param.menuNo}" ><span>월간일정</span></a>
</p>
<div class="schdule-navi-warp pb30">
	<div class="schdule-navi">
		<p class="prev-month">
			<a href="javascript:prevCalendar();"><img src="/static/bos/img/cal-prev-sch.png" alt="이전년도 보기" /> <span id="prevY"></span> </a>
		</p>
		<p class="present" id="tbCalendarYM"></p>
		<p class="next-month">
			<a href="javascript:nextCalendar();"> <span id="nextY"></span> <img src="/static/bos/img/cal-next-sch.png" alt="다음년도 보기" /></a>
		</p>
	</div>
</div>
<div style="margin: 30px;"></div>
<div class="center-t">일정</div>
<div class="table-scroll-wrap">
	<div class="table-view td-center">
		<table>
			<caption>일정</caption>
			<colgroup>
				<col style="width: 10%" />
				<col style="width: 15%" />
				<col />
				<col style="width: 20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">월</th>
					<th scope="col">기간</th>
					<th scope="col">일정명</th>
					<th scope="col">장소</th>
				</tr>
			</thead>
			<tbody id="show">
			</tbody>
		</table>
		<div></div>
	</div>
</div>
<script language="javascript" type="text/javascript">
    buildCalendar();
</script>
