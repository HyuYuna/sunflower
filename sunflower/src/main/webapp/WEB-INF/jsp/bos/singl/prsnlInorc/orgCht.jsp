<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>


<div class="ogg">
	<ol class="top">
		<li class="item">
			<c:forEach var="result" items="${resultList}" begin="0" end="1" varStatus="status">
				<c:if test="${result.authorCd eq 'ROLE_CPO'}">
					<dl>
						<dt>개인정보 책임자</dt>
						<dd>
							교학부 총장 ${result.userNm}
						</dd>
					</dl>
				</c:if>
			</c:forEach>
		</li>
		<li class="item">
			<c:forEach var="result" items="${resultList}" begin="0" end="1" varStatus="status">
				<c:if test="${result.authorCd eq 'ROLE_CPM'}">
					<dl>
						<dt>개인정보 부책임자</dt>
						<dd>
							정보통신센터장 ${result.userNm}
						</dd>
					</dl>
					</c:if>
			</c:forEach>
		</li>
		<li class="team-title">
			개인정보 보호팀
		</li>
	</ol>
	<ul class="team-list">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${result.authorCd eq 'ROLE_CPP'}">
				<li class="item2">
					<dl>
						<dt>개인정보 담당자</dt>
						<dd>
							관리적 보호조치 / 담당자 ${result.userNm}
						</dd>
					</dl>
				</li>
			</c:if>
		</c:forEach>
	</ul>
</div>

<script>
	// 개인정보 팀원 라인 설정
	$('.ogg').each(function (index, element) {
		var item2 = $(this).find('.item2')
		if(item2.length < 2){
			item2.addClass('one')
		}
	});
</script>