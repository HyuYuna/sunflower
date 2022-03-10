<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<style>
	.policy{ width:90%; text-align: center;}
</style>

<script src="/static/bos/js/common.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>
<script>
function goSearch(frm2){
	
	
}

function goUserView(id){

//    if(confirm("개인정보보호를 위해서 조회 시 이력을 쌓고있습니다.\n확인 버튼을 클릭해주세요.")) {
      
   // }
}

function fnUpdate() {
	$("#frm2").attr("action", '/bos/singgl/loginPolicy/update.do');
	$("#frm2").submit();
	
}
</script>
	<form id="frm2" name="frm2" method="post" action="" class="pure-form">
	<input type="hidden" name="updtId" value="${adminUser2.userId}"/>
	    <div class="list">
	        <table class="table">
	            <caption>정책 목록</caption>
	            <colgroup>
	            	<col width="60%">
	            	<col width="40%">
	            </colgroup>
	            <thead>
	                <tr>
	                    <!--th scope="col">번호</th-->
	                    <th scope="col">정책명</th>
	                    <th scope="col">설정값</th>
	                </tr>
	            </thead>
	            <tbody>
	                    <tr>
	                        <td>자동로그아웃 설정 시간(분)</td>
	                        <td><input type="text" class="policy" name ="atmcLogoutTime" value="${result.atmcLogoutTime}"/></td>
	                    </tr>
	                    <tr>
	                        <td>자동 로그아웃 전 알림 시간(분)</td>
	                        <td><input type="text" class="policy" name ="atmcLogoutTimeAlert" value="${result.atmcLogoutTimeAlert}"/></td>
	                   	</tr>
	                   	<tr>
	                        <td>로그인 재시도 횟수</td>
	                        <td><input type="text" class="policy" name ="passwordRetryCo" value="${result.passwordRetryCo}"/></td>
	                    </tr>
	                    <tr>
	                        <td>패스워드 변경 일수</td>
	                        <td><input type="text" class="policy" name ="passwordDeriveDaycnt" value="${result.passwordDeriveDaycnt}"/></td>
	                    </tr>
	            </tbody>
	        </table>
	    </div>
	</form>
<div class="btnSet">
        <a class="pure-button btnInsert btnSave" href="#" id="regBtn" onclick="fnUpdate()"><span>저장</span></a>
</div>
<%--\\
<div class="btnSet">
    <a class="btn btn-primary" href="/bos/member/user/forInsert.do?${pageQueryString}" id="regBtn"><span>등록</span></a>
    <a class="btn btn-inverse" href="#self"><span>비밀번호 초기화</span></a>
    <a class="btn btn-danger" href="javascript:del();"><span>삭제</span></a>
    <a class="btn btn-success" href="javascript:void(0);"><span>엑셀저장</span></a>
</div>
--%>

