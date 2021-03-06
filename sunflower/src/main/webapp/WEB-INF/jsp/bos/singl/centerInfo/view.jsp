<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- http-->
<!-- <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script> -->
<!-- https-->
<style>
	th{background-color: #F8F8F8; vertical-align: middle !important;}
	.w90pc{	width: 90%; text-align: center;}
	.w90pl{	width: 90%; text-align: left;}
	.w40pl{	width: 40%; text-align: left;}
	.w10pc{	width: 10%; text-align: center;}
</style>
<script>
	function fnSave() {
		$("#centerInfoFrm").attr("action", '/bos/singl/centerInfo/update.do');
		$("#centerInfoFrm").submit();
		
	}

</script>

<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
	<form name="centerInfoFrm" id="centerInfoFrm" action="#" method="post"  class="pure-form"> 
		<input type="hidden" name="cntrCod" value="${result.cntrCod }"/>
	    <table class="table table-bordered mb0">
	        <colgroup>
	            <col width="15%" />
	            <col width="35%" />
	            <col width="15%" />
	            <col width="35%" />
	        </colgroup>
	        <thead>
	            <tr>
	                <th colspan="4">센터정보</th>
	            </tr>
	        </thead>
	        <tbody>
	            <tr>
	                <th>센터구분</th>
	                <td class="align-left">${result.gubunName}</td>
	                <th>센터명</th>
	                <td class="align-left">${result.cntrName}</td>
	            </tr>
	            <tr>
	                <th>지역</th>
	                <td class="align-left">
	                	<select name="areaCod" id="areaCod" title="지역">
	                          	<script>
	                          		getCmmnCd.select('HM46', 'areaCod', '${result.areaCod}','N');
	                          	</script>
		                </select>
	                </td>
	                <th>센터장</th>
	                <td class="align-left"><input type="text" class="w90pc" name="cntch" value="${result.cntch}"/></td>
	            </tr>
	            <tr>
	                <th>위탁병원</th>
	                <td class="align-left">${result.cnmtHosplName}</td>
	                <th>홈페이지</th>
	                <td class="align-left"><input type="text" class="w90pc" name="cntrHomepage" value="${result.cntrHomepage}"/></td>
	            </tr>
	            <tr>
	                <th>운영여부</th>
	                <td class="align-left">
	                	<select name="cntrUseYn" id="cntrUseYn" title="운영여부">
	                		<option value="Y" ${result.cntrUseYn eq '운영' ? 'selected' : '' }>운영</option>
	                		<option value="N" ${result.cntrUseYn eq '미운영' ? 'selected' : '' }>미운영</option>
	                	</select>
	                </td>
	                <th>개소일</th>
	                <td class="align-left">${result.odate}</td>
	            </tr>
	            <tr>
	                <th>연락처</th>
	                <td class="align-left"><input type="text" class="w90pc" name="cntad" value="${result.cntad}"/></td>
	                <th>FAX</th>
	                <td class="align-left"><input type="text" class="w90pc" name="faxNum" value="${result.faxNum}"/></td>
	            </tr>
	            <tr>
	                <th>주소</th>
	                <td colspan="3"  class="align-left"><input type="text" class="w10pc" name="zipNum" value="${result.zipNum }"/> <input type="text" class="w40pl" name="addr1" value="${result.addr1 }"/> <input type="text" class="w40pl" name="addr2" value="${result.addr2 }"/></td>
	            </tr>
	            <tr>
	                <th>E-Mail</th>
	                <td colspan="3"  class="align-left"><input type="text" class="w90pl" name="ref" value="${result.ref }"/></td>    
	            </tr>
	            
	        </tbody>
	    </table>
	</form>
<div class="btnSet">
	<c:if test="${userVO.authorCd eq 'CA' || userVO.authorCd eq 'ROLE_SUPER' || userVO.centerCode eq result.cntrCod }">
		<a href="#" class="pure-button btnUpdate" onclick="fnSave()">수정</a>
	</c:if>
	<a href="/bos/singl/centerInfo/list.do?${pageQueryString}" class="pure-button btnList">목록</a>
</div>
