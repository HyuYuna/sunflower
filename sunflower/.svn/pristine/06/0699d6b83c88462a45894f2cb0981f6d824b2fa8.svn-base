<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<sec:authorize access="hasRole('ROLE_USERKEY') or hasRole('ROLE_VNAME')">
<script type="text/javascript">
var base_time = 600;
var setTime = base_time; // 최초 설정 시간(기본 : 초)
var minTs1; //분단위
var secTs1; //초단위

$(function() {
	$('.vTimeResets').on('click',function() {
		setTime = base_time + 1;
	});
	oTime = setInterval('out_time()', 1000);
});

function out_time() { // 1초씩 카운트
	--setTime;

	if (setTime < 0) {
		clearInterval(oTime); // 타이머 해제
		//alert("자동로그아웃이 되었습니다.");
		document.location.href = "/ucms/member/user/logout.do";
	} else {
		minTs1 = Math.floor(setTime / 60);
		secTs1 = (setTime % 60);
		secTs1 = secTs1 < 10 ? "0" + secTs1 : secTs1;
		minTs1 = minTs1 < 10 ? "0" + minTs1 : minTs1;
		m = minTs1 + "분 " + secTs1 + "초";

		$('#ViewTimer').html(m);
	}
}
</script>
</sec:authorize>