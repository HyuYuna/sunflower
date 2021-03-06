<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>

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
                        <th><span id="viewdiv1"></th>
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
    <h1 class="tit_line">사례등록지</h1>

            <h4>접수정보</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>접수일자 / 시간</th>
                        <td>${result.caseDate} &nbsp;&nbsp;&nbsp; ${result.caseTime}</td>
                        <th>접수방법</th>
                        <td>${result.caseJupsooNm}</td>
                    </tr>
                    <tr>
                        <th>의뢰인 이름</th>
                        <td>${result.client}</td>
                        <th>접수담당자</th>
                        <td>${result.memberName}</td>
                    </tr>
                    <tr>
                        <th>의뢰인과<br />피해자와의 관계</th>
                        <td>${result.clientRelNm}</td>
                        <th>기타선택시내용</th>
                        <td>${result.clientRelMemo}</td>
                    </tr>
                    <tr>
                        <th>세부내용</th>
                        <td colspan="3" style="white-space:pre-wrap;">${resultMemo.jupsooMemo}</td>
                    </tr>
                </tbody>
            </table>

            <h4>피해자정보</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="30%" />
                    <col width="20%" />
                    <col width="30%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>이름</th>
                        <td>${result.victimName}
                        </td>
                        <th>성별</th>
                        <td>
                            <c:choose>
                                <c:when test="${result.victimSex == 'M'}" >남자</c:when>
                                <c:when test="${result.victimSex == 'F'}" >여자</c:when>
                                <c:otherwise>알수없음</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>가명</th>
                        <td colspan="3">${result.caseAlias}</td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>${result.victimBirth}
                        </td>
                        <th>현재나이</th>
                        <td><c:if test="${result.victimAge eq 199}">알수없음</c:if> 
                            <c:if test="${result.victimAge ne 199}">
                                <fmt:parseNumber integerOnly="true" value="${result.victimAge}"/>
                            </c:if>
                        </td>
                    </tr>
                    <tr>
                        <th>장애여부</th>
                        <td>${result.victimDisableNm}
                            <c:choose>
                                <c:when test="${result.victimDisable == '1'}" >장애급수 : ${result.victimDisableMemo}</c:when>
                                <c:when test="${result.victimDisable == '2'}" >장애명 : ${result.victimDisableMemo}</c:when>
                                <c:when test="${result.victimDisable == '3'}" >장애명 : ${result.victimDisableMemo}</c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </td>
                        <th>국적</th>
                        <td>
                            <c:choose>
                                <c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
                                <c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
                                <c:otherwise></c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th>거주지</th>
                        <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}
                        </td>
                    </tr>
                    <tr>
                        <th>피해자의 센터인지경로</th>
                        <td colspan="3">${result.caseRouteNm}
                        </td>
                    </tr>
                    <tr>
                        <th>세부내용</th>
                        <td colspan="3" style="white-space:pre-wrap;">${resultMemo.victimMemo}</td>
                    </tr>
                </tbody>
            </table>

            <h4>피해정보</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="12%" />
                    <col width="12%" />
                    <col width="33%" />
                    <col width="23%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>피해구분1</th>
                        <td>${result.caseTypeNm}</td>
                        <th>피해구분2</th>
                        <td>${result.caseTypeSubNm}
                        </td>
                        <td colspan="2">기타 : ${result.caseTypeMemo}
                        </td>
                    </tr>
                    <tr>
                        <th>피해시 특이사항</th>
                        <td colspan="5">  
		                    <c:choose>
		                        <c:when test="${result.dmgStateYn == 'N'}" >없음</c:when>
		                        <c:when test="${result.dmgStateYn == 'Y'}" >
		                            <div id="divDMG_STATE">
		                                <script>
		                                    getCmmnCd.checkBoxPrint('CSDG', 'divDMG_STATE', 'dmgState', '${result.dmgState}', '1','D');
		                                </script>
		                            </div>
		                        </c:when>
		                        <c:otherwise>
		                        </c:otherwise>
		                    </c:choose>
		                </td>
                    </tr>
                    <tr>
                        <th>피해일시</th>
                        <td colspan="5">
                            ${result.dmgTime}&nbsp;${result.dmgTimeMemo}
                        </td>
                    </tr>
                    <tr>
                        <th>세부내용</th>
                        <td colspan="5" style="white-space:pre-wrap;">${resultMemo.caseMemo}</td>
                    </tr>
                </tbody>
            </table>


            <h4>가해자정보 </h4>
            <c:forEach var="result" items="${resultAttkrList}" varStatus="status">
		        <table cellpadding="0" cellspacing="0" border="0" class="table02">
		            <colgroup>
		                <col width="19%" />
		                <col width="31%" />
		                <col width="19%" />
		                <col width="31%"/>
		            </colgroup>
		            <tbody>
		                <tr>
		                    <th>성별</th>
		                    <td>
		                        <c:choose>
		                            <c:when test="${result.attkrSex == 'M'}" >남자</c:when>
		                            <c:when test="${result.attkrSex == 'F'}" >여자</c:when>
		                            <c:otherwise>
		                                알수없음
		                            </c:otherwise>
		                        </c:choose>
		                    </td>
		                    <th>나이</th>
		                    <td>${result.attkrAgeNm}</td>
		                </tr>
		                <tr>
		                    <th>장애</th>
		                    <td>
		                        ${result.attkrDisableNm}
		                        <c:choose>
		                            <c:when test="${result.attkrDisable == '1'}" >장애급수 : ${result.attkrDisableMemo}</c:when>
		                            <c:when test="${result.attkrDisable == '2'}" >장애명 : ${result.attkrDisableMemo}</c:when>
		                            <c:when test="${result.attkrDisable == '3'}" >장애명 : ${result.attkrDisableMemo}</c:when>
		                            <c:otherwise>
		                            </c:otherwise>
		                        </c:choose>
		                    </td>
		                    <th>국적</th>
		                    <td>
		                    ${result.attkrFrgerNm}
		                        <c:choose>
		                            <c:when test="${result.attkrFrger == 'N'}" >내국인</c:when>
		                            <c:when test="${result.attkrFrger == 'Y'}" >외국인 / 현재국적 : ${result.attkrFrgerMemo}</c:when>
		                            <c:otherwise>
		                            </c:otherwise>
		                        </c:choose>
		                    </td>
		                </tr>
		                <tr>
		                    <th>피해자와의 관계<br>(피해자기준)</th>
		                    <td colspan="3">${result.attkrRelNm} ${result.attkrRelMemo}</td>
		                </tr>
		                <tr>
		                    <th>가해시 특이사항</th>
		                    <td colspan="3">
		                        <c:choose>
		                            <c:when test="${result.attkrStateYn == 'N'}" >없음</c:when>
		                            <c:when test="${result.attkrStateYn == 'Y'}" >
		                            <div id="div_attkr">
		                                <script>
			                                getCmmnCd.checkBoxPrint('ATST', 'div_attkr', 'result', '${result.attkrState}', '1','D');
			                            </script>
			                        </div>
		                            </c:when>
		                            <c:otherwise>
		                            </c:otherwise>
		                        </c:choose>
		                    </td>
		                </tr>
		                <tr>
		                    <th>세부사항</th>
		                    <td colspan="3" style="white-space:pre-wrap;">${result.attkrMemo}</td>
		                </tr>
		            </tbody>
		        </table>
		        <br/>
		    </c:forEach>
		    <c:if test="${fn:length(resultAttkrList) == 0}">
		        <div>데이터가 없습니다.</div>
		    </c:if>

            <h4>상담정보</h4>
            <table cellpadding="0" cellspacing="0" border="0" class="table02">
                <colgroup>
                    <col width="20%" />
                    <col width="80%" />
                </colgroup>
                <tbody>
                    <tr>
                        <th>도움 요청 내용(중복)</th>
                        <td>
                        <div id="div_result"> 
                            <script>
                                getCmmnCd.checkBoxPrint('CDHP', 'div_result', 'result', '${result.caseHelp}', '1','D');
                            </script>
	                    </div>
                        </td>
                    </tr>
                    <tr>
                        <th>주호소 및 상담내용</th>
                        <td style="white-space:pre-wrap;">${resultMemo.sangdamMemo}</td>
                    </tr>
                    <tr>
                        <th>사례관리자 설정</th>
                        <td>${result.caseManagerNm}
                        </td>
                    </tr>
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
