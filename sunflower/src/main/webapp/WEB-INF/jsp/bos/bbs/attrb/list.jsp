<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	$(function() {
		$(":input[id^=update_]").on('click',function() {
			var attrbCd = this.id.replace("update_", "");
			location.href = "/bos/bbs/attrb/forUpdate.do?menuNo=${param.menuNo}&attrbCd=" + attrbCd;
		});
		$(":input[id^=delete_]").on('click',function() {
			if (confirm("정말로 삭제하시겠습니까?")) {
				var attrbCd = this.id.replace("delete_", "");
				location.href = "/bos/bbs/attrb/delete.do?menuNo=${param.menuNo}&attrbCd=" + attrbCd;
			}
		});
	});

	function createMybatisQuery() {
		var tableNm = $('#tableName option:selected').val();
		if (!tableNm) {
			alert('테이블을 선택하세요.');
			$('#tableName')[0].focus();
			return;
		}
		var inData = {attrbTyCd : "mybatis", tableNm : tableNm};
		$.post(
			"/bos/bbs/attrb/createPage.json",
			inData,
			function(data) {
				var resultCode = data.resultCode;
				if (resultCode == "success") {
					var outputPath = data.outputPath;
					alert(outputPath + '에 생성되었습니다.');
				}
			}
		);
	}
</script>

<form id="frm" name="frm" action="/bos/bbs/attrb/list.do" method="get">
	<input type="hidden" name="bbsId" value="${param.bbsId}" />${param.bbsId}
	<input type="hidden" name="menuNo" value="${param.menuNo}" />

	<!--
	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<select id="tableName" name="tableName" class="select">
				<option value='' label="테이블선택" />
				<c:forEach var="item" items="${tableList}" varStatus="status">
					<option value="${item}" ${item eq param.tableName ? 'selected="selected"' : ''}>${item}</option>
				</c:forEach>
			</select>
			<a href="javascript:list('1')" class="b-sh">검색</a>
		</fieldset>
	</div>
	 -->

	<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>게시물 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="20%" />
				<col width="40%" />
				<col width="30%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">속성코드</th>
					<th scope="col">속성명</th>
					<th scope="col">관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${status.count}</td>
						<td><a href="/bos/bbs/attrb/view.do?attrbCd=${result.attrbCd}&menuNo=${param.menuNo}">${result.attrbCd}</a></td>
						<td class="tit"><a href="/bos/bbs/attrb/view.do?attrbCd=${result.attrbCd}&menuNo=${param.menuNo}">${result.attrbNm}</a></td>
						<td>
							<button type="button" class="b-edit btn-xs" id="update_${result.attrbCd}" name="update" >수정</button>
							<button type="button" class="b-del btn-xs" id="delete_${result.attrbCd}" name="delete" >삭제</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="4">데이터가 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>
	<!-- board list end //-->

	<div class="btnSet">
		<a class="b-reg" href="/bos/bbs/attrb/forInsert.do?menuNo=${param.menuNo}"><span>등록</span></a>
	</div>

</form>
