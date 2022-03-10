<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" trimDirectiveWhitespaces="true"%>
<%@ page import="java.util.*" %>
<%@ page import="site.unp.core.util.CacheUtil"%>
<%@ page import="site.unp.cms.domain.*" %>
<%@ page import="org.springframework.util.StringUtils"%>
<%@ page import="site.unp.core.conf.GlobalsProperties"%>
<%@ page import="site.unp.core.service.sec.UnpUserDetailsHelper" %>
<%@ page import="site.unp.cms.service.siteManage.SiteInfoService" %>
<%@ page import="site.unp.cms.service.siteManage.impl.SiteInfoServiceImpl" %>
<%@ page import="site.unp.core.service.menu.MasterMenuManager"%>
<%@ page import="site.unp.cms.service.member.sec.SessionSavedRequestAwareAuthenticationHandler"%>
<%@ page import="site.unp.core.ZValue"%>
<%@ page import="site.unp.cms.service.siteManage.BannerService"%>
<%@ page import="site.unp.cms.service.siteManage.VisualService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<spring:eval expression="@prop['Globals.ucms.OsType']" var="osType" scope="request" />
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<%
	String osType = (String)request.getAttribute("osType");

	MemberVO user = (MemberVO)UnpUserDetailsHelper.getAuthenticatedUser();
	pageContext.setAttribute("userVO", user); 
    //메뉴설정 SiteMngService.UCMS_SITE_ID,
	String contextScopeMenuAllName = MasterMenuManager.CONTEXT_SCOPE_MENU_PREFIX + SiteInfoServiceImpl.UCMS_SITE_ID;
	pageContext.setAttribute("contextScopeMenuAllName", contextScopeMenuAllName);
	org.springframework.context.ApplicationContext context =
	org.springframework.web.context.support.WebApplicationContextUtils.getWebApplicationContext(getServletContext());
	HashMap<String, List<ZValue>> menuMap = (HashMap<String, List<ZValue>>)application.getAttribute(contextScopeMenuAllName);
	MasterMenuManager masterMenuManagerService = (MasterMenuManager)context.getBean("masterMenuManagerService");
	GlobalsProperties globalsProperties = (GlobalsProperties)context.getBean("globalsProperties");
	String realMode = globalsProperties.isReal() ? "Y" : "N";
	String realTp = realMode;
	BannerService bannerService = context.getBean("bannerService", BannerService.class);
	ZValue param = new ZValue();

	param.put("pSiteId",SiteInfoServiceImpl.UCMS_SITE_ID);

	List<ZValue> bannerList = bannerService.getBanner(param);
	application.setAttribute("bannerList", bannerList);
	SiteInfoService siteMngService = context.getBean("siteInfoService", SiteInfoService.class);
	ZValue site = siteMngService.getSiteBySiteName(SiteInfoServiceImpl.UCMS_SITE_ID);
	pageContext.setAttribute("siteVO", site);
%>
<c:set var="currMenu" value="${currMenu }" scope="session" />
<c:set var="userVO" value="${userVO }" scope="request" />
<c:set var="OS_TYPE" value="${osType }" />
<c:set var="topCategories" value="${menuAll_ucms['menu_0']}" />
<c:set var="curD" value="${topCategories[depth01]}" />
<c:set var="d01Category" value="${topCategories[depth01]}" />
<c:set var="d01menuKey" value="menu_${d01Category.menuNo}" />
<c:set var="curD02Categories" value="${menuAll_ucms[d01menuKey]}" />
<c:set var="curD03menuKey" value="menu_${curD02Categories[depth02].menuNo}" />
<c:set var="curD03Categories" value="${menuAll_ucms[curD03menuKey]}" />
<c:set var="curD04menuKey" value="menu_${curD03Categories[depth03].menuNo}" />
<c:set var="curD04Categories" value="${menuAll_ucms[curD04menuKey]}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<title>U-CMS V2.0</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />

