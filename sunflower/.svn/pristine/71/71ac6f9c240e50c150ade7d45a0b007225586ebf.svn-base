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
	function del(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delete.do";
		form.submit();
	}

	function restore(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/restore.do";
		form.submit();
	}

	function delPermanently(){
		var form = $("#board")[0];
		form.action = "/bos/bbs/${paramVO.bbsId}/delPermanently.do";
		form.submit();
	}

</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}"/>
	<input type="hidden" name="nttId" value="${empty result.nttId ? 0 : result.nttId }" />
	<input type="hidden" name="bbsId" value="${masterVO.bbsId}" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>

	<div class="galleryView">
		<h2>${result.nttSj}</h2>
		<div>
			<dl>
				<dt>조회수 :</dt>
				<dd class="wid">${result.inqireCo}</dd>
				<dt>등록일시 :</dt>
				<dd><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></dd>
			</dl>
		</div>
		<div class="photoView">
			 <div class="sliderMc">
				<div class="thumbs" id="vsThumbs">
			 	<c:forEach var="file" items="${fileList}" varStatus="status">
					<div> <img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${file.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${file.streFileNm}'/>" width="596" alt="" /></div>
				</c:forEach>
				</div>
				<div class="thumbsList" id="thumbsList">
					<ul>
			 		<c:forEach var="file" items="${fileList}" varStatus="status">
						<li> <button type="button"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${file.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${file.streFileNm}'/>"  alt="" /></button></li>
					</c:forEach>
					</ul>
				</div>
				<div class="sliderMcCtrl">
					<a href="#self" class="prevVs"><span class="hidden">이전 이미지 보기</span></a>
					<a href="#self" class="nextVs"><span class="hidden">다음 이미지 보기</span></a>
				</div>
				<script src="/static/jslibrary/jquery.carouFredSel-6.2.1/jquery.carouFredSel-6.2.1-packed.js"></script>
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
			<div class="dbData">
				<c:choose>
					<c:when test="${result.htmlAt=='Y'}"><util:out escapeXml="false">${result.nttCn}</util:out></c:when>
					<c:otherwise>
						<% pageContext.setAttribute("crlf", "\n"); %>
						${fn:replace(result.nttCn, crlf, "<br/>")}
					</c:otherwise>
				</c:choose>
			</div>

			<div>
				<ul>
				<c:forEach var="file" items="${fileList}" varStatus="status">
					<li style="float:left;padding-right:20px;">
						<input type="checkbox" name="zipFileSn" value="${file.fileSn }" >
						<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${file.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${file.streFileNm}'/>" width="100" alt="" />
					</li>
				</c:forEach>
				</ul>
			</div>
			<div style="clear:both;"><a href="#" id="zipDownBtn" class="btn btn-default">선택다운로드</a></div>

			<script>
				$("#zipDownBtn").on('click',function() {
					if ($("input[name=zipFileSn]:checked").length == 0) {
						alert("다운받으실 이미지를 선택하세요.");
						return false;
					}

					var fileSnArr = [];
					var fileSnListStr = "";
					$("input[name=zipFileSn]:checked").each(function(index) {
						fileSnArr.push($(this).val());
					});

					fileSnListStr = fileSnArr.join(",");
					location.href = "/${paramVO.siteId}/cmmn/file/zipFileDown.do?atchFileId=" + $("#atchFileId0").val() + "&fileSnListStr=" + fileSnListStr;
					return false;
				});
			</script>
		</div>
	</div>
</form>


<div class="btnSet">
	<c:if test="${masterVO.prevNextPosblAt eq 'Y'}">
	<div class="fl">
		<c:if test="${result.deleteCd eq '1'}">
			<a class="b-del" href="javascript:delPermanently();" onclick="return confirm('정말로 영구삭제하시겠습니까?');">영구삭제</a>
		</c:if>

		<c:if test="${prevNextMap.prevNttId > 0}">
		<a class="b-prev" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.prevNttId}&${pageQueryString}">이전글</a>
		</c:if>
		<c:if test="${prevNextMap.nextNttId > 0}">
		<a class="b-next" href="/bos/bbs/${paramVO.bbsId}/view.do?nttId=${prevNextMap.nextNttId}&${pageQueryString}">다음글</a>
		</c:if>
	</div>
	</c:if>
	<div class="fr" >
		<a class="b-edit" href="/bos/bbs/${paramVO.bbsId}/forUpdate.do?nttId=${result.nttId}&${pageQueryString}">수정</a>
	<c:if test="${result.deleteCd eq '0' }" >
		<a class="b-del" href="javascript:del();" onclick="return confirm('정말로 삭제하시겠습니까?');">삭제</a>
	</c:if>
	<c:if test="${result.deleteCd eq '1' }" >
		<a class="b-edit" href="javascript:restore();" onclick="return confirm('정말로 복구하시겠습니까?');">원글복구</a>
	</c:if>
		<a class="b-list" href="/bos/bbs/${paramVO.bbsId}/list.do?${pageQueryString}">목록</a>
	</div>
</div>

<c:if test="${masterVO.cmPosblAt eq 'Y'}">

	<c:import url="/${paramVO.siteId }/bbs/bbsCm/commentForm.do?viewType=CONTBODY">
		<c:param name="bbsId" value="${result.bbsId }" />
		<c:param name="cmSe" value="${paramVO.programId }" />
	</c:import>
</c:if>


