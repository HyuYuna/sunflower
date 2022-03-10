<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
	function setValue(bbsId,bbsNm){
		var menuLink = "/${param.pSiteId}/bbs/" + bbsId + "/list.do";
		<c:choose>
			<c:when test="${param.opnerFnAt eq 'Y'}">
			window.opener.fnSetBbsValue(bbsId,menuLink,bbsNm);
			</c:when>
			<c:otherwise>
				$("#menuLink",opener.document).val(menuLink);
				$("#cntntsFileCours",opener.document).val("");
				$("#menuLinkNm",opener.document).val(bbsNm);
				window.opener.document.getElementById(window.name).value = bbsId;
			</c:otherwise>
		</c:choose>
		self.close();
	}
</script>
<h1>게시판선택</h1>
<form name="frm" action ="/bos/cmmn/cmmnBbsMaster/listPop.do?viewType=BODY" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
	<input type="hidden" name="pSiteId" value="${param.pSiteId}">

	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
	   		<select id="bbsAttrbCd" name="bbsAttrbCd" class="select">
   	  			<option value='' label="속성선택" />
			<c:forEach var="attrb" items="${attrbList}" varStatus="status">
	      		<option value="${attrb.attrbCd}" <c:if test="${attrb.attrbCd eq param.bbsAttrbCd}">selected</c:if> >${attrb.attrbNm}(${attrb.attrbCd})</option>
	      	</c:forEach>
		   </select>
			<select id="stributary" name="searchCnd" title="검색조건">
		   		<option value="0" <c:if test="${param.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
			</select>
				<input type="text" title="검색어" name="searchWrd" value="${param.searchWrd}" />
				<button type="submit" class="b-sh">검색</button>
		</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->

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
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">게시판명</th>

					<th scope="col">게시판속성</th>
					<th scope="col">생성일</th>
					<th scope="col" class="last">사용여부</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}</td>
					<td class="tit">
						<a href="javascript:void(0)" onclick="setValue('${result.bbsId}','${result.bbsNm}');">${result.bbsNm}(${result.bbsId})</a>
					</td>
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
