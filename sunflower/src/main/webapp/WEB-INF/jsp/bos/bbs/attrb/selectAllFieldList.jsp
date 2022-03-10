<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
$(function(){

	$("input[name^=fieldAttribute]").on('click',function(){
		var idx = $(this).attr("id").replace("chk_", "");
		if(this.checked){
			$("#typeSpan_"+idx).show();
		}
		else{
			$("input[name^=fieldType_"+idx+"]").attr("checked", "");
			$("#typeSpan_"+idx).hide();
		}
	});
});

function save()
{
	var form = document.frm2;
	var v = new MiyaValidator(form);
    v.add("fieldAttributeIdx", {
        required: true
    });
	result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	form.submit();
}
</script>

<h1>필드내용</h1>
<form name="frm2" method="post" action="/bos/bbs/attrb/addFieldAttr.do">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="attrbCd" value="${param.attrbCd}" />
	<input type="hidden" name="attrbTyCd" value="${param.attrbTyCd}" />
	<input type="hidden" name="menuNo" value="${param.menuNo}" />
<div class="bdList">
	<table class="table table-bordered table-hover">
	<caption>민원업무 및 담당자를 검색</caption>
	<colgroup>
		<col width="15%">
		<col width="20%">
		<col width="15%">
		<col >
		<col width="10%">
	</colgroup>
	<thead>
		<tr>
			<th scope="col">선택</th>
			<th scope="col">name</th>
			<th scope="col">text</th>
			<th scope="col">type</th>
			<th scope="col">목록노출</th>
		</tr>
	</thead>
	<tbody>
	<c:forEach var="result" items="${fieldAttributes}" varStatus="status">
		<tr>
			<td>
				<input type="hidden" name="fieldIemNm_${status.count}" value="${result.fieldIemNm}" />
				<input type="checkbox" id="chk_${status.count}" name="fieldAttributeIdx" value="${status.count}" <c:if test="${not empty result.fieldTyCd}"> checked</c:if> />
				<input type="hidden" name="fieldId" value="${result.fieldId}" />
			</td>
			<td>${result.fieldIemNm}</td>
			<td>
				<input type="text" name="fieldDc_${status.count}" id="fieldDc_${status.count}" style="width:200px" value="${result.fieldDc}" />
			</td>
			<td>
				<span id="typeSpan_${status.count}" ${empty result.fieldTyCd ? 'style="display:none"' : 'style="display:"'}>
					<label><input type="radio" id="emptyType_${status.count}" name="fieldTyCd_${status.count}" value="empty" ${result.fieldTyCd=='empty'?'checked':''} />empty</label>
					<label><input type="radio" id="textType_${status.count}" name="fieldTyCd_${status.count}" value="text" ${result.fieldTyCd=='text' || empty result.fieldType?'checked':''} />text</label>
					<label><input type="radio" id="radioType_${status.count}" name="fieldTyCd_${status.count}" value="radio" ${result.fieldTyCd=='radio'?'checked':''} />radio</label>
					<label><input type="radio" id="checkboxType_${status.count}" name="fieldTyCd_${status.count}" value="checkbox" ${result.fieldTyCd=='checkbox'?'checked':''} />checkbox</label>
					<label><input type="radio" id="selectType_${status.count}" name="fieldTyCd_${status.count}" value="select" ${result.fieldTyCd=='select'?'checked':''} />select</label>
				</span>
			</td>
			<td>
				<input type="checkbox" id="chk_${status.count}" name="listUseAt_${status.count}" value="Y" <c:if test="${result.listUseAt eq 'Y'}"> checked</c:if> />
			</td>
		</tr>
	</c:forEach>
	<c:if test="${fn:length(fieldAttributes) == 0}" >
		<tr><td colspan="5" class="nodata">데이터가없습니다.</td></tr>
	</c:if>
	</tbody>
	</table>
</div>
<!-- board list end //-->
</form>

<div class="btnSet">
	<a class="b-reg" href="javascript:void(0);" onclick="save();"><span>등록</span></a>
</div>