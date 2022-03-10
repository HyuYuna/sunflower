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
});

function btnFinish(index) {
	var memo 
	if(index == "Y"){
		memo = "[자동입력] 사례를 보관함으로 이동했습니다."
	}else{
		memo = "[자동입력] 사례를 진행사례로 변경했습니다."
	}
	$.ajax({
        type:"post",
        url:"/bos/instance/case/updateCaseFinish.json" ,
        data: {
        	caseFinish :index,
        	caseSeq : "${result.caseSeq}",
        	historyMemo : memo
		},
        dataType: "json",
        success:function(entry){
        	window.location.reload();
        }, error: function(xhr,status,error){
            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
        }
    });
}

function btnEnd(index) {
	var memo 
	if(index == "Y"){
		memo = "[자동입력] 사례를 종결사례보관함으로 이동했습니다."
	}else{
		memo = "[자동입력] 사례를 종결사례를 해제했습니다."
	}
	$.ajax({
        type:"post",
        url:"/bos/instance/case/updateCaseEnd.json" ,
        data: {
        	caseEnd :index,
        	caseSeq : "${result.caseSeq}",
        	historyMemo : memo
		},
        dataType: "json",
        success:function(entry){
        	window.location.reload();
        }, error: function(xhr,status,error){
            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
        }
    });
}

function btnCaseBookDel() {
	$.ajax({
        type:"post",
        url:"/bos/instance/case/deleteCaseBookmark.json" ,
        data: {
        	caseSeq : "${result.caseSeq}"
		},
        dataType: "json",
        success:function(entry){
            alert("사례를 즐겨찾기에서 제거했습니다");
        	window.location.reload();
        }, error: function(xhr,status,error){
            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
        }
    });
}

function btnCaseBookInsert() {
	$.ajax({
        type:"post",
        url:"/bos/instance/case/insertCaseBookmark.json" ,
        data: {
        	caseSeq : "${result.caseSeq}"
		},
        dataType: "json",
        success:function(entry){
            alert("사례를 즐겨찾기에 추가했습니다");
        	window.location.reload();
        }, error: function(xhr,status,error){
            alert('데이터를 저장하지 못했습니다.\n이유 : '+ error);
        }
    });
}

</script>

<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
	<ul>
	    <li class="" ><a href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
		<li class="" ><a href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li class=""><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li class="" ><a href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li class="" ><a href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li class="active" ><a href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">관리</a></li>
	</ul>
</div>

<br/>
<h4>현재 이 사례의 사례관리자는
	<c:choose>
		<c:when test="${not empty result.caseManager}" >
		      	'${result.caseManagerNm}'입니다.
		</c:when>
		<c:otherwise>
		      	없습니다.
		</c:otherwise>
	</c:choose>
</h4>

	<c:if test="${result.caseFinish == 'Y'}">
        <h4>[사례보관함] 이동 설정 : 
	        <a class="pure-button btnFinish" href="javascript:btnFinish('N');" >복원하기</a>
        </h4>
    </c:if>
	<c:if test="${result.caseFinish != 'Y'}">
        <h4>[사례보관함] 이동 설정 : 
			<a class="pure-button btnFinish" href="javascript:btnFinish('Y');" >보내기</a>
        </h4>
    </c:if>  
         
    <h4>[자주보기사례] 추가 설정 :
    	<c:choose>
			<c:when test="${resultBookCnt > 0}" >
	        	<a class="pure-button pointer isBookmarkCase" href="javascript:btnCaseBookDel();" >해제하기</a>
			</c:when>
			<c:otherwise>
	        	<a class="pure-button pointer isBookmarkCase" href="javascript:btnCaseBookInsert();" >추가하기</a>
			</c:otherwise>
		</c:choose>
        <span id="btnBookmarkCaseLoading" style="display:none; color:red;">자주보기사례 처리중</span>
    </h4>
    
    <h4>[종결사례함] 이동 설정 : 
   		<c:if test="${result.caseEnd == 'Y'}">
	        <a class="pure-button" href="javascript:btnEnd('N');" >복원하기</a>
    	</c:if>
		<c:if test="${result.caseEnd != 'Y'}">
			<a class="pure-button" href="javascript:btnEnd('Y');" >보내기</a>
    	</c:if> 
    </h4>

    <h4>사례 수정 이력</h4>

    <div id="divViewManage" style="width:100%;">      
        <div style="margin-bottom:5px;">
            <span>결과: <strong class="f_blue" id="txtTotalRecordManageCount">${resultManageCnt}</strong>건</span>
        </div>
        <div style="width:100%;">
            <table class="table table-striped table-hover" id="tbPass" >
				<thead>
					<tr>
						<th style="width: 20%" scope="col">수정일</th>
						<th style="width: 15%" scope="col">수정자</th>
						<th style="width: 15%" scope="col">수정그룹</th>
						<th style="width: 15%" scope="col">처리</th>
						<th style="width: " scope="col">수정이력</th>
					</tr>
				</thead>
				<tbody id="passTbody">
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><fmt:formatDate value="${result.chDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
							<td>${result.chUserNm}</td>
							<td>${result.chGroupNm}</td>
							<td>${result.chActionNm}</td>
							<td>${result.chMemo}</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
						    <td colspan="7">데이터가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
		    </table>
        </div>
        <c:if test="${fn:length(resultList) > 0}">
			${pageNav}
		</c:if>
    </div>

    <div class="btnGroup">
    
        <button id="btnCaseManagePrint" title="print4-7" class="pure-button btnInsert btnCasePrintView">출력</button>
    
    </div>

<script>
    $('#btnCaseManagePrint').click(function(e) {
        e.preventDefault();
        var thisSeq = $(this).attr("title");
        var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
    });
    
</script>
