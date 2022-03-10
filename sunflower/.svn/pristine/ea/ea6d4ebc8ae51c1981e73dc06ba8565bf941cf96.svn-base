<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<div>
		<table class="table table-striped table-hover">
			<caption>사이트 관리 목록</caption>
			<thead>
				<tr>
					<th style="width:8%" scope="col">사이트ID</th>
					<th style="width:12%" scope="col">사이트명</th>
					<th scope="col">사이트설명</th>
					<th style="width:20%" scope="col">사이트URL주소</th>
					<th style="width:9%" scope="col">만족도사용</th>
					<th style="width:10%" scope="col">자료관리자사용</th>
					<th style="width:10%" scope="col">상단가이드메뉴</th>
					<th style="width:10%" scope="col">하단가이드메뉴</th>
					<th style="width:9%" scope="col" class="last">등록일</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="result" items="${resultList}" varStatus="status">
				<tr>
					<td>${result.siteId}</td>
					<td class="tit">
						<a href="/bos/siteManage/siteInfo/forUpdate.do?pSiteId=${result.siteId}&menuNo=${param.menuNo}">${result.siteNm}</a>
					</td>
					<td>
						<a href="/bos/siteManage/siteInfo/forUpdate.do?pSiteId=${result.siteId}&menuNo=${param.menuNo}">${result.siteDc}</a>
					</td>
			    	<td>${result.siteUrlad}</td>
			    	<td>${result.stsfdgUseAt eq 'Y' ? '사용' : '미사용'}</td>
			    	<td>${result.dtaMngrUseAt eq 'Y' ? '사용' : '미사용'}</td>
			    	<td><button type="button" class="b-edit btn-sm completeBtn" onclick=location.href='/bos/siteManage/siteInfo/upendList.do?menuNo=${param.menuNo}&amp;pSiteId=${result.siteId}'>설정</button></td>
			    	<td><button type="button" class="b-edit btn-sm completeBtn" onclick=location.href='/bos/siteManage/siteInfo/lptList.do?menuNo=${param.menuNo}&amp;pSiteId=${result.siteId}'>설정</button></td>
					<td>${result.registDt}</td>
				</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}"><tr><td colspan="7">데이터가 없습니다.</td></tr></c:if>
			</tbody>
		</table>
	</div>
		<!-- board list end //-->

	<div class="btnSet">
		<a class="b-reg" href="/bos/siteManage/siteInfo/forInsert.do?menuNo=${param.menuNo}"><span>등록</span></a>
	</div>
