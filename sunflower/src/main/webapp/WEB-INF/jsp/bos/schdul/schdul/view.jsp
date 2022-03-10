<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<form name="listForm" id="listForm" action="" method="get">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input name="menuNo" id="menuNo" type="hidden" value="${paramVO.menuNo}">
		<input name="schdulSn" id="schdulSn" type="hidden" value="${result.schdulSn }" >
		<input type="hidden" id="bassInfo" name="bassInfo" value="${result.bassInfo }">
	</form>
	<div class="bdView">
		<table>
			<caption>일정관리</caption>
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="lclas">구분</label></th>
					<td colspan="3"><c:out value="${result.sclasNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="lclas">일정명</label></th>
					<td colspan="3"><c:out value="${result.lclas}" escapeXml="false"/></td>
				</tr>
				<tr>
					<th scope="row"><label for="mlsfc">세부 일정명</label></th>
					<td colspan="3"><c:out value="${result.mlsfc}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="mlsfc">장소</label></th>
					<td colspan="3"><c:out value="${result.placeNm}" /></td>
				</tr>
				<tr>
					<th scope="row">일정기간</th>
					<td><c:out value="${result.bgnde} ~ ${result.endde}" /></td>
					<th scope="row">시간</th>
					<td><c:out value="${result.timeBgnde} ~ ${result.timeEndde}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="mlsfc">공개구분</label></th>
					<td colspan="3"><c:out value="${result.othbcSeNm}" /></td>
				</tr>
				<tr>
					<th scope="row">상세정보</th>
					<td colspan="3">
						<div id="dbdata">
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">파일첨부</th>
					<td colspan="3">
						<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileDownloadZone.jsp" flush="true">
							<jsp:param value="schdul" name="subFileGroup" />
							<jsp:param value="${result.schdulSn }" name="subFileCode" />
							<jsp:param value="" name="subFilecodeSub" /> 
							<jsp:param value="" name="subFileFolder" />
						</jsp:include>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-edit" href="javascript:void(0);" id="updtBtn"><span>수정</span></a>
		<a class="b-del" href="javascript:void(0);" id="delBtn"><span>삭제</span></a>
		<a class="b-cancel" href="/bos/schdul/schdul/list.do?${pageQueryString}"><span>취소</span></a>
	</div>

<script>
$(document).ready(function(){
	var content = document.getElementById("bassInfo").value;
	fncHtml(content);
});
	$("#updtBtn").click(function() {
		/* $("#listForm").attr("action","/bos/schdul/schdul/forUpdate.do");
		$("#listForm").submit(); */
		location.href="/bos/schdul/schdul/forUpdate.do?schdulSn=${result.schdulSn}&menuNo=${paramVO.menuNo}";
		return false;
	});

	$("#delBtn").click(function() {
		if (!confirm("삭제 처리하시겠습니까?")) return false;
		$("#listForm").attr("action","/bos/schdul/schdul/delete.do");
		$("#listForm").submit();
		return false;
	});
	function fncHtml(content){
		var randValNode = document.getElementById("dbdata");
		randValNode.innerHTML = content;
	}
</script>
