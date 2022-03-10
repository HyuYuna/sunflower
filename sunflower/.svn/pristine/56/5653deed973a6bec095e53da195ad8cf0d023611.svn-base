<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<body bgcolor = "#FFFFFF">

<div id="divPrintForm" >
    <div style="width:250px; float:right;">
        <table cellpadding="0" cellspacing="0" border="0" class="table02">
            <colgroup>
                <col width="5%" />
                <col width="31.66%" />
                <col width="31.66%" />
                <col width="31.66%" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="2">결재</th>
                    <th>담당자</th>
                    <th><input type="text" style="width:100%;" id="formdiv1" /></th>
                    <th><input type="text" style="width:100%;" id="formdiv2" /></th>
                </tr>
                <tr style="height:50px;">
                    <td><input type="text" style="width:100%;" id="formdiv3" /></td>
                    <td><input type="text" style="width:100%;" id="formdiv4" /></td>
                    <td><input type="text" style="width:100%;" id="formdiv5" /></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<div id="divPrintZone" style="display:none">
        <div style="width:250px; float:right;">
        <table cellpadding="0" cellspacing="0" border="0" class="table02">
            <colgroup>
                <col width="5%" />
                <col width="31.66%" />
                <col width="31.66%" />
                <col width="31.66%" />
            </colgroup>
            <tbody>
                <tr>
                    <th rowspan="2">결재</th>
                    <th>담당자</th>
                    <th><span id="viewdiv1"></span></th>
                    <th><span id="viewdiv2"></span></th>
                </tr>
                <tr style="height:50px;">
                    <td style="text-align:center;"><span id="viewdiv3"></span></td>
                    <td style="text-align:center;"><span id="viewdiv4"></span></td>
                    <td style="text-align:center;"><span id="viewdiv5"></span></td>
                </tr>
            </tbody>
        </table>
    </div>
</div>
    

<div class="c_both"></div>
<h1 class="tit_line">출력</h1>
        <h4>사례정보</h4>
        <table cellpadding="0" cellspacing="0" border="0" class="table02">
            <colgroup>
                <col style="width:160px;" />
                <col style="width:160px;" />
                <col style="width:150px;" />
                <col style="width:180px;" />
                <col style="width:100px;" />
                <col style="width:190px;" />
            </colgroup>
            <tr style="height:30px;">
                <td style="background-color:#f6f6f6; text-align:center;">피해자 이름</td>
                <td colspan='5' style="padding:0px;">
                    <table class="pure-table pure-table-bordered" style="width:100%; border:0px">
                        <colgroup>
                            <col style="width:120px;" />
                            <col style="width:70px;" />
                            <col style="width:70px;" />
                            <col style="width:110px;" />
                            <col style="width:170px;" />
                            <col style="width:70px;" />
                            <col style="width:120px;" />
                        </colgroup>
                        <tr>
                            <td>${result.victimName}</td>
                            <td style="background-color:#f6f6f6; text-align:center;">성별</td>
                            <td><c:choose>
                                    <c:when test="${result.victimSex == 'M'}" >남자</c:when>
                                    <c:when test="${result.victimSex == 'F'}" >여자</c:when>
                                    <c:otherwise>알수없음</c:otherwise>
                                </c:choose>
                            </td>
                            <td style="background-color:#f6f6f6; text-align:center;">장애</td>
                            <td>${result.victimDisableNm}</td>
                            <td style="background-color:#f6f6f6; text-align:center;">국적</td>
                            <td><c:choose>
                                    <c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
                                    <c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
                                    <c:otherwise></c:otherwise>
                                </c:choose></td>
                        </tr>
                    </table>

                </td>
            </tr>
            <tr style="height:30px;">
                <td style="background-color:#f6f6f6; text-align:center;">피해구분</td>
                <td>${result.caseTypeNm}(${result.caseTypeSubNm})</td>
                <td style="background-color:#f6f6f6; text-align:center;">최초접수일</td>
                <td>${result.caseDate} ${result.caseTime}</td>
                <td style="background-color:#f6f6f6; text-align:center;">센터명</td>
                <td>${result.centerName}</td>
            </tr>
            <tr style="height:30px;">
                <td style="background-color:#f6f6f6; text-align:center;">전산관리번호</span>
                    <span id="bxtFinishCaseLoading" style="display:none; color:red;">사례 관리중</span></td>
                <td>${result.caseNumber}</td>
                <td style="background-color:#f6f6f6; text-align:center;">센터사례번호</td>
                <td>${result.centerNumber}</td>
                <td style="background-color:#f6f6f6; text-align:center;">참조번호</td>
                <td>${result.caseRel}</td>
            </tr>
        </table>
        <input type="hidden" id="state_case_info" value="N">

        <h4>출력 이력</h4>
        <table cellpadding="0" cellspacing="0" border="0" class="table02">
            <colgroup>
                <col width="50px" />
                <col />
                <col width="150px" />
                <col width="80px" />
            </colgroup>
            <tbody>
                <tr>
                    <th>연번</th>
                    <th>서식종류</th>
                    <th>출력일</th>
                    <th>출력자</th>
                </tr>
                <c:forEach var="result" items="${resultPrint}" varStatus="status">
                <tr>
                    <td style="text-align:center;">${status.count}</td>
                    <td style="text-align:left;">${result.phName}</td>
                    <td style="text-align:center;">${result.phCdate}</td>
                    <td style="text-align:center;">${result.phUserName}</td>
                </tr>
                </c:forEach>

            </tbody>
        </table>
    <br>
    <div style="text-align:center;"><h1>${result.centerName}</h1></div>
</div>

<script>

    function fn_print_page_action() {
        $('#viewdiv1').text( $('#formdiv1').val() );
        $('#viewdiv2').text( $('#formdiv2').val() );
        $('#viewdiv3').text( $('#formdiv3').val() );
        $('#viewdiv4').text( $('#formdiv4').val() );
        $('#viewdiv5').text( $('#formdiv5').val() );
    }

</script>
