<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<script src="/static/bos/js/common.js"></script>

<script>
$(function() {
	
});

</script>

<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
	<ul>
	    <li class="" ><a href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
		<li><a href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li  class="active" ><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li class=""><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li class="" ><a href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li class="" ><a href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li class="" ><a href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">관리</a></li>
	</ul>
</div>

<br/>
<h4>피해구분 추가 : 피해구분 추가하기</h4>
        <table class="table03">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="" />
            </colgroup>
            <tbody>
				<c:if test="${resultServ.csType == 'C'}">
	                <tr>
	                    <th rowspan="2">아동학대범죄</th>
	                    <th>가해자구분</th>
	                    <td>
	                    	${resultServ.csTypeGroupNm}
	                    </td>
	                </tr>
	                <tr>
	                    <th>학대행위구분</th>
	                    <td>
	                    	<c:if test="${resultServ.csTypeAct01 == 'Y'}">신체학대, </c:if>
	                    	<c:if test="${resultServ.csTypeAct02 == 'Y'}">정서학대, </c:if>
	                    	<c:if test="${resultServ.csTypeAct03 == 'Y'}">성학대, </c:if>
	                    	<c:if test="${resultServ.csTypeAct04 == 'Y'}">방임, </c:if>
	                    	<c:if test="${resultServ.csTypeAct05 == 'Y'}">알 수 없음</c:if>
	                    </td>
	                </tr>
                </c:if>
                <c:if test="${resultServ.csType == 'M'}">
	                <tr>
	                    <th>군대내성폭력</th>
	                    <td colspan="2">
	                        군대내성폭력
	                    </td>
	                </tr>
                </c:if>
            </tbody>
        </table>
        <br>

        <h4>지원경과 : 성폭력 피해자 지원제도 활용 여부</h4>
        <table class="table03">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="25%;" />
                <col width="45%;" />
            </colgroup>
            <tbody>
                <tr>
                    <th>수사법률지원</th>
                    <td colspan="3">
                    	<c:if test="${resultServ.csGroupA04 == 'Y'}">진술녹화 시행, </c:if>
                    	<c:if test="${resultServ.csGroupA05 == 'Y'}">피해자 국선변호사 연계, </c:if>
                    	<c:if test="${resultServ.csGroupA01 == 'Y'}">전문가 의견조회 제도 활용, </c:if>
                    	<c:if test="${resultServ.csGroupA02 == 'Y'}">진술조력인 활용, </c:if>
                    	<c:if test="${resultServ.csGroupA03 == 'Y'}">신뢰관계인 동석(${resultServ.csGroupA10Nm}), </c:if>
                    	<c:if test="${resultServ.csGroupA06 == 'Y'}">무료법률구조사업 연계, </c:if>
                    	<c:if test="${resultServ.csGroupA07 == 'Y'}">통역지원, </c:if>
                    	<c:if test="${resultServ.csGroupA08 == 'Y'}">속기사</c:if>
                    </td>
                </tr>
                
                <tr>
                    <th rowspan='5'>의료지원</th>
                    <th>의료비지원대상</th>
                    <td colspan='2'>
                    	${resultServ.csGroupB20Nm}
                    </td>
                </tr>
                <tr>
                    <th>간병비지원 사유</th>
                    <td colspan='2'>
                    	${resultServ.csGroupB40Nm}
                    </td>
                </tr>
                <tr>
                    <th>응급키트 실시</th>
                    <td colspan='2'>
                    	${resultServ.csGroupB51}
                    </td>
                </tr>

                <tr>
                    <th rowspan='2'>인공임신중절 지원</th>
                    <td>센터가 임신을 확인한 시점
                    </td>
                    <td>
                    	${resultServ.csGroupB61Nm}
                    </td>
                </tr>
                <tr>
                    <td>인공임신중절 수술시행 병원
                    </td>
                    <td>
                    	${resultServ.csGroupB62Nm}
                    </td>
                </tr>
            </tbody>
        </table>

		<br/>
        <h4>사례 경과 및 종결 : 수사재판 경과</h4>
        <table class="table03">
            <colgroup>
                <col width="15%;" />
                <col width="15%;" />
                <col width="15%;" />
                <col width="" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="6">수사재판 경과</th>
                    <th>신고</th>
                    <td colspan='2'>
                    	${resultServ.csGroupC10Nm}
                    </td>
                </tr>
                <tr>
                    <th rowspan=2>검찰</th>
                    <th>불기소
                    </th>
                    <td>
                    	<c:if test="${resultServ.csGroupC20 == '11'}">무혐의</c:if>
                    	<c:if test="${resultServ.csGroupC20 == '12'}">기소유예</c:if>
                    	<c:if test="${resultServ.csGroupC20 == '14'}">기타</c:if>
                    </td>
                </tr>
                <tr>
                    <th>기소
                    </th>
                    <td>
                    	<c:if test="${resultServ.csGroupC20 == '13'}">기소</c:if>
                    </td>
                </tr>
                <tr>
                    <th>재판</th>
                    <td colspan="2">
                        1심 재판결과 ${resultServ.csGroupC22Nm} ${resultServ.csGroupC22MemoNm}
                        <br>
                        2심 재판결과 ${resultServ.csGroupC23Nm} ${resultServ.csGroupC23MemoNm}
                        <br>
                        3심 재판결과 ${resultServ.csGroupC24Nm} ${resultServ.csGroupC24MemoNm}
                    </td>
                </tr>
            </tbody>
        </table>
		<br/>
        <h4>사례관련 추가 기재 필요 사항</h4>
        <table class="table03">
            <tbody>
                <tr>
                    <td>
                    	${resultServ.csMemo}
                    </td>
                </tr>
            </tbody>
        </table>

