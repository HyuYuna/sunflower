<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<script src="/static/bos/js/common.js"></script>

<c:if test="${empty param.urlType}">
    <c:set var="action" value="/bos/cmmn/file/ekrFileDown.do?menuNo=${param.menuNo }&uflSeq=${param.uflSeq }&uflFilesize=${param.uflFilesize }" />
</c:if>

<c:if test="${not empty param.urlType}">
    <c:set var="action" value="/bos/cmmn/file/zipFileDown2.do" />
</c:if>

<script language="javascript">

	function fn_submit() {
		var form = $("#frm")[0];
		if($("#chMemo").val() == ""){
			alert("다운로드 사유를 입력하세요.");
			return;
		}
        form.submit();
	}
	
</script>

<form id="frm" name="frm" method="post" action="${action}" >
    <input type="hidden" name="action" value="${action}" />
    <input type="hidden" name="menuNo" value="${param.menuNo }" />
    <input type="hidden" name="seq" value="${param.caseSeq }" />
    <input type="hidden" name="zipName" value="case" />
    <input type="hidden" name="urlType" value="${param.urlType }" />
    <input type="hidden" name="uflFilesize" value="${param.uflFilesize }" />
    
    <input type="hidden" name="caseSeq" value="${param.caseSeq }" />
    <input type="hidden" name="uflSeq" value="${param.uflSeq }" />
    <input type="hidden" name="chGroup" value="CASE" />
    <input type="hidden" name="chUserId" value="${paramVO.userId}" />
    <input type="hidden" name="chUserNm" value="${paramVO.userNm}" />
    <input type="hidden" name="chAction" value="I" />
    
	    	
    <h1>다운로드 사유</h1>
    <div class="bdView" style="width: 450px; margin: 10px 0px;">

        <table class="table03">
            <caption>다운로드 사유</caption>
            <colgroup>
                <col width="30%" />
                <col width="" />
            </colgroup>
            <tbody>
		        <tr>
					<th><label for="chMemo"><span class="essentialInputField req"><span>필수입력</span></span>다운로드<br/> 사유</label></th>
					
		            <td>
		            	<textarea name="chMemo" id="chMemo" style="height:80px; width:100%;"></textarea>
		            </td>
		        </tr>
            </tbody>
        </table>
    </div>

</form>

<div class="btnSet">
    <a class="btn btn-primary" href="javascript:fn_submit()">다운로드</a> 
    <a class="btn btn-primary" href="javascript:close();" style="background-color: #8C8C8C; border-color: #8C8C8C;" id="closeBtn"><span>닫기</span> </a>
</div>

<script>

$("#closeBtn").click(function() {
	self.close();
});


</script>