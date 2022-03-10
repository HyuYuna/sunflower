<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
 <style>
.b-reg2{
    color: #ffffff;
    background-color: #337ab7;
    border-color: #2e6da4;
	height: 25px;
    margin: 0;
    font-size: 13px;
    padding: 2px 15px;
    font-weight: lighter;
}
 .date-select-form{margin:0 0 30px 0}
.cal-wrap table{border-top:2px solid #333;width:100%;}
.cal-wrap table th{border:1px solid #a2a2a2;height:43px;}
.cal-wrap table td{border:1px solid #dfdfdf;text-align:center;vertical-align:top;height:50px;}
.cal-wrap table td:first-child{none;color:#ff0000;}
.cal-wrap table td a{display:block;width:100%;height:100%;}
.cal-wrap table td a.on{background:#dbdbdb;color:#fff;}
.cal-wrap .cal-navi{position:relative;height:32px;line-height:32px;}
.cal-wrap .cal-navi .present{text-align:center;font-size:20px;color:#000;font-weight:500;}
.cal-wrap .cal-navi .prev-month{position:absolute;bottom:0;left:0;}
.cal-wrap .cal-navi .next-month{position:absolute;bottom:0;right:0;}
.cal-wrap .able{margin:10px 0 30px 0;}
.cal-wrap .able span{display:inline-block;padding:0 10px;line-height:25px;background:#dbdbdb;border-radius:10px;margin:0 10px 0 0;}
.cal-wrap .able p{margin:5px 0 0 0;}
.cal-wrap.schdule table td{text-align:left;padding:7px;height:110px;}
.cal-wrap.schdule table td a{border-bottom:1px dotted #dbdbdb;padding:5px 0;height:auto;}
.cal-wrap.schdule table td a:last-child{border-bottom:none;}
.cal-wrap.schdule table td a dl dt{color:#000;margin:0 0 5px 0;}
.cal-wrap.schdule table td a dl dd{font-size:13px;color:#666;} 
.date-select-form .right-con ul li{letter-spacing:-1px;}
.email-sel{letter-spacing:-1px;} 
.email-sel span{display:inline-block;}
.schdule-navi-warp{border:1px solid #dbdbdb;border-top:2px solid #333;padding:15px 15px 0 15px;margin:0 0 20px 0;height:130px;}
.schdule-navi{position:relative;height:37px;line-height:37px;}
.schdule-navi .present{text-align:center;font-size:24px;color:#000;font-weight:500;}
.schdule-navi .prev-month{position:absolute;top:0;left:0;color:#666;}
.schdule-navi .prev-month img{margin:0 12px 0 0;}
.schdule-navi .next-month{position:absolute;top:0;right:0;color:#666;}
.schdule-navi .next-month img{margin:0 0 0 12px;}
ul.tab-list.schdule{margin:20px auto 0;text-align:center;border-top:1px dotted #ddd;padding:14px 0 0 0;}
ul.tab-list.schdule li a{background:none;font-size:15px;}
ul.tab-list.schdule li a span{position:relative;z-index:100;height:50px;border-bottom:0;}
ul.tab-list.schdule li.on{border-bottom:0;}
ul.tab-list.schdule li.on a{font-weight:bold;}
ul.tab-list.schdule li.on span:after{content:"";background:#fff200;width:28px;margin-left:-14px;height:6px;position:absolute;bottom:0;left:50%;z-index:-1;}
ul.tab-list.schdule li{border-bottom:0;position:relative;float:left;width:calc(100% / 12);}

 </style>
 <script type="text/javascript">
var today = new Date();//오늘 날짜//내 컴퓨터 로컬을 기준으로 today에 Date 객체를 넣어줌
var date = new Date();//today의 Date를 세어주는 역할

$(document).ready(function(){
	var  month = today.getMonth();
	$( "li" ).removeClass("on");
	$("#t"+month).addClass("on");
});
function fncInsert(){
	$("#listForm").attr("action","/bos/schdul/schdul/forInsert.do");
	$("#listForm").submit();
	return false;
}
function fncReplaceYear(){
	location.replace("/bos/schdul/schdulYear/list.do?menuNo=${param.menuNo}");
}

function monthCalendar(month) {//이전 달
	$( "li" ).removeClass("on");
	$("#t"+month).addClass("on");
	today = new Date(today.getFullYear(), month , today.getDate());
	buildCalendar(); //달력 cell 만들어 출력 
}

function prevCalendar() {//이전 달
	today = new Date(today.getFullYear()- 1, today.getMonth() , today.getDate());
	buildCalendar(); //달력 cell 만들어 출력 
}

function nextCalendar() {
    today = new Date(today.getFullYear() + 1, today.getMonth(), today.getDate());
    buildCalendar();//달력 cell 만들어 출력
}
/* 달력만드는 스크립트 */
function buildCalendar(){
    var doMonth = new Date(today.getFullYear(),today.getMonth(),1);
    var lastDate = new Date(today.getFullYear(),today.getMonth()+1,0);
    var tbCalendar = document.getElementById("calendar");
    var tbCalendarYM = document.getElementById("tbCalendarYM");
    var prevY = document.getElementById("prevY");
    var nextY = document.getElementById("nextY");

    tbCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월"; 
    prevY.innerHTML = today.getFullYear()-1; 
    nextY.innerHTML = today.getFullYear()+1; 
    
    /*while은 이번달이 끝나면 다음달로 넘겨주는 역할*/
    while (tbCalendar.rows.length > 1) {
        tbCalendar.deleteRow(tbCalendar.rows.length-1);
     }
     var row = null;
     row = tbCalendar.insertRow();
     //테이블에 새로운 열 삽입//즉, 초기화
     var cnt = 0;// count, 셀의 갯수를 세어주는 역할
    // 1일이 시작되는 칸을 맞추어 줌
     for (i=0; i<doMonth.getDay(); i++) {
     /*이번달의 day만큼 돌림*/
          cell = row.insertCell();//열 한칸한칸 계속 만들어주는 역할
          cnt = cnt + 1;//열의 갯수를 계속 다음으로 위치하게 해주는 역할
     }

    var schdulDate = "";
     /*달력 출력*/
     for (i=1; i<=lastDate.getDate(); i++) { 
     //1일부터 마지막 일까지 돌림
     	
          cell = row.insertCell();
          cell.innerHTML = i;
          
          if(i<10){
        	if(today.getMonth()+1<10){
        		schdulDate = today.getFullYear() + "-0" + (today.getMonth() + 1) + "-0"+i;  
        	}else{
        		schdulDate = today.getFullYear() + "-" + (today.getMonth() + 1) + "-0"+i;  
        	}
         }else{
         	if(today.getMonth()+1<10){
         		schdulDate = today.getFullYear() + "-0" + (today.getMonth() + 1) + "-"+i;   
        	}else{
        		schdulDate = today.getFullYear() + "-" + (today.getMonth() + 1) + "-"+i;  
        	}
          }
              
          ajaxCntroller(schdulDate,cnt,tbCalendar.rows.length);
          cnt = cnt + 1;

      if (cnt % 7 == 1) {
    	  /* 일요일 */
        	cell.innerHTML =  i;
      }    
      if (cnt%7 == 0){
    	  /* 토요일*/
          cell.innerHTML =  i;
         row = calendar.insertRow();
       }
     }
}
function ajaxCntroller(schdulDate,cnt,row){
var show ="";
  	$.post(
        	"/bos/schdul/schdul/detailDate.json",
        	{schdulDate : schdulDate},
        	function(data){
        		if (data.resultCode == "success") {
        			var dateList = data.dateList;
        			if(dateList!=""){
        				$.each(dateList, function( index, value ) {
        					//alert(cnt+row);
        					//alert(row);
        					if(cnt>=28)
        						cnt-=28;
        					else if(cnt>=21)
        						cnt -=21;
        					else if(cnt>=14)
        						cnt -=14;
        					else if(cnt>=7)
        						cnt -=7; 
        					
        					show +="<a href='/bos/schdul/schdul/view.do?menuNo=100272&schdulSn="+value.schdulSn+"'>";
        					show += "<dl><dt>"+value.lclas;
        					show +="</dt></dl></a>";
        					//alert(value.lclas);
        				}); 
        				calendar.rows[row-1].cells[cnt].innerHTML += show;
        				//document.getElementById("schdulSn").value = sortCnt;
        			}else{
        				
        			}
        			//alert("일단 succes"+schdulDate);
        		}else{
        			alert("일정을 가져오는 데 오류가 발생했습니다.");
        		}
			},"json"
		);
}

</script>
<form name="listForm" id="listForm" action="/bos/schdul/schdul/list.do" method="get">
	<input type="hidden" name="csrfToken" value="${csrfToken}" /> 
	<input type="hidden" name="menuNo" value="${param.menuNo}" /> 
	<input type="hidden" name="pageIndex" id="pageIndex" value="${paramVO.pageIndex}" />
</form>

<p class="align-right mb10">
	<a class="pure-button btnList" href="/bos/schdul/schdul/list.do?menuNo=${param.menuNo}" ><span>월간일정</span></a>
	<a class="pure-button btnList" href="/bos/schdul/schdul/listSchdulYear.do?menuNo=${param.menuNo}" ><span>연간일정</span></a>
</p>

<div class="schdule-navi-warp">
	<div class="schdule-navi">
		<p class="prev-month">
			<a href="javascript:prevCalendar();"><img src="/static/bos/img/cal-prev-sch.png" alt="이전년도 보기" /> <span id="prevY"></span> </a>
		</p>
		<p class="present" id="tbCalendarYM"></p>
		<p class="next-month">
			<a href="javascript:nextCalendar();"> <span id="nextY"></span><img src="/static/bos/img/cal-next-sch.png" alt="다음년도 보기" /></a>
		</p>
	</div>
	<ul class="tab-list schdule">
	
			<li id="t0" class="on"><a href="javascript:monthCalendar('0');"><span>1월</span></a></li>
			<li id="t1" class=""><a href="javascript:monthCalendar('1');"><span>2월</span></a></li>
			<li id="t2" class=""><a href="javascript:monthCalendar('2');"><span>3월</span></a></li>
			<li id="t3" class=""><a href="javascript:monthCalendar('3');"><span>4월</span></a></li>
			<li id="t4" class=""><a href="javascript:monthCalendar('4');"><span>5월</span></a></li>
			<li id="t5" class=""><a href="javascript:monthCalendar('5');"><span>6월</span></a></li>
			<li id="t6" class=""><a href="javascript:monthCalendar('6');"><span>7월</span></a></li>
			<li id="t7" class=""><a href="javascript:monthCalendar('7');"><span>8월</span></a></li>
			<li id="t8" class=""><a href="javascript:monthCalendar('8');"><span>9월</span></a></li>
			<li id="t9" class=""><a href="javascript:monthCalendar('9');"><span>10월</span></a></li>
			<li id="t10" class=""><a href="javascript:monthCalendar('10');"><span>11월</span></a></li>
			<li id="t11" class=""><a href="javascript:monthCalendar('11');"><span>12월</span></a></li>
	</ul>
</div>
<div class="table-scroll-wrap">
	<div class="cal-wrap schdule">
		<table id="calendar" >
			<caption>공연일 선택</caption>
			<colgroup>
				<col style="width: calc(100%/ 7)" />
				<col style="width: calc(100%/ 7)" />
				<col style="width: calc(100%/ 7)" />
				<col style="width: calc(100%/ 7)" />
				<col style="width: calc(100%/ 7)" />
				<col style="width: calc(100%/ 7)" />
				<col />
			</colgroup>
			<thead>

				<tr>
					<th scope="col">일</th>
					<th scope="col">월</th>
					<th scope="col">화</th>
					<th scope="col">수</th>
					<th scope="col">목</th>
					<th scope="col">금</th>
					<th scope="col">토</th>
				</tr>
			</thead>
		</table>
		<script language="javascript" type="text/javascript">
			buildCalendar();//
		</script>
	</div>
</div>

<div class="btnSet">
	<a class="pure-button btnSave"  href="javascript:fncInsert();" ><span>일정 등록</span></a>
</div>