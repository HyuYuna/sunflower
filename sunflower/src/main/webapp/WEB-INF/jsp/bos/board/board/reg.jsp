<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<fmt:parseNumber integerOnly='true' value='${result.bddSeq }' var="seq" />

<script>
//센터 출력
fnCodeDepthCheckbox = function(gCode){
	//통합형 서울북부해바라기센터, 전남서부해바라기센터제외
	$.ajax({
		url: "/bos/board/board/checkboxCodeList.json",
		type: "post",
		data: { sCode: "CM05", gCode: gCode },
		async:false,
		success:function (data) {
			for(i=0;i<data.codeList.length;i++){
				var checkbox = "<span style='display:inline-block; width:200px; padding20px 0;'>"
					+ "<input type='checkbox' name='chekBddTarget' id='checkBddTarget" + data.codeList[i].cdNo + "' value='" + data.codeList[i].cdNo + "'>"
					+ "<label for='checkBddTarget" + data.codeList[i].cdNo + "'>" + data.codeList[i].cdNm + "</label></span>";
				$("#divCenterListCheck" + gCode).append(checkbox);
			}
		}
	});
};
</script>

<div>
	<form name="formBoard" id="formBoard" method="post" class="pure-form" enctype="multipart/form-data">
		<input type="hidden" name="menuNo" value="${param.menuNo }"/>
		<input type="hidden" name="act" value="C" />
		<input type="hidden" name="bdsSeq" id="bdsSeq" value="${empty result ? 'demand' : result.bdsSeq }" />
		<input type="hidden" name="bddSeq" id="bddSeq" value="${result.bddSeq }" />
		<input type="hidden" name='bddDateWorkb' value="2000-01-01" class="jQueryDatepickers"> 
		<input type="hidden" name='bddDateWorke' value="2099-01-01" class="jQueryDatepickers">
		<input type="hidden" name='bddUser' value="${userVO.userId }"/>
		<input type="hidden" name='bddTarget' id="bddTarget" />
		
		<table cellpadding="0" cellspacing="1" border="0" class="table01">
			<colgroup>
				<col width="130px;" />
				<col width="" />
				<col width="130px;" />
				<col width="" />
			</colgroup>
			<thead>
				<tr>
					<th colspan="20">기본정보<span id="divPageStateMessage" class="ml10" style="color: orange;"></span></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th class='ac'>작성자 </th>
					<td colspan=3><input type='text' id='bddWriter' name='bddWriter' value='${empty result ? userVO.userNm : result.bddWriter }' style='width: 100%;' readonly /></td>
				</tr>
				<tr>
					<th class='ac'>제목</th>
					<td colspan=3><input type='text' id='bddTitle' name='bddTitle' value='${result.bddTitle }' style='width: 100%;' /></td>
				</tr>

				<tr>
					<th class='ac'>내용</th>
					<td colspan=3>
						<textarea id="bocontents" name="bocontents" rows="30" hidden style="display:none;" class="textarea">
							<c:if test="${not empty result }"><util:out escapeXml="false">${result.bddContent}</util:out></c:if>
						</textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true"/>
					</td>
				</tr>
				<tr>
					<th class='ac'>공지여부</th>
					<td colspan=3>
						<input type='radio' name='bddNotice' id="bddNotice1" value='1' ${result.bddNotice eq '1' ? 'checked' : ''}/> <label for="bddNotice1">공지함</label>
						<input type='radio' name='bddNotice' id="bddNotice0" value='0' ${result.bddNotice eq '0' || empty result ? 'checked' : ''} /> <label for="bddNotice0">공지하지않음</label>
					</td>
				</tr>
				<tr style="height: 30px;">
					<th class='ac'>회신구분</th>
					<td colspan=3>
						<input type='radio' name='bddDataType' value='B' id="bddDataTypeB" ${result.bddDataType eq 'B' || empty result ? 'checked' : ''} /> <label for="bddDataTypeB">회신필요없음</label>
						<input type='radio' name='bddDataType' value='A' id="bddDataTypeA" ${result.bddDataType eq 'A' ? 'checked' : ''} /> <label for="bddDataTypeA">회신요청(첨부파일)</label>
						<input type='radio' name='bddDataType' value='C' id="bddDataTypeC" ${result.bddDataType eq 'C' ? 'checked' : ''} /> <label for="bddDataTypeC">회신요청(댓글)</label>
					</td>
				</tr>
				<tr>
					<th class='ac'>대상센터</th>
					<td colspan=3 style="padding-top: 15px;">
						<input type='checkbox' name='chekBddTarget1All' value='' id='chekBddTarget1All' /><label for='chekBddTarget1All' class="checkListAllLabel">해바라기센터-위기지원형 전체선택</label>
						<div id="divCenterListCheck1" class="checkListArea">
							<script>
								fnCodeDepthCheckbox(1);
							</script>
						</div> 
						<input type='checkbox' name='chekBddTarget2All' value='' id='chekBddTarget2All' /><label for='chekBddTarget2All' class="checkListAllLabel">해바라기센터-아동형 전체선택</label>
						<div id="divCenterListCheck2" class="checkListArea">
							<script>
								fnCodeDepthCheckbox(2);
							</script>
						</div> 
						<input type='checkbox' name='chekBddTarget3All' value='' id='chekBddTarget3All' /><label for='chekBddTarget3All' class="checkListAllLabel">해바라기센터-통합형 전체선택</label>
						<div id="divCenterListCheck3" class="checkListArea">
							<script>
								fnCodeDepthCheckbox(3);
							</script>
						</div>

						<div id="divCenterListCheck7" class="checkListArea">
							<script>
								fnCodeDepthCheckbox(7);
							</script>
						</div>

						<div id="divCenterListCheckI" class="checkListArea">
							<script>
								fnCodeDepthCheckbox("I");
							</script>
						</div>
						
						<script>
							/*******************************************************
							 * 체크박스 전체 선택
							 */
							var checkAllSubName= "chekBddTarget";	//여기만 수정해요
							$("#"+ checkAllSubName +"1All").click(function(){
								setCheckBoxAllSelectByClass9(this, checkAllSubName, "divCenterListCheck1");
							});
							$("#"+ checkAllSubName +"2All").click(function(){
								setCheckBoxAllSelectByClass9(this, checkAllSubName, "divCenterListCheck2");
							});
							$("#"+ checkAllSubName +"3All").click(function(){
								setCheckBoxAllSelectByClass9(this, checkAllSubName, "divCenterListCheck3");
							});
							
							$(document).on('click', "#divCenterListCheck1 input[name='"+ checkAllSubName +"']", function(e) {
								if (!$(this).is(':checked')) {
									setCheckBoxAllLease9(checkAllSubName +"1All");
								}
							});
							$(document).on('click', "#divCenterListCheck2 input[name='"+ checkAllSubName +"']", function(e) {
								if (!$(this).is(':checked')) {
									setCheckBoxAllLease9(checkAllSubName +"2All");
								}
							});
							$(document).on('click', "#divCenterListCheck3 input[name='"+ checkAllSubName +"']", function(e) {
								if (!$(this).is(':checked')) {
									setCheckBoxAllLease9(checkAllSubName +"3All");
								}
							});
							/*******************************************************/
						</script>
					</td>
				</tr>
			</tbody>
		</table>

		<!-- 파일 업로드 -->
		<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileUploadZone.jsp" flush="true">
			<jsp:param value="demand" name="subFileGroup" />
			<jsp:param value="${seq }" name="subFileCode" />
			<jsp:param value="" name="subFilecodeSub" /> 
			<jsp:param value="" name="afterUrl" />
			<jsp:param value="5" name="fileCnt" />
		</jsp:include>
	</form>