<link rel="stylesheet" href="/static/ucms/css/default.css">
<link rel="stylesheet" href="/static/ucms/css/main.css">
<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script>
function getCookie(cookieName) {
  	var cookie = document.cookie;
  	if(cookie.length > 0) {
   		startIndex = cookie.indexOf(cookieName);
   		if(startIndex != -1) {
    		startIndex += cookieName.length;
    		endIndex = cookie.indexOf(";", startIndex);
    		if(endIndex == -1) endIndex = cookie.length;
    		return unescape(cookie.substring(startIndex + 1, endIndex));
   		} else {
    		return false;
   		}
  	} else {
   		return false;
  	}
}
$(function() {
	<c:forEach var="result" items="${popupList}" varStatus="status">
		if (getCookie("gnEventCookie${result.popupNo}") != "done") {
			var url = "/ucms/siteManage/popup/userPopup.do?";
			var params = "viewType=CONTBODY&pop";
			var height;
			if (navigator.userAgent.indexOf('Chrome')>-1) {
				height = parseInt('${result.hgValue}');
	        } else {
	        	height = parseInt('${result.hgValue}')+34;
	        }
			window.open(url + params + "&popupNo=${result.popupNo}", "", "width=${result.arValue}, height="+height+", left=${result.lftCrdnt}, top=${result.upendCrdnt}, scrollbars=${result.scrlUseAt eq 'Y' ? 'yes' : 'no'}");
		}
	</c:forEach>
});
</script>
</head>
<body>
<div class="skip">
	<a href="#main">본문내용 바로가기</a>
