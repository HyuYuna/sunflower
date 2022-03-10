<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

<script>
	$(".relmSeBtn").on('click',function() {
		var relmSeCd = $(this).attr("data-relmSeCd");
		var mainCntntsCd = $(this).attr("data-mainCntntsCd");
		var url = "/bos/main/userMainCntnts/mainPopup.do";
		var params = "?viewType=BODY&relmSeCd="+relmSeCd + "&mainCntntsCd=" + mainCntntsCd;
		window.open(url+params,"mainRelmPopup","width=780, height=450");
		return false;
	});

	$(".delRelmSeBtn").on('click',function() {
		var mainCntntsCd = $(this).attr("data-mainCntntsCd");
		if (mainCntntsCd == "") {
			alert("삭제 할 콘텐츠가 존재하지 않습니다.");
			return false;
		}
		if (!confirm("삭제하시겠습니까?")) return false;
		var url = "/bos/main/userMainCntnts/delete.json";
		var params = {
			relmSeCd : $(this).attr("data-relmSeCd")
		};
		$.post(url,params,function(data) {
			if (data.resultCode == "success") {
				alert("삭제되었습니다.");
				window.location.reload();
			}
			else {
				alert("삭제가 실패하였습니다.");
			}
		},"json");
		return false;
	});
</script>



