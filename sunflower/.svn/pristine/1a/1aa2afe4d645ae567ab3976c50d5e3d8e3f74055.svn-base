<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<script>
	function del(){
		var form = $("#board")[0];
		form.action = "/bos/qestnar/qustnr/delete.do";
		form.submit();
	}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="qustnrSn" value="${empty result.qustnrSn ? 0 : result.qustnrSn }" />

<div class="bdView">
		<table>
			<caption>${result.nttSj} (읽기)</caption>
			<colgroup>
				<col style="width:15%"/>
				<col style="width:85%"/>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">설문주제</th>
					<td>
						${result.qustnrSj}
					</td>
				</tr>
				<tr>
					<th scope="row">조사기간</th>
					<td>
						<fmt:formatDate value="${result.bgnde}" pattern="yyyy-MM-dd HH:mm"/> ~
						<fmt:formatDate value="${result.endde}" pattern="yyyy-MM-dd HH:mm"/>
					</td>
				</tr>
				<tr>
					<th scope="row">설문대상</th>
					<td>
						<c:if test="${result.qustnrTrgetCd eq 'A'}">아무나</c:if>
						<c:if test="${result.qustnrTrgetCd eq 'M'}">회원</c:if>
					</td>
				</tr>
				<tr>
					<th scope="row">결과보기 공개여부</th>
					<td>
						${result.resultOthbcAt}
					</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td>
						<div id="dbdata">
							<%-- <c:choose>
								<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.qestnarCn}</util:out></c:when>
								<c:otherwise>
									${result.qestnarCn}
								</c:otherwise>
							</c:choose> --%>
							<util:out escapeXml="false">${result.qestnarCn}</util:out>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">등록일</th>
					<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
				<tr>
					<th scope="row">최종수정일</th>
					<td><fmt:formatDate value="${result.updtDt}" pattern="yyyy-MM-dd HH:mm"/></td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">
	<div class="fr" >
		<a class="pure-button b-edit" href="/bos/qestnar/qustnr/forUpdate.do?qustnrSn=${result.qustnrSn}&${pageQueryString}">수정</a>
	<c:if test="${result.deleteCd eq '0' }" >
		<a class="pure-button b-del" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
	</c:if>
		<a class="pure-button b-list" href="/bos/qestnar/qustnr/list.do?${pageQueryString}">목록</a>
	</div>
</div>