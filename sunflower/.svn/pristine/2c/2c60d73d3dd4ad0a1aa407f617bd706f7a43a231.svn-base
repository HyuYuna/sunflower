<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<script src="https://unpkg.com/dayjs@1.8.21/dayjs.min.js"></script>

<style>
#header {display:none}
#footer {display:none}
#leftmenu {display:none}
.hgroup.clearfix {display:none}
#content {display:none; float:center;}
@page { size: 90%; margin-top:50px; margin-bottom:50px;}
</style>
<%
    Date nowTime = new Date();
    SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
%>

 
<jsp:include page="/WEB-INF/jsp/bos/instance/case/print/print_header.jsp" flush="true" />
</head>

<jsp:include page="/WEB-INF/jsp/bos/instance/case/print/${param.thisSeq}.jsp" flush="true" />
<div class="print_date"><%=sf.format(nowTime)%>  (${userVO.userNm})</div>

<jsp:include page="/WEB-INF/jsp/bos/instance/case/print/print_footer.jsp" flush="true" />
