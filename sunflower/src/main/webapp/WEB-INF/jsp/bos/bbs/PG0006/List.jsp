<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>
<script>
	$(function() {
		<c:if test="${paramVO.delcode eq '1'}">
		$(".contMenuNm").text($(".contMenuNm").text() + "(삭제글보기)");
		</c:if>
	});
</script>
<div class="box">
	<p>해당 게시판에 첨부파일을 등록하고 웹콘텐츠에서 아래와 같은 첨부파일 다운로드 및 이미지 링크를 사용할 경우 보안취약점 및 보안 약점을 미연에 방지할 수 있습니다.</p>
	<p>첨부파일 다운로드 링크 시 : /{siteId}/cmmn/file/fileDown.do?atchFileId={파일ID}&fileSn={파일순번}&bbsId=${paramVO.bbsId}</p>
</div>
<form id="frm" name="frm" action ="/bos/bbs/${paramVO.bbsId}/list.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}">

	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<input type="text" id="sdate" name="sdate" value="${param.sdate}" size="10" /> ~
		    <input type="text" id="edate" name="edate" value="${param.edate}" size="10" />
			<select id="stributary" name="searchCnd" title="검색조건">
			   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
			   <option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if> >회원명</option>
			   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
			   <option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
			</select>
			<input type="text" title="검색어" name="searchWrd" value="${paramVO.searchWrd}" />
			<input type="submit" id="input2" name="input2" value="검색" class="btn" />
		</fieldset>
	</div>
</form>
	<div class="bdList">
		<table class="table table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<thead>
				<tr>
					<th style="width:6%" 	scope="col">번호</th>
					<th scope="col">제목</th>
					<th style="width:12%" 	scope="col">파일ID</th>
					<th style="width:8%" 	scope="col">파일순번</th>
					<th style="width:10%" 	scope="col">작성자</th>
					<th style="width:12%" 	scope="col">작성일</th>
					<th style="width:8%" 	scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${(resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td class="tit">
						<a href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pageQueryString}">
						<c:choose>
							<c:when test="${result.delcode ne SearchVO.NON_DELETION}">
							<span class="del">${result.nttSj}</span>
							</c:when>
							<c:otherwise>${fn:trim(result.nttSj) eq '' or empty result.nttSj ? '제목 없음' : result.nttSj}</c:otherwise>
						</c:choose>
						</a>
					</td>
					<td>
			    		${result.atchFileId}
			    	</td>
					<td>
			    		${result.fileSn}
			    	</td>
			    	<td>${result.ntcrNm}</td>
					<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm" /></td>
					<td>${result.inqireCo}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->
<c:if test="${fn:length(resultList) > 0}">
${pageNav}
</c:if>
<div class="btnSet">
	<c:if test="${empty paramVO.deleteCd or paramVO.deleteCd eq '0'}">
	    <sec:authorize access="hasRole('ROLE_SUPER')">
			<%-- <a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?deleteCd=1&amp;menuNo=${param.menuNo}"><span>삭제글보기</span></a> --%>
	   	</sec:authorize>
			<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
	</c:if>
	<c:if test="${paramVO.deleteCd eq '1'}">
			<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?deleteCd=0&amp;menuNo=${param.menuNo}"><span>돌아가기</span></a>
	</c:if>
</div>