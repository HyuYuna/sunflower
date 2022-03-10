<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
	function setValue(link, groupId, srvcId, methodId, srvcNm){
		if ($("#pSrvcId").val()=="siteHpcm"){
			$("#pGroupId",opener.document).val(groupId);
			$("#pSrvcId",opener.document).val(srvcId);
			$("#pMethodId",opener.document).val(methodId);
			$("#pSrvcNm",opener.document).val(srvcNm);
			self.close();
		} else {
			$("#menuLink",opener.document).val(link);
			$("#bbsId",opener.document).val('');
			$("#cntntsFileCours",opener.document).val("");
			$("#menuLinkNm",opener.document).val(srvcNm);
			self.close();
		}
	}
</script>
<h1>메뉴링크선택</h1>

<form name="frm" action ="menuLinkPop.do" method="get">
	<input type="hidden" name="viewType" value="BODY"/>
	<input type="hidden" name="siteId" value="${param.siteId}"/>
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<select id="stributary" name="searchCnd" title="검색조건">
		   		<option value="1" <c:if test="${param.searchCnd == '1'}">selected="selected"</c:if>>프로그램명</option>
		   		<option value="2" <c:if test="${param.searchCnd == '2'}">selected="selected"</c:if>>링크</option>
			</select>
				<input type="text" title="검색어" name="searchWrd" value="${param.searchWrd}" />
				<input type="hidden" name="pSrvcId" id="pSrvcId" value="${param.pSrvcId}"/>
				<input type="hidden" name="pSiteId" id="pSiteId" value="${param.pSiteId}"/>
				<button type="submit" class="b-sh">검색</button>
		</fieldset>
	</div>
	<!-- 게시판 게시물검색 end -->

		<!-- board list start -->
	<div>
		<table class="table table-striped table-hover">
			<caption>게시물 목록</caption>
			<colgroup>
				<col width="10%" />
				<col width="40%" />
				<col width="50%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">프로그램명</th>
					<th scope="col">링크</th>
				</tr>
			</thead>
			<tbody>
		<c:if test="${fn:length(resultList) gt 0}">
		 <c:forEach var="result" items="${resultList}" varStatus="status">

			<c:set var="siteNm" value="/${fn:split(result.link,'/')[0]}/" />
			<c:set var="siteId" value="/${param.siteId}/" />
			<c:set var="link" value="${fn:replace(result.link, 'userMember', 'user')}" />
			<c:set var="link" value="${fn:replace(link, 'uwamMember', 'uwam')}" />
			<c:set var="link" value="${fn:replace(link, siteNm, siteId)}" />
			  <tr>
			    <td>${status.count}</td>
			    <td class="tit">
			    	<a href="javascript:void(0);" onclick="setValue('${link}','${result.groupId}','${result.srvcId}','${result.methodId}','${result.desc}')">${result.desc}</a>
			    </td>
				<td class="tal">
			    	<a href="javascript:void(0);" onclick="setValue('${link}','${result.groupId}','${result.srvcId}','${result.methodId}','${result.desc}')">${link}</a>
				</td>
			  </tr>
				<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>
		</c:if>
		<c:if test="${fn:length(resultList) eq 0}">
			  <tr>
			    <td colspan="3" class="nodata"><spring:message code="common.nodata.msg" /></td>
			  </tr>
			 </c:if>
	 		</tbody>
		</table>
	</div>

	<div class="btnSet">
		<a class="b-end" href="javascript:void()" onclick="self.close()"><span>닫기</span></a>
	</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

</form>