</div>
<div id="wrap">
	<%@ include file="/WEB-INF/jsp/ucms/main/header.jsp" %>
	<main>
		<c:if test="${not empty fileMap[relmSeCd01.atchFileId]  and relmSeCd01.useAt eq 'Y'}">
			<div class="mainvisual" id="main">
				<div class="area">
				<ul>
					<c:forEach items="${visualList}" var="visual" varStatus="status">
							<li>
								<a href="#news-list_${status.count}" class="num"><span class="r"><span class="sr-only">${status.count}</span></span></a>
								<a style="display: block; background-image: url('/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${visual.fileStreCours}'/>&streFileNm=<util:seedEncrypt str='${visual.streFileNm}'/>');" class="view" id="news-list_${status.count}">
									<span class="sr-only">${visual.visualNm}</span>
								</a>
							</li>

					</c:forEach>
				</ul>
				<div class="ctrl">
					<button type="button" class="play"><span class="sr-only">최근소식 재생</span></button>
					<button type="button" class="stop"><span class="sr-only">최근소식 정지</span></button>
					<!-- <button type="button" class="pre"><span class="sr-only">최근소식 이전보기</span></button> -->
					<!-- <button type="button" class="next"><span class="sr-only">최근소식 다음보기</span></button> -->
				</div>
				</div>
				<script src="/static/jslibrary/jquery.slideCtrl.js"></script>
				<script>
					$('.mainvisual li').eq(0).addClass('on').find('.view').css({
						opacity: '1',
						zIndex: '50'
					});
					jQuery(".mainvisual").slideCtrl({
						photo_list    :jQuery('.mainvisual>.area li'),
						// photo_list_right:jQuery('.mainvisual .next'),
						// photo_list_left :jQuery('.mainvisual .pre'),
						photo_list_play :jQuery(".mainvisual .play"),
						photo_list_stop :jQuery(".mainvisual .stop"),
						FXconfig    :true,
						// d_time     :6000,
						debug     :false
					});
				</script>
			</div>
		</c:if>
		<div id="mainContent">
			<div class="topSet">
				<div id="notice">
					<c:set var="bbsList" value="${relmSeCd05.bbsList }" />
					<h2>공지사항</h2>
					<ul>
					<c:forEach items="${bbsList }" var="result" varStatus="status">
						<c:set var="bbsIdSet" value="${result.bbsId }" />
						<li><a href="/ucms/bbs/${result.bbsId }/view.do?nttId=${result.nttId }&amp;menuNo=300017"><span class="txt">${result.nttSj }</span><span class="date">${result.registDt }</span></a></li>
					</c:forEach>
					<c:if test="${fn:length(relmSeCd05.bbsList) == 0 }">
						<li>등록된 게시물이 존재하지 않습니다.</li>
					</c:if>
					</ul>
					<a href="/ucms/bbs/B0000001/list.do?menuNo=300017" class="btnMore"><span class="sr-only">더보기</span></a>
				</div>
				<div id="article">
					<c:set var="bbsList" value="${relmSeCd06.bbsList }" />
					<h2>워크샵</h2>
					<c:forEach items="${bbsList }" var="result" varStatus="status">
					<c:if test="${status.index == 0 }">
					<a href="/ucms/bbs/${result.bbsId }/view.do?nttId=${result.nttId }&amp;menuNo=300080" class="link">
						<span class="img"><img src="/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${result.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${result.streFileNm}'/>" alt="${fileMap[result.atchFileId][0].fileCn} 이미지" width="220" height="180"></span>
						<span class="s">
							<span class="title">
								${result.nttSj }
							</span>
							<span class="txt">
								<util:noTagStr length="100" value="${fn:replace(fn:replace(fn:replace(result.nttCn,'&lt;p&gt;',''),'&lt;br&gt;',''),'&lt;/p&gt;','') }" />
							</span>
							<span class="date">${result.registDt }</span>
						</span>
					</a>
					</c:if>
					</c:forEach>
					<a href="/ucms/bbs/B0000002/list.do?menuNo=300004" class="btnMore"><span class="sr-only">더보기</span></a>
				</div>
			</div>
			<div id="service">
				<div class="set">
					<h2>SERVICE</h2>
					<p>
						유앤피플은 SI, Solution, Consulting 등 다양한 사업분야에
						대한 사업수행경험을 보유하고 있습니다.
					</p>
					<a href="/ucms/main/contents.do?menuNo=300088"> 서비스 소개 </a>
				</div>
			</div>
			<div id="quicklink">
				<a href="/ucms/bbs/B0000001/list.do?menuNo=300017" aria-label="고객센터">
					<dl>
						<dt>고객센터</dt>
						<dd>
							궁금하신 내용이 있을 경우, <br>
							고객센터에 문의하시면 최선을 다해 <br>
							상담해 드리겠습니다.
						</dd>
					</dl>
				</a>
				<a href="/ucms/bbs/B0000002/list.do?menuNo=300004" aria-label="워크샵">
					<dl>
						<dt>워크샵</dt>
						<dd>
							유앤피플은 특별한 사람들이 <br>
							함께하는 곳입니다.
						</dd>
					</dl>
				</a>
				<a href="/ucms/main/contents.do?menuNo=300016" aria-label="CAREER">
					<dl>
						<dt>CAREER</dt>
						<dd>
							유앤피플은 잠재적인 능력을 <br>
							발휘하여 함께 특별해지고 <br>
							싶은 당신을 초대합니다.
						</dd>
					</dl>
				</a>
			</div>
		</div>
	</main>
			<%--
			<div class="dynamicSet">
				<div class="pos1">
				<jsp:include page="/WEB-INF/jsp/ucms/main/incDynamicCntnts.jsp">
					<jsp:param name="relmSeCd" value="02" />
				</jsp:include>
				</div>
				<div class="pos2">
				<jsp:include page="/WEB-INF/jsp/ucms/main/incDynamicCntnts.jsp">
					<jsp:param name="relmSeCd" value="03" />
				</jsp:include>
				</div>
				<div class="pos3">
				<jsp:include page="/WEB-INF/jsp/ucms/main/incDynamicCntnts.jsp">
					<jsp:param name="relmSeCd" value="04" />
				</jsp:include>
				</div>
				<div class="pos4">
				<jsp:include page="/WEB-INF/jsp/ucms/main/incDynamicCntnts.jsp">
					<jsp:param name="relmSeCd" value="05" />
				</jsp:include>
				</div>
				<div class="pos5">
				<jsp:include page="/WEB-INF/jsp/ucms/main/incDynamicCntnts.jsp">
					<jsp:param name="relmSeCd" value="06" />
				</jsp:include>
				</div>
				<div class="pos6">
				<jsp:include page="/WEB-INF/jsp/ucms/main/incDynamicCntnts.jsp">
					<jsp:param name="relmSeCd" value="07" />
				</jsp:include>
				</div>
			</div>
			--%>

	<c:if test="${fn:length(bannerList) > 0 }">
	<aside id="adSet">
		<div class="set">
			<div class="ctrl">
				<button type="button" aria-label="이전 배너" class="adLeft"></button>
				<button type="button" aria-label="다음 배너" class="adRight"></button>
				<button type="button" aria-label="배너 정지" class="adStop"></button>
			</div>
			<div class="listArea">
				<ul>
					<c:forEach var="banner" items="${bannerList }" varStatus="status">
					<li>
						<a  href='${banner.bannerUrlad }' target="_blank" title="새창열림" style="background-image:url(/cmmn/file/imageSrc.do?fileStreCours=<util:seedEncrypt str='${banner.fileStreCours}/thumb'/>&amp;streFileNm=<util:seedEncrypt str='${banner.streFileNm}'/>)">
						<span class="sr-only">${banner.bannerNm }</span>
						</a>
					</li>
					</c:forEach>
				</ul>
			</div>
		</div>
		<script src="/static/jslibrary/jquery.carouFredSel-6.2.1/jquery.carouFredSel-6.2.1-packed.js"></script>
		<script>
			var slideTarget = $("#adSet");
			var slide_item	= slideTarget.find(".listArea ul");
			slide_item.carouFredSel({
					responsive : true,
					circular	: true,		//원형  예) 처음 > 두번째 세번째.... > 마지막 > 처음
					infinite	: true,		//무한반복
					padding		: null,          // Padding around the carousel (top, right, bottom and left). For example: [10, 20, 30, 40] (top, right, bottom, left) or [0, 50] (top/bottom, left/right).
					synchronise	: null,      // Selector and options for the carousel to synchronise: [string selector, boolean inheritOptions, boolean sameDirection, number deviation] For example: ["#foo2", true, true, 0]
					cookie		: false,          // Determines whether the carousel should start at its last viewed position. The cookie is stored until the browser is closed. Can be a string to set a specific name for the cookie to prevent multiple carousels from using the same cookie.
					auto		: {
						play:true,
						delay   :5000,	//최초 페이지 로드후 재생되는 딜레이
						timeoutDuration:2000 //슬라이드 지연 시간
						},
					align       : "left",
					width		: '%', //전체 너비
					height		: 60, //전체 높이
					items		: {
						visible : 4 //보여질 갯수
						},
					scroll      : {
						// easing			:'easeInOutQuart',
						items:1,
						duration        : 1000, //시간
						pauseOnHover	: true //마우스오버시 일시정지기능 마우스 아웃시 자동재생됨
						},
					prev:{
						button	: '.adLeft',
						wipe 	: true //로테이션 허용(리스트 처음에서 클릭시 마지막요소로 이동)
					},
					next: {
						button :'.adRight',
						wipe	: true
					},
					direction	: "left"
				});
			slide_item.find('a').each(function() {
				 $(this).on('focusin', function(event) {
					slide_item.trigger("pause");
				 });
			});
		</script>
	</aside>
	</c:if>
</div>
<%@ include file="/WEB-INF/jsp/ucms/main/footer.jsp" %>
<%@ include file="/WEB-INF/jsp/cmmn/autoLogout.jsp" %>
	<!-- 로그기록  -->
	<script>
	document.writeln("<img src='/${paramVO.siteId}/singl/siteConectStats/rcord.do?menuNo=${paramVO.menuNo}&amp;conectUrlad=/${paramVO.siteId}/main/main.do' border='0' width='0' height='0' alt='' />");
	</script>
	<!-- 로그기록 END  -->
	<script src="/static/ucms/js/common.js"></script>
</body>
</html>