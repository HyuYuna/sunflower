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

	function delReply(){
		if (!confirm('정말로 답변삭제 하시겠습니까?')) {
			return;
		}
		var form = $("#replyBoard")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		if (!confirm('정말로 삭제 하시겠습니까?')) {
			return;
		}
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

<div class="view">
				<dl>
					<dt>구분</dt>
					<dd>
						<c:if test="${result.nttTyCd eq '1'}">
						공지
						</c:if>
						<c:if test="${result.nttTyCd eq '2'}">
						일반
						</c:if>
					</dd>
				</dl>
				<c:if test="${result.nttType == '1'}">
				<dl>
					<dt>공지기간</dt>
					<dd>
						${result.ntceBgnde} ~ ${result.ntceEndde}
					</dd>
				</dl>
				</c:if>
				<dl>
					<dt>게시물제목</dt>
					<dd>
						${result.nttSj}
					</dd>
				</dl>
				<dl>
					<dt>게시글내용</dt>
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
				<dl>
					<dt>작성자</dt>
					<dd>
						${result.ntcrNm}
					</dd>
				</dl>
				<dl>
					<dt>조회수</dt>
					<dd>
						${result.inqireCo}
					</dd>
				</dl>
			<c:if test="${masterVO.fileAtchPosblAt eq 'Y'}">
				<dl>
					<dt>첨부파일</dt>
					<dd>
						<jsp:include page="/WEB-INF/jsp/bos/share/incFileList.jsp" flush="true" />
						<c:if test="${fn:length(fileList) == 0}">등록된 첨부파일이 없습니다.</c:if>
					</dd>
				</dl>
			</c:if>
			<c:if test="${not empty result}">
				<dl>
					<dt>등록일</dt>
					<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
				</dl>
				<dl>
					<dt>최종수정일</dt>
					<dd><fmt:formatDate value="${result.updtDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
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
	<div class="fr" >
		<a class="b-edit" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}"><span>수정</span></a>
	<c:if test="${result.deleteCd eq '0' }" >
		<a class="b-del" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
	</c:if>
	<c:if test="${result.deleteCd eq '1' }" >
		<a class="b-edit" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');"><span>원글복구</span></a>
	</c:if>
	<c:if test="${fn:length(replyList) == 0}">
		<a class="b-edit" href="/bos/bbs/${paramVO.bbsId}/forInsertRe.do?parntsNo=${result.nttId}&${pageQueryString}"><span>답변등록</span></a>
	</c:if>
		<a class="b-list" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}"><span>목록</span></a>
	</div>
</div>

<c:if test="${fn:length(replyList) > 0}">
	<c:set var="reply" value="${replyList[0]}" />
<form id="replyBoard" name="replyBoard" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${reply.nttId}" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" name="parntsNo" value="${result.nttId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${reply.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<h2>답변</h2>
	<div class="view">
				<dl>
					<dt style="width:15%">답변제목</dt>
					<dd>
						${reply.nttSj}
					</dd>
				</dl>
				<dl>
					<dt>답변내용</dt>
					<dd>
						<div id="dbdata">
							<c:choose>
								<c:when test="${reply.htmlYn=='Y'}"><util:out escapeXml="false">${reply.nttCn}</util:out></c:when>
								<c:otherwise>
									${reply.nttCn}
								</c:otherwise>
							</c:choose>
						</div>
					</dd>
				</dl>
				<dl>
					<dt>작성자</dt>
					<dd>
						${reply.ntcrNm}
					</dd>
				</dl>
			<c:if test="${not empty result}">
				<dl>
					<dt>등록일</dt>
					<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
				</dl>
				<dl>
					<dt>최종수정일</dt>
					<dd><fmt:formatDate value="${result.updtDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
				</dl>
			</c:if>
	</div>

	<div class="btnSet">
		<a class="b-edit" href="/bos/bbs/${paramVO.bbsId}/forUpdateRe.do?nttId=${reply.nttId}&parntsNo=${result.nttId}&${pageQueryString}"><span>답변수정</span></a>
		<button type="button" class="b-del" onclick="delReply();">답변삭제</button>
	</div>
</form>
</c:if>

<c:if test="${masterVO.cmPosblAt eq 'Y'}">

	<c:import url="/${paramVO.siteId }/bbs/bbsCm/commentForm.do?viewType=CONTBODY">
		<c:param name="bbsId" value="${result.bbsId }" />
		<c:param name="cmSe" value="${paramVO.programId }" />
	</c:import>
</c:if>