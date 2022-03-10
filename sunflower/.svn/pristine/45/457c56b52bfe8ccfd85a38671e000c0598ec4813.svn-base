<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

	<c:if test="${not empty masterVO.bbsDc }">
	<div class="plist">
		${masterVO.bbsDc }
	</div>
	</c:if>

	<dl id="faqList" class="callFaq">
	<c:forEach var="result" items="${resultList}" varStatus="status">
		<dt class="on open">
			<button type="button" title="답변 열기">
				<span class="qna_img"><span class="sr-only">질문</span></span> <span> ${result.nttSj} </span>
			</button>
		</dt>
		<dd>
			<span class="qna_img">
				<span class="sr-only">답변</span>
			</span>
			<util:out escapeXml="false">${result.nttCn}</util:out>
		</dd>
	</c:forEach>
	<c:if test="${fn:length(resultList) eq 0}">
		<dt id="no-data">게시글이 존재하지 않습니다.</dt>
	</c:if>
	</dl>
	<c:if test="${fn:length(resultList) > 0}">
		${pageNav}
	</c:if>
	<!-- faqList -->
	<script>
		jQuery(function($) {
			var article = $('.callFaq dt>button');
			article.each(function(index, el) {
				$(this).on('click',function(event) {
					if ($(this).parent().hasClass('open')) {
						$(this).parent().removeClass('open').next().hide();
						$(this).attr('title', '답변 열기')
					} else {
						$(this).parent().addClass('open').next().show();
						$(this).attr('title', '답변 닫기')
					}
				});
				$(this).parent().removeClass('open').next().hide();
			});
			article.eq(0).trigger('click')
		});
	</script>