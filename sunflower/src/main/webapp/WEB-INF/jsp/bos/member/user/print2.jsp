<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<script src="https://unpkg.com/dayjs@1.8.21/dayjs.min.js"></script>
<script>
window.print();
</script>
<style>
#header {display:none}
#footer {display:none}
#leftmenu {display:none}
.hgroup.clearfix {display:none}
</style>
<%
    Date nowTime = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy. MM. dd. a hh:mm:ss");
%>
<div id="divPrintZone">
<h1>사용자 리스트</h1>
    <table id="tableUserList" cellpadding="0" cellspacing="0" border="0" class="table01">
        <colgroup>
            <col width="" />
            <col width="" />
            <col width="" />
            <col width="" />
            <col width="" />
            <col width="" />
        </colgroup>
        <tbody>
            <tr>
                <th>상태</th>
                <th>센터</th>
                <th>이름</th>
                <th>입사일자</th>
                <th>연도별</th>
                <th>월별</th>
            </tr>
            <c:forEach var="result" items="${resultList}" varStatus="status">
	            <tr>                                                                                               
	                <td>${result.userStateName }  </td>                                             
	                <td>${result.centerCodeName   }  </td>                                             
	                <td>${result.userName        }  </td>                                            
                    <fmt:parseDate value='${result.userBCdate}' var='userBCdate' pattern='yyyy-mm-dd'/>
                    <td><fmt:formatDate value="${userBCdate}" pattern="yyyy-mm-dd"/></td>  
                    <td><fmt:formatDate value="${userBCdate}" pattern="yyyy"/>년</td>  
                    <td><fmt:formatDate value="${userBCdate}" pattern="mm"/>월</td>  
	            </tr>   
            </c:forEach>
        </tbody>
    </table>
    <div class="print_date"><%=sf.format(nowTime)%>출력자 : ${userVO.userNm}</div>
</div>