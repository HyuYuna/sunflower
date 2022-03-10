<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:useBean id="toDay" class="java.util.Date" />
<fmt:formatDate value="${toDay}" var="yearToday" pattern="yyyy" />

<script>
$(function (){ 
    $("#pageSelect").change(function() {
        var pageUnit = $(this).val();
        var frm = $("#frm")[0];
        $.ajax({
            url: "/bos/member/user/pageUnitChange.json",
            type: "get",
            data: {pageUnit : pageUnit},
            success: function(data) {
                $("#pageUnit").val(data.pageUnit);
                
                $("#frm").attr("action", "/bos/auth/authorHist/list.do");
                $("#frm").submit();
            }
        });
    });
});
function filePopZip(now,searchWrd,searchKwd,sdate,edate,searchCnd,searchCnd1,searchCnd2){
    var now = now;
    var url = "/bos/auth/authorHist/excelDownPopup.do";
    var params = "?viewType=BODY&urlType=zip&searchWrd="+searchWrd+"&searchKwd="+searchKwd
            +"&sdate="+sdate+"&edate="+edate+"&searchCnd="+searchCnd+"&searchCnd1="+searchCnd1+"&searchCnd2="+searchCnd2+"&viewType=CONTBODY";
    window.open(url+params , 'caseFilePopup',"width=500, height=300");
}
</script>

<form name="frm" id="frm" action="list.do" method="post" class="pure-form">
    <input type="hidden" name="menuNo" value="${param.menuNo}" />
    <input type="hidden" name="pSiteId" value="${param.pSiteId}">
    <input type="hidden" name="pageUnit" id="pageUnit" value="${param.pageUnit }" />
    <!-- 게시판 게시물검색 start -->
    <div class="sh">
            <fieldset>
            <legend>게시물검색</legend>
            <span class="shDate" ${calDate}>
            <input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${paramVO.sdate}" type="text" readonly="readonly">
            ~
            <input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${paramVO.edate}" type="text" readonly="readonly">
            </span>
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
            <span class="select">
                <select name="searchCnd" id="searchCnd" title="검색어 구분">
                    <option value="1" <c:if test="${empty paramVO.searchCnd or paramVO.searchCnd == '1'}">selected="selected"</c:if>>아이디</option>
                    <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if>>이름</option>
                </select>
            </span>
            <input type="text" title="검색어" name="searchKwd" value='${paramVO.searchKwd}' />
            <button class="pure-button btnSave">검색</button>
            <a href="list.do?menuNo=${param.menuNo}" class="pure-button b-reset">초기화</a>
    </fieldset>
    </div>
    <!-- 게시판 게시물검색 end -->
</form>
<!-- board list start -->
    <div class="cont">
        <div class="board_top">
            <span>결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt}</strong>건</span>
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
    </div>
<div>
    <table class="table table-striped table-hover">
        <caption>권한 이력</caption>
        <thead>
            <tr>
                <th scope="col">번호</th>
                <th scope="col">아이디</th>
                <th scope="col">사용자</th>
                <th scope="col">등록일시</th>
                <th scope="col">상태내역</th>
                <th scope="col">등록자</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="result" items="${resultList}" varStatus="status">
            <c:set var="files" value="${fileMap[result.atchFileId]}" />
            <tr>
                <td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
                <td>${result.userId}</td>
                <td>${result.userName2}</td>
                <td><fmt:formatDate value="${result.logPdate}" pattern="yyyy-MM-dd HH:mm"/></td>
                <td>${result.logCate}</td>
                <td>${result.regName}</td>
            </tr>
            <c:set var="resultCnt" value="${resultCnt-1}" />
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}"><tr><td colspan="9">데이터가 없습니다.</td></tr></c:if>
        </tbody>
    </table>
</div>
<!-- board list end //-->
<div class="btnSet">
        <a class="pure-button b-down" href="javascript:filePopZip('downloadExcel','${param.searchWrd}', '${param.searchKwd}', '${param.sdate}', '${param.edate}', '${param.searchCnd}', '${param.searchCnd1}', '${param.searchCnd2}')" >엑셀다운</a>
</div>

<c:if test="${fn:length(resultList) > 0}">
    ${pageNav}
</c:if>