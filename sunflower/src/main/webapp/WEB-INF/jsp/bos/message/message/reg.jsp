<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/message/message/insert.do" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/message/message/update.do" />
</c:if>
<c:if test="${not empty re }">
	<c:set var="reTitle" value="Re : ${re.title }" />
</c:if>

<script>
$(function(){
	//센터 유형별 동적 option 출력
	fnCodeDepthSelect = function() {
		$("#srcCntrCod").empty();
		$.ajax({
			url : "/bos/message/message/searchCodeList.json",
			type : "post",
			data : {
				sCode : "CM05",
				gCode : $("#srcCntrGbn").val()
			},
			async : false,
			success : function(data) {
				for (i = 0; i < data.titleList.length; i++) {
					var selected = "";
					if(data.titleList[i].cdNo == data.centerCode){
						selected = "selected";
					}
					var optionAppend = $("<option value='" + data.titleList[i].cdNo + "' " + selected + ">" + data.titleList[i].cdNm + "</option>")
					$("#srcCntrCod").append(optionAppend);
				}
				fnNameDepthSelect();
			}
		});
	};
	
	//센터 유형별 동적 option 출력
	fnNameDepthSelect = function() {
		$("#receiver").empty().append("<option value=''>수신인선택</option>");
		$.ajax({
			url : "/bos/message/message/searchCenterNameList.json",
			type : "post",
			data : {
				centerCode : $("#srcCntrCod").val(),
				state : "Y"
			},
			async : false,
			success : function(data) {
				for (i = 0; i < data.nameList.length; i++) {
					var optionAppend = $("<option value='" + data.nameList[i].userId + "' >" + data.nameList[i].userName + "</option>")
					$("#receiver").append(optionAppend);
				}
			}
		});
	};
	
	fnCodeDepthSelect();
});
</script>
<form id="formMain" class="pure-form" action="${action}" method="post" enctype="multipart/form-data">
	<input type="hidden" name="menuNo" value="${param.menuNo }"/>
	
	<table class="table03">
		<colgroup>
			<col width="20%"/>
			<col width="80%"/>
		</colgroup>
		<thead>
			<tr>
				<th colspan="2">메일 보내기</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="title" id="msgTitle" style="width:100%;" value="${reTitle}"/>
				</td>
			</tr>
			<tr>
				<th rowspan="2">수신인</th>
				<td>
					<input type="text" id="receiverX" name="receiverX" style="width:100%;" value="${re.wuserNm }" readonly="readonly">
					<input type="hidden" id="receiverS" name="receiverS" value="${re.wuser }">
				</td>
			</tr>
			<tr>
				<td>
					<select id="srcCntrGbn" name="srcCntrGbn" onchange="fnCodeDepthSelect()" style="width:25%;">
						<c:forEach var="result" items="${codeList}" varStatus="status">
							<option value="${result.cdNo }" ${fn:substring(userVO.centerCode, 0, 1) eq result.cdNo ? 'selected' : '' }>${result.cdNm }</option>
						</c:forEach>
					</select>
					<select id="srcCntrCod" name="srcCntrCod" onchange="fnNameDepthSelect()" style="width:40%;">
					</select>
					<select id="receiver" name="receiver" style="width:20%">
					</select>
					<button id="btnAddReceiver" class="pure-button btnInsert">추가</button>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="content" style="width:100%; height:200px;"><c:if test="${not empty re.title }">
원본글 :
--------------------------------------------------------------
${re.content }
--------------------------------------------------------------
</c:if></textarea>
				</td>
			</tr>
		</tbody>
	</table>
	
	<!-- 파일 없로드 -->
	<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileUploadZone.jsp" flush="true">
		<jsp:param value="message" name="subFileGroup" />
		<jsp:param value="${result.messageSeq }" name="subFileCode" />
		<jsp:param value="" name="subFilecodeSub" /> 
		<jsp:param value="" name="afterUrl" />
		<jsp:param value="5" name="fileCnt" />
	</jsp:include>
</form>

<div class="btnGroup">
	<button id="btnSave" class="pure-button btnSave">발송</button>
	<button id="btnList" class="pure-button btnCancel">취소</button>
</div>

<script>
	var $VAR_FORM_ID = "formMain";
	
	$('#btnSave').click(function(e) {
	    
		e.preventDefault();
	
		var receiverS = $('#receiverS').val();
		var msgTitle  = $('#msgTitle').val();
	
	    if(msgTitle.length<2) {
			alert('제목을 입력해주세요');
			$("#msgTitle").focus();
		} else if(receiverS.length<2) {
			alert('수신인을 선택후 추가해주세요');
		} else {
			$("#formMain")[0].submit();
	    }
	
	});
	
	$('#btnDelete').click(function() {
	    location.href = "/bos/message/list.do?${pageQueryString}";
	});
	
	$('#btnAddReceiver').click(function(e) {
	    
	    e.preventDefault();
	
	    if ( $("#receiver option:selected").val().length>1 ){
	
	        var inputx = $("#receiverS");
	        var strx = inputx.val();
	        if (strx.length>0) strx += ",";
	        strx += $("#receiver option:selected").val() +",";
	
	        inputx.val( strx.substr(0, strx.length -1) );
	
	        var inputs = $( "#receiverX" );
	        var strs = inputs.val();
	        if (strs.length>0) strs += ",";  
	        strs += $("#receiver option:selected").text() +",";
	
	        inputs.val( strs.substr(0, strs.length -1) );
	    } 
	});
	
	$('#btnList').click(function(e) {
	    
	    e.preventDefault();
		
		location.href = '/bos/message/message/list.do?${pageQueryString}';
	});
	
	//센터구분변경시 하위 옵션 변경 : 옵션(3)-$VAR_OPTION_CENTER, CENTER_GBN, CENTER_CODE
	$VAR_OPTION_CENTER = $.getSelectSubOptions($VAR_FORM_ID, 'CENTER_CODE');
	$("#"+ $VAR_FORM_ID +" select[name='CENTER_GBN']").change(function() {
	    fnc_SUB_SELECT_CHANGE($VAR_FORM_ID, 'CENTER_GBN', 'CENTER_CODE', $VAR_OPTION_CENTER );
	    
	    setTimeout(function(){ 
	        var CENTER_CODE = $('#CENTER_CODE').val();
	        setUserSelectByCenterChoice( CENTER_CODE );
	    }, 500);
	});
	fnc_SUB_SELECT_CHANGE($VAR_FORM_ID, 'CENTER_GBN', 'CENTER_CODE', $VAR_OPTION_CENTER );
	//End : 센터구분변경시 하위 옵션 변경  
	
	
	/* //센터 변경시 사용자의 리스트가 변경이 되도록 처리
	$('#centerCode').change( function() {
	    var centerCode = $(this).val();
	    setUserSelectByCenterChoice( centerCode );
	} );
	setUserSelectByCenterChoice( '${userVO.centerCode}' );
	
	 function setUserSelectByCenterChoice(CENTER_CODE) {
	    $('#RECEIVER').find('option').each( function() { $(this).remove(); } ).end().append("<option value=''>수신인선택</option>") ;
	
	    $.getJSON("/user/json/get_center_user.asp", { center_code: CENTER_CODE , ADMSN_YN: "Y" , "nocache": new Date().getTime() }, function(data1) {
	        $.each(data1, function(index, entry) {
	            $('#RECEIVER').append("<option value='"+ entry["USER_ID"] +"'>"+ entry["USER_NAME"] +"</option>") ;
	        });
	    });
	} */
</script>