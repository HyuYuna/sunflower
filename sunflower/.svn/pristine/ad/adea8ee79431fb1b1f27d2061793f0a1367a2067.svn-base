<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script>
function agreeYN(frm) {
 	if(!$("#aggr1").prop("checked")){
		alert("이용약관에 동의해 주시기 바랍니다.");
		$("#aggr1").focus();
		return false;
	}
 	if(!$("#aggr2").prop("checked")){
		alert("개인정보 수집·이용에 동의해 주시기 바랍니다.");
		$("#aggr2").focus();
		return false;
	}
	//if(!$("#aggr3").prop("checked")){
	// 	alert("수집한 개인정보의 제3자 제공에 동의해 주시기 바랍니다.");
	// 	$('input:checkbox[name=aggr3]').first().focus();
	// 	return false;
	// }
	return true;
}
</script>
<jsp:include page="/WEB-INF/jsp/${paramVO.siteId }/member/user/joinStepNav.jsp" flush="true" />
<div class="plist">
	<p>본사이트는는 회원의 개인정보보호문제를 신중하게 취급합니다.</p>
	<p>가입하신 정보는 회원님의 동의 없이 공개되지 않으며, 개인정보보호정책에 의해 보호를 받습니다.</p>
</div>
<form name="frm" onsubmit="return agreeYN(this);" action='/${paramVO.siteId }/member/user/joinVerify.do?menuNo=${param.menuNo }' method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="agg-set">
		<div class="set scroll">
		<jsp:include page="/WEB-INF/jsp/cts/ucms/300033.jsp" flush="true" />
		</div>
	</div>
	<div class="tar">
		<input type="checkbox" id="aggr1" name="aggr1" value="Y" class="mr10" />
		<label for="aggr1">이용약관에 동의 합니다. (동의해야만 회원가입 가능)</label>
	</div>
	<h2 class="bu2">개인정보 수집∙이용 동의</h2>
	<div class="agg-set">
		<div class="set scroll">
		<jsp:include page="/WEB-INF/jsp/cts/ucms/300044.jsp" flush="true" />
		</div>
	</div>
	<div class="tar">
		<input type="checkbox" id="aggr2" name="aggr2" value="Y" class="mr10" />
		<label for="aggr2">개인정보 수집·이용에 동의합니다. (동의해야만 회원가입 가능)</label>
	</div>
<!--
	<h2 class="bu2">수집한 개인정보의 제3자 제공 동의</h2>
	<div class="agg-set"><div class="set scroll">약관</div></div>
	<div class="tar"><input type="checkbox" id="aggr3" name="aggr3" value="Y" class="mr10" /> <label for="aggr3">수집한 개인정보의 제3자 제공에 동의합니다. (동의해야만 회원가입 가능) </label></div>
-->
	<div class="btnSet c">
		<input type="submit" value="회원가입" class="b-join" />
		<a href="/${paramVO.siteId }/main/main.do" class="b-cancel b-lg">취소</a>
	</div>
</form>