<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<script>
$(function() {
	$('#btnInsertContact').click(function(e){
	    $("#formContact input[name='act']").val('insert');
	    if ($("#formContact input:text[name='ccRel']").val().length<1 || $("#formContact input:text[name='ccName']").val().length<1) {
	        alert('내용을 입력해주세요');
	        return false;
	    }
	    $.ajax({
	        type:"post",
	        url:"/bos/instance/case/insertContact.json" ,
	        data: $("#formContact").serialize(),
	        dataType: "json",
	        success:function(entry){
	        	window.location.reload();
	            $("#formContact input:text[name='ccRel']").val("");
	            $("#formContact input:text[name='ccName']").val("");
	            $("#formContact input:text[name='ccPhone']").val("");
	            $("#formContact input:text[name='ccEmail']").val("");
	            $("#formContact input:text[name='ccMemo']").val("");
	        }, error: function(xhr,status,error){
	            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
	        }
	    });
	});
	
	$('#btnInsertSms').click(function() {
	    //신규문자시스템
// 	    popupOpenSms('');

	    //기존문자시스템
	    /*
	    if ( ekrIsMSIE() ) {
	        var myWindow = window.open("/sun/sms/sms_form.asp", "wncsmssystem_window", "width=950,height=600");
	    } else {
	        alert('문자는 인터넷 익스플로러에서만 발송이 가능합니다');
	    }
	    */
	    
	});

	$('#btnCaseContactPrint').click(function(e) {
// 	    e.preventDefault();
// 	    var thisSeq = $(this).attr("title");
<%-- 	    var myWindow = window.open("/case/print/"+ thisSeq +".asp?case_seq=<%=case_seq%>", "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no"); --%>
	});
	
	$('#btnInsertSms').click(function() {
		popupOpenSms('');
	});

});

function popupOpenSms(telNumber){
	var popUrl = "/bos/system/sms/form.do?viewType=CONTBODY&menuNo=${param.menuNo}&caseSeq=${param.caseSeq}&rphone=" + telNumber;
	var popOption = "width=720, height=700, resizable=yes, scrollbars=yes, status=no";
	window.open(popUrl, "", popOption);
}

function clickButtonModify(ccSeqC) {
	$("#trModify"+ccSeqC).show();
	$("#trView"+ccSeqC).hide();
}

function clickButtonCancel(ccSeqC) {
	$("#trModify"+ccSeqC).hide();
	$("#trView"+ccSeqC).show();
}

function clickButtonUpdate(ccSeqC) {
    if ($("#ccRel_"+ccSeqC).val() == "" || $("#ccName_"+ccSeqC).val() == "") {
        alert('내용을 입력해주세요');
        return false;
    }
    $.ajax({
        type:"post",
        url:"/bos/instance/case/updateContact.json" ,
        data: {
        	ccSeq : $("#ccSeq_"+ccSeqC).val(),
        	ccRel : $("#ccRel_"+ccSeqC).val(),
        	ccName : $("#ccName_"+ccSeqC).val(),
        	ccPhone : $("#ccPhone_"+ccSeqC).val(),
        	ccEmail : $("#ccEmail_"+ccSeqC).val(),
        	ccMemo : $("#ccMemo_"+ccSeqC).val(),
        	caseSeq : "${result.caseSeq}",
        	historyMemo : $("#ccName_"+ccSeqC).val()+"님의 연락처를 수정했습니다."
		},
        dataType: "json",
        success:function(entry){
        	window.location.reload();
            $("#formContact input:text[name='ccRel']").val("");
            $("#formContact input:text[name='ccName']").val("");
            $("#formContact input:text[name='ccPhone']").val("");
            $("#formContact input:text[name='ccEmail']").val("");
            $("#formContact input:text[name='ccMemo']").val("");
        }, error: function(xhr,status,error){
            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
        }
    });
}

