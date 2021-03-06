<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>


<c:if test="${empty result}">
	<c:set var="action" value="/bos/sys/globalsManage/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/sys/globalsManage/update.do" />
</c:if>
<script>

	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);

		v.add("attrbNm", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		if (!confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
			return;
		}

		form.submit();
	}

	function deleteOne(){
		var form = $("#board")[0];
		form.action = "/bos/sys/globalsManage/delete.do";
		form.submit();
	}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="attrbSn" value="${empty result.attrbSn ? 0 : result.attrbSn }" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<div class="bdView">
		<table summary="">
			<caption>${empty result ? '쓰기' : '수정'}</caption>
			<colgroup>
				<col style="width: 15%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label for="attrbNm">속성명</label><span class="req"><span>필수입력</span></span></th>
					<td><input type="text" name="attrbNm" id="attrbNm" class="w100p" value="${result.attrbNm}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="attrbValue">속성값</label></th>
					<td><input type="text" name="attrbValue" id="attrbValue" class="w100p" value="${result.attrbValue}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="attrbDc">속성설명</label></th>
					<td><input type="text" name="attrbDc" id="attrbDc" class="w100p" value="${result.attrbDc}" /></td>
				</tr>
				<c:if test="${not empty result}">
					<tr>
						<th scope="row"><label for="useAt">사용여부</label></th>
						<td>
							<input type="radio" name="useAt" id="useAtY" value="Y" <c:if test="${result.useAt eq 'Y' }">checked="checked"</c:if>/><label for="useAtY">사용</label>
							<input type="radio" name="useAt" id="useAtN" value="N" <c:if test="${result.useAt eq 'N' }">checked="checked"</c:if>/><label for="useAtN">미사용</label>
						</td>
					</tr>
					<tr>
						<th scope="row">등록일</th>
						<td>${result.registDt}</td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">

	<div class="fr" >
		<c:choose>
		<c:when test="${empty result}" >
			<a href="javascript:checkForm();" class="b-reg"><span>등록</span></a>
		</c:when>
		<c:otherwise>
			<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
			<a class="b-del" href="javascript:deleteOne();" onclick="return confirm('정말로 삭제하시겠습니까?');"><span>삭제</span></a>
		</c:otherwise>
		</c:choose>
			<a class="b-cancel" href="/bos/sys/globalsManage/list.do?${pageQueryString}"><span>취소</span></a>
	</div>
</div>
