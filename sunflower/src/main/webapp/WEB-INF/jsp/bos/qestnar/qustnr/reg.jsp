<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/qestnar/qustnr/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/qestnar/qustnr/update.do" />
</c:if>

<sec:authorize access="hasRole('ROLE_SUPER')">
	<c:set var="roleSuper" value="Y" />
</sec:authorize>


<script>

$(function(){
	$('.btnDeleteSearchDateRage').click(function() {
	    $('#bgnde1').val("").show();
	    $('#endde1').val("").show();
	});
});

function checkForm() {
	var form = $("#board")[0];
	var v = new MiyaValidator(form);

    v.add("qustnrSj", {
        required: true
    });
   	v.add("qustnrTrgetCd", {
        required: true
    });
    v.add("resultOthbcAt", {
        required: true
    });
    /* v.add("bgnde1", {
    	required: true
    });
    v.add("endde1", {
    	required: true
    });
 */

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (oEditors.getById["qestnarCn"].getIR() == "<p><br></p>") {
		alert('내용을 입력해 주세요.');
		oEditors.getById["qestnarCn"].exec("FOCUS", []);
	    return;
	}

	document.getElementById("qestnarCn").value = oEditors.getById["qestnarCn"].getIR();
	if (!confirm('${empty result ? "등록" : "수정"}하시겠습니까?')) {
		return;
	}
	
	if ($('#bgnde1').val() == "" || $('#endde1').val() == "") {
		if ($('#bgnde1').val() == "") {
			$('#bgnde1').val("2000-01-01");
		}
		if ($('#endde1').val() == "") {
			$('#endde1').val("2099-12-31");
		}
	}
	
	$("#loadingDiv").show();

	form.submit();
}
function del(){
	if (!confirm('정말로 삭제 하시겠습니까?')) {
		return;
	}
	var form = $("#board")[0];
	form.action = "/bos/qestnar/qustnr/delete.do";
	form.submit();
}

function initDept() {
	$("#deptKorNm").val("");
	$("#deptId").val("");
}

function openDept() {
	window.open("/bos/cmmn/cmmnDeptInfo/listPop.do?viewType=BODY","deptPop","scrollbars=yes,width=800,height=600");
	return;
}
</script>

<form id="board" name="board" method="post" action="${action}" class="pure-form">
	<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
	<input type="hidden" name="qustnrSn" value="${empty result.qustnrSn ? 0 : result.qustnrSn }" />
	<input type="hidden" id="atchFileId0" name="atchFileId" value="${result.atchFileId}">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="bdView">
		<table>
			<caption>설문조사 - ${empty result ? '쓰기' : '수정'}</caption>
			<tbody>
				<tr>
					<th scope="row"><label for="qustnrSj">설문주제</label></th>
					<td><input type="text" name="qustnrSj" id="qustnrSj" class="w100p" value="${result.qustnrSj}" /></td>
				</tr>
				<tr>
					<th scope="row"><label for="bgnde">조사기간</label></th>
					<td>
						<span class="shDate">
						<input id="bgnde1" name="bgnde1" class="sdate" title="시작일" value="${result.bgnde1}" type="text">
						<select name="bgnde2" id="bgnde2">
						<c:forEach var="x" begin="0" end="23">
						<c:set var="h"><util:fz source='${x}' resultLen='2' isFront='true' /></c:set>
							<option value="${h}" ${result.bgnde2 eq h ? 'selected="selected"' : ''}>${h}시</option>
						</c:forEach>
						</select>
						:
						<select name="bgnde3" id="bgnde3">
						<c:forEach var="x" begin="0" end="59">
						<c:set var="m"><util:fz source='${x}' resultLen='2' isFront='true' /></c:set>
							<option value="${m}" ${result.bgnde3 eq m ? 'selected="selected"' : ''}>${m}분</option>
						</c:forEach>
						</select>
						~
						<input id="endde1" name="endde1" class="edate" title="종료일" value="${result.endde1}" type="text">
						<select name="endde2" id="endde2">
						<c:forEach var="x" begin="0" end="23">
						<c:set var="h"><util:fz source='${x}' resultLen='2' isFront='true' /></c:set>
							<option value="${h}" ${result.endde2 eq h ? 'selected="selected"' : ''}>${h}시</option>
						</c:forEach>
						</select>
						:
						<select name="endde3" id="endde3">
						<c:forEach var="x" begin="0" end="59">
						<c:set var="m"><util:fz source='${x}' resultLen='2' isFront='true' /></c:set>
							<option value="${m}" ${result.endde3 eq m ? 'selected="selected"' : ''}>${m}분</option>
						</c:forEach>
						</select>
						<img class="btnDeleteSearchDateRage" src='/static/bos/image/icons/cross-th.png' style="width: 10px; height: 10px;">
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="qustnrTrgetCd">설문대상</label></th>
					<td>
						<label for="qustnrTrgetCd1"><input type="radio" name="qustnrTrgetCd" id="qustnrTrgetCd1" value="A" ${result.qustnrTrgetCd eq 'A' ? 'checked="checked"' : ''} onclick="return(false);"/> 아무나</label>
						<label for="qustnrTrgetCd2"><input type="radio" name="qustnrTrgetCd" id="qustnrTrgetCd2" value="M" ${(result.qustnrTrgetCd eq 'M') or (empty result) ? 'checked="checked"' : ''}  onclick="return(false);"/> 회원</label>
					</td>
				</tr>
				<tr>
					<th scope="row"><label for="resultOthbcAt">결과보기 공개여부</label></th>
					<td>
						<label for="resultOthbcAt1"><input type="radio" name="resultOthbcAt" id="resultOthbcAt1" value="Y" ${result.resultOthbcAt eq 'Y' ? 'checked="checked"' : ''} /> 공개</label>
						<label for="resultOthbcAt2"><input type="radio" name="resultOthbcAt" id="resultOthbcAt2" value="N" ${result.resultOthbcAt eq 'N' ? 'checked="checked"' : ''} /> 비공개</label>
					</td>
				</tr>
				<tr>
					<th scope="row" class="con_tit">내용</th>
					<td class="outputEditor">
						<textarea id="qestnarCn" name="qestnarCn" cols="150" rows="30" style="display: none;" class="textarea" title="내용">${result.qestnarCn}</textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true">
							<jsp:param name="target" value="qestnarCn"/>
						</jsp:include>
					</td>
				</tr>
				<c:if test="${not empty result}">
					<tr>
						<th scope="row">등록일</th>
						<td><fmt:formatDate value="${result.registDt}" pattern="yyyy-MM-dd HH:mm"/></td>
					</tr>
				</c:if>

			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">

	<div class="fr" >
		<c:choose>
		<c:when test="${empty result}" >
			<button type="button" onclick="checkForm();" class="pure-button b-reg">등록</button>
		</c:when>
		<c:otherwise>
			<button type="button" class="pure-button b-reg" onclick="checkForm();">수정</button>
			<button type="button" class="pure-button b-del" onclick="del();">삭제</button>
		</c:otherwise>
		</c:choose>
			<a class="pure-button b-list" href="/bos/qestnar/qustnr/list.do?${pageQueryString}">목록</a>
	</div>
</div>