<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<script src="https://unpkg.com/dayjs@1.8.21/dayjs.min.js"></script>
<script src="/static/bos/js/common.js"></script>
<script>
function filePopZip(now,searchCnd1,searchCnd2,searchCnd3,searchCnd4,searchCnd5,searchWrd,orderName,orderBdate,sdate1,edate1,loginCenterCode,loginAuthorCd){
    var now = now;
    var url = "/bos/member/user/excelDownPopup.do";
    var params = "?viewType=BODY&urlType=zip&searchCnd1="+searchCnd1+"&searchCnd2="+searchCnd2
            +"&searchCnd3="+searchCnd3+"&searchCnd4="+searchCnd4+"&searchCnd5="+searchCnd5+"&searchWrd="+searchWrd
            +"&orderName="+orderName+"&orderBdate="+orderBdate+"&sdate1="+sdate1+"&edate1="+edate1+"&loginCenterCode="+loginCenterCode+"&now="+now+"&loginAuthorCd="+loginAuthorCd+"&viewType=CONTBODY";
    window.open(url+params , 'caseFilePopup',"width=500, height=300");
}
$(function (){ 
    $('.formatDate')
    .numeric({allow:"-"})
    .css("ime-mode", "disabled").css("width", "100px").css("text-align", "center").css("color", "#0000FF").css("font-weight", "bold")
    .mask("9999-99-99")
    .datepicker({
        changeMonth: true,
        changeYear: true,
        maxDate: "+0D",
        yearRange:'c-100:c+10',
        numberOfMonths: 1,
        showButtonPanel: true
    })
    .blur(function() { 
        if ( RegularDateFormat( $(this).val() ) ) {      
        } else {
            if($(this).val().length>0) {
                alert("날짜는 2016-02-15 형식으로 입력해야 합니다.");
                $(this).val("2021-01-01");
            }
        }
    });
    jQuery(function($){
        $.datepicker.regional['ko'] = {
            closeText: '닫기',
            prevText: '이전달',
            nextText: '다음달',
            currentText: '오늘',
            monthNames: ['1월','2월','3월','4월','5월','6월',
            '7월','8월','9월','10월','11월','12월'],
            monthNamesShort: ['1월','2월','3월','4월','5월','6월',
            '7월','8월','9월','10월','11월','12월'],
            dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
            dayNamesShort: ['일','월','화','수','목','금','토'],
            dayNamesMin: ['일','월','화','수','목','금','토'],
            weekHeader: 'Wk',
            dateFormat: 'yy-mm-dd',
            firstDay: 0,
            isRTL: false,
            showMonthAfterYear: true,
            yearSuffix: '년'};
        $.datepicker.setDefaults($.datepicker.regional['ko']);
    });
    

    $('#orderNameBtn').on('click',function(){
    	var orderName = document.getElementById("orderName");
    	
    	if(orderName.value == ""){
    		orderName.value ="DESC";
    	}else if(orderName.value == "ASC"){
    		orderName.value = "DESC";
    	}else if(orderName.value == "DESC"){
    		orderName.value = "ASC";
    	}else{
    		orderName.value = "ASC";
    	}
    	document.getElementById("orderBdate").value="default";
    	
        var form = document.frm2;
    	goSearch(form);
    	form.submit();
    });
    $('#orderBdateBtn').on('click',function(){
        var orderBdate = document.getElementById("orderBdate");
        
        if(orderBdate.value == ""){
        	orderBdate.value ="ASC";
        }else if(orderBdate.value == "ASC"){
        	orderBdate.value = "DESC";
        }else if(orderBdate.value == "DESC"){
        	orderBdate.value = "ASC";
        }else{
        	orderBdate.value = "ASC";
        }
        document.getElementById("orderName").value="default";

        var form = document.frm2;
        goSearch(form);
        form.submit();
    });
    $("#printBtn").on('click',function() {  
    	var url = "/bos/member/user/print2.do?menuNo=${param.menuNo}&searchCnd1=${param.searchCnd1}&searchCnd2=${param.searchCnd2}&searchCnd3=${param.searchCnd3}&searchCnd4=${param.searchCnd4}&searchCnd5=${param.searchCnd5}&searchWrd=${param.searchWrd}&searchWrd2=${param.searchWrd2}&orderName=${param.orderName}&orderBdate=${param.orderBdate}&sdate=${param.sdate}&edate=${param.edate}&loginCenterCode=${userVO.centerCode}&loginAuthorCd=${userVO.authorCd}";
        if(confirm("검색 결과인 목록 전체가 출력됩니다. \n검색결과인 "+ ${resultCnt} + "건의 목록을 출력하시겠습니까?")){
        	window.open(url);
         }
    });
    $("#pageSelect").change(function() {
        var pageUnit = $(this).val();
        var frm = $("#frm2")[0];
        $.ajax({
            url: "/bos/member/user/pageUnitChange.json",
            type: "get",
            data: {pageUnit : pageUnit},
            success: function(data) {
                $("#pageUnit").val(data.pageUnit);
                
                $("#frm2").attr("action", "/bos/member/user/list2.do");
                $("#frm2").submit();
            }
        });
    });
});



function goSearch(frm2){
    if (frm2.sdate.value > frm2.edate.value) {
        alert("기간을 올바르게 선택해주세요.");
        frm2.sdate.value = "";
        frm2.edate.value = "";
        return false;
    }
}

