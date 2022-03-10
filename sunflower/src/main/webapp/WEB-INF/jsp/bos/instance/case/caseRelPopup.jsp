<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>

var cookieName = "case";
var splitStr = "/";
 
$(document).ready(function(e){
    // 이전에 체크됐던 아이템들을 체크해준다.
    checkChkCookie(cookieName, "/", "chkValue");
 
    // 신규 체크가 발생할 경우 실행.
    chkBoxCookie(cookieName, "/", "allCheck", "chk", "chk", "chkValue", "changeMigBtnName");
});
 
 
/**
 * 체크박스 체크 후 페이지를 이동해도 이전에 체크했던 기록이 남아있도록.
 * @param cookieName : 저장할 쿠키명
 * @param splitStr : 구분자 ex) "/"
 * @param chkAllId : 전체체크 체크박스 id
 * @param chkName : 목록 체크박스 name
 * @param chkClassName : 목록 체크박스 classname
 * @param basketId : 체크된 쿠키값을 들고 있을 input hidden id
 * @param funcName : 체크박스 동작 수행 후, 실행되어야 할 함수명
 * @returns
 */
function chkBoxCookie(cookieName, splitStr, chkAllId, chkName, chkClassName, basketId, funcName){
    $("input:checkbox[name='"+ chkName + "']").change(function(){ // 목록 체크박스에 변화가 있다면,
        var chkValue = $(this).val();
        var oldCookie = getCookie(cookieName);
 
        if($("input:checkbox[id='" + chkValue + "']").is(":checked")){ // 체크했을 때,
        	
            if(oldCookie != ""){ // 기존에 체크했던 쿠키가 있다면,
                chkValue = oldCookie + splitStr + chkValue;
            }
 
			setCookie(cookieName, chkValue, null);
			$("#" + basketId).val(chkValue);
        }else{ // 체크 해제 시,
            var oldCookieArray = oldCookie.split(splitStr);
            for (var i = 0; i < oldCookieArray.length; i++) {
                if(oldCookieArray[i] == chkValue){
                    oldCookieArray.splice(i, 1);
                }
            }
            var oldCookieStr = oldCookieArray.join(splitStr);
            
            setCookie(cookieName, oldCookieStr, null);
			$("#" + basketId).val(oldCookieStr);
        }
    });
}
 
/**
 * 저장된 쿠키를 불러와서 체크박스 체크
 * @param cookieName
 * @param splitStr
 * @param basketId
 * @returns
 */
function checkChkCookie(cookieName, splitStr, basketId){
    var cookiesStr = getCookie(cookieName);
    $("#"+basketId).val(cookiesStr);
    if(cookiesStr != ""){
        var cookieArray = cookiesStr.split(splitStr);
        for (var i = 0; i < cookieArray.length; i++) {
            $("input:checkbox[id='" + cookieArray[i] + "']").prop("checked", true);
        }
    }
}
 
function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}
 
function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
 
function fn_choice(obj){
	var arr = new Array();
	var cookieArray = $("#chkValue").val().split(splitStr);
	for (var i = 0; i < cookieArray.length; i++) {
		var obj = {
			"caseNumber" : cookieArray[i]
		}
		arr[i] = obj;
	}

	var callback = "fn_setFormInfo";
	if(typeof eval("opener."+callback) != "undefined"){
		eval("opener."+callback+"(arr)");
	}
	self.close();
}

function fn_search(){
	document.frm.action = "/bos/instance/case/caseRelPopup.do?viewType=BODY&menuNo=${param.menuNo}";
	document.frm.submit();
}

function caseDefaultPopup(caseSeq) {
	var myWindow = window.open("/bos/instance/case/caseDefault.do?viewType=CONTBODY&caseSeq=" + caseSeq, "caseDefaultPopup", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
}
</script>
<form id="frm" name="frm" class="pure-form" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="viewType" value="${param.viewType }" />
	<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
	<input type="hidden" name="pSiteId" value="${param.pSiteId}">
	<input type="hidden" id="chkValue" name="chkValue" style="width: 400px">
	
	<div class="sh">
		<div class="row">
			<div class="">
				<span class="title">검색조건</span>
				
				<select name="searchCnd" class="w15p" id="searchCnd" >
					<option value='1' <c:if test="${paramVO.searchCnd eq '1'}">selected="selected"</c:if>>이름</option>
					<option value='2' <c:if test="${paramVO.searchCnd eq '2'}">selected="selected"</c:if>>가명</option>
				</select>
				
				<input id="searchWrd" type="text" title="검색어" name="searchWrd" value="${paramVO.searchWrd}" class="w25p" />
				
				<input type="button" id="input2" name="input2" value="검색" class='btn btn-primary' style="float:right;" onclick="fn_search()"/>
			</div>
			
			
			
		</div>
	</div>
	<div>
		<table class="table table-striped table-hover" id="list_table">
			<caption>강사찾기 목록</caption>
			<colgroup>
				<col style="width:8%" />
				<col style="width:10%" />
				<col style="" />
				<col style="width:20%" />
				<col style="width:20%" />
				<col style="width:20%" />
				
			</colgroup>
			<thead>
				<tr>
					<th scope="col">
						선택
					</th>
					<th scope="col">No</th>
					<th scope="col">전산관리번호</th>
					<th scope="col">피해구분</th>
					<th scope="col">사례등록일</th>
					<th scope="col" class="last">피해자명</th>
				
				</tr>
			</thead>
			<tbody id="tbody_selectedBoxDiv">
				<c:forEach items="${resultList}" var="result" varStatus="status">
					<tr>
				    	<td>
				    	<input type="checkbox" class="chk" name="chk" id="${result.caseNumber}" value="${result.caseNumber}" >
				    	</td>
						<td><c:out value="${(resultCnt) - (paginationInfo.pageSize * (paginationInfo.currentPageNo-1))}" /></td>
						<td>
						<a href="javascript:caseDefaultPopup('${result.caseSeq }')">${result.caseNumber}</a>
							<input type="hidden" name="caseNumber" id="caseNumber" value="${result.caseNumber}" />
						</td>				
						<td>${result.caseTypeNm}</td>
						<td>${result.caseDate}</td>
						<td>${result.victimName}</td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="5">
							<spring:message code="common.nodata.msg" />
						</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<div class="btnSet">
			<div class="fr" >
				<a href="javascript:fn_choice();" class="b-reg">선택</a>
				<a class="b-cancel"  href="#" onclick="javascript:self.close();">취소</a>
			</div>
		</div>
	</div>
	<c:if test="${fn:length(resultList) > 0}">
		<div class="paging">
			${pageNav}
		</div>
	</c:if>
</form>