function clickButtonDelete(ccSeqC) {
	//항목 지우기
 	if(confirm('항목을 삭제하시겠습니까?')) {
 		$.ajax({
 	        type:"post",
 	        url:"/bos/instance/case/deleteContact.json" ,
 	        data: {
 	        	ccSeq : $("#ccSeq_"+ccSeqC).val(),
 	        	caseSeq : "${result.caseSeq}",
 	        	historyMemo : $("#ccName_"+ccSeqC).val()+"님의 연락처를 삭제했습니다."
 			},
 	        dataType: "json",
 	        success:function(entry){
 	        	window.location.reload();
 	            $("#formContact input:text[name='ccRel']").val("");
 	            $("#formContact input:text[name='ccName']").val("");
 	            $("#formContact input:text[name='ccPhone']").val("");
 	            $("#formContact input:text[name='ccEmail']").val("");
 	            $("#formContact input:text[name='ccMemo']").val("");
 	        }, error: function(xhr,status,error){
 	            alert('데이터를 삭제하지 못했습니다.\n이유 : '+ error);
 	        }
 	    });
     }
}


// function popupOpenSms(telNumber){
<%-- 	var popUrl = "/system/sms/sms_form.asp?case_seq=<%=case_seq%>&rphone="+ telNumber;	//팝업창에 출력될 페이지 URL --%>
// 	var popOption = "width=720, height=600, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
// 	window.open(popUrl,"",popOption);
// }

// function popupOpenSmsContact(telNumber){
<%-- 	var popUrl = "/system/sms/sms_form.asp?case_seq=<%=case_seq%>&rphone="+ telNumber;	//팝업창에 출력될 페이지 URL --%>
// 	var popOption = "width=720, height=700, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
// 	window.open(popUrl,"",popOption);
// }

// function fn_smsjqgrid_reload() {
//     //console.log('sms loaded');
//     jQuery("#jqDataSmsList")
<%--         .jqGrid('setGridParam',{url:"/system/sms/sms_run.asp?act=list&case_seq=<%=case_seq%>", page:1}) --%>
//         .trigger('reloadGrid');
// }




</script>

<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
	<ul>
		<li class="" ><a href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
		<li><a href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li  class="" ><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li class=""><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li class="" ><a href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li class="active" ><a href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li class="" ><a href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">관리</a></li>
	</ul>
</div>
<br/>
<h4>연락처</h4>
    <div style="margin-bottom:5px;">
        <span>결과: <strong class="f_blue" id="txtTotalRecordContactCount">${resultContactCnt}</strong>건</span>
    </div>
    <div style="width:100%;">
    	<form id="formContactView" class="pure-form" method="post">
	        <table class="table table-striped table-hover" id="tbContact" >
				<thead>
					<tr>
					    <th style="width:15% " scope="col">피해자와의 관계</th>
						<th style="width:15% " scope="col">이름</th>
						<th style="width:15% " scope="col">전화번호</th>
						<th style="width:15% " scope="col">메일</th>
						<th style="width: " scope="col">메모</th>
						<th style="width:13% " scope="col">관리</th>
						<th style="width:8% " scope="col">삭제</th>
					</tr>
				</thead>
				<tbody id="passTbody">
					<c:forEach var="result" items="${resultContactList}" varStatus="status">
						<tr id="trView${result.ccSeqC}">
							<td>${result.ccRel}</td>
							<td>${result.ccName}</td>
							<td><a href="javascript:popupOpenSms('${result.ccPhone }');">${result.ccPhone}</a></td>
							<td>${result.ccEmail}</td>
							<td>${result.ccMemo}</td>
							<td>
								<a onclick="clickButtonModify('${result.ccSeqC}');" class="pure-button btnUpdate">수정</a>
								<a onclick="clickButtonUpdate('${result.ccSeqC}');" class="pure-button btnUpdate">저장</a>
							</td>
							<td>
								<a onclick="clickButtonDelete('${result.ccSeqC}');" class="pure-button btnDelete">삭제</a>
							</td>
						</tr>
						<tr id="trModify${result.ccSeqC}" style="display: none;">
							<td>
								<input type="hidden" id="ccSeq_${result.ccSeqC}" name="ccSeq_${result.ccSeqC}" value="${result.ccSeq}" />
								<input type="text" id="ccRel_${result.ccSeqC}" name="ccRel_${result.ccSeqC}" value="${result.ccRel}" />
							</td>
							<td><input type="text" id="ccName_${result.ccSeqC}" name="ccName_${result.ccSeqC}" value="${result.ccName}" /></td>
							<td><input type="text" id="ccPhone_${result.ccSeqC}" name="ccPhone_${result.ccSeqC}" value="${result.ccPhone}" /></td>
							<td><input type="text" id="ccEmail_${result.ccSeqC}" name="ccEmail_${result.ccSeqC}" value="${result.ccEmail}" /></td>
							<td><input type="text" id="ccMemo_${result.ccSeqC}" name="ccMemo_${result.ccSeqC}" value="${result.ccMemo}" /></td>
							<td>
								<a onclick="clickButtonCancel('${result.ccSeqC}');" class="pure-button btnUpdate">취소</a>
								<a onclick="clickButtonUpdate('${result.ccSeqC}');" class="pure-button btnUpdate">저장</a>
							</td>
							<td>
								<a onclick="clickButtonDelete('${result.ccSeqC}');" class="pure-button btnDelete">삭제</a>
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultContactList) == 0}">
						<tr>
						    <td colspan="7">데이터가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
		    </table>
		</form>
    </div>
    

    
    
    <div style="padding-top:20px;">
        <form id="formContact" class="pure-form">
	        <table class="table02">
	            <colgroup>
	                <col width="15%;" />
	                <col width="15%;" />
	                <col width="20%;" />
	                <col width="25%;" />
	                <col width="15%;" />
	                <col width="10%;" />
	            </colgroup>
	            <thead>
	                <tr>
	                    <th>피해자와의 관계</th>
	                    <th>이름</th>
	                    <th>전화번호</th>
	                    <th>메일</th>
	                    <th>메모</th>
	                    <th>저장</th>
	                </tr>
	            </thead>
	            <tbody>
	                <tr>
	                    <td>
	                        <input type="hidden" name="act" />
	                        <input type="hidden" name="caseSeq" value="${result.caseSeq}" />
	                        <input type="text" name="ccRel" class="form-control" style="width:100%;" />
	                    </td>
	                    <td>
	                        <input type="text" name="ccName" class="form-control" style="width:100%;" />
	                    </td>
	                    <td>
	                        <input type="text" name="ccPhone" class="form-control" style="width:100%;" />
	                    </td>
	                    <td>
	                        <input type="text" name="ccEmail" class="form-control" style="width:100%;" />
	                    </td>
	                    <td>
	                        <input type="text" name="ccMemo" class="form-control" style="width:100%;" />
	                    </td>
	                    <td>
	                        <button id="btnInsertContact" class="pure-button pure-button-primary" style="width:100%;">추가</button>
	                    </td>
	                </tr>
	            </tbody>
	        </table>
        </form>
    </div>

    <div class="btnGroup">

