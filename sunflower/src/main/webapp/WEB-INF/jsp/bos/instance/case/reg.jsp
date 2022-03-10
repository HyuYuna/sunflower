<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO" />
<c:if test="${empty result}">
    <c:set var="action" value="/bos/instance/case/insert.do" />
</c:if>
<c:if test="${not empty result}">
    <c:set var="action" value="/bos/instance/case/update.do" />
</c:if>

<c:set var="fileVO" value="" />
<c:forEach var="fileList" items="${fileList}" varStatus="status">
    <c:if test="${fileList.fileFieldNm eq 'imgFile_1' }">
        <c:set var="fileVO" value="${fileList}" />
    </c:if>
</c:forEach>


<script>
</script>

<form id="board" name="board" method="post" enctype="multipart/form-data" action="${action}">
    <input type="hidden" name="pageQueryString" value="${pageQueryString}" /> 
    <input type="hidden" name="menuNo" value="${param.menuNo }" /> 

    <div class="view">
</form>

<div class="btnSet">
    <div class="fr">
        <c:choose>
            <c:when test="${empty result}">
                <a href="javascript:checkForm();" class="btn btn-primary"><span>등록</span></a>
            </c:when>
            <c:otherwise>
                <a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
            </c:otherwise>
        </c:choose>
        <a class="b-list" href="/bos/instance/case/list.do?${pageQueryString}"><span>목록</span></a>
    </div>
</div>