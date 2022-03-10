<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/cmmnCd/cmmnCdCl/insert.do" />
	<c:set var="actionName" value="등록" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/cmmnCd/cmmnCdCl/update.do" />
	<c:set var="actionName" value="수정" />
</c:if>


<form id="cmmnCdClForm" name="cmmnCdClForm" action="${action }" method="post">
	<input name="menuNo" type="hidden" value="${paramVO.menuNo }" />
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
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
					<td>
						<input type="text" name="clCd" id="clCd" style="text-transform:uppercase;" size="3" maxlength="3" class="wid100" value="${result.clCd}" <c:if test="${not empty result }">readonly="readonly"</c:if> />
						<script>
						$(document).on("keyup", "input[name=clCd]", function() {$(this).val( $(this).val().replace(/[^\!-z]/gi,"").toUpperCase() );});
						</script>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="clCdNm">분류코드명</label></th>
					<td><input type="text" name="clCdNm" id="clCdNm" maxlength="60" class="w100p" value="${result.clCdNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="clCdDc">분류코드설명</label></th>
					<td>
						<textarea id="clCdDc" name="clCdDc" cols="150" rows="5" class="textarea">${result.clCdDc}</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span class="sr-only">필수입력</span></span> <label for="useAt">사용여부</label></th>
					<td>
						<select name="useAt" id="useAt">
							<option value="Y" <c:if test="${result.useAt eq 'Y' }">selected="selected"</c:if>>사용</option>
							<option value="N" <c:if test="${result.useAt eq 'N'}">selected="selected"</c:if>>미사용</option>
						</select>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">
	<a class="btn btn-primary" href="javascript:void(0);" id="saveBtn">
		<span>${actionName }</span>
	</a>
	<a class="btn btn-primary" href="/bos/cmmnCd/cmmnCdCl/list.do?${pageQueryString}">
		<span>목록</span>
	</a>
</div>

<script>
	function fnIsHangeul(input_s) {
		var pattern = /[\u3131-\u314e|\u314f-\u3163|\uac00-\ud7a3]/g;
		return (pattern.test(input_s)) ? true : false;
	}

	$("#saveBtn").on('click',function() {

		var varFrom = $("#cmmnCdClForm")[0];
		var v = new MiyaValidator(varFrom);
		v.add("clCd", {
			required : true
		});
		v.add("clCdNm", {
			required : true
		});
		v.add("clCdDc", {
			required : true
		});
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		if (fnIsHangeul($("#clCd").val())) {
			alert("한글은 허용하지 않습니다.");
			$("#clCd").focus();
			return;
		}

		if (confirm("${actionName } 하시겠습니까?")) {
			varFrom.submit();
		}
		return false;
	});
</script>


