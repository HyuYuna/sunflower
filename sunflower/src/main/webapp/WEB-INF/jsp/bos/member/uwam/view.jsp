<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- http-->
<!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
<!-- https-->
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script src="/static/jslibrary/jquery.modal/jquery.modal.min.js"></script>
<link rel="stylesheet" href="/static/jslibrary/jquery.modal/jquery.modal.min.css" />

<script>
//<![CDATA[
var mode = "${empty result ? 'I' : 'M'}";


//]]>
</script>

	<h4>기본정보</h4>
	<div class="view">
		<input type="hidden" name="snsId" id="snsId" value="${result.snsId }">
		<dl>
			<dt>SNS구분</dt>
			<dd>${result.snsSe }</dd>

		</dl>
		<dl>
			<dt>성명</dt>
			<dd>${result.userNm} </dd>
			<dt>이메일</dt>
			<dd>
				<span id="email">${result.userEmad }</span>
			</dd>
		</dl>
		<dl>
			<dt>가입일시</dt>
			<dd>${result.registDt}</dd>
			<dt>수정일시</dt>
			<dd>${result.updtDt}</dd>
		</dl>
		<dl>
			<dt>승인여부</dt>
			<dd>
				<select name="confmAt" id="confmAt">
					<option value="N" <c:if test="${result.confmAt eq 'Y' }">selected="selected"</c:if>>승인대기</option>
					<option value="Y" <c:if test="${result.confmAt eq 'Y' }">selected="selected"</c:if>>승인완료</option>
				</select>
				<button type="button" class="b-edit" id="confmUpdtBtn" data-value="${result.snsId }">상태변경</button>
			</dd>
			<dt>승인일시</dt>
			<dd>${result.confmDt}</dd>
		</dl>
		<script>
			$("#confmUpdtBtn").on('click',function() {
				if (!confirm("승인상태를 변경 하시겠습니까?")) return false;
				var url = "/bos/member/uwam/updateConfmState.json";
				var param = {
					confmAt : $("#confmAt").val(),
					snsId : $(this).attr("data-value")
				};
				$.post(url, param, function(data) {
					if (data.resultCode == "success") {
						alert("승인상태변경이 완료되었습니다.");
					}
					else {
						alert("승인상태변경이 실패했습니다.");
					}
				},"json");
				return false;
			});
		</script>
	</div>


	<h4>APP 정보</h4>
	<div class="view">
		<dl>
			<dt>APP TOKEN</dt>
			<dd>${result.appTokenValue }</dd>
		</dl>
		<dl>
			<dt>APP DEVICE ID</dt>
			<dd>${result.appDeviceId }</dd>
			<dt>APP OS</dt>
			<dd>${result.appOd}</dd>
		</dl>
		<dl>
			<dt>APP Version</dt>
			<dd>${result.appVersion }</dd>
			<dt>APP MODEL</dt>
			<dd>${result.appModelSe}</dd>
		</dl>
	</div>

	<div class="btnSet">
	<!--
		<a href="/bos/member/user/forUpdate.do?userId=${result.userId}&${pageQueryString}" class="b-edit">수정</a>
	 -->
		<a href="javascript:delUser();" class="b-del">삭제</a>
		<a href="/bos/member/uwam/list.do?${pageQueryString}" class="b-list">목록</a>
	</div>


	<h4>등록사이트 정보</h4>
	<form name="siteForm" id="siteForm" action="/bos/member/uwam/view.do" method="get">
	<input type="hidden" name="menuNo" value="${paramVO.menuNo }">
	<input type="hidden" name="snsId" id="snsId" value="${result.snsId }">
	<div class="sh">
		<label for="siteSeCdSrh">사이트구분</label>
		<select name="siteSeCdSrh" id="siteSeCdSrh" title="사이트구분">
			<option value="">사이트구분 선택</option>
			<c:forEach var="code" items="${siteSeCdCodeList }">
				<option value="${code.cd }" <c:if test="${param.siteSeCdSrh eq code.cd}">selected="selected"</c:if>>${code.cdNm }</option>
			</c:forEach>
		</select>

		<input type="text" name="siteNmSrh" id="siteNmSrh" value="${paramVO.siteNmSrh}" placeholder="사이트명" title="검색어" />
		<button class="b-sh">검색</button>
		<a href="/bos/member/uwam/view.do?menuNo=${param.menuNo}&snsId=${result.snsId}" class="b-reset">초기화</a>
	</div>
	</form>

	<div class="bdList">
		<table class="table">
			<caption>PUSH회원관리 목록</caption>
			<thead>
				<tr>
					<th scope="col">사이트구분</th>
					<th scope="col">사이트명</th>
					<th scope="col">설정</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${resultList}" varStatus="status">
					<tr>
						<td>${item.siteSeCdNm}</td>
						<td class="tit"><a href="/${paramVO.siteId }/member/uwam/viewSite.do?viewType=CONTBODY&amp;siteSn=${item.siteSn}&amp;menuNo=${paramVO.menuNo}" rel="modal:open">${item.siteNm}</a></td>
						<%--
						<td>
						<c:choose>
						<c:when test="${item.rspnsSuccesAt eq 'Y'}">정상</c:when>
						<c:when test="${item.rspnsSuccesAt eq 'N'}">장애</c:when>
						<c:otherwise>확인중</c:otherwise>
						</c:choose>
						</td>
						 --%>
						<td><a href="/bos/member/uwam/forUpdateSite.do?viewType=CONTBODY&amp;siteSn=${item.siteSn }&amp;userSn=${item.userSn }&amp;menuNo=${paramVO.menuNo }" class="b-edit" rel="modal:open">설정변경</a></td>
						<%--
						<td><a href="#" class="b- errLogBtn" target="_blank" title="새창열림" data-value="${item.siteSn }">장애LOG확인</a></td>
						--%>
						<%-- <td><fmt:formatDate value="${result.lastLoginDt}" pattern="yyyy-MM-dd HH:mm"/></td> --%>

					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="3">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
<div class="btnSet">
	<%-- <a class="b-reg" href="/bos/member/uwam/forInsertSiteStep1.do?viewType=CONTBODY&amp;userSn=${result.userSn }&amp;menuNo=${paramVO.menuNo }" rel="modal:open"><span>등록</span></a> --%>
	<a class="b-reg" href="/bos/member/uwam/forInsertSite.do?viewType=CONTBODY&amp;userSn=${result.userSn }&amp;menuNo=${paramVO.menuNo }" rel="modal:open"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>


<script>
$(".errLogBtn").on('click',function() {
	var siteSn = $(this).attr("data-value");
	var url = "/bos/member/uwam/listErrLog.do?siteSn="+siteSn+"&userSn=${result.userSn}&viewType=BODY&menuNo=${paramVO.menuNo}";
	alert(url);
	window.open(url,"errLogPop","width=800, height=900, scrollbars=yes");
	return false;
});

</script>