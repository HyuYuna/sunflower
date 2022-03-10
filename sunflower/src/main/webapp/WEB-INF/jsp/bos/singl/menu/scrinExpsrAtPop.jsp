<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>

function updateScrinExpsrAt(sMenuNo) {
	var scrinExpsrAt = $("input[name=scrinExpsrAt]:checked").val();
	$.post(
		"/bos/singl/menu/updateScrinExpsrAt.json",
		{sMenuNo:sMenuNo, scrinExpsrAt:scrinExpsrAt},
		function(data) {
			var resultCode = data.resultCode;
			var resultMsg = data.msg;
			alert(resultMsg);
			if(resultCode == "success") location.reload();
		}
	)
}
</script>

<h1>하위메뉴일괄적용</h1>
<form name="frm" enctype="multipart/form-data" action="/bos/singl/menu/scrinExpsrAtPop.do" method="post">
	<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo}"/>
	<input type="hidden" name="sMenuNo" id="sMenuNo" value="${paramVO.sMenuNo}"/>
	<input type="hidden" name="viewType" id="viewType" value="${paramVO.viewType}"/>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="view">
		<dl>
			<dt>
				하위메뉴일괄적용
			</dt>
			<dd>
				<label> <input type="radio" id="scrinExpsrAt1" name="scrinExpsrAt" value="Y" /> 노출</label>
				<label> <input type="radio" id="scrinExpsrAt2" name="scrinExpsrAt" value="N" /> 미노출 </label>
				<button type="button" onclick="javascript:updateScrinExpsrAt('${paramVO.sMenuNo}')" class="b-edit">적용</button>
			</dd>
		</dl>

	</div>
</form>
