<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<script>
$(document).ready(function(){
	var strKey = '${paramVO.searchKwd}'; // 하이라이트를 적용할 스트링
	if(strKey != ''){
		$('.tit').highlight(strKey); //line class에 해당하는 요소들에서 strKey 값들을 하이라이트 처리
	}
});

function sortOrdrBtn(ntcnNo, option) {
	$.post(
		"/bos/siteManage/ntcnRelm/updateSortOrdr.json",
		{ntcnNo:ntcnNo,option:option,pSiteId:"${paramVO.pSiteId}"},
		function(data) {
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	)
}

function updateUseAt(ntcnNo, useAt) {
	if (useAt == "Y") {
		$("#useAt").val('N');
	} else {
		$("#useAt").val('Y');
	}
	$.post(
		"/bos/siteManage/ntcnRelm/updateUseAt.json",
		{ntcnNo:ntcnNo,useAt:$("#useAt").val()},
		function(data) {
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	)
}

</script>
<!-- 게시판 게시물검색 start -->
<form  id="frm" name="frm" action="/bos/siteManage/ntcnRelm/list.do" method="get">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="pSiteId" value="${param.pSiteId}">
	<input type="hidden" name="type" value="01">

	<div class="sh">
		<fieldset>
			<legend>게시물검색</legend>
			<select name="searchUseAt" id="searchUseAt" title="사용여부">
				<option value=''>사용여부</option>
				<option value='Y' <c:if test="${param.searchUseAt == 'Y'}">selected="selected"</c:if>>사용</option>
				<option value='N' <c:if test="${param.searchUseAt == 'N'}">selected="selected"</c:if>>미사용</option>
			</select>
			<input type="text" title="검색어" name="searchKwd" value='${paramVO.searchKwd}' />
			<button class="b-sh">검색</button>
			<a href="/bos/siteManage/ntcnRelm/list.do?pSiteId=${param.pSiteId}&menuNo=${param.menuNo}" class="b-reset">초기화</a>
		</fieldset>
	</div>
</form>

<div>
	<table class="table table-striped table-hover">
		<caption>알림영역관리 목록</caption>
		<thead>
			<tr>
				<th style="width:52px" 	scope="col">번호</th>
				<th style="width:166px" scope="col">이미지</th>
				<th	scope="col">제목</th>
				<th style="width:180px"	scope="col">노출기간</th>
				<th style="width:157px" scope="col">노출순서</th>
				<th style="width:6%" 	scope="col">사용</th>
			</tr>
		</thead>
		<tbody>

			<c:forEach items="${resultList}" var="item" varStatus="status">
			<c:set var="files" value="${fileMap[item.atchFileId]}" />
			<c:forEach var="fileList" items="${files }">
				<c:if test="${fileList.fileFieldNm eq 'imgFile_1' }">
				 	<c:set var ="fileVO" value="${fileList }" />
				</c:if>
			</c:forEach>
			<tr>
				<%-- <td><input type="checkbox" name="nttIdData" id="nttIdData_${result.nttId}" class="input_check" value="${result.nttId}" /></td> --%>
				<!-- 번호 -->
				<td>
					${(resultCnt) - (paramVO.recordCountPerPage * (paramVO.pageIndex-1))}
				</td>
				<!-- 구분 -->
				<%-- <td>
					<strong>
					${item.category_nm}
					</strong>
				</td> --%>
				<!-- 이미지-->
				<td>
					<c:if test="${not empty item.atchFileId}">
					<a href="/bos/siteManage/ntcnRelm/forUpdate.do?ntcnNo=${item.ntcnNo}&${pageQueryString}" style="max-width:350px;display:block">
						<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileVO.fileStreCours}/thumb'/>&streFileNm=<util:seedEncrypt str='${fileVO.streFileNm}'/>" width="150" height="145" alt="${item.ntcnNm}" />
					</a>
					</c:if>
				</td>
				<%-- 알림 URL
				<td class="tal">
					<a href="${item.alert_url}" target="_blank" alt="새창"><util:head value="${item.alert_url}" length="100" /></a>
				</td>
				--%>
				<!-- 제목 -->
				<td class="tit">
					<a href="/bos/siteManage/ntcnRelm/forUpdate.do?ntcnNo=${item.ntcnNo}&${pageQueryString}">${item.ntcnNm}</a>
				</td>
				<%-- <!-- 게시기간 -->
				<td>
					${item.pub_sdate}
					~
					${item.pub_edate}
				</td> --%>
				<td>
					<fmt:formatDate value="${item.bgnde}" pattern="yyyy-MM-dd"/> ~
					<fmt:formatDate value="${item.endde}" pattern="yyyy-MM-dd"/>
				</td>
				<!-- 노출순서 -->
				<td>
					<span class="btn-group">
						<button type="button" class="b-default" onclick="sortOrdrBtn('${item.ntcnNo}',1);"><i class="fa fa-angle-double-up"></i><span class="sr-only">노출순서 맨 처음으로 이동</span></button>
						<button type="button" class="b-default" onclick="sortOrdrBtn('${item.ntcnNo}',2);"><i class="fa fa-angle-up"></i><span class="sr-only">노출순서 한단계 위로 이동</span></button>
						<button type="button" class="b-default" onclick="sortOrdrBtn('${item.ntcnNo}',3);"><i class="fa fa-angle-down"></i><span class="sr-only">노출순서 한단계 밑으로 이동</span></button>
						<button type="button" class="b-default" onclick="sortOrdrBtn('${item.ntcnNo}',4);"><i class="fa fa-angle-double-down"></i><span class="sr-only">노출순서 맨 끝으로 이동</span></button>
					</span>
				</td>
				<!-- 표시 여부 -->
				<td>
					<button type="button" onclick="updateUseAt('${item.ntcnNo}','${item.useAt}')" class="<c:if test='${item.useAt eq "Y" }'>b-view</c:if><c:if test='${item.useAt eq "N" }'>b-disabled</c:if>">${item.useAt eq 'Y' ? '사용중' : '미사용중'}</button>
					<input type="hidden" id="useAt" name="useAt" value="" />
				</td>
			</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="6" class="tac">데이터가없습니다.</td></tr></c:if>
		</tbody>
	</table>
</div>
<!-- board list end //-->
<div class="btnSet">
	<a class="b-reg" href="/bos/siteManage/ntcnRelm/forInsert.do?${pageQueryString}"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
${pageNav}
</c:if>