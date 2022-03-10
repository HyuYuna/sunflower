<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<script>
function del(){
	if (!confirm('정말로 삭제 하시겠습니까?')) {
		return;
	}
	var form = $("#board")[0];
	form.action = "/ucms/bbs/${paramVO.bbsId}/delete.do";
	form.submit();
}
</script>
<c:if test="${not empty masterVO.aditCntntsCn }">
<div>
	<util:out escapeXml="false">${masterVO.aditCntntsCn}</util:out>
</div>
</c:if>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="/ucms/bbs/${paramVO.bbsId}/delete.do">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">

<div class="view">
	<h2 class="subject">
		${result.nttSj}
	</h2>
	<dl>
		<dt>작성일</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
		<dt>작성자</dt>
		<dd>${result.ntcrNm}</dd>
		<dt>조회수</dt>
		<dd>${result.inqireCo}</dd>
	</dl>

	<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
 	<dl>
		<dt>첨부파일</dt>
		<dd>
			<ul class="fileList">
		 	<c:forEach var="file" items="${fileList}" varStatus="status">
				<li><a href="/ucms/cmmn/file/fileDown.do?menuNo=${param.menuNo}&amp;atchFileId=${file.atchFileId}&fileSn=${file.fileSn}">${file.orignlFileNm}</a></li>
			</c:forEach>
			</ul>
		</dd>
	</dl>
	</c:if>

	<div class="dbData">
		<% // 에디터 없이 사용자 글쓰기시 내용 처리 방법 : 태그는 먹지 않게 하고 엔터키 값만 처리 %>
		<%pageContext.setAttribute("crlf", "\n"); %>
		${fn:replace(result.nttCn, crlf, "<br/>")}
	</div>
</div>
</form>

<div class="btnSet">
	<a href="/ucms/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" class="b-list">목록</a>

	<c:if test="${result.ntcrId eq userVO.userId }">
	<c:if test="${result.answerAt ne 'Y'}">
		<a class="b-edit" href="/ucms/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}">수정</a>
	</c:if>
	<button type="button" class="b-del" onclick="del();">삭제</button>
	</c:if>
</div>

<c:if test="${fn:length(replyList) > 0}">
	<c:set var="reply" value="${replyList[0]}" />
<div class="view">
	<h2 class="subject">
		[답변] ${result.nttSj}
	</h2>
	<dl>
		<dt>작성일</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
		<dt>작성자</dt>
		<dd>${reply.ntcrNm}</dd>
	</dl>
	<div class="dbData viewResult">
		<c:choose>
			<c:when test="${reply.htmlYn=='Y'}">${reply.nttCn}</c:when>
			<c:otherwise>
				<% pageContext.setAttribute("crlf", "\n"); %>
				${fn:replace(reply.nttCn, crlf, "<br/>")}
			</c:otherwise>
		</c:choose>
	</div>
</div>
</c:if>

<c:if test="${masterVO.prevNextPosblAt eq 'Y'}">
<div class="bdViewNav">
	<dl>
		<dt>윗글</dt>
		<dd>
	<c:choose>
		<c:when test="${prevNextMap.prevNttId > 0}">
			<a href="/ucms/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.prevNttId}&${pageQueryString}">${prevNextMap.prevNttSj}</a>
		</c:when>
		<c:otherwise><span>이전글이 없습니다.</span></c:otherwise>
	</c:choose>
		</dd>
	</dl>
	<dl>
		<dt class="n">아랫글</dt>
		<dd>
	<c:choose>
		<c:when test="${prevNextMap.nextNttId > 0}">
			<a href="/ucms/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.nextNttId}&${pageQueryString}">${prevNextMap.nextNttSj}</a>
		</c:when>
		<c:otherwise><span>다음글이 없습니다.</span></c:otherwise>
	</c:choose>
		</dd>
	</dl>
</div>
</c:if>

<c:if test="${masterVO.cmPosblAt eq 'Y'}">

	<c:import url="/${paramVO.siteId }/bbs/bbsCm/commentForm.do?viewType=CONTBODY">
		<c:param name="bbsId" value="${result.bbsId }" />
		<c:param name="nttId" value="${result.nttId }" />
		<c:param name="cmSe" value="${paramVO.programId }" />
	</c:import>
</c:if>