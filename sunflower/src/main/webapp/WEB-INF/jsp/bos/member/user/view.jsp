<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- http-->
<!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
<!-- https-->
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
function initPW(userId){
	var pattern = "1234@"; 
	
	if(confirm("사용자 비밀번호를 초기화 하시겠습니까? \n규칙 : 사용자아이디+"+pattern+"\n예시 : userid"+pattern)){
	    $.ajax({
	        type:"post",
	        url:"/bos/member/user/pwInit.json" ,
	        data: {
	            userId : userId,
	            pattern : pattern
	        },
	        dataType: "json",
	        success:function(entry){
	            alert("초기화 되었습니다.\n " + userId+pattern);
	        }, error: function(xhr,status,error){
	            alert('초기화를 실패했습니다.\n이유 : '+ error);
	        }
	    });
	}
}

</script>
    <table class="table03 table03view">
        <colgroup>
            <col width="15%" />
            <col width="35%" />
            <col width="15%" />
            <col width="35%" />
        </colgroup>
        <thead>
            <tr>
                <th colspan="4">사용자정보</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <th>이름</th>
                <td>${result.userName}</td>
                <th>아이디</th>
                <td>${result.userId}</td>
            </tr>
            <tr>
                <th>생일</th>
                <td>${result.userBirth}</td>
                <th>연락처</th>
                <td>${result.userPhone}</td>
            </tr>
            <tr>
                <th>센터구분</th>
                <td>${result.centerGbn}</td>
                <th>센터</th>
                <td>${result.centerCodeName}</td>
            </tr>
            <tr>
                <th>입사일자</th>
                <td>${result.userBdate}</td>
                <th>퇴사일자</th>
                <td>${result.userEdate}</td>
            </tr>
            <tr>
                <th>부서</th>
                <td>${result.userDepartment}</td>
                <th>직위</th>
                <td>${result.userPosition}</td>
            </tr>
            <tr>
                <th>성별</th>
                <td>${result.userSexName }
                </td>
                <th>권한</th>
                <td>${result.userLevelName}</td>
            </tr>
            <tr>
                <th>채용구분</th>
                <td>${result.userStateName }</td>    
                <th>이메일</th>
                <td>${result.userEmail}</td>
            </tr>
            <tr>
                <th>직군</th>
                <td colspan="3">${result.userGroupName}</td>
            </tr>
            
        </tbody>
    </table>

<div class="btnSet">
	<c:if test="${result.failrCnt >= 5}">
		<a href="#" id="failrBtn" class="b-unlock">잠금해제</a>
	</c:if>
	<c:if test="${param.menuNo eq '100017' }">
       <a href="javascript:initPW('${result.userId}');" class="pure-button btn-danger">비밀번호 초기화</a>
       <a href="/bos/member/user/forUpdate.do?userId=${result.userId}&${pageQueryString}" class="pure-button btnUpdate">수정</a>
       <a href="/bos/member/user/deleteUser.do?userId=${result.userId}&userName=${result.userName}&${pageQueryString}" class="pure-button pure-button-delete">삭제</a>
	   <a href="/bos/member/user/list.do?${pageQueryString}" class="pure-button btnList">목록</a>
	</c:if>
	<c:if test="${param.menuNo eq '100250' }">
	   <a href="/bos/member/user/list2.do?${pageQueryString}" class="pure-button btnList">목록</a>
    </c:if>
</div>
