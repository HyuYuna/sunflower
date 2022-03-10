<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="step1Param" value="${not empty paramVO.prevStep ? step1Param : null }" />

<form name="regForm" id="regForm" method="post" action="">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="siteSn" value="${empty result ? step1Param.siteSn : result.siteSn}"/>
	<input type="hidden" name="userSn" value="${paramVO.userSn}"/>
	<input type="hidden" name="menuNo" value="${paramVO.menuNo }" />
	<input type="hidden" name="prevStep" value="${empty paramVO.prevStep ? '1' : paramVO.prevStep }" />
	<input type="hidden" name="updtFlag" value="${empty result ? 'N' : 'Y'}" />
	<input type="hidden" name="viewType" value="CONTBODY" />


	<h4 class="bu_t1">사이트 URL정보 (Step 01)</h4>
	<div class="view">
		<dl>
			<dt><label for="siteSeCd">사이트구분</label></dt>
			<dd>
				<select name="siteSeCd" id="siteSeCd" title="사이트구분을 선택해 주세요.">
					<option value="">사이트구분 선택</option>
					<c:forEach var="code" items="${siteSeCdCodeList }">
						<option value="${code.cd }" <c:if test="${(empty result ? step1Param.siteSeCd  : result.siteSeCd) eq code.cd}">selected="selected"</c:if> >${code.cdNm }</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt><label for="siteNm">사이트명</label></dt>
			<dd>
				<input type="text" name="siteNm" id="siteNm" class="w100p" value="${empty result ? step1Param.siteNm : result.siteNm }" title="사이트명">
			</dd>
		</dl>
		<dl>
			<dt><label for="siteAlarmCycleCd">알람주기</label></dt>
			<dd>
				<select name="siteAlarmCycleCd" id="siteAlarmCycleCd" title="알람주기">
					<option value="">알람주기 선택</option>
					<c:forEach var="code" items="${siteAlarmCycleCdCodeList }">
						<option value="${code.cd }" <c:if test="${(empty result ? step1Param.siteAlarmCycleCd  : result.siteAlarmCycleCd) eq code.cd}">selected="selected"</c:if> >${code.cdNm }</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt><label for="timeOutCycle">타임아웃시간</label></dt>
			<dd>
				<input type="number" name="timeOutCycle" id="timeOutCycle" class="w20p" value="${empty result ? step1Param.timeOutCycle : result.timeOutCycle }" title="타임아웃시간"> ms
			</dd>
		</dl>
		<dl>
			<dt>알람정지일시</dt>
			<dd>
				<c:set var="arr" value="${fn:split(result.alarmStopDt,' ') }" />
				<c:if test="${not empty result.alarmStopDt }">
					<c:set var="alarmStopDe" value="${arr[0] }" />
					<c:set var="alarmStopTime" value="${arr[1] }" />
				</c:if>
				<c:if test="${not empty step1Param.alarmStopDt }">
					<c:set var="alarmStopDe" value="${step1Param.alarmStopDe }" />
					<c:set var="alarmStopTime" value="${step1Param.alarmStopTime }" />
				</c:if>
				<input type="date" name="alarmStopDe" id="alarmStopDe" class="w25p" value="${alarmStopDe }" title="알람정지일자">
				<input type="time" name="alarmStopTime" id="alarmStopTime" class="w25p" value="${alarmStopTime }" title="알람정지시간">
				<input type="hidden" name="alarmStopDt" id="alarmStopDt" value="${empty result ? step1Param.alarmStopDt : result.alarmStopDt }">
			</dd>
		</dl>

		<dl>
	</div>

	<div class="btnSet">
		<a class="b-reg btn btn-default btn-primary" href="/bos/member/uwam/for${empty result ? 'Insert' : 'Update'}SiteStep2.do" id="nextBtn">다음</a>
		<a class="b-cancel btn btn-default btn-primary" href="#closeLayerBtn" id="closeLayerBtn">취소</a>
	</div>
</form>

<script>
//<![CDATA[

$("#closeLayerBtn").on('click',function() {
	$(this).closest(".modal").find(".close-modal").on('click',);
});

$('#nextBtn').on('click',function(event) {
	event.preventDefault();
  	this.blur(); // Manually remove focus from clicked link.

  	var form = document.regForm;
	var v = new MiyaValidator(form);

	v.add("siteSeCd", {
		required: true
	});
	v.add("siteNm", {
		required: true,
		trim : true
	});
	v.add("siteAlarmCycleCd", {
		required: true
	});
	v.add("timeOutCycle", {
		required: true
	});
	/*
	v.add("alarmStopDe", {
		required: false
	});
	v.add("alarmStopTime", {
		required: true
	});
	*/

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return false;
	}


	if ($("#alarmStopDe").val().trim() == "" || $("#alarmStopTime").val().trim() == "") {
		alert("알람정지일시를 입력해 주세요.");
		return false;
	}

	$("#alarmStopDt").val($("#alarmStopDe").val() + " " + $("#alarmStopTime").val());

	if (!confirm("다음단계로 넘어가시겠습니까?")) return false;


  	var param = $("#regForm").serialize();
  	$.get(this.href,param, function(html) {
    	$(".modal").html(html).modal();
  	});
  	return false;
});

//]]>

</script>

