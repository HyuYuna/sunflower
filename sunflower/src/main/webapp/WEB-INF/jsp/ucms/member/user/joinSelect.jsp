<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<c:set var="siteId" value="${paramVO.siteId}"/>

<script>
var title = document.title;
document.title = "회원유형선택 " + title;
</script>

<c:import url="/WEB-INF/jsp/${siteId}/member/user/joinStepNav.jsp"/>

<div class="plist">
	<p>
		고객님께서 해당하시는 회원유형을 선택해 주세요.<br/>
		회원유형에 따라 가입절차가 차이가 있으니 본인이 해당하는 경우를 올바르게 선택하여 주시기 바랍니다.
	</p>
</div>

<div class="row certify">
	<div class="col-xs-6">
		<h2 class="bu_t1">일반회원</h2>
		<div class="s">
			<p>
				개인회원으로 가입하실 수 있습니다.
			</p>
			<a href="/ucms/member/user/joinVerify.do?menuNo=${param.menuNo }" class="b-">일반회원</a>
		</div>
	</div>
	<div class="col-xs-6">
		<h2 class="bu_t1">어린이회원</h2>
		<div class="s">
			<p>
				만 14세 미만의 어린이는 보호자의 동의가 필요합니다.
			</p>
			<a href="/ucms/member/user/joinVerify.do?menuNo=${param.menuNo }&amp;chldCrtfcAt=Y" class="b-">어린이회원</a>
		</div>
	</div>
</div>