</div>

<div class="btnGroup">
	<img id="goSubmit" src="/static/bos/image/common/btn_send.png" style="cursor:pointer" alt="문서발신" />
	<img id="goView" src="/static/bos/image/common/btn_cancel.png" style="cursor:pointer" alt="수정취소" />
</div>

<script>
    var selectedCenter = '${result.bddTarget}';
    
	$(function() {
		var center = selectedCenter.split(",");
		
		$(center).each(function(idx){
			$("#checkBddTarget" + center[idx].trim()).prop("checked", true);
			//alert(center[idx]);
		});
	});

	setInterval(function() {
		document.getElementById("bocontents").value = oEditors.getById["bocontents"].getIR(); //editor 내용 저장
		
		//대상센터 추가
		var chkArray = new Array();
		$("input:checkbox[name=chekBddTarget]:checked").each(function(){
			chkArray.push(this.value);
		});
		
		if(chkArray.length > 0){
			$("#bddTarget").val(chkArray);
		}
		
		$.ajax({
			url : "/bos/board/board/autoSave.json", 
			type : "post",
			data : $("#formBoard").serialize(),
			success : function(data) {
				if(data.resultCode=="success") {
					$("#divPageStateMessage").html(data.resultMessage);
	                
					if($("#bddSeq").val() == ''){
						$("#bddSeq").val(data.bsq);
						$("#cmFileUploadCode").val(parseInt(data.bsq));
					}
				} else {
					$("#divPageStateMessage").html("자동저장에 실패했습니다");
				}
			}
		});
    }, 60000); //1분마다 자동저장한다

	$("#formBoard").validate({
		rules: {
			bddTitle: { required: true }
		},
		messages: {
			bddTitle: { required: "제목을 입력해 주세요" }
		}

    });

	$('#goSubmit').click(function() {

		//if(jQuery('#cmUploadFile_file').val().length > 0 ){
		//	alert("선택하신 첨부파일이 있습니다. 첨부하시려면 [추가] 버튼을 클릭해 주세요!");
        //	return false;
		//}

		if ($("#formBoard").valid()) {
			// 내용
			if (oEditors.getById["bocontents"].getIR() == "<p><br></p>") {
				alert("내용을 입력해주세요.");
				oEditors.getById["bocontents"].exec("FOCUS", []);
				return false;
			}
			document.getElementById("bocontents").value = oEditors.getById["bocontents"].getIR();
			
			//대상센터 추가
			var chkArray = new Array();
			$("input:checkbox[name=chekBddTarget]:checked").each(function(){
				chkArray.push(this.value);
			});
			
			if(chkArray.length > 0){
				$("#bddTarget").val(chkArray);
			}

			if(!$("#bddSeq").val()){
				$("#formBoard").attr("action", "/bos/board/board/insert.do");
			} else {
				$("#formBoard").attr("action", "/bos/board/board/update.do");
			}
	        
	        $("#formBoard").submit();
		} else {
            alert("필수입력사항을 조건에 맞추어 입력해주세요");
        }
	});

	$('#goList').click(function() {
		$('#formBoard').attr('action', '/bos/board/board/list.do');
		$('#formBoard').submit();
	});

	$('#goView').click(function() {
		location.href="/bos/board/board/list.do?${pageQueryString}";
	});

    //뒤로가기 기능 제거
    /*
    history.pushState(null, null, "#noback");
    $(window).bind("hashchange", function(){
        history.pushState(null, null, "#noback");
    });
    */
</script>