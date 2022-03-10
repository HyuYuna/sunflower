<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
	function goSearch(frm2){
		if(frm2.confmDtSt.value > frm2.confmDtEt.value){
			alert("기간을 올바르게 선택해주세요.");
			frm2.confmDtSt.value = "";
			frm2.confmDtEt.value = "";
			return false;
		}

	}

</script>
<form id="frm2" name="frm2" method="post" action="/bos/member/user/waitManageList.do?menuNo=${param.menuNo}" onsubmit="return goSearch(this);" class="form-inline">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		<!-- 게시판 게시물검색 start -->
	<fieldset>
		<legend></legend>
			<div class="bdView mb0">
				<table>
					<tbody>
						<tr>
							<th scope="row">승인요청일시</th>
							<td>
								<input class="sdate" name="confmDtSt" readonly="readonly" value="${param.confmDtSt}" title="승인요청 시작일시 "> ~&nbsp;
								<input class="edate" name="confmDtEt" readonly="readonly" value="${param.confmDtEt}" title="승인요청 종료일시">
							</td>
							<th scope="row" ><label for="confmSttus">승인상태</label></th>
							<td>
								<select name="confmSttus" id="confmSttus" title="승인상태를 선택해 주세요.">
									<option value="">승인상태 선택</option>
									<c:forEach var="code" items="${COM070CodeList }">
										<c:if test="${code.code ne 'CONFM02' }">
									   	<option value="${code.code }" <c:if test="${param.confmSttus == code.code}">selected="selected"</c:if> >${code.codeNm }</option>
									   	</c:if>
								   	</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" >검색어</th>
							<td colspan="3">
								<select id="searchCnd" name="searchCnd" title="검색조건">
									<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >이름</option>
								   <option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >아이디</option>
								</select>
								<input type="text" class="w500" name="searchWrd" id="searchWrd" value="${paramVO.searchWrd}" />
								<span><input type="submit" class="btn btn-primary" value="검색" /></span>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
	</fieldset>
		<!-- 게시판 게시물검색 end -->

	<div class="row mt10 mb5">
		<div class="col-md-12"> 총 : <strong class="text-danger">${resultCnt }</strong>건 | <strong class="text-danger">${paramVO.pageIndex } / ${paginationInfo.totalPageCount }</strong> Page </div>
	</div>

<!-- board list start -->
	<div class="bdList">
		<table class="table table-bordered">
			<caption>회원관리 목록</caption>
			<colgroup>
				<col  />
				<col  />
				<col  />
				<col  span="2" />
				<col  />
				<col  />
				<col  />
			</colgroup>
			<thead>
				<tr>
<%--					<th>선택</th> --%>
					<th>번호</th>
					<th>회원구분</th>
					<th>성명</th>
					<th>아이디</th>
					<th>인증방식</th>
					<th>승인요청(완료)일시</th>
					<th>승인상태</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
				<c:url var="viewUrl" value="/bos/member/${fn:toLowerCase(result.mberSe) }/${result.actSe ne 'ACT02' ? 'view' : 'tmprEntrprsInfoView'}.do">
					<c:param name="menuNo" value="${param.menuNo}" ></c:param>
					<c:param name="userId" value="${result.userId}" ></c:param>
					<c:param name="searchType" value="${param.searchType}" ></c:param>
					<c:param name="searchTxt" value="${param.searchTxt}" ></c:param>
					<c:param name="pageIndex" value="${empty param.pageIndex ? '1' : param.pageIndex}" ></c:param>
					<c:param name="chgReqSn" value="${result.chgReqSn }"></c:param>
					<c:param name="waitAt" value="Y"></c:param>
				</c:url>
				<tr>
					<td>${(resultCnt) - (paginationInfo.recordCountPerPage * (paramVO.pageIndex-1))}</td>
					<td>${result.mberSeNm}</td>
					<td><a href="${viewUrl}">${result.userNm}</a></td>
					<td class="tit"><a href="${viewUrl}">${result.userId}</a></td>
					<td>${result.authSeNm}</td>
					<td>${result.confmDt}</td>
					<td>${result.confmSttusNm}</td>
				</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}" >
					<tr><td colspan="8">데이터가 없습니다.</td></tr>
				</c:if>
			</tbody>
		</table>
	</div>
<!-- board list end //-->
</form>

	<div class="btnSet">
<!-- 		<a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a> -->
	</div>

	<c:if test="${fn:length(resultList) > 0}">
	<div class="paging">
			${pageNav}
	</div>
	</c:if>
