<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<script>
$(function(){
	$("#pageUnit").on('change',function(){
		var size = $(this).val();
		$("#frm")[0].submit();
	});
});

function pop() {
	var attrbTyCd = $('#attrbTyCd2 option:selected').val();
	if (!attrbTyCd) {
		alert('속성을 선택하세요.');
		$('#attrbTyCd2')[0].focus();
		return;
	}
	var u = '/bos/bbs/attrb/selectAllFieldList.do?attrbCd=${result.attrbCd}&viewType=BODY&attrbTyCd='+attrbTyCd;
	var n = "attrPop";
	var w = "1200";
	var h = "800";
	var s = "yes";
	popupW(u,n,w,h,s);
}

function createPage() {
	var attrbTyCd = $('#attrbTyCd2 option:selected').val();
	if (!attrbTyCd) {
		alert('속성을 선택하세요.');
		$('#attrbTyCd2')[0].focus();
		return;
	}
	if (!confirm('페이지를 생성하시겠습니까?')) {
		return;
	}
	$('.b-reg').hide();
	var inData = {attrbCd :'${result.attrbCd}', attrbTyCd : attrbTyCd};
	$.post(
		"/bos/bbs/attrb/createPage.json",
		inData,
		function(data) {
			var resultCode = data.resultCode;
			if (resultCode == "success") {
				var outputPath = data.outputPath;
				alert(outputPath + '에 생성되었습니다.');
			}
			else {
				alert('작업에 실패하였습니다.');
			}
			$('.b-reg').show();
		}
	);
}

</script>

<form id="frm" name="frm" action="view.do?attrbCd=${result.attrbCd}&menuNo=${param.menuNo}" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<h3>속성정보</h3>
	<!-- board list start -->
	<div class="bdView">
		<table>
			<caption>게시판 쓰기</caption>
			<colgroup>
				<col width="20%" />
				<col width="80%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">테이블명</th>
					<td>${result.tableNm}</td>
				</tr>
				<tr>
					<th scope="row">게시판속성코드</th>
					<td>${result.attrbCd}</td>
				</tr>
				<tr>
					<th scope="row">게시판속성명</th>
					<td>${result.attrbNm}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-cancel" href="list.do?${pageQueryString}"><span>취소</span></a>
	</div>

	<%-- <h3>필드리스트</h3>
	<!-- board list start -->
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<select id="attrbTyCd" name="attrbTyCd" class="select">
				<option value=''>속성선택</option>
			<c:forEach var="item" items="${attrbTyCdMap}" varStatus="status">
				<option value='${item.key}' ${param.attrbTyCd eq item.key ? 'selected="selected"' : ''}>${item.key}</option>
			</c:forEach>
			</select>
			<button class="b-sh">검색</button>
		</fieldset>
	</div>
	<div>
		<table class="table table-striped table-hover">
			<caption>게시물 목록</caption>
			<colgroup>
				<col width="20%" />
				<col width="20%" />
				<col width="40%" />
				<col width="20%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">attrbTyCd</th>
					<th scope="col">name</th>
					<th scope="col">text</th>
					<th scope="col">type</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="field" items="${fieldAttributes}" varStatus="status">
					<tr>
						<td>${field.attrbTyCd}</td>
						<td>${field.fieldIemNm}</td>
						<td>${field.fieldDc}</td>
						<td>${field.fieldTyCd}</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(fieldAttributes) == 0}">
					<tr>
						<td colspan="4">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
</form>

<h3>페이지생성</h3>
<div class="sh">
	<select id="attrbTyCd2" name="attrbTyCd" class="select">
		<option value=''>속성선택</option>
	<c:forEach var="item" items="${attrbTyCdMap}" varStatus="status">
		<option value='${item.key}' ${param.attrbTyCd eq item.key ? 'selected="selected"' : ''}>${item.key}</option>
	</c:forEach>
	</select>
	<a class="b-open" href="javascript:void(0);" onclick="pop();" target="_blank"><span>필드속성팝업</span></a>
	<a class="b-reg" href="javascript:void(0);" onclick="createPage();"><span>페이지생성</span></a>
</div> --%>

