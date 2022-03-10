<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<script src="/static/bos/js/common.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>
<script>
document.title= "센터 관리";
</script>

<script>
$(function (){ 
});


function mouseOverEvent(x) {
	x.style.background = '#F4F4F4';
}

function mouseOutEvent(x) {
	x.style.background = '';
}

function goSearch(frm2){
	
	
}

function goCenterView(x){
         location.href = "/bos/singl/centerInfo/view.do?cntrCod="+x+"&menuNo=${param.menuNo}&pageIndex=1";
         
}

</script>
<form id="frm2" name="frm2" method="get" action="/bos/singl/centerInfo/list.do" class="pure-form">
    <!-- 게시판 게시물검색 start -->
    <!-- 게시판 게시물검색 end -->

    <!-- board list start -->
    <div class="list">
        <table class="table">
            <caption>정책 목록</caption>
            <thead>
                <tr>
                    <!--th scope="col">번호</th-->
                    <th scope="col">센터구분</th>
                    <th scope="col">센터명</th>
                    <th scope="col">센터장</th>
                    <th scope="col">지역</th>
                    <th scope="col">전화</th>
                    <th scope="col">위탁병원</th>
                    <th scope="col">운영여부</th>
                </tr>
            </thead>
            <tbody>
            	<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr onclick="goCenterView(${result.cntrCod})" style="cursor: pointer;" onmouseover="mouseOverEvent(this)" onmouseout="mouseOutEvent(this)" >
					<!-- <td><input type="checkbox" name="userId" value="${result.userId}" /></td> -->
					<td>${result.gubunName}</td>
					<td>${result.cntrName}</td>
					<td>${result.cntch}</td>
					<td>${result.areaName}</td>
					<td>${result.cntad}</td>
					<td>${result.cnmtHosplName}</td>
                    <td>${result.cntrUseYn}</td>
					
					
					
					<%-- <td><a href="/bos/singl/mngr/forUpdate.do?userId=${result.userId}&menuNo=${param.menuNo}">${result.userId}</a></td>
					<td><a href="/bos/singl/mngr/forUpdate.do?userId=${result.userId}&menuNo=${param.menuNo}">${result.userNm}</a></td>
					<td class="tal">${result.authorNm}</td>
					<td>${result.registDt}</td> --%>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="5">데이터가없습니다.</td></tr>
				</c:if>
            </tbody>
            
        </table>
    </div>
    <!-- board list end //-->
</form>
<div class="btnSet">
        <%-- <a class="pure-button btnInsert btnSave" href="/bos/member/user/forInsert.do?${pageQueryString}" id="regBtn"><span>등록</span></a> --%>
</div>
<%--\\
<div class="btnSet">
    <a class="btn btn-primary" href="/bos/member/user/forInsert.do?${pageQueryString}" id="regBtn"><span>등록</span></a>
    <a class="btn btn-inverse" href="#self"><span>비밀번호 초기화</span></a>
    <a class="btn btn-danger" href="javascript:del();"><span>삭제</span></a>
    <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a>
</div>
--%>

