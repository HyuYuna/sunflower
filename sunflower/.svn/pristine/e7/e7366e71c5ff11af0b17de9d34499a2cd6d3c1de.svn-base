<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<form name="cmmnCdClForm" id="cmmnCdClForm" action="" method="get">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input name="menuNo" id="menuNo" type="hidden" value="${paramVO.menuNo}">
		<input name="codegCode" id="codegCode" type="hidden" value="${result.codegCode }" >
	</form>
	<div class="bdView">
		<table>
			<caption>코드정보</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<%-- <tr>
					<th scope="row">분류코드명</th>
					<td>${result.clCdNm}</td>
				</tr> --%>
				<tr>
					<th scope="row">코드ID</th>
					<td>${result.codegCode}</td>
				</tr>
				<tr>
					<th scope="row">코드카테고리명</th>
					<td>${result.codegName}</td>
				</tr>
				<tr>
					<th scope="row">생성일</th>
					<td>${result.codegRegdate}</td>
				</tr>
				<%--<tr>
					<th scope="row">사용여부</th>
					<td>
						<c:if test="${result.useAt eq 'Y' }">사용</c:if>
						<c:if test="${result.useAt eq 'N' }">미사용</c:if>
					</td>
				</tr> --%>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-edit" href="javascript:void(0);" id="updtBtn"><span>수정</span></a>
		<a class="b-del" href="javascript:void(0);" id="delBtn"><span>삭제</span></a>
		<a class="b-cancel" href="/bos/cmmnCd/cmmnCdCtgry/list.do?${pageQueryString}"><span>취소</span></a>
	</div>

<script>
	$("#updtBtn").on('click',function() {
		$("#cmmnCdClForm").attr("action","/bos/cmmnCd/cmmnCdCtgry/forUpdate.do");
		$("#cmmnCdClForm").submit();
		return false;
	});

	$("#delBtn").on('click',function() {
		if (!confirm("삭제 처리하시겠습니까? (삭제 후 상세코드를 포함한 코드복구가 불가능합니다.)")) return false;
		$("#cmmnCdClForm").attr("action","/bos/cmmnCd/cmmnCdCtgry/delete.do");
		$("#cmmnCdClForm").submit();
		return false;
	});
</script>
