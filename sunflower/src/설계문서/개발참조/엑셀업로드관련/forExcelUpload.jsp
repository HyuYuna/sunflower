<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript">
$(function() {

});

function checkForm() {

	if ($("#file_1").val() != "") {
		var ext = $('#file_1').val().split('.').pop().toLowerCase();
		if ($.inArray(ext, [ 'xls', 'xlsx']) == -1) {
			alert('xls,xlsx 파일만 업로드 할수 있습니다.');
			return;
		}

	}else{
		alert('xls, xlsx 파일을 업로드 하기고 등록 하시기 바랍니다.');
		return;
	}

	document.board.submit();
}
</script>

<div id="topDesc" class="topDesc">
	<ul>
		<li>해당게시판은 마지막으로 작성된 내용이 안내메세지로 노출됩니다.</li>
	</ul>
</div>


<form id="board" name="board" method="post" enctype="multipart/form-data" action="/bos/freecheck/chckBssh/uploadExcel.do">
	<input type="hidden" name="menuNo" value="${param.menuNo }" />
	<div class="bdView">
		<table summary=" ${masterVO.bbsDc} 포함">
			<caption>${masterVO.bbsNm} - ${empty result ? '쓰기' : '수정'}</caption>
			<colgroup>
				<col style="width: 15%" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" style="width:15%">
						<span class="req"><span class="sr-only">필수입력</span></span><label for="file_1">엑셀파일</label>
					</th>
					<td>
						<input name="file_1" type="file" id="file_1" class="input_file form-control" title="첨부파일 1" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="btnSet">
		<button type="button" onclick="checkForm()" class="b-reg">등록</button>
	</div>
</form>