<%--

<%' If isAdmin Then %>

<h4>기존자료 이전정보</h4>
<div style="padding-left:20px;">
<%
    Call ekrOpenDb

    sql = " SELECT RCP_ITV_NUM "_
        & "      , CASE_ETC_INFO1, CASE_ETC_INFO2, CASE_ETC_INFO3"_
        & "   from TZ_CASE_SUB_MAINS WHERE CASE_SEQ='"& case_seq &"' "

    set ekrRs =ekrDbCon.Execute(sql)
    if not (ekrRs.EOF or ekrRs.BOF) Then
        
        i = 1
        Do UNTIL ekrRs.eof
    
            Response.write ekrRs("CASE_ETC_INFO1")
            Response.write ekrRs("CASE_ETC_INFO2")
            Response.write ekrRs("CASE_ETC_INFO3")
        
            i = i+1
            ekrRs.movenext
        LOOP

    end If
    set ekrRs = Nothing


    sql = " SELECT RCP_ITV_NUM "_
        & "      , ITEM_NAME, ITEM_VALUE"_
        & "   from TZ_CASE_SUB_INFOS WHERE CASE_SEQ='"& case_seq &"' "

    set ekrRs =ekrDbCon.Execute(sql)
    if not (ekrRs.EOF or ekrRs.BOF) Then
        
        i = 1
        Do UNTIL ekrRs.eof
    
            Response.write ekrRs("ITEM_NAME") &" : "& ekrRs("ITEM_VALUE") &"<br>"
        
            i = i+1
            ekrRs.movenext
        LOOP

    end If
    set ekrRs = Nothing
    
    Call ekrCloseDb
%>
</div>
<%' End If %>
 --%>



        <div class="btnGroup">
            
<%--             <% 'If ruleCaseUpdatable Then %> --%>
                <a class="pure-button btnUpdate" href="/bos/instance/case/servReg.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}"><span>수정</span></a>
<%--             <% 'End If %> --%>
            
            <button id="btnCaseServPrint" title="print4-3" class="pure-button btnInsert btnCasePrintView">출력</button>
            
        </div>

        <script>
            $('#btnUpdateServ').click(function() {
                $('#formPage').attr('action', '/case/serv/serv_form.asp');
                $('#formPage').submit();
            });

            $('#btnCaseServPrint').click(function(e) {
            	e.preventDefault();
                var thisSeq = $(this).attr("title");
                var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
            });
        </script>
