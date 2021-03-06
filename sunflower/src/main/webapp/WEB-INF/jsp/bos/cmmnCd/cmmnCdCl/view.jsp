<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<form name="cmmnCdClForm" id="cmmnCdClForm" action="" method="get">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<input name="menuNo" id="menuNo" type="hidden" value="${paramVO.menuNo}">
		<input name="clCd" id="clCd" type="hidden" value="${result.clCd }" >
		<input name="pageQueryString"  type="hidden" value="${pageQueryString }">
	</form>
	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="clCd">분류코드</label></th>
					<td>${result.clCd}</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="clCdNm">분류코드명</label></th>
					<td>${result.clCdNm}</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="clCdDc">분류코드설명</label></th>
					<td>${result.clCdDc}</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="useAt">사용여부</label></th>
					<td>
						<c:if test="${result.useAt eq 'Y' }">사용</c:if>
						<c:if test="${result.useAt eq 'N' }">미사용</c:if>

					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-edit" href="javascript:void(0);" id="updtBtn"><span>수정</span></a>
		<a class="b-del" href="javascript:void(0);" id="delBtn"><span>삭제</span></a>
		<a class="b-cancel" href="/bos/cmmnCd/cmmnCdCl/list.do?${pageQueryString}"><span>취소</span></a>
	</div>

<script>
	$("#updtBtn").on('click',function() {
		$("#cmmnCdClForm").attr("action","/bos/cmmnCd/cmmnCdCl/forUpdate.do");
		$("#cmmnCdClForm").submit();
		return false;
	});

	$("#delBtn").on('click',function() {
		if (!confirm("삭제 처리하시겠습니까?")) return false;
		$("#cmmnCdClForm").attr("action","/bos/cmmnCd/cmmnCdCl/delete.do");
		$("#cmmnCdClForm").submit();
		return false;
	});
</script>
