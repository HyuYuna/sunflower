<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<script src="https://unpkg.com/dayjs@1.8.21/dayjs.min.js"></script>
<script src="/static/bos/js/common.js"></script>
<script>
function filePopZip(now,searchCnd1,searchCnd2,searchCnd3,searchCnd4,searchCnd5,searchWrd,orderName,orderBdate,sdate1,edate1){
    var now = now;
    var url = "/bos/member/user/excelDownPopup.do";
    var params = "?viewType=BODY&urlType=zip&searchCnd1="+searchCnd1+"&searchCnd2="+searchCnd2
            +"&searchCnd3="+searchCnd3+"&searchCnd4="+searchCnd4+"&searchCnd5="+searchCnd5+"&searchWrd="+searchWrd
            +"&orderName="+orderName+"&orderBdate="+orderBdate+"&sdate1="+sdate1+"&edate1="+edate1+"&now="+now+"&viewType=CONTBODY";
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
    
    $("#pageSelect").change(function() {
        var pageUnit = $(this).val();
        var frm = $("#frm2")[0];
        $.ajax({
            url: "/bos/member/user/pageUnitChange.json",
            type: "get",
            data: {pageUnit : pageUnit},
            success: function(data) {
                $("#pageUnit").val(data.pageUnit);
                
                $("#frm2").attr("action", "/bos/member/user/listDownload.do");
                $("#frm2").submit();
            }
        });
    });
});



function goSearch(frm2){
    if (frm2.sdate1.value > frm2.edate1.value) {
        alert("기간을 올바르게 선택해주세요.");
        frm2.sdate1.value = "";
        frm2.edate1.value = "";
        return false;
    }
}

</script>
<form id="frm2" name="frm2" method="post" action="/bos/member/user/listDownload.do" onsubmit="return goSearch(this);" class="pure-form">
    <input type="hidden" name="menuNo" value="${param.menuNo}">
    <input type="hidden" name="orderName" id="orderName" value="${param.orderName}">
    <input type="hidden" name="orderBdate" id="orderBdate" value="${param.orderBdate}">
    <input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />

    <!-- 게시판 게시물검색 start -->
    <fieldset>
        <div class="sh">
            <span class="shDate">
                            작업시간
            </span>
            <input id="sdate1" name="sdate1" class="formatDate" title="시작일" placeholder="작업 시작일" value="${paramVO.sdate1}" type="text" readonly="readonly"> ~
            <input id="edate1" name="edate1" class="formatDate" title="종료일" placeholder="작업 종료일" value="${paramVO.edate1}" type="text" readonly="readonly">
            
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
            <input type="text" name="searchWrd" id="searchWrd" value="${paramVO.searchWrd}" class="" placeholder="사용자이름" title="사용자이름" />
            <button type="submit" id="btnJqgridSearch" class='pure-button btnSave'>검색</button>
            <a href="/bos/member/user/list_action.do?menuNo=${param.menuNo}" class="pure-button b-reset">초기화</a>
        </div>
    </fieldset>
    <!-- 게시판 게시물검색 end -->

    <div class="cont">
        <div class="board_top">
            <span>결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt}</strong>건</span>
        </div>
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
    </div>

    <!-- board list start -->
    <div style="clear:both; width:100%;">
        <table id="jqlblList" style="width:100%;" class="table table-striped table-hover">
            <caption>사용자 작업기록</caption>
            <thead>
                <tr>
                    <th scope="col">일시</th>
                    <!-- <th scope="col">메뉴명</th> -->
                    <th scope="col">자료명</th>
                    <th scope="col">사유 </th>
                    <th scope="col">사용자명</th>
                    <th scope="col">소속</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="result" items="${resultList}" varStatus="status">
                    <tr>
                        <td><fmt:formatDate value="${result.shDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td> 
                        <!-- <td>${result.shMenuNm}</td> -->
                        <td>${result.shDataNm}</td>
                        <td>${result.shMemo}</td>
                        <td>${result.shUserName}</td>
                        <td>${result.centerCodeName}</td>
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
        <a class="pure-button b-down" href="javascript:filePopZip('downloadExcel4','${param.searchCnd1}','${param.searchCnd2}','${param.searchCnd3}','${param.searchCnd4}','${param.searchCnd5}','${param.searchWrd}','${param.orderName}','${param.orderBdate}','${param.sdate1}','${param.edate1}')">엑셀다운</a>
</div>

<c:if test="${fn:length(resultList) > 0}">
    ${pageNav}
</c:if>