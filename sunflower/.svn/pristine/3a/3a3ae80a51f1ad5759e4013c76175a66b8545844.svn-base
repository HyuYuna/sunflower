<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>

	<ul class="cmmntList">
		<c:forEach var="result" items="${resultList }" varStatus="status">
		<li>
			<div class="cmtBody">
				<span class="infoAppend">
					<span class="name">${result.ntcrNm }</span>
					<span class="vline">|</span>
					<span class="time">${result.registDt }</span>
				</span>
				<p class="txtDesc cmmntViewDiv">
					<% pageContext.setAttribute("crlf", "\n"); %>
					${fn:replace(result.nttCn, crlf, "<br/>")}
				</p>
			</div>
			<div class="cmtFoot cmmntViewDiv">
				<c:if test="${result.ntcrId eq userVO.userId }">
				<a href="#none" class="updtBtn b-edit">수정</a>
				<span class="vline">|</span>
				<a href="#none" class="cmmntDelBtn b-del" data-value="${result.cmId }">삭제 </a>
				</c:if>
			</div>
			<div class="row clear dn cmmntUpdtDiv">
				<c:if test="${result.ntcrId eq userVO.userId }">
				<div class="col-sm-10">
					<textarea name="nttCn" id="nttCn${status.count }" cols="30" rows="10" class="w100p characterLen2" title="댓글수정" style="height:67px"><util:out escapeXml="false">${result.nttCn}</util:out></textarea>
				</div>
				<div class="col-sm-2">
				<a href="#none" class="updtSaveBtn b-edit" data-value="${result.cmId }">수정</a>
				<span class="vline">|</span>
				<a href="#none" class="updtCancelBtn b-cancel">수정취소</a>
				</div>
				</c:if>
			</div>

		</li>
		</c:forEach>
		<c:if test="${fn:length(resultList) == 0 }"><li>등록된 글이 존재하지 않습니다.</li></c:if>
	</ul>

	<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
	</c:if>


<script>
$(".cmmntList").find(".cmmntDelBtn").on('click',function() {
	var $this = $(this);
	if (!confirm("삭제하시겠습니까?")) return false;
	var v_cmmntId = $(this).attr("data-value");
	var url = "/${paramVO.siteId}/bbs/bbsCm/delete.json";
	var params = {
			cmId : v_cmmntId
	};
	$.post(url,params,function(data) {
		if (data.resultCode == "success") {
			alert("댓글이 삭제되었습니다.");
			$this.closest("li").remove();
			return false;
		}
		else {
			alert("댓글삭제를 실패하였습니다.");
			return false;
		}
	},"json");
	return false;
});

$(".cmmntList").find(".updtBtn").on('click',function() {
	$(this).closest("li").find(".cmmntViewDiv").hide();
	$(this).closest("li").find("div.cmmntUpdtDiv").removeClass("dn");
	return false;
});

$(".cmmntList").find(".updtCancelBtn").on('click',function() {
	$(this).closest("li").find("div.cmmntUpdtDiv").addClass("dn");
	$(this).closest("li").find(".cmmntViewDiv").show();
});

$(".cmmntList").find(".updtSaveBtn").on('click',function() {
	var $this = $(this);
	if (!confirm("수정하시겠습니까?")) return false;
	var v_cmmntId = $(this).attr("data-value");
	var url = "/${paramVO.siteId}/bbs/bbsCm/update.json";
	var params = {
			cmId : v_cmmntId,
			nttId : v_nttId,
			bbsId : v_bbsId,
			cmSe : v_bbsId,
			nttCn : $(this).closest("div.cmmntUpdtDiv").find("textarea[name=nttCn]").val()
	};
	$.post(url,params,function(data) {
		if (data.resultCode == "success") {
			alert("댓글이 수정되었습니다.");
			commentList(v_bbsId, v_nttId);
			return false;
		}
		else {
			alert("댓글수정을 실패하였습니다.");
			return false;
		}
	},"json");
	return false;
});


$(".paginationSet").find("a").on('click',function() {
	if ($(this).closest("li.disabled").length > 0) return false;
	var url = $(this).attr("href");
	params = {
		bbsId : v_bbsId
	}
	$.get(url,params,function(data) {
		$("#commentList").html(data);
	},"html");
	return false;
});
</script>