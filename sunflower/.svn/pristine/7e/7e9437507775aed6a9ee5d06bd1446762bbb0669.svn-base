<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO"/>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
</form>
<c:if test="${not empty masterVO.aditCntntsCn }">
<div>
	<util:out escapeXml="false">${masterVO.aditCntntsCn}</util:out>
</div>
</c:if>
<div class="view">
	<h2 class="subject">
		${result.nttSj}
	</h2>
	<dl>
		<dt>작성일</dt>
		<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
		<dt>작성자</dt>
		<dd>${result.ntcrNm}</dd>
		<dt>조회수</dt>
		<dd>${result.inqireCo}</dd>
	</dl>
	<div class="photoView">
		 <div class="sliderMc">
			<div class="thumbs" id="vsThumbs">
			 	<c:forEach var="file" items="${fileList}" varStatus="status">
					<div><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${file.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${file.streFileNm}'/>" width="596" alt="${result.nttSj} 관련사진 ${status.count}" /></div>
				</c:forEach>
			</div>
			<div class="thumbsList" id="thumbsList">
				<ul>
		 		<c:forEach var="file" items="${fileList}" varStatus="status">
					<li> <a href="#self"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${file.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${file.streFileNm}'/>"  alt="${result.nttSj} 관련사진 ${status.count} 보기" /></a></li>
				</c:forEach>
				</ul>
			</div>
			<div class="sliderMcCtrl">
				<a href="#self" class="prevVs"><span class="hidden">이전 배너 보기</span></a>
				<a href="#self" class="nextVs"><span class="hidden">다음 배너 보기</span></a>
			</div>
			<script src="/js/jquery.carouFredSel-6.2.1-packed.js"></script>
			<script>

				$(function() {
					 $('#thumbsList ul').find( 'li:eq(0)' ).addClass( 'on' );

					 $('#thumbsList ul').carouFredSel({
					 	width:596,
						items		:{
							visible : 4
						},
						direction: 'up',
						scroll      :{
							items		:1,
							pauseOnHover	: true
						},
						auto: {
							play: false,
							duration: 750,
							timeoutDuration: 8000,
							easing: 'quadratic',
							onBefore: function() {
								var index = $(this).triggerHandler( 'currentPosition' );
								if ( index == 0 ) {
									index = $(this).children().length;
								}
								$('#vsThumbs').trigger('slideTo', [ index, {
									fx: 'directscroll'
								}, 'prev' ]);
								 $('#thumbsList ul').find( 'li' ).removeClass( 'on' );
								 $('#thumbsList ul').find( 'li:eq(1)' ).addClass( 'on' );
								 //console.log("index : "+index);
							},
							onAfter:function(){
							},
						},
						next : ".nextVs",
						prev : ".prevVs"
					 });
					var thumbsList = $('#thumbsList ul li');
					thumbsList.on("click", function(){
						var index =  thumbsList.index(this);
						var directStr = "prev";
						if (index%2 == 0) directStr = "next";
						$('#vsThumbs').trigger('slideTo', [ index, {
							fx: 'directscroll'
						}, directStr ]);


						 $('#thumbsList ul').find( 'li' ).removeClass( 'on' );
						 $(this).addClass( 'on' );

						 //console.log("index : "+index);

					});
					 $('#vsThumbs').carouFredSel({
						items: 1,
						direction: 'left',
						width:596,
						height:533,
						scroll :{
							items : 1
						},
						auto: {
							play: false,
							duration: 750,
							easing: 'directscroll'
						}
					 });
				});
			</script>
		</div>
	</div>
	<div class="dbData">
		<c:choose>
			<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.nttCn}</util:out></c:when>
			<c:otherwise>
				<% pageContext.setAttribute("crlf", "\n"); %>
				${fn:replace(result.nttCn, crlf, "<br/>")}
			</c:otherwise>
		</c:choose>
	</div>
</div>
<div class="btnSet">
	<a href="/ucms/bbs/${paramVO.bbsId}/list.do?${pageQueryString}" class="b-list">목록</a>
</div>

<c:if test="${masterVO.prevNextPosblAt eq 'Y'}">
<div class="bdViewNav">
	<dl>
		<dt>윗글</dt>
		<dd>
	<c:choose>
		<c:when test="${prevNextMap.prevNttId > 0}">
			<a href="/ucms/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.prevNttId}&${pageQueryString}">${prevNextMap.prevNttSj}</a>
		</c:when>
		<c:otherwise><span>이전글이 없습니다.</span></c:otherwise>
	</c:choose>
		</dd>
	</dl>
	<dl>
		<dt class="n">아랫글</dt>
		<dd>
	<c:choose>
		<c:when test="${prevNextMap.nextNttId > 0}">
			<a href="/ucms/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.nextNttId}&${pageQueryString}">${prevNextMap.nextNttSj}</a>
		</c:when>
		<c:otherwise><span>다음글이 없습니다.</span></c:otherwise>
	</c:choose>
		</dd>
	</dl>
</div>
</c:if>

<c:if test="${masterVO.cmPosblAt eq 'Y'}">
	<c:import url="/${paramVO.siteId }/bbs/bbsCm/commentForm.do?viewType=CONTBODY">
		<c:param name="bbsId" value="${result.bbsId }" />
		<c:param name="nttId" value="${result.nttId }" />
		<c:param name="cmSe" value="${paramVO.programId }" />
	</c:import>
</c:if>