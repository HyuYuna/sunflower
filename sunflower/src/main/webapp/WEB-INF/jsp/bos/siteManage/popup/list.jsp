<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
function updateUseAt(popupNo, useAt) {
	if (useAt == "Y") {
		$("#useAt").val('N');
	} else {
		$("#useAt").val('Y');
	}
	$.post(
		"/bos/siteManage/popup/updateUseAt.json",
		{popupNo:popupNo,useAt:$("#useAt").val()},
		function(data) {
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	)
}
</script>

<form name="frm" id="frm" action ="/bos/siteManage/popup/list.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
	<input type="hidden" name="pSiteId" value="${param.pSiteId}">
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>

				<%-- <select id="siteId" name="siteId" class="input_select">
							<option value="">사이트선택</option>
					 <c:forEach var="site" items="${siteList}" varStatus="status">
						<c:set var="data"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
							<option value="${data}" <c:if test="${fn:indexOf(data,param.siteId) ne -1 and not empty param.siteId}">selected="selected"</c:if> >${site.siteDesc}</option>
					 </c:forEach>
				</select> --%>
			<select name="searchUseAt" id="searchUseAt" title="사용여부">
				<option value=''>사용여부</option>
				<option value='Y' <c:if test="${param.searchUseAt == 'Y'}">selected="selected"</c:if>>사용</option>
				<option value='N' <c:if test="${param.searchUseAt == 'N'}">selected="selected"</c:if>>미사용</option>
			</select>
			<input type="text" title="검색어" name="searchKwd" value='${paramVO.searchKwd}' />
			<button class="b-sh">검색</button>
			<a href="/bos/siteManage/popup/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
	</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->
</form>
<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>팝업관리 목록</caption>
		<thead>
			<tr>
				<th style="width:52px"	scope="col">번호</th>
				<th style="width:10%"		scope="col">이미지</th>
				<th 										scope="col">제목</th>
				<th style="width:15%"		scope="col">노출기간</th>
				<th style="width:15%"		scope="col">이미지링크</th>
				<th style="width:10%"		scope="col">사용여부</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
			<tr>
					<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
					<td>
						<img src="/cmmn/file/imageSrc.do?menuNo=${param.menuNo}&amp;fileStreCours=<util:seedEncrypt str='${files[0].fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${files[0].streFileNm}'/>" width="150" align="${result.popupSj}">
					</td>
				<td class="tit">
					<a href="/bos/siteManage/popup/forUpdate.do?popupNo=${result.popupNo}&${pageQueryString}">${result.popupSj}</a>
				</td>
					<td>
						<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd"/>
						~
						<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd"/>
				</td>
				<td>${result.urlad }
				<%-- <c:forEach var="site" items="${siteList}" varStatus="status">
					<c:set var="_siteId"><util:fz source="${site.siteId}" resultLen="2" isFront="true" /></c:set>
					<c:if test="${fn:indexOf(result.siteId, _siteId) ne -1}">${site.siteDesc}<br/></c:if>
				</c:forEach> --%>
				</td>

				<td>
					<button type="button"
						onclick="updateUseAt('${result.popupNo}','${result.useAt}')" class="<c:if test='${result.useAt eq "Y" }'>b-view</c:if><c:if test='${result.useAt eq "N" }'>b-disabled</c:if>"
						title="${result.useAt eq 'Y' ? '미사용하기' : '사용하기'}"
					>
					${result.useAt eq 'Y' ? '사용중' : '미사용중'}
					</button>
					<input type="hidden" id="useAt" name="useAt" value="" />
				</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>
<!-- board list end //-->

<div class="btnSet">
	<a class="b-reg" href="/bos/siteManage/popup/forInsert.do?menuNo=${param.menuNo}&${pageQueryString}"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>