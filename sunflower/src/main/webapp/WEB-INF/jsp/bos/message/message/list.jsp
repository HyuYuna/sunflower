<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<c:if test="${param.menuNo eq '100240' }">
	<c:set var="dataGroup" value="GET"/>
</c:if>
<c:if test="${param.menuNo eq '100241' }">
	<c:set var="dataGroup" value="SEND"/>
</c:if>

<div class="board_top">
	<span>결과: <strong class="f_blue" id="txtTotalRecordCount">${resultCnt }</strong>건</span>
	<div style="float:right;">
		<form id="formSearch" name="formSearch" method="post" class="pure-form">
			<input type="hidden" name="menuNo" value='${param.menuNo }'/>
			<input type="hidden" name="orderWdate" id="orderWdate" value="${param.orderWdate}">
			<input type="hidden" name="dataGroup" value="${dataGroup }" />
			<select name='searchGroup'>
				<option value='title' ${param.searchGroup eq 'title' ? 'selected' : '' }>제목</option>
				<option value='name' ${param.searchGroup eq 'name' ? 'selected' : '' }>${param.menuNo eq '100240' ? '발신자' : '수신자' }</option>
			</select>
			<input type="text" name="searchText" id="searchText" value="${param.searchText }" placeholder="검색어">
			<button type="submit" id="btnJqgridSearch" class='pure-button btnSave'>검색</button>
		</form>
	</div>
</div>

<c:if test="${param.menuNo eq '100241' }">
	<div class="btnGroup">
		<!-- <img id="btnCreate" style="cursor:pointer" src="/static/bos/image/common/btn_write.png" alt="메일작성"/> -->
		<button id="btnCreate" class='pure-button pure-button-list' style="height:36px;">
			<span class="f-bod">메일쓰기</span>
		</button>
	</div>
</c:if>

<div style="width:100%;">
	<c:if test="${param.menuNo eq '100240' }">
		<table id="GET" class="table table-striped table-hover">
			<colgroup>
				<col style="width:5%;"/>
				<col style="width:45%;"/>
				<col style="width:20%;"/>
				<col style="width:15%;"/>
				<col style="width:15%;"/>
			</colgroup>
			<thead>
				<tr>
					<th> </th>
					<th>제목</th>
					<th>발신자</th>
					<th><b><a href="javascript:orderWdate();">발신일</a></b></th>
					<th>수신일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
						<td style="text-align:left;"><a href="/bos/message/message/view.do?seq=<fmt:parseNumber integerOnly="true" value="${result.seq}"/>&${pageQueryString}">${result.title }</a></td>
						<td>${result.userName }</td>
						<td><fmt:formatDate value="${result.wdate }" pattern="yyyy-MM-dd HH:mm"/></td>
						<td><fmt:formatDate value="${result.rdate }" pattern="yyyy-MM-dd HH:mm"/></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) eq 0}">
					<tr>
						<td colspan="6">표시할 행이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</c:if>
	<c:if test="${param.menuNo eq '100241' }">
		<table id="SEND" class="table table-striped table-hover">
			<colgroup>
				<col style="width:5%;"/>
				<col style="width:35%;"/>
				<col style="width:10%;"/>
				<col style="width:20%;"/>
				<col style="width:15%;"/>
				<col style="width:15%;"/>
			</colgroup>
			<thead>
				<tr>
					<th></th>
					<th>제목</th>
					<th>첨부파일유무</th>
					<th>수신자</th>
					<th><b><a href="javascript:orderWdate();">발신일</a></b></th>
					<th>수신일</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="result" items="${resultList}" varStatus="status">
					<tr>
						<td>${resultCnt - (paramVO.pageUnit * (paramVO.pageIndex-1))}</td>
						<td style="text-align:left;"><a href="/bos/message/message/view.do?seq=<fmt:parseNumber integerOnly="true" value="${result.seq}"/>&${pageQueryString}">${result.title }</a></td>
						<td><c:if test="${result.msgFileHas eq 0 }">없음</c:if><c:if test="${result.msgFileHas > 0 }">있음</c:if></td>
						<td>${result.ruser }</td>
						<td><fmt:formatDate value="${result.wdate }" pattern="yyyy-MM-dd HH:mm"/></td>
						<td><fmt:formatDate value="${result.rdate2 }" pattern="yyyy-MM-dd HH:mm"/></td>
					</tr>
					<c:set var="resultCnt" value="${resultCnt-1}" />
				</c:forEach>
				<c:if test="${fn:length(resultList) eq 0}">
					<tr>
						<td colspan="6">표시할 행이 없습니다.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</c:if>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

<script>
	$("#btnCreate").click(function(){
		location.href = "/bos/message/message/forInsert.do?${pageQueryString}";
	})

	function orderWdate(){
	    var orderWdate = document.getElementById("orderWdate");
	    
	    if(orderWdate.value == ""){
	        orderWdate.value ="DESC";
	    }else if(orderWdate.value == "ASC"){
	        orderWdate.value = "DESC";
	    }else if(orderWdate.value == "DESC"){
	        orderWdate.value = "ASC";
	    }else{
	        orderWdate.value = "ASC";
	    }
	    
	    var form = document.formSearch;
	    form.submit();
	}
</script>