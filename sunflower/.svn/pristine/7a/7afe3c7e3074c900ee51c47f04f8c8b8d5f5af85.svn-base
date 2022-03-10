<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<c:if test="${empty result}">
    <c:set var="action" value="/bos/main/mainMypage/insert.do" />
</c:if>
<c:if test="${not empty result}">
    <c:set var="action" value="/bos/main/mainMypage/update.do" />
</c:if>

<script>

function checkForm(){
	var numMC = $("input:checkbox[name='chkMenuChoise']:checked").length;
	if(numMC > 6 ){
		alert("선택한 항목은 최대 6개까지 적용이 가능합니다.");
		return
	}
	
	var menuChoise = document.getElementsByName("chkMenuChoise");
	var _menuChoise = "";
    for(var i=0;i<menuChoise.length;i++){
	   	if(menuChoise[i].checked){
	   		_menuChoise += menuChoise[i].value+ ", ";
   		}
   	}
    _menuChoise = _menuChoise.substr(0, _menuChoise.length - 2);
	$("#menuChoise").val(_menuChoise);
	
	document.frm.action="${action}";
	document.frm.submit();
}


</script>

<form name="frm" id="frm" method="post" enctype="multipart/form-data" class="pure-form">
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
	<input type="hidden" id="menuChoise" name="menuChoise" value="" />
	
	<ul class="list mb20">
		<li>메인페이지에 노출할 주요 정보를 선택합니다.</li>
		<li>선택한 항목은 최대 6개까지 적용이 가능합니다.</li> 
	</ul>
	<table class="table table-bordered mb0">
		<colgroup>
			<col width="50%" /> 
			<col /> 
		</colgroup> 
		<tbody> 
			<tr>
				<td><label><input type="checkbox" id="chkMenuChoise1" name="chkMenuChoise" value="b1" <c:if test="${fn:indexOf(result.menuChoise, 'b1') != -1 }">checked="checked"</c:if> /> 공지사항</label></td>
				<td><label><input type="checkbox" id="chkMenuChoise2" name="chkMenuChoise" value="b2" <c:if test="${fn:indexOf(result.menuChoise, 'b2') != -1 }">checked="checked"</c:if>/> 상담직군 게시판</label></td>
			</tr>
			<tr> 
				<td><label><input type="checkbox" id="chkMenuChoise3" name="chkMenuChoise" value="b3" <c:if test="${fn:indexOf(result.menuChoise, 'b3') != -1 }">checked="checked"</c:if>/> 자료실</label></td>
				<td><label><input type="checkbox" id="chkMenuChoise4" name="chkMenuChoise" value="b4" <c:if test="${fn:indexOf(result.menuChoise, 'b4') != -1 }">checked="checked"</c:if> /> 간호직군 게시판</label></td>
			</tr>
			<tr> 
				<td><label><input type="checkbox" id="chkMenuChoise5" name="chkMenuChoise" value="b5" <c:if test="${fn:indexOf(result.menuChoise, 'b5') != -1 }">checked="checked"</c:if> /> 문서 수신함</label></td>
				<td><label><input type="checkbox" id="chkMenuChoise6" name="chkMenuChoise" value="b6" <c:if test="${fn:indexOf(result.menuChoise, 'b6') != -1 }">checked="checked"</c:if> /> 행정직군 게시판</label></td>
			</tr>
			<tr> 
				<td><label><input type="checkbox" id="chkMenuChoise7" name="chkMenuChoise" value="b7" <c:if test="${fn:indexOf(result.menuChoise, 'b7') != -1 }">checked="checked"</c:if> /> 메일 수신함</label></td>
				<td><label><input type="checkbox" id="chkMenuChoise8" name="chkMenuChoise" value="b8" <c:if test="${fn:indexOf(result.menuChoise, 'b8') != -1 }">checked="checked"</c:if> /> 동행직군 게시판</label></td>
			</tr>
			<tr> 
				<td><label><input type="checkbox" id="chkMenuChoise9" name="chkMenuChoise" value="b9" <c:if test="${fn:indexOf(result.menuChoise, 'b9') != -1 }">checked="checked"</c:if> /> 최근 등록사례</label></td>
				<td><label><input type="checkbox" id="chkMenuChoise10" name="chkMenuChoise" value="c1" <c:if test="${fn:indexOf(result.menuChoise, 'c1') != -1 }">checked="checked"</c:if> /> 부소장직군 게시판</label></td>
			</tr>
			<tr> 
				<td><label><input type="checkbox" id="chkMenuChoise11" name="chkMenuChoise" value="c2" <c:if test="${fn:indexOf(result.menuChoise, 'c2') != -1 }">checked="checked"</c:if> /> 최근 지원서비스</label></td>
				<td></td>
			</tr>
		</tbody>
	</table>


<div class="btnSet">
	<a href="javascript:checkForm();" class="btn btn-primary"><span>저장</span></a>
</div>
