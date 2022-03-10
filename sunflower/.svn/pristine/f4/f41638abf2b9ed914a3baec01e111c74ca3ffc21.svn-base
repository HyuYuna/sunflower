<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/${paramVO.groupId}/${paramVO.programId}/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/${paramVO.groupId}/${paramVO.programId}/update.do" />
</c:if>

<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />
<link rel="stylesheet" href="/bos/css/common.css" />

<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/bootstrap/js/bootstrap.min.js"></script>
<script src="/static/jslibrary/jquery-ui/jquery-ui.js"></script>
<script src="/js/miya_validator.js"></script>


<script>

	function checkForm() {

		var form = $("#board")[0];
		var v = new MiyaValidator(form);
	    v.add("wordSe", {
	        required: true
	    });
	    v.add("wordNm", {
	        required: true
	    });
	    v.add("wordEngNm", {
	        required: true
	    });
	    v.add("wordEngAbrvNm", {
	        required: true
	    });
	    v.add("wordDfn", {
	        required: true
	    });
	    v.add("themaAreaSe", {
	        required: true
	    });

		result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (!confirm('${empty result.mnno ? "등록" : "수정" } 하시겠습니까?')) {
			return;
		}

		form.submit();
	}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="mnno" value="${empty result.mnno ? 0 : result.mnno }" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

<div class="bdView">
<table cellpadding="0" cellspacing="0" summary="게시물 내용">
	<caption>용어사전 쓰기</caption>
	<colgroup>
		<col width="15%"/>
		<col width="85%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label for="wordSe"><span class="req"><span>필수입력</span></span>구분</label></th>
			<td>
				<select id="wordSe" name="wordSe" title="구분선택" class="w30p">
				   <option value="">선택</option>
				   <option value="표준어" <c:if test="${result.wordSe eq '표준어'}">selected="selected"</c:if> >표준어</option>
				   <option value="동의어" <c:if test="${result.wordSe eq '동의어'}">selected="selected"</c:if> >동의어</option>
				   <option value="도메인" <c:if test="${result.wordSe eq '도메인'}">selected="selected"</c:if> >도메인</option>
				</select>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordNm"><span class="req"><span>필수입력</span></span>용어명</label></th>
			<td>
				<input type="text" name="wordNm" id="wordNm" class="w100p" value="${result.wordNm}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordEngNm"><span class="req"><span>필수입력</span></span>영문용어명</label></th>
			<td>
				<input type="text" name="wordEngNm" id="wordEngNm" class="w100p" value="${result.wordEngNm}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordEngAbrvNm"><span class="req"><span>필수입력</span></span>용문약어명</label></th>
			<td>
				<input type="text" name="wordEngAbrvNm" id="wordEngAbrvNm" class="w100p" value="${result.wordEngAbrvNm}" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="wordDfn"><span class="req"><span>필수입력</span></span>용어정의</label></th>
			<td>
				<textarea name="wordDfn" id="wordDfn"  class="w100p board1" style="height:200px;">${result.wordDfn}</textarea>
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="themaAreaSe"><span class="req"><span>필수입력</span></span>주제영역</label></th>
			<td>
				<input type="text" name="themaAreaSe" id="themaAreaSe" class="w100p board1" value="${result.themaAreaSe}" />
			</td>
		</tr>
<!--
		<tr>
			<th scope="row"><label for="creatDe">관리일</label></th>
			<td>
				<input type="text" name="creatDe" id="creatDe" class="w100p" value="${result.creatDe}" size="10" maxlength="10" />
			</td>
		</tr>
 -->
	<c:if test="${not empty result}" >
		<tr>
			<th scope="row"><label for="frstRegisterPnttm">등록일</label></th>
			<td>
				${result.registDt}
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="subject">수정일</label></th>
			<td>
				${result.updtDt}
			</td>
		</tr>
	</c:if>
	</tbody>
</table>
</div>
</form>
	<div class="btnSet">
	<c:choose>
	<c:when test="${empty result}" >
		<a href="javascript:checkForm();" class="b-reg">등록</a>
	</c:when>
	<c:otherwise>
			<a href="javascript:checkForm();" class="b-edit">수정</a>
			<a href="delete.do?mnno=${result.mnno}&amp;${pageQueryString}" class="b-del" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
	</c:otherwise>
	</c:choose>
		<a href="list.do?${pageQueryString}" class="b-cancel">취소</a>
	</div>

