<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<script>
	function del(){
		var form = $("#board")[0];
		form.action = "/bos/singl/errorLog/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/singl/errorLog/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/singl/errorLog/delPermanently.do";
		form.submit();
	}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="logNo" value="${empty result.logNo ? 0 : result.logNo }" />

	<div class="view">
		<dl>
			<dt>제목</dt>
			<dd>
				${result.errorSj}
			</dd>
		</dl>
		<dl>
			<dt>이전경로</dt>
			<dd>
				${result.beforeUrlad}
			</dd>
		</dl>
		<dl>
			<dt>에러경로</dt>
			<dd>
				${result.errorUrlad}
			</dd>
			<dt>에러일자</dt>
			<dd>
				<fmt:formatDate value="${result.errorDt}" pattern="yyyy-MM-dd HH:mm" />
			</dd>
		</dl>
		<dl>
			<dt>사용자ID</dt>
			<dd>
				${result.userId}
			</dd>
			<dt>사용자IP</dt>
			<dd>
				${result.userIpad}
			</dd>
		</dl>
		<dl>
			<dt>에러내용</dt>
			<dd>
				<div id="dbdata">
					<c:choose>
						<c:when test="${result.htmlAt eq 'Y'}"><util:out escapeXml="false">${result.errorCn}</util:out></c:when>
						<c:otherwise>
							<% pageContext.setAttribute("crlf", "\n"); %>
							${fn:replace(result.errorCn, crlf, "<br/>")}
						</c:otherwise>
					</c:choose>
				</div>
			</dd>
		</dl>
	</div>
</form>

<div class="btnSet">
	<%-- <c:if test="${masterVO.prevNextPosblAt eq 'Y'}">
	<div class="fl">
		<c:if test="${result.deleteCd eq '1'}">
			<a class="b-del" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		</c:if>
		<c:if test="${prevNextMap.prevNttId > 0}">
			<a class="b-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.prevNttId}&${pageQueryString}"><span>이전글</span></a>
			</c:if>
		<c:if test="${prevNextMap.nextNttId > 0}">
			<a class="b-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.nextNttId}&${pageQueryString}"><span>다음글</span></a>
			</c:if>
	</div>
	</c:if> --%>
	<div class="fr" >
		<%-- <a class="b-edit" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}"><span>수정</span></a>
	<c:if test="${result.deleteCd eq '0' }" >
		<a class="b-del" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.deleteCd eq '1' }" >
		<a class="b-edit" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if> --%>
		<a class="b-list" href="/bos/singl/errorLog/list.do?${pageQueryString}"><span>목록</span></a>
	</div>
</div>
