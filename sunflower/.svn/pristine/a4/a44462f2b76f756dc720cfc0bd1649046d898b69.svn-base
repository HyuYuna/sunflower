<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<script>
document.title='게시판 선택';
	function setValue(bbsId,bbsNm,menuNo,menuNm){
		var menuLink = "/${param.pSiteId}/bbs/" + bbsId + "/list.do";
		window.opener.fnSetBbsValue${param.relmSeCd}(bbsId,menuLink,bbsNm,menuNo,menuNm);
		self.close();
	}
</script>
<h1>게시판선택</h1>
<form name="frm" action ="/bos/main/userMainCntnts/listPopup.do" method="get">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageIndex" value="${paramVO.pageIndex}">
	<input type="hidden" name="pSiteId" value="ucms">
	<input type="hidden" name="viewType" value="BODY">

		<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>게시물 목록</caption>
			<colgroup>
				<col width="8%" />
				<col width="*" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
				<col width="15%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">게시판명</th>
					<th scope="col">메뉴명</th>
					<th scope="col">게시판유형</th>
					<th scope="col">생성일</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
					<td class="tit">
						<a href="javascript:void(0)" onclick="setValue('${result.bbsId}','${result.bbsNm}','${result.menuNo}','${result.menuNm}');">${result.bbsNm}(${result.bbsId})</a>
					</td>
			    	<td>${result.menuNm}</td>
			    	<td>${result.bbsAttrbNm}</td>
					<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd"/></td>
					<td>
				    	<c:if test="${result.useAt == 'N'}">미사용</c:if>
				    	<c:if test="${result.useAt == 'Y'}">사용</c:if>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->
	<div class="btnSet">
		<a class="b-end" href="javascript:void()" onclick="self.close()"><span>닫기</span></a>
	</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

</form>
