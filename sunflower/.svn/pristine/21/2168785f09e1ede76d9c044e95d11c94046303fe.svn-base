<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<c:if test="${not empty masterVO.aditCntntsCn }">
<div>
	<util:out escapeXml="false">${masterVO.aditCntntsCn}</util:out>
</div>
</c:if>

<div class="photoListTop">
	<form name="frm" action="/ucms/bbs/${paramVO.bbsId}/list.do" method="get" class="shSet">
		<input type="hidden" name="menuNo" value="${param.menuNo}">

		<fieldset class="sh">
			<legend>검색</legend>
			<div class="bbsSchArea">
				<select id="stributary" name="searchCnd" class="inpSel" title="검색조건">
			   		<option value="1" <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if> >제목</option>
			   		<option value="4" <c:if test="${paramVO.searchCnd eq '4'}">selected="selected"</c:if> >작성자</option>
			   		<option value="2" <c:if test="${paramVO.searchCnd eq '2'}">selected="selected"</c:if> >내용</option>
			   		<option value="3" <c:if test="${paramVO.searchCnd eq '3'}">selected="selected"</c:if> >제목+내용</option>
				</select>
				<input title="검색어" class="searchWrd" name="searchWrd" value="${paramVO.searchWrd}" type="text">
				<button class="b-sh">검색</button>
			</div>
		</fieldset>
	</form>
	<div class="photoType">
		<button type="button" class="imgType active"><span class="sr-only">이미지보기</span></button>
		<button type="button" class="textType"><span class="sr-only">텍스트보기</span></button>
	</div>
</div>
<script>
	$('.photoType .imgType').on('click',function(event) {
		$('.photoList').addClass('photoListTypeText');
		$(this).addClass('active').siblings().removeClass('active');
	});
	$('.photoType .textType').on('click',function(event) {
		$('.photoList').removeClass('photoListTypeText')
		$(this).addClass('active').siblings().removeClass('active');
	});
</script>
<div class="photoList photoListTypeText">
	<c:set var="pQueryStr"><util:replaceAll string="${pageQueryString}" pattern="&?nttId=[0-9]*" replacement="" /></c:set>
	<ul>
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<a href="/ucms/bbs/${paramVO.bbsId}/view.do?nttId=${result.nttId}&${pQueryStr}" class="img">
				<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" alt="${result.nttSj}" height="169" width="230">
			</a>
			<dl>
				<dt>
				<span class="date"><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></span>
				<span>${result.nttSj}</span>
				</dt>
				<dd>
					<c:choose>
						<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.nttCn}</util:out></c:when>
						<c:otherwise>
							<% pageContext.setAttribute("crlf", "\n"); %>
							${fn:replace(result.nttCn, crlf, "<br/>")}
						</c:otherwise>
					</c:choose>
				</dd>
			</dl>
		</li>
	</c:forEach>
	<c:if test="${fn:length(resultList) == 0}">
		<li class="nodata">게시글이 존재하지 않습니다.</li>
	</c:if>
	</ul>
</div>
<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>