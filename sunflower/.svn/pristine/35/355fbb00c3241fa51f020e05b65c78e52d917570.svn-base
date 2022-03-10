<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<fmt:parseNumber integerOnly='true' value='${result.seq }' var="seq" />

<form id="formBoard">
	<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo }"/>
	<input type="hidden" name="act" value="insert"/>
	<input type="hidden" name="seq" value="${seq }"/>
	<input type="hidden" name="userId" value="${userVO.userId }"/>
</form>

	<table class="table03">
		<colgroup>
			<col width="20%" />
			<col width="80%" />
		</colgroup>
	<thead>
		<tr>
			<c:if test="${param.menuNo eq '100240' }">
				<th colspan="2">메일보내기</th>
			</c:if>
			<c:if test="${param.menuNo eq '100241' }">
				<th colspan="2">발신 메일</th>
			</c:if>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th>제목</th>
			<td>${result.title }</td>
		</tr>
		<tr>
			<th>발신인</th>
			<td>${result.wuserNm } (${result.centerCodeName })</td>
		</tr>
		<tr>
			<th>수신인</th>
			<td>
				<c:forEach var="rec" items="${rec}" varStatus="status">
					${rec.ruser } <c:if test="${not empty rec.rdate }">[ <fmt:formatDate value="${rec.rdate }" pattern="yyyy-MM-dd HH:mm"/>에 읽음 ]</c:if><br/>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><fmt:formatDate value="${result.wdate }" pattern="yyyy-MM-dd HH:mm" /></td>
		</tr>
		<c:if test="${param.menuNo eq '100241' }">
			<tr>
				<th>수신일</th>
				<td><fmt:formatDate value="${result.rdate2 }" pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
		</c:if>
		<tr>
			<th>내용</th>
			<td>
				<c:out value="${fn:replace(result.content, newLineChar, '<br/>')}" escapeXml="false"/>
			</td>
		</tr>
	</tbody>
</table>

<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileDownloadZone.jsp" flush="true">
	<jsp:param value="message" name="subFileGroup" />
	<jsp:param value="${seq }" name="subFileCode" />
	<jsp:param value="" name="subFilecodeSub" /> 
	<jsp:param value="message" name="subFileFolder" />
</jsp:include>

<c:if test="${(not empty result.fvname1 && fn:length(result.fvname1)>5) 
	|| (not empty result.fvname2 && fn:length(result.fvname2)>5) 
	|| (not empty result.fvname3 && fn:length(result.fvname3)>5) 
	|| (not empty result.fvname4 && fn:length(result.fvname4)>5) }">
	<div>
		<table cellpadding="0" cellspacing="0" border="0" class="table03" id="idUpload_View">
			<colgroup>
				<col width=""/>
			</colgroup>
			<tbody>
				<tr style="background-color:#F6F6F6;">
					<td class="ac f_bold">파일다운로드</td>
				</tr>
				<c:if test="${(not empty result.fvname1 && fn:length(result.fvname1)>5) }">
					<tr>
						<td>File1 : <a href="#" onclick="javascript:;">${result.fvname1 }</a></td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</c:if>

<div class="btnGroup">
	<c:if test='${paramVO.menuNo == "100240" }'>
		<input type="submit" id="btnReply" class="pure-button btnInsert" value="답장하기">
	</c:if>
	<input type="submit" id="btnList" class="pure-button btnList" value="목록">
</div>

<script>
	$("#btnList").click(function(){
		location.href = "/bos/message/message/list.do?${pageQueryString}";
	});
	
	$("#btnReply").click(function(){
		location.href = "/bos/message/message/forInsert.do?${pageQueryString}&seq=${result.seq}";
	});
	
	function fnFileDownloadMessageAlert(gSeq, gSize) {
		if (confirm("파일을 다운로드 받으시겠습니까?")) {
		}
	}
</script>