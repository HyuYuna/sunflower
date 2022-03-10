<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<script>
<%--
function del(){
	var act = "/bos/bbs/${paramVO.bbsId}/delete.json";
	if( "${paramVO.delcode}" == "1" ){
		act = "/bos/bbs/${paramVO.bbsId}/delPermanently.json";
	}
	if($(":checkbox:checked").length == 0)
	{
		alert("삭제할 게시물을 선택하세요.");
		return;
	}
	if( !confirm("정말로 삭제하시겠습니까?") ){
		return;
	}
	var inData = $("#frm").serialize();
	$.post(
		act,
		inData,
		function(data){
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	);
}
--%>
	$(function() {
		var strKey = '${paramVO.searchWrd}'; // 하이라이트를 적용할 스트링

		 if(strKey != ''){

			$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리

		 }

		<c:if test="${paramVO.delcode eq '1'}">
		$(".contMenuNm").text($(".contMenuNm").text() + "(삭제글보기)");
		</c:if>
	});


</script>

<form id="frm" name="frm" action ="/bos/bbs/${paramVO.bbsId}/list.do" method="get">
<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
<input type="hidden" name="pageQueryString" value="${pageQueryString}">
<input type="hidden" name="menuNo" value="${param.menuNo }">

		<!-- 게시판 게시물검색 start -->
		<div class="sh">
			<fieldset>
			<legend>게시물검색</legend>
				<select id="bbsSe" name="bbsSe" title="구분">
				  	<option value="">전체</option>
					<c:forEach var="code" items="${COM094CodeList}" varStatus="status">
					<option value="${code.code}" <c:if test="${param.bbsSe eq code.code}">selected="selected"</c:if>>${code.codeNm}</option>
				 	</c:forEach>
				</select>

				<label for="stributary" class="blind"></label>
				<select id="stributary" name="searchCnd" title="검색조건">
				   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
				   <option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
				</select>
				<input type="text" title="검색어" name="searchWrd" value="${paramVO.searchWrd}" />
				<span><button class="b-sh">검색</button></span>
			</fieldset>
		</div>
		<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>${masterVO.bbsNm} 목록</caption>
			<colgroup>
			<%-- <col width="5%" /> --%>
				<col width="8%" />
				<col width="8%" />
				<col width="" />
				<col width="13%" />
				<col width="13%" />
				<col width="8%" />
			</colgroup>
			<thead>
				<tr>
<%-- 					<th scope="col"><input type="checkbox" name="check-all" id="tschLfrcOrgplceCode" value="all" class="check-all" <c:if test="${zvl.check_all == 'all'}">checked="checked"</c:if> /></th> --%>
					<th scope="col">번호</th>
					<th scope="col">구분</th>
					<th scope="col">제목</th>
					<th scope="col">메인이미지</th>
					<th scope="col">등록일</th>
					<th scope="col">조회</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:set var="files" value="${fileMap[result.atchFileId]}" />
				<tr <c:if test="${result.nttType eq '1' }">class="notice"</c:if>>
<%-- 					<td><input type="checkbox" name="nttIdData" id="nttIdData_${result.nttId}" class="input_check" value="${result.nttId}" /></td> --%>
					<td>${result.nttType=='1' ? '<span>공지</span>' : (resultCnt) - (paramVO.pageSize * (paramVO.pageIndex-1))}</td>
					<td>
						<c:forEach var="code" items="${COM094CodeList}" varStatus="status">
							<c:if test="${result.bbsSe eq code.code}">${code.codeNm}</c:if>
						 </c:forEach>
					</td>
					<td class="tit">
						<a href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pageQueryString}">
						<c:choose>
							<c:when test="${result.delcode ne SearchVO.NON_DELETION}">
							<span class="del">${result.nttSj}</span>
							</c:when>
							<c:otherwise>${result.nttSj}</c:otherwise>
						</c:choose>
						<c:if test="${result.commentCnt>0}">(댓글:${result.commentCnt})</c:if>
						<c:if test="${result.replyCnt>0}">(댓글:${result.replyCnt})</c:if>
						${result.newYn=='Y'?'[new]':''}
						</a>
					</td>
			    	 <td>
			    	 <c:set var="file" value="${files }" />
					<c:forEach var="fileList" items="${file }">
						<c:if test="${fileList.fileFieldName eq 'main_image' }">
						 	<c:set var ="fileVO" value="${fileList }" />
						</c:if>
					</c:forEach>
			    		<c:if test="${not empty fileVO}">
					    	<img src='/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>'  style="width: 120px;height: 105px;" alt="${fileVO.fileCn}" />
			    		</c:if>
			    		<c:set var ="fileVO" value="" />
			    	</td>
					<td>${result.frstRegisterPnttm}</td>
					<td>${result.inqireCo}</td>
				</tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
	<%-- <div class="fl"><a class="btn btn-primary" href="javascript:del();"><span>삭제</span></a></div>--%>
	<div class="btnSet">
		<c:if test="${empty paramVO.delcode or paramVO.delcode eq '0'}">
		    <sec:authorize access="hasRole('ROLE_SUPER')">
				<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=1&amp;menuNo=${param.menuNo}"><span>삭제글보기</span></a>
		   	</sec:authorize>
				<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>글쓰기</span></a>
		</c:if>
		<c:if test="${paramVO.delcode eq '1'}">
				<a class="btn btn-primary" href="/bos/bbs/${paramVO.bbsId}/list.do?delcode=0&amp;menuNo=${param.menuNo}"><span>돌아가기</span></a>
		</c:if>
	</div>

		<!-- board list end //-->
<c:if test="${fn:length(resultList) > 0}">
${pageNav}
</c:if>


</form>