function goUserView(id){
        $.post(
            "/bos/member/user/setCallUserId.json",
            {userId : id},
            function(data) {
                var resultCode = data.resultCode;
                if (resultCode == "success") {
                    location.href = "/bos/member/user/view.do?userId="+id+"&menuNo=${param.menuNo}&pageIndex=1";
                }
                else {
                    alert("잠시후 다시 시도하세요.");
                }
            },"json"
        )
}
</script>
<form id="frm2" name="frm2" method="post" action="/bos/member/user/list2.do" onsubmit="return goSearch(this);" class="pure-form">
    <input type="hidden" name="menuNo" value="${param.menuNo}">
    <input type="hidden" name="orderName" id="orderName" value="${param.orderName}">
    <input type="hidden" name="orderBdate" id="orderBdate" value="${param.orderBdate}">
    <input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />

    <!-- 게시판 게시물검색 start -->
    <fieldset>
        <div class="sh">
            <select name="searchCnd1" id="searchCnd1" title="센터 구분" onchange="getCmmnCd.subSelect('CM05','searchCnd2',this.value , '', 'N')">
                <script>
                    getCmmnCd.select('CM04', 'searchCnd1', '${paramVO.searchCnd1}', 'N');
                </script>
            </select>
            <select name="searchCnd2" id="searchCnd2" title="센터 구분 서브" >
                <script>
                    getCmmnCd.subSelect('CM05','searchCnd2','${paramVO.searchCnd1}', '${paramVO.searchCnd2}', 'N')
                </script>
            </select>
            <select name="searchCnd5" id="searchCnd5" title="사용자 상태" >
                <script>
                    getCmmnCd.select('USST','searchCnd5','${paramVO.searchCnd5}', 'N')
                </script>
            </select>
            <input id="sdate" name="sdate" class="formatDate" title="시작일" placeholder="입사 시작일" value="${paramVO.sdate}" type="text" readonly="readonly"> ~
            <input id="edate" name="edate" class="formatDate" title="종료일" placeholder="입사 종료일" value="${paramVO.edate}" type="text" readonly="readonly">
            <input type="text" name="searchWrd" id="searchWrd" value="${paramVO.searchWrd}" class="" placeholder="사용자이름" title="사용자이름" />
            <button type="submit" id="btnJqgridSearch" class='pure-button btnSave'>검색</button>
            <a href="/bos/member/user/list.do?menuNo=${param.menuNo}" class="pure-button b-reset">초기화</a>
        </div>
    </fieldset>
    <!-- 게시판 게시물검색 end -->

    <div class="cont">
        <div class="board_top">
            <span>결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</span>
            <div style="float: right;">
                <p>
                    <select id="pageSelect" name="pageSelect">
                        <option value="10" ${paramVO.pageUnit eq '10' ? 'selected' : '' }>10개</option>
                        <option value="20" ${paramVO.pageUnit eq '20' ? 'selected' : '' }>20개</option>
                        <option value="50" ${paramVO.pageUnit eq '50' ? 'selected' : '' }>50개</option>
                        <option value="100" ${paramVO.pageUnit eq '100' ? 'selected' : '' }>100개</option>
                        <option value="0" ${paramVO.pageUnit eq '999999' ? 'selected' : '' }>전체</option>
                    </select>
                </p>
            </div>
            <!-- <strong class="text-danger">${paramVO.pageIndex } / ${paginationInfo.totalPageCount }</strong> Page -->
        </div>
    </div>

    <!-- board list start -->
    <div style="clear:both; width:100%;">
        <table id="jqlblList" style="width:100%;" class="table table-striped table-hover">
            <caption>사용자 입사정보</caption>
            <thead>
                <tr>
                    <th scope="col">상태</th>
                    <th scope="col">센터</th>
                    <th scope="col">이름 <button type="button" name="orderNameBtn" id="orderNameBtn">▼▲</button></th>
                    <th scope="col">입사일자 <button type="button" name="orderBdateBtn" id="orderBdateBtn">▼▲</button></th>
                    <th scope="col">연도별</th>
                    <th scope="col">월별</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td>${result.userStateName}</td>  
                        <td>${result.centerCodeName}</td>
                        <td>${result.userName}</td>
                        <fmt:parseDate value='${result.userBCdate}' var='userBCdate' pattern='yyyy-mm-dd'/>
                        <td><fmt:formatDate value="${userBCdate}" pattern="yyyy-mm-dd"/></td>  
                        <td><fmt:formatDate value="${userBCdate}" pattern="yyyy"/>년</td>  
                        <td><fmt:formatDate value="${userBCdate}" pattern="mm"/>월</td>  
                    </tr>
                    <c:set var="resultCnt" value="${resultCnt-1}" />
                </c:forEach>
                <c:if test="${fn:length(resultList) == 0}">
                    <tr>
                        <td colspan="6">데이터가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
    <!-- board list end //-->
</form>
<div class="btnSet">
        <a class="pure-button btnInsert btnSave" href="/bos/member/user/forInsert.do?menuNo=100209" id="regBtn"><span>등록</span></a>
        <a class="pure-button btnInsert btnCasePrintView" id="printBtn"><span>사용자리스트 출력</span></a>
        <a class="pure-button b-down" href="javascript:filePopZip('downloadExcel2','${param.searchCnd1}','${param.searchCnd2}','${param.searchCnd3}','${param.searchCnd4}','${param.searchCnd5}','${param.searchWrd}','${param.orderName}','${param.orderBdate}','${param.sdate1}','${param.edate1}','${userVO.centerCode}','${userVO.authorCd}')">엑셀다운</a>
</div>
<%--\\
<div class="btnSet">
    <a class="btn btn-primary" href="/bos/member/user/forInsert.do?${pageQueryString}" id="regBtn"><span>등록</span></a>
    <a class="btn btn-inverse" href="#self"><span>비밀번호 초기화</span></a>
    <a class="btn btn-danger" href="javascript:del();"><span>삭제</span></a>
    <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a>
</div>
--%>

<c:if test="${fn:length(resultList) > 0}">
    ${pageNav}
</c:if>