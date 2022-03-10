<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/schdul/schdul/insert.do" />
	<c:set var="actionName" value="등록" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/schdul/schdul/update.do" />
	<c:set var="actionName" value="수정" />
</c:if>

<script>
$(function() {
	$('.formatTime').numeric({allow:":"}).mask("99:99")
    .css("width", "60px").css("ime-mode", "disabled").css("text-align", "center")
    .blur(function() {
      if ( RegularTime24Format( $(this).val() ) ) {      
      } else {
        if($(this).val().length>0) {
          alert("시간은 21:33 형식으로 입력해야 합니다.\r\n[ 00:00부터 23:59까지 입력 가능 ]");
        }
        $(this).val("00:00");
      }
    });
});  
</script>
<form id="listForm" name="listForm" action="${action }" method="post" enctype="multipart/form-data">
	<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo }" /> 
	<input type="hidden" name="schdulSn" id="schdulSn" value="${result.schdulSn}" />
	<input type="hidden" name="userId" value="${userVO.userId}" />
	<input type="hidden" name="userNm" value="${userVO.userNm}" />
	
	<div class="bdView">
		<table>
			<caption>일정관리 폼</caption>
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>구분</th>
					<td colspan="3">
						<select name="sclas" id="sclas" title="구분" >
							<script>
								getCmmnCd.select('SCLAS', 'sclas', '${result.sclas}');
							</script>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>일정명</th>
					<td colspan="3"><input type="text" name="lclas" id="lclas" style="text-transform: uppercase;" value="${result.lclas }" size="60" maxlength="32" class="w20p" title="일정명" /></td>
				</tr>
				<tr>
					<th scope="row">세부 일정명</th>
					<td colspan="3"><input type="text" name="mlsfc" id="mlsfc" style="text-transform: uppercase;" value="${result.mlsfc }" size="60" maxlength="32" class="w30p" title="세부일정명" /></td>
				</tr>
				<tr>
					<th scope="row">장소</th>
					<td colspan="3"><input type="text" name="placeNm" id="placeNm" style="text-transform: uppercase;" value="${result.placeNm }" size="60" maxlength="32" class="w30p" title="세부일정명" /></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>일정기간</th>
					<td>
						<input id="bgnde" name="bgnde" value="${result.bgnde}" readonly="readonly" type="text" class="sdate" title="게시시작일" /> ~
						<input id="endde" name="endde" value="${result.endde}" readonly="readonly" type="text" class="edate" title="게시종료일" />
					</td>
					<th scope="row">시간</th>
					<td>
						<input type="text" name="timeBgnde" id="timeBgnde" value="" class="formatTime"> ~
                        <input type="text" name="timeEndde" id="timeEndde" value="" class="formatTime">
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>공개구분</th>
					<td colspan="3">
						<div id="div_OTHBC_SE" > 
                        	<script>
                          		getCmmnCd.radio('OTHBC_SE', 'div_OTHBC_SE', 'othbcSe', '${result.othbcSe}');
                          	</script>
                        </div>
					</td>
				</tr>
				<tr>
					<th>상세정보</th>
					<td class="outputEditor" colspan="3">
						<textarea id="bassInfo" name="bassInfo" cols="150" rows="30" style="display: none;" class="textarea" title="내용">
						<c:out value="${result.bassInfo}" escapeXml="false"/>
						</textarea> 
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"><jsp:param name="target" value="bassInfo" /></jsp:include>
					</td>
				</tr>
				<tr>	
					<th>파일첨부</th>
					<td colspan="3">
						<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileUploadZone.jsp" flush="true">
							<jsp:param value="schdul" name="subFileGroup" />
							<jsp:param value="${result.schdulSn }" name="subFileCode" />
							<jsp:param value="" name="subFilecodeSub" /> 
							<jsp:param value="" name="afterUrl" />
							<jsp:param value="10" name="fileCnt" />
						</jsp:include>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">
	<a class="pure-button btnInsert" href="javascript:void(0);" id="saveBtn">${actionName } </a> 
	<a class="pure-button btnList" href="/bos/schdul/schdul/list.do?${pageQueryString}"> 목록 </a>
</div>

<script>
	$("#saveBtn").click(function() {
		var varFrom = $("#listForm")[0];
		var v = new MiyaValidator(varFrom);
		
		v.add("lclas", {
			required : true
		});
		v.add("bgnde", {
			required: true
		});
		v.add("endde", {
			required: true
		});
		
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}
		
		if($('input:radio[name=othbcSe]').is(':checked') == false){
			alert("공개구분을 선택하세요.");
			return
		}
		
		var b = $('#bgnde').val();
		var e = $('#endde').val();
		if (b > e) {
			alert('공지기간 종료일이 시작일보다 작습니다.');
			return;
		}

// 		if (oEditors.getById["bassInfo"].getIR() == "<p><br></p>") {
// 			alert('내용을 입력해 주세요.');
// 			oEditors.getById["bassInfo"].exec("FOCUS", []);
// 		    return;
// 		}
	
		document.getElementById("bassInfo").value = oEditors.getById["bassInfo"].getIR();

		if (confirm("${actionName } 하시겠습니까?")) {
			varFrom.submit();
		}
		return false;

	});
</script>

