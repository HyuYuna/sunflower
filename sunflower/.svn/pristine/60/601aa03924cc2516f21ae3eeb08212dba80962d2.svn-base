<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="updtFlag" value="${empty result ? 'N' : 'Y'}" />

<form name="regForm" id="regForm" method="post" action="/bos/member/uwam/${updtFlag eq 'Y' ? 'update' : 'insert'}Site.json">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="siteSn" value="${result.siteSn}"/>
	<input type="hidden" name="userSn" value="${paramVO.userSn}"/>
	<input type="hidden" name="menuNo" value="${paramVO.menuNo }" />
	<input type="hidden" name="viewType" value="CONTBODY" />

	<h4 class="bu_t1">사이트 URL정보</h4>
	<div class="view">
		<dl>
			<dt><label for="siteSeCd">사이트구분</label></dt>
			<dd>
				<select name="siteSeCd" id="siteSeCd" title="사이트구분을 선택해 주세요.">
					<option value="">사이트구분 선택</option>
					<c:forEach var="code" items="${siteSeCdCodeList }">
						<option value="${code.cd }" <c:if test="${result.siteSeCd eq code.cd}">selected="selected"</c:if> >${code.cdNm }</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt><label for="siteNm">사이트명</label></dt>
			<dd>
				<input type="text" name="siteNm" id="siteNm" class="w100p" value="${result.siteNm }" title="사이트명">
			</dd>
		</dl>
		<dl>
			<dt><label for="siteUrl">사이트URL</label></dt>
			<dd>
				<div><a href="#" class="b-add" id="addUrlBtn">추가</a></div>
				<ul class="siteUrlList">
					<c:choose>
						<c:when test="${empty result }">
							<li>
								<input type="text" name="siteUrl" class="w70p" value="" title="사이트 URL" placeholder="ex) http://www.unpl.co.kr">
								<a href="#" class="b-del delBtn" data-value="">삭제</a>
							</li>
						</c:when>
						<c:otherwise>
							<c:forEach var="url" items="${urlList }" varStatus="status">
								<li>
									<input type="text" name="siteUrl" class="w70p" value="${url.checkUrlad }" title="사이트 URL" placeholder="ex) http://www.unpl.co.kr">
									<input type="hidden" name="urlSn" value="${url.urlSn }">
									<a href="#" class="b-del delBtn" data-value="${url.urlSn }">삭제</a>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</ul>
			</dd>
		</dl>
		<dl>
			<dt><label for="siteAlarmCycleCd">알람주기</label></dt>
			<dd>
				<select name="siteAlarmCycleCd" id="siteAlarmCycleCd" title="알람주기">
					<option value="">알람주기 선택</option>
					<c:forEach var="code" items="${siteAlarmCycleCdCodeList }">
						<option value="${code.cd }" <c:if test="${result.siteAlarmCycleCd eq code.cd}">selected="selected"</c:if> >${code.cdNm }</option>
					</c:forEach>
				</select>
			</dd>
		</dl>
		<dl>
			<dt><label for="timeOutCycle">타임아웃시간</label></dt>
			<dd>
				<input type="number" name="timeOutCycle" id="timeOutCycle" class="w20p" value="${result.timeOutCycle }" title="타임아웃시간"> ms
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
				<input type="date" name="alarmStopDe" id="alarmStopDe" class="w25p" value="${alarmStopDe }" title="알람정지일자">
				<input type="time" name="alarmStopTime" id="alarmStopTime" class="w25p" value="${alarmStopTime }" title="알람정지시간">
				<input type="hidden" name="alarmStopDt" id="alarmStopDt" value="${result.alarmStopDt }">
			</dd>
		</dl>
	</div>

	<div class="btnSet">
		<a class="b-reg btn btn-default btn-primary" href="#" id="saveBtn">${updtFlag eq 'Y' ? '수정' : '등록'}</a>
		<a class="b-cancel btn btn-default btn-primary" href="#closeLayerBtn" id="closeLayerBtn">취소</a>
	</div>
</form>

<script>
//<![CDATA[

$(function() {
	if ("${result.siteSeCd}" == "02") {
		$(".siteUrlList").attr('style','overflow-y:scroll;height:50px;');
	} else {
		$("#addUrlBtn").hide();
		$(".delBtn").hide();
	}
	
	$("#siteSeCd").on('change',function() {
		var siteSeCd = this.value;
		if (siteSeCd == "02") {
			$("#addUrlBtn").show();
			$(".delBtn").show();
			$(".siteUrlList").attr('style','overflow-y:scroll;height:50px;');
		} else {
			$("#addUrlBtn").hide();
			$(".delBtn").hide();
			$(".siteUrlList").attr('style','');
		}
	});
});

$("#closeLayerBtn").on('click',function() {
	$(this).closest(".modal").find(".close-modal").on('click',);
});

$("#saveBtn").on('click',function(event) {
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
	v.add("siteUrl", {
		required: true
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

	if (!confirm("${updtFlag eq 'Y' ? '수정' : '등록'}하시겠습니까?")) return;

	var url = $("#regForm").attr("action");
	var params = $("#regForm").serialize();
	$.post(url, params, function(data) {
		if (data.resultCode == "success") {
			alert("사이트 URL관련 정보 입력이 완료되었습니다.");
			window.location.reload();
		}
		else {
			alert("사이트 URL관련 정보 입력이 실패하였습니다.");
		}
	}, "json");

	return false;
});

$("#addUrlBtn").on('click',function() {
	var $cloneLi = $(".siteUrlList").find("li:first").clone();
	$cloneLi.find("input[name=siteUrl]").val("");
	$cloneLi.find("input[name=urlSn]").val("");
	$cloneLi.find(".delBtn").attr("data-value","");
	$cloneLi.appendTo($(".siteUrlList"));
	return false;
});

$(".siteUrlList").on("click",".delBtn",function() {
	if ($(".siteUrlList").find("li").length == 1) {
		alert("URL입력란이 1개인 경우 삭제할 수 없습니다.");
		return false;
	}
	var $this = $(this);
	var v_urlSn = $this.attr("data-value");
	
	if (v_urlSn != "") {
		$.post(
			"/bos/member/uwam/deleteSiteUrl.json",
			{urlSn : v_urlSn},
			function(data) {
				if (data.resultCode = "success") {
					$this.closest("li").remove();	
				}
			}
		, "json");
	} else {
		$this.closest("li").remove();
	}
	return false;
});

//]]>

</script>

