<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

<script>
$(function() {
});

</script>

<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
    <ul>
		<li class="" ><a href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
		<li class="" ><a href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li class=""><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li class="active" ><a href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li class="" ><a href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li class="" ><a href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">관리</a></li>
    </ul>
</div>

<h4>서식목록 및 출력</h4>
    <table class="table03">
        <colgroup>
            <col width="20%" />
            <col width="65%" />
            <col width="15%" />
        </colgroup>
        <thead>
            <tr>
                <th>서식구분</th>
                <th>서식 종류</th>
                <th>기능</th>
            </tr>
        </thead>
        <tbody>
<%--             <% If True Then %> --%>
            <tr>
                <th rowspan=2>해바라기센터정보시스템<br>사례정보</th>
                <td>사례등록지(사례기본정보)</td>
                <td><button id="btnCasePrint3-1" title="print3-1" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
            <tr>
                <td>사례부가정보 기록지</td>
                <td><button id="btnCasePrint4-3" title="print4-3" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
<%--             <% Else %> --%>
            <tr>
                <th rowspan=3>해바라기센터<br>사업안내 서식</th>
                <td>[서식 4] 성폭력 피해자 무료법률구조 신청서</td>
                <td><button id="btnCasePrint1-4" title="print1-4" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
            <tr>
                <td>[서식 5] 피해 상담사실 확인서</td>
                <td><button id="btnCasePrint1-2" title="print1-2" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
            <tr>
                <td>[서식 6] 성폭력 사건 보고</td>
                <td><button id="btnCasePrint1-6" title="print1-6" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>

<%--             <% If True Then %> --%>
            <tr>
                <th rowspan="2">기타 서식</th>
                <td>[기타 1] 센터이용확인서</td>
                <td><button id="btnCasePrint1-3" title="print1-3" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
            <tr>
                <td>[기타 2] 연계의뢰서</td>
                <td><button id="btnCasePrint3-4" title="print3-4" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
<%--             <% Else %> --%>
            <tr>
                <th>기타 서식</th>
                <td>[기타 1] 센터이용확인서</td>
                <td><button id="btnCasePrint3-4" title="print1-3" class="pure-button btnInsert btnCasePrint">서식 출력</button>
                </td>
            </tr>
<%--             <% End If %> --%>


        </tbody>
    </table>
    <div style="padding:7px;">
        <mark>주의 : 서식에 입력하여 출력한 내용은 별도로 저장되지 않습니다.</mark>
    </div>
    
    <br>
    <h4>서식출력 이력정보</h4>
    <div id="divViewManage" style="width:100%;">      
        <div style="margin-bottom:5px;">
            <span>결과: <strong class="f_blue" id="txtTotalRecordManageCount">${resultPrintCnt}</strong>건</span>
        </div>
        <div style="width:100%;">
            <table class="table table-striped table-hover" id="tbHistory" >
                <thead>
                    <tr>
                        <th style="width: 40%" scope="col">서식 종류</th>
                        <th style="width: 30%" scope="col">출력일</th>
                        <th style="width: 20%" scope="col">출력자</th>
                    </tr>
                </thead>
                <tbody id="historyTbody">
                    <c:forEach var="result" items="${resultList}" varStatus="status">
                        <tr>
                            <td>${result.phName}</td>
                            <td><fmt:formatDate value="${result.phCdate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${result.phUserName}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${fn:length(resultList) == 0}">
                        <tr>
                            <td colspan="7">데이터가 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
        <c:if test="${fn:length(resultList) > 0}">
            ${pageNav}
        </c:if>
       
    </div>

        <div class="btnGroup">
        
            <button id="btnCasePrintPrint" title="print4-5" class="pure-button btnInsert btnCasePrintView">출력</button>
        
        </div>

        <script>
            $('#btnCasePrintPrint').click(function(e) {
                e.preventDefault();
                var thisSeq = $(this).attr("title");
                var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
            });

		    $('.btnCasePrint').click(function(e) {
		        e.preventDefault();
		        var thisSeq = $(this).attr("title");
		        var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
		    });
	    </script>