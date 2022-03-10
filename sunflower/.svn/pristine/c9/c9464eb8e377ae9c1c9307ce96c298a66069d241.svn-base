<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<%
	String relmSeCd = request.getParameter("relmSeCd");
	Object obj = request.getAttribute("relmSeCd" + relmSeCd);
	request.setAttribute("relmSeVO", obj);
%>

<c:set var="relmSe" value="${relmSeVO }" />
<c:set var="mainCntntsCd" value="${relmSe.mainCntntsCd }" />
<c:set var="bbsIdSet" value="" />
<c:if test="${not empty relmSe and relmSe.useAt eq 'Y'}">
<c:choose>
	<c:when test="${mainCntntsCd eq '01' }">
		<c:if test="${relmSe.bbsAttrbCd eq 'PG0002' }">
			<div class="type-gallery">
			<c:set var="bbsList" value="${relmSe.bbsList }" />
			<c:if test="${fn:length(bbsList) > 0 }">
			<h2>${relmSe.menuNm }</h2>
			<c:forEach items="${bbsList }" var="result" varStatus="status">

			<img  src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" alt="${result.fileCn}">
			<a href="/ucms/bbs/${relmSe.bbsId }/view.do?nttId=${result.nttId }&amp;menuNo=${relmSe.menuNo }">
				${result.nttSj }
			</a>
			</c:forEach>
			</c:if>
			</div>
		</c:if>

		<c:if test="${relmSe.bbsAttrbCd ne 'PG0002' }">
			<div class="type-notice">
			<h2>${relmSe.menuNm }</h2>
			<ul>
			<c:set var="bbsList" value="${relmSe.bbsList }" />
			<c:forEach items="${bbsList }" var="result" varStatus="status">
			<c:set var="bbsIdSet" value="${result.bbsId }" />
				<c:choose>
				<c:when test="${status.index == 0 }">
					<li class="top">
						<a href="/ucms/bbs/${result.bbsId }/view.do?nttId=${result.nttId }&amp;menuNo=${relmSe.menuNo }">
							<c:if test="${result.imageAt eq 'Y' }">
							<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" alt="${fileMap[result.atchFileId][0].fileCn} 이미지">
							</c:if>
							<span class="set">
								<p class="t">${result.nttSj }</p>
								<p><util:noTagStr length="100" value="${result.nttCn }" /></p>
							</span>
						</a>
					</li>
				</c:when>
				<c:otherwise>
					<li><a href="/ucms/bbs/${result.bbsId }/view.do?nttId=${result.nttId }&amp;menuNo=${relmSe.menuNo }"><span class="txt">${result.nttSj }</span><span class="date">${result.registDt }</span></a></li>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${fn:length(relmSe.bbsList) == 0 }">
				<li>등록된 게시물이 존재하지 않습니다.</li>
			</c:if>
			</ul>
			<a href="/ucms/bbs/${bbsIdSet }/list.do?menuNo=${relmSe.menuNo }" class="btnMore"><span class="sr-only">더보기</span></a>
			</div>
		</c:if>
	</c:when>

	<c:when test="${mainCntntsCd eq '03' }">
		<div class="type-link">
		<a href="${relmSe.menuLink }" <c:if test="${relmSe.popupAt eq 'Y' }">target="_blank" title="새창열림"</c:if>>
			<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${fileMap[relmSe.atchFileId][0].fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${fileMap[relmSe.atchFileId][0].streFileNm}'/>" alt="${fileMap[relmSe.atchFileId][0].fileCn}"  />
		</a>
		</div>
	</c:when>
	<c:when test="${mainCntntsCd eq '04' }">
		<c:set var="ntcnRelmList" value="${relmSe.ntcnRelmList }" />
		<div class="popupZone">
			<div class="area">
				<c:if test="${fn:length(ntcnRelmList) > 0 }">
				<ul>
					<c:forEach var="ntcnRelm" items="${ntcnRelmList }" varStatus="status">
					<li class="${status.index == 0 ? 'on' : ''}">
						<a href="#news-list_${status.count }" class="num"><span class="r"><span class="t">1번 최근소식 보기</span></span></a>
						<a class="view" id="news-list_${status.count }" href="${ntcnRelm.ntcnUrlad }" target="_blank" title="${ntcnRelm.ntcnNm } 새창열림">
						<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${ntcnRelm.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${ntcnRelm.streFileNm}'/>" alt="${ntcnRelm.fileCn}">
						</a>
					</li>
					</c:forEach>

				</ul>
				</c:if>

			</div>
			<script src="/static/jslibrary/jquery.slideCtrl.js"></script>
			<script>
				jQuery(".news").slideCtrl({
					photo_list		: jQuery('.popupZone>.area li'),
					photo_list_left	: jQuery('.popupZone_pre'),
					photo_list_right: jQuery('.popupZone_next'),
					photo_list_play	: jQuery(".popupZone_play"),
					photo_list_stop	: jQuery(".popupZone_stop"),
					FXconfig		: true,
					d_time			: 6000,
					debug			: true
				});
			</script>
		</div>
	</c:when>
</c:choose>

</c:if>