<%-- <% If true Then %> --%>
        <input type="submit" id="btnInsertSms" class="pure-button btnInsert" value="문자발송">
<%-- <% End If %> --%>

        <button id="btnCaseContactPrint" title="print4-6" class="pure-button btnInsert btnCasePrintView">출력</button>
    
    </div>

    <br><br>

		
<%-- <% If true Then %> --%>
    <h4>SMS 발송 리스트</h4>
    <div id="divViewSms" style="width:100%;">      
        <div style="width:100%;">
                  <table class="table table-striped table-hover" id="tbCase">
	            <caption>사례 목록</caption>
	            <thead>
	                <tr>
	                    <th style="width:20%" scope="col">발송일</th>
	                    <th style="width:10%" scope="col">발송자</th>
	                    <th style="width:20%" scope="col">수신번호</th>
	                    <th style="width:" scope="col">발신내용</th>
	                    <th style="width:10%" scope="col">발송형태</th>
	                </tr>
				</thead>
				<tbody>
		           <c:forEach var="result" items="${resultList}" varStatus="status">
		               <tr>
	                       <td>${result.sendDate}</td>
	                       <td>${result.userName}</td>
	                       <td>${result.rPhone}</td>
	                       <td>${result.msg}</td>
	                       <td>${result.smsType }MS</td>
		               </tr>
	                </c:forEach>
	                <c:if test="${fn:length(resultList) == 0}">
	                    <tr>
	                        <td colspan="5">데이터가 없습니다.</td>
	                    </tr>
	                </c:if>
	            </tbody>
	        </table>
			<c:if test="${fn:length(resultList) > 0}">
				${pageNav}
			</c:if>
        </div>
    </div>
<%-- <% End If %> --%>

        <script>
            $('.btnCasePrintView').click(function(e) {
                e.preventDefault();
                var thisSeq = $(this).attr("title");
                var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
            });
        </script>