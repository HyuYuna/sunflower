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
	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}
	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}
	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}
</script>
<title>${masterVO.bbsNm} - 게시글쓰기</title>
<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<div class="view">
				<dl>
					<dt>제목</dt>
					<dd>
						${result.nttSj}
					</dd>
				</dl>
				<dl>
				<dt>분류구분</dt>
				<dd>
					<c:forEach var="code" items="${COM094CodeList}" varStatus="status">
						<c:if test="${result.bbsSe eq code.code}">${code.codeNm}</c:if>
		 			</c:forEach>
				</dl>
				<dl>
					<dt>내용</dt>
					<dd>
						<div id="dbdata">
							<c:choose>
								<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.nttCn}</util:out></c:when>
								<c:otherwise>
									<% pageContext.setAttribute("crlf", "\n"); %>
									${fn:replace(result.nttCn, crlf, "<br/>")}
								</c:otherwise>
							</c:choose>
						</div>
					</dd>
				</dl>
			 <c:if test="${result.atchFileId ne ''}">
				<dl>
					<dt>첨부파일</dt>
					<dd>
						<c:if test="${fn:length(fileList) gt 0}">
							<c:forEach var="x" begin="0" end="${fn:length(fileList)-1}">
								<c:if test="${fileList[x].fileFieldNm eq 'sub_image1' or fileList[x].fileCn eq 'sub_image1'}">
									<c:set var="fileVO" value="${fileList[x]}"/>
								</c:if>
							</c:forEach>
							<c:if test="${not empty fileVO}">
								<a href="/bos/cmmn/file/fileDown.do?menuNo=${param.menuNo}&amp;atchFileId=${fileVO.atchFileId}&amp;fileSn=${fileVO.fileSn}&amp;bbsId=${masterVO.bbsId}"  class="${icn}">
									${fileVO.orignlFileNm} [${fileVO.fileMg} byte]
								</a>
							</c:if>
							<c:if test="${empty fileVO}">등록된 첨부파일이 없습니다.</c:if>
						</c:if>
					</dd>
				</dl>
			</c:if>
			<c:if test="${not empty result}">
				<dl>
					<dt>등록일</dt>
					<dd>${result.regDate}</dd>
				</dl>
			</c:if>
			<c:if test="${not empty result}">
				<dl>
					<dt>최종수정일</dt>
					<dd>${result.uptDate}</dd>
				</dl>
			</c:if>
	</div>
</form>
<div class="btnSet">
	<c:if test="${masterVO.prevNextPosblAt eq 'Y'}">
	<div class="fl">
	 	<c:if test="${result.deleteCd eq '1'}">
	 	<!--
			<a class="b-del" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		 -->
		</c:if>
		<c:if test="${prevNextMap.prevNttId > 0}">
			<a class="b-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap.nextNttId > 0}">
			<a class="b-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.nextNttId}&${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>
	</c:if>
	<div class="fl">
		<c:if test="${result.delcode eq '1'}">
			<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');"><span>영구삭제</span></a>
		</c:if>
		<c:if test="${prevNextMap.prevNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.prevNttId}&${pageQueryString}"><span>이전글</span></a>
	    </c:if>
		<c:if test="${prevNextMap.nextNttId > 0}">
		<a class="btn btn-default" href="/bos/bbs/${paramVO.bbsId}/view.do?${prevNextMap.nextNttId}.do&${pageQueryString}"><span>다음글</span></a>
	    </c:if>
	</div>
	<div class="fr" >
		<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}&${result.delcode}"><span>수정</span></a>
	<c:if test="${result.delcode eq '0' }" >
		<a class="btn btn-danger" href="javascript:delPermanently();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.delcode eq '1' }" >
		<a class="b-restore" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if>
		<a class="b-list" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"><span>목록</span></a>
	</div>
</div>
<c:if test="${masterVO.cmPosblAt eq 'Y'}">
	<c:import url="/${paramVO.siteId }/bbs/bbsCm/commentForm.do?viewType=CONTBODY">
		<c:param name="bbsId" value="${result.bbsId }" />
		<c:param name="cmSe" value="${paramVO.programId }" />
	</c:import>
</c:if>