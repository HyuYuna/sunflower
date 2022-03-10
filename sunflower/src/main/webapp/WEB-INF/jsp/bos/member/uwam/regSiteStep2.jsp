<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<form name="regForm" id="regForm" method="post" action="/bos/member/uwam/${paramVO.updateFlag eq 'Y' ? 'update' : 'insert'}Site.json">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="menuNo" value="${paramVO.menuNo }" />
	<input type="hidden" name="siteSn" value="${paramVO.siteSn}"/>
	<input type="hidden" name="userSn" value="${paramVO.userSn}"/>
	<input type="hidden" name="prevStep" value="${paramVO.prevStep }" />
	<input type="hidden" name="updtFlag" value="${paramVO.updtFlag}" />
	<input type="hidden" name="viewType" value="CONTBODY" />


	<h4 class="bu_t1">사이트 URL정보(Step 02)</h4>
	<div class="view">
		<dl>
			<dt>사이트구분</dt>
			<dd>
			<c:forEach var="code" items="${siteSeCdCodeList }">
				<c:if test="${paramVO.siteSeCd eq code.cd}">${code.cdNm }</c:if>
			</c:forEach>
			</dd>
		</dl>
		<dl>
			<dt>사이트명</dt>
			<dd>${param.siteNm }</dd>
		</dl>
		<dl>
			<dt><label for="siteUrl">사이트URL</label></dt>
			<dd>
				<c:choose>
				<c:when test="${paramVO.siteSeCd eq '02' }">
					<div><a href="#" class="b-add" id="addUrlBtn">추가</a></div>
					<ul class="siteUrlList">
						<li>
							<input type="text" name="siteUrl" class="w70p" value="${result.siteUrl }" title="사이트 URL" placeholder="ex) http://www.unpl.co.kr">
							<a href="#" class="b-del delBtn" data-value="">삭제</a>
						</li>
					</ul>


				</c:when>
				<c:otherwise>
					<input type="text" name="siteUrl" id="siteUrl" class="w100p" value="${result.siteUrl }" title="사이트 URL" placeholder="ex) http://www.unpl.co.kr">
				</c:otherwise>
				</c:choose>

			</dd>
		</dl>
	</div>

	<div class="btnSet">
		<a class="b-reg btn btn-default btn-primary" href="#" id="saveBtn">${paramVO.updateFlag eq 'Y' ? '수정' : '등록'}</a>
		<a class="b-back btn btn-default btn-primary" href="/bos/member/uwam/for${paramVO.updateFlag eq 'Y' ? 'Update' : 'Insert'}SiteStep1.do" id="returnBtn">뒤로가기</a>
	</div>
</form>

<script>
//<![CDATA[

$("#returnBtn").on('click',function() {
	var param = $("#regForm").serialize();
  	$.get(this.href, param, function(html) {
    	$(".modal").html(html).modal();
  	});
	return false;
});

$("#saveBtn").on('click',function() {

	<c:choose>
	<c:when test="${paramVO.siteSeCd eq '02' }">
	if ($("#siteUrl").val().trim() == "") {
		alert("사이트URL을 입력해 주세요.");
		$("#siteUrl").focus();
		return false;
	}
	</c:when>
	<c:otherwise>

	</c:otherwise>
	</c:choose>

	if (!confirm("${paramVO.updateFlag eq 'Y' ? '수정' : '등록'}하시겠습니까?")) return;

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
	var $cloneLi = $(".siteUrlList").find("li:first");
	$cloneLi.find("input[name=siteUrl]").val("");
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
		var url = "/bos/member/uwam/deleteSiteUrl.json";
		var param = {
				urlSn : v_urlSn
		}
		$.post("");
	}
	else {
		$this.closest("li").remove();
	}
	return false;
});


//]]>
</script>

