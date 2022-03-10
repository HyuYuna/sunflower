<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
$(function(){
	$(":input[id^=update_]").on('click',function(){
		var pageCode = this.id.replace("update_", "");
		location.href = "/bos/pg/readPage.do?menuNo=${param.menuNo}&pageCode=" + pageCode;
	});
	$(":input[id^=delete_]").on('click',function(){
		if( confirm("정말로 삭제하시겠습니까?") ){
			var pageCode = this.id.replace("delete_", "");
			location.href = "/bos/pg/deletePageAttr.do?menuNo=${param.menuNo}&pageCode=" + pageCode;
		}
	});
});
</script>

<form id="frm" name="frm" action ="/bos/pg/pageAttrList.do?menuNo=${param.menuNo}" method="post">
	<input type="hidden" name="bbsId" value="${param.menuNo}" />
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
					<th scope="col">게시판속성코드</th>
					<th scope="col">게시판속성명</th>
					<th scope="col">관리</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${status.count}</td>
					<td>             <a href="/bos/pg/readPage.do?pageCode=${result.pageCode}&amp;bbsId=${param.bbsId}&amp;menuNo=${param.menuNo}">${result.pageCode}</a></td>
					<td class="tit"> <a href="/bos/pg/readPage.do?pageCode=${result.pageCode}&amp;bbsId=${param.bbsId}&amp;menuNo=${param.menuNo}">${result.pageName}</a></td>
					<td>
						<button type="button" class="mr20 btn btn-success btn-xs"  id="update_${result.pageCode}" name="update" >수정</button>
						<button type="button" class="btn btn-xs btn-danger" id="delete_${result.pageCode}" name="delete" >삭제</button>
					</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="4">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btnSet">
		<a class="b-reg" href="/bos/pg/regPage.do?menuNo=${param.menuNo}"><span>등록</span></a>
	</div>

</form>
