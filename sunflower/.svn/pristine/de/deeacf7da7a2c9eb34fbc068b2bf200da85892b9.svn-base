<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
function goSearch(frm) {
	if(frm.sdate.value > frm.edate.value) {
		alert("기간을 올바르게 선택해주세요.");
		frm.sdate.value = "";
		frm.edate.value = "";
		$('#sdate').focus();
		return false;
	}
}
</script>
<form name="frm" id="frm" method="get" action="/bos/bbs/${paramVO.bbsId}/list.do" onsubmit="return goSearch(this);">
	<input type="hidden" name="menuNo" value="${param.menuNo}">
	<input type="hidden" name="bbsId">
	<input name="pageIndex" type="hidden" value="${paramVO.pageIndex}"/>
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<span class="shDate">
			<input id="sdate" name="sdate" class="sdate" title="검색기간 시작일" value="${param.sdate}" type="text" readonly="readonly"> ~
			<input id="edate" name="edate" class="edate" title="검색기간 종료일" value="${param.edate}" type="text" readonly="readonly">
			</span>
			<label for="searchCnd">구분</label>
				<select id="searchCnd" name="searchCnd" class="select">
					<option value="1" <c:if test="${paramVO.searchCnd == '1'}">selected="selected"</c:if> >제목</option>
					<option value="4" <c:if test="${paramVO.searchCnd == '4'}">selected="selected"</c:if> >작성자</option>
					<option value="2" <c:if test="${paramVO.searchCnd == '2'}">selected="selected"</c:if> >내용</option>
					<option value="3" <c:if test="${paramVO.searchCnd == '3'}">selected="selected"</c:if> >제목+내용</option>
				</select>
				<input type="text" title="검색어" name="searchWrd" value='${paramVO.searchWrd}'/>
				<button type="submit" class="b-sh">검색</button>
				<a href="/bos/bbs/${paramVO.bbsId}/list.do?menuNo=${param.menuNo}" class="b-reset">초기화</a>
				<button type="reset">초기화</button>
		</fieldset>
	</div>
</form>
<c:set var="pQueryStr">
	<util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" />
</c:set>
<div class="galleryList">
	<ul>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<div>
				<a href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pQueryStr}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" height="210" alt="${empty result.fileCn ? result.nttSj : result.fileCn}">
					<span class="tit">${result.nttSj}</span>
					<c:if test="${result.newYn eq 'Y'}"><span class="ico-new"><span class="sr-only">새글</span></span></c:if>
					<span class="time"><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></span>
				</a>
			</div>
		</li>
	</c:forEach>
	</ul>
</div>

<div class="btnSet">
	<a class="b-reg" href="/bos/bbs/${paramVO.bbsId}/forInsert.do?${pageQueryString}"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>