<div class="mainadminSetting">
	<div class="left">
		<h2 class="bu2">상단비쥬얼영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="01" />
		</jsp:include>

		<h2 id="maincontentarea1" class="bu2">상단좌측 콘텐츠영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="02" />
		</jsp:include>


		<h2 id="maincontentarea2" class="bu2">상단중앙 콘텐츠영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="03" />
		</jsp:include>


		<h2 id="maincontentarea3" class="bu2">상단우측 콘텐츠영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="04" />
		</jsp:include>


		<h2 id="maincontentarea4" class="bu2">하단좌측 콘텐츠영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="05" />
		</jsp:include>

		<h2 id="maincontentarea5" class="bu2">하단중앙 콘텐츠영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="06" />
		</jsp:include>

		<h2 id="maincontentarea6" class="bu2">하단우측 콘텐츠영역</h2>
		<jsp:include page="/WEB-INF/jsp/bos/main/userMainCntnts/incMainForm.jsp">
			<jsp:param name="relmSeCd" value="07" />
		</jsp:include>
	</div>

	<div class="right">
		<a href="#mainvisual1" class="visual">
			<c:choose>
			<c:when test="${relmSeCd01.useAt eq 'Y' and not empty fileMap[relmSeCd01.atchFileId] }">
				<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd01.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd01.streFileNm}'/>" alt="${relmSeCd01.fileCn}" width="256" height="77" />
			</c:when>
			<c:otherwise>
				<span class="nocontents">No Contents</span>
			</c:otherwise>
			</c:choose>
			<span class="sr-only">메인 비주얼 변경</span>
		</a>
		<div class="set">
			<a href="#maincontentarea1" class="c1">
				<c:choose>
				<c:when test="${not empty relmSeCd02 and relmSeCd02.useAt eq 'Y'}">
					<c:choose>
					<c:when test="${relmSeCd02.mainCntntsCd eq  '03'}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd02.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd02.streFileNm}'/>" alt="${relmSeCd02.fileCn}" width="80" height="77" />
					</c:when>
					<c:when test="${relmSeCd02.mainCntntsCd eq  '04'}">
						<span class="nocontents">알림영역</span>
					</c:when>
					<c:otherwise>
						<span class="nocontents">BBS</span>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><span class="nocontents">No<br> Contents</span></c:otherwise>
				</c:choose>
				<span class="sr-only">상단좌측 콘텐츠 변경</span>
			</a>
			<a href="#maincontentarea2" class="c2">
				<c:choose>
				<c:when test="${not empty relmSeCd03 and relmSeCd03.useAt eq 'Y'}">
					<c:choose>
					<c:when test="${relmSeCd03.mainCntntsCd eq  '03'}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd03.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd03.streFileNm}'/>" alt="${relmSeCd03.fileCn}" width="80" height="77" />
					</c:when>
					<c:when test="${relmSeCd03.mainCntntsCd eq  '04'}">
						<span class="nocontents">알림영역</span>
					</c:when>
					<c:otherwise>
						<span class="nocontents">BBS</span>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><span class="nocontents">No<br> Contents</span></c:otherwise>
				</c:choose>
				<span class="sr-only">상단중앙 콘텐츠 변경</span>
			</a>
			<a href="#maincontentarea3" class="c3">
				<c:choose>
				<c:when test="${not empty relmSeCd04 and relmSeCd04.useAt eq 'Y'}">
					<c:choose>
					<c:when test="${relmSeCd04.mainCntntsCd eq  '03'}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd04.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd04.streFileNm}'/>" alt="${relmSeCd04.fileCn}" width="80" height="77" />
					</c:when>
					<c:when test="${relmSeCd04.mainCntntsCd eq  '04'}">
						<span class="nocontents">알림영역</span>
					</c:when>
					<c:otherwise>
						<span class="nocontents">BBS</span>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><span class="nocontents">No<br> Contents</span></c:otherwise>
				</c:choose>
				<span class="sr-only">상단우측 콘텐츠 변경</span>
			</a>
			<a href="#maincontentarea4" class="c4">
				<c:choose>
				<c:when test="${not empty relmSeCd05 and relmSeCd05.useAt eq 'Y'}">
					<c:choose>
					<c:when test="${relmSeCd05.mainCntntsCd eq  '03'}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd05.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd05.streFileNm}'/>" alt="${relmSeCd05.fileCn}" width="80" height="77" />
					</c:when>
					<c:when test="${relmSeCd05.mainCntntsCd eq  '04'}">
						<span class="nocontents">알림영역</span>
					</c:when>
					<c:otherwise>
						<span class="nocontents">BBS</span>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><span class="nocontents">No<br> Contents</span></c:otherwise>
				</c:choose>
				<span class="sr-only">하단좌측 콘텐츠 변경</span>
			</a>
			<a href="#maincontentarea5" class="c5">
				<c:choose>
				<c:when test="${not empty relmSeCd06 and relmSeCd06.useAt eq 'Y'}">
					<c:choose>
					<c:when test="${relmSeCd06.mainCntntsCd eq  '03'}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd06.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd06.streFileNm}'/>" alt="${relmSeCd06.fileCn}" width="80" height="77" />
					</c:when>
					<c:when test="${relmSeCd06.mainCntntsCd eq  '04'}">
						<span class="nocontents">알림영역</span>
					</c:when>
					<c:otherwise>
						<span class="nocontents">BBS</span>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><span class="nocontents">No<br> Contents</span></c:otherwise>
				</c:choose>
				<span class="sr-only">하단중앙 콘텐츠 변경</span>
			</a>
			<a href="#maincontentarea6" class="c6">
				<c:choose>
				<c:when test="${not empty relmSeCd07 and relmSeCd07.useAt eq 'Y'}">
					<c:choose>
					<c:when test="${relmSeCd07.mainCntntsCd eq  '03'}">
					<img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${relmSeCd07.fileStreCours}'/>&amp;streFileNm=<util:seedEncrypt str='${relmSeCd07.streFileNm}'/>" alt="${relmSeCd07.fileCn}" width="80" height="77" />
					</c:when>
					<c:when test="${relmSeCd07.mainCntntsCd eq  '04'}">
						<span class="nocontents">알림영역</span>
					</c:when>
					<c:otherwise>
						<span class="nocontents">BBS</span>
					</c:otherwise>
					</c:choose>
				</c:when>
				<c:otherwise><span class="nocontents">No<br> Contents</span></c:otherwise>
				</c:choose>
				<span class="sr-only">하단우측 콘텐츠 변경</span>
			</a>
		</div>
		<a href="/ucms/main/main.do" target="_blank" title="새창열림" class="preview">미리보기</a>
	</div>
</div>

<script>

$(window).scroll(function(event) {
	$('.mainadminSetting .right').stop().animate({
		'top':$(window).scrollTop()
	}, 500)
});
</script>
