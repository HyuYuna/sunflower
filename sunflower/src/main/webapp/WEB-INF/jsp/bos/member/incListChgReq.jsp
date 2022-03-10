<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<h4>회원 전환신청 승인상태정보</h4>
<div class="bdList">
	<table class="table table-bordered">
	  <caption>회원 전환신청 이력목록</caption>
	  <thead>
	  	<tr>
	  	  <th scope="col">번호</th>
	  	  <th scope="col">전환회원구분</th>
	  	  <th scope="col">항목</th>
	  	  <th scope="col">승인요청상태</th>
	  	  <th scope="col">승인요청(완료)일자</th>
	  	</tr>
	  </thead>
	  <c:forEach var="chgReqVO" items="${chgReqList}" varStatus="status">
	  <tr>
	    <td>${status.count }</td>
	    <td>
	    	<c:choose>
		    	<c:when test="${(chgReqVO.actSe eq 'ACT02') and (chgReqVO.mberSe eq 'EXPERT') and (chgReqVO.confmSttus eq 'CONFM01')}">
		   			<a href="/bos/member/expert/tmprEntrprsInfoPopup.do?userId=${chgReqVO.userId }&amp;chgReqSn=${chgReqVO.chgReqSn}&amp;confmSttus=${chgReqVO.confmSttus}&amp;mberSe=${chgReqVO.mberSe }&amp;viewType=BODY" onclick="window.open(this.href, '임시_기업_회원_정보','width=800,height=600,scrollbars=yes');event.preventDefault();" title="">	${chgReqVO.mberSeNm }</a>
		    	</c:when>
		    	<c:otherwise>
	   		    	${chgReqVO.mberSeNm }
		    	</c:otherwise>
	    	</c:choose>

	    </td>
	    <td>${chgReqVO.actSeNm }</td>
	    <td>${chgReqVO.confmSttusNm }</td>
	    <td>${chgReqVO.confmDt }</td>
	  </tr>
	  </c:forEach>
	</table>

</div>
