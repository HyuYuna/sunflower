<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="/cmmn/error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
 
<ccc:constantsMap className="site.unp.core.domain.SearchVO" var="SearchVO" />

<script>
$(function() {

});

function caseDelete(){
	var form = document.frm;
	if (confirm('삭제 하시겠습니까?')) {
		$("#historyMemo").val("[자동입력] 사례를 삭제했습니다.");
		form.action="/bos/instance/case/delete.do";
		form.submit();
	}
}
function fn_list(menuNo){
    $("#searchMasterText").val("");
    $("#searchCaseType").val("");
    $("#searchType").val("");
    document.frm.action = "/bos/instance/case/listCenter.do?menuNo="+menuNo;
    document.frm.submit();
}
function fn_list2(menuNo){
    $("#chkCsTypeArr").val("");
    $("#chkCsJupsooArr").val("");
    $("#termType").val("");
    $("#caseType").val("");
    $("#chkCaseJupsoo").val("");
    document.frm.action = "/bos/instance/case/listCenter.do?menuNo="+menuNo;
    document.frm.submit();
}
</script>
<form id="frm" name="frm" class="pure-form" method="post">
            <c:if test="${param.searchType eq 'C' }">
            <input type="hidden" id="searchMasterText" name="searchMasterText" value="${param.searchMasterText}" />
            <input type="hidden" id="searchCaseType" name="searchCaseType" value="${param.searchCaseType}" />
            <input type="hidden" id="searchType" name="searchType" value="${param.searchType}" />
            </c:if>
            <input type="hidden" name="menuNo" value="${param.menuNo}">
            <c:if test="${param.searchType ne 'C'}"> 
            <input type="hidden" id="smonth1" name="smonth" value="${paramVO.smonth}" />
            <input type="hidden" id="emonth1" name="emonth" value="${paramVO.emonth}" />
            <input type="hidden" id="tody" name="tody" value="${today}" />
            <input type="hidden" name="chkCsTypeArr" id="chkCsTypeArr" value="${paramVO.chkCsTypeArr}"/>
            <input type="hidden" name="chkCsJupsooArr" id="chkCsJupsooArr" value="${paramVO.chkCsJupsooArr}"/>
            <input type="hidden" name="userId" value="${userVO.userId}" />
            <input type="hidden" name="userNm" value="${userVO.userNm}" />
            <input type="hidden" id="condFrdate" name="condFrdate" value="${paramVO.condFrdate}" />
            <input type="hidden" id="condTodate" name="condTodate" value="${paramVO.condTodate}" />
            <input type="hidden" id="termType" name="termType" value="${param.termType}" />
            <input type="hidden" name="caseType" id="caseType" value="${param.caseType}"/>
            <input type="hidden" name="chkCaseJupsoo" id="chkCaseJupsoo" value="${param.chkCaseJupsoo}"/>
            <input type="hidden" id="srcCslId"  name="srcCslId" value="${param.srcCslId}" />
            <input type="hidden" id="centerCodeSub" name="centerCodeSub" value="${param.centerCodeSub}" />
            <input type="hidden" id="srcState" name="srcState" value="${param.srcState}" />
            <input type="hidden" id="victimFrger" name="victimFrger" value="${param.victimFrger}" />
            <input type="hidden" id="victimAgeFrom" name="victimAgeFrom" value="${param.victimAgeFrom}" />
            <input type="hidden" id="victimAgeTo" name="victimAgeTo" value="${param.victimAgeTo}" />
            <input type="hidden" id="victimDisable" name="victimDisable" value="${param.victimDisable}" />
            <input type="hidden" id="victimArea" name="victimArea" value="${param.victimArea}" />
            <input type="hidden" id="attkrAge" name="attkrAge" value="${param.attkrAge}" />
            <input type="hidden" id="attkrDisable" name="attkrDisable" value="${param.attkrDisable}" />
            <input type="hidden" id="attkrRelGrp" name="attkrRelGrp" value="${param.attkrRelGrp}" />
            </c:if>
            
<c:import url="/WEB-INF/jsp/bos/instance/case/caseView.jsp" />
<div id="tabs" class="view-btn-array">
	<ul>
		<li class="active"><a class="" href="/bos/instance/case/view.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례기본정보</a></li>
		<li><a class="" href="/bos/instance/case/passView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">지원서비스</a> </li>
<%-- 		<li><a class="" href="/bos/instance/case/servView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">사례부가정보</a></li> --%>
		<li><a class="" href="/bos/instance/case/fileView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">첨부</a></li>
        <li><a class="" href="/bos/instance/case/printView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">출력</a></li>
		<li><a class="" href="/bos/instance/case/contactView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}">연락처</a></li>
		<li><a class="" href="/bos/instance/case/manageView.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}"">관리</a></li>
	</ul>
</div>
	
<h2>접수정보</h2>
  <table class="table03">
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
            <th>초기 상담자</th>
            <td>${result.eryyCnsltnt}</td>
        </tr>
        <tr>
            <th>의뢰인과 피해자와의 관계</th>
            <td>${result.clientRelNm}</td>
            <th>기타선택시내용</th>
            <td>${result.clientRelMemo}</td>
        </tr>
        <tr>
            <th>세부내용</th>
            <td colspan="3" style="white-space:pre-wrap;"><c:out value="${resultMemo.jupsooMemo}" escapeXml="false"/></td>
        </tr>
    </tbody>
</table>



<h2>피해자정보</h2>
<table class="table03">
    <colgroup>
        <col width="20%" />
        <col width="30%" />
        <col width="20%" />
        <col width="30%" />
    </colgroup>
    <tbody>
        <tr>
            <th>이름</th>
            <td>${result.victimName}</td>
            <th>성별</th>
            <td>
            	<c:choose>
					<c:when test="${result.victimSex == 'M'}" >남자</c:when>
					<c:when test="${result.victimSex == 'F'}" >여자</c:when>
					<c:otherwise>
						알수없음
					</c:otherwise>
				</c:choose>
            </td>
        </tr>
        <tr>
            <th>가명</th>
            <td colspan="3">${result.caseAlias}</td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>${result.victimBirth}</td>
            <th>현재나이</th>
            <td>
                <c:if test="${result.victimAge eq 199}">알수없음</c:if> 
                <c:if test="${result.victimAge ne 199}">
                    <fmt:parseNumber integerOnly="true" value="${result.victimAge}"/>
                </c:if>
            </td>
        </tr>
        <tr>
            <th>장애여부</th>
            <td>
            	${result.victimDisableNm}
            	<c:choose>
					<c:when test="${result.victimDisable == '1'}" >장애급수 : ${result.victimDisableMemo}</c:when>
					<c:when test="${result.victimDisable == '2'}" >장애명 : ${result.victimDisableMemo}</c:when>
					<c:when test="${result.victimDisable == '3'}" >장애명 : ${result.victimDisableMemo}</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
            </td>
            <th>국적</th>
            <td>
            	<c:choose>
		<c:when test="${result.victimFrger == 'N'}" >내국인</c:when>
		<c:when test="${result.victimFrger == 'Y'}" >외국인 / 현재국적 : ${result.victimFrgerMemo}</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>
            </td>
        </tr>
        <tr>
            <th>거주지</th>
            <td colspan="3">${result.victimAreaNm}&nbsp;${result.victimAreaSubNm}&nbsp;${result.victimAreaMemo}</td>
        </tr>
        <tr>
            <th>피해자의 센터인지경로</th>
            <td colspan="3">${result.caseRouteNm}</td>
        </tr>
        <tr>
            <th>세부내용</th>
            <td colspan="3" style="white-space:pre-wrap;"><c:out value="${resultMemo.victimMemo}" escapeXml="false"/></td>
        </tr>
    </tbody>
</table>


<h2>피해정보</h2>
<table class="table03">
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
            <td>${result.caseTypeSubNm}</td>
            <td>기타선택시내용 : ${result.caseTypeMemo}</td>
        </tr>
        <tr>
            <th>피해시 특이사항</th>
            <td colspan="5">
				<c:choose>
					<c:when test="${result.dmgStateYn == 'N'}" >없음</c:when>
					<c:when test="${result.dmgStateYn == 'Y'}" >
					<div id="divDMG_STATE">
						<script>
							getCmmnCd.checkBox('CSDG', 'divDMG_STATE', 'dmgState', '${result.dmgState}', '','D');
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
            <td colspan="5" style="white-space:pre-wrap;"><c:out value="${resultMemo.caseMemo}" escapeXml="false"/>
            </td>
        </tr>
    </tbody>
</table>

<h2>가해자정보</h2>
<c:forEach var="result" items="${resultAttkrList}" varStatus="status">
	<table class="table03" id="">
		<caption>가해자정보</caption>
		<colgroup>
			<col style="width:19%;" />
			<col style="width:31%;" />
			<col style="width:19%;" />
			<col style="width:31%;" />
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
						<c:set var="data" value="${fn:split(result.attkrState,', ')}" />
						<label><input type="checkbox" name="attkrState" id="attkrState10" value="10" disabled="disabled">가해자2인 이상</label>
						<label><input type="checkbox" name="attkrState" id="attkrState11" value="11" disabled="disabled">흉기소지</label>
						<label><input type="checkbox" name="attkrState" id="attkrState12" value="12" disabled="disabled">주거침입</label>
						<label><input type="checkbox" name="attkrState" id="attkrState13" value="13" disabled="disabled">야간</label>
						<label><input type="checkbox" name="attkrState" id="attkrState14" value="14" disabled="disabled">음주</label>
						<label><input type="checkbox" name="attkrState" id="attkrState15" value="15" disabled="disabled">약물</label>
						<c:forEach var="x" begin="0" end="${fn:length(data)-1}">
							<script language="javascript">
								$('input:checkbox[id="attkrState${data[x]}"]').attr("checked", true);
							</script>
						</c:forEach>
					</c:when>
					<c:otherwise>
					</c:otherwise>
				</c:choose>
		    </td>
		</tr>
		<tr>
		    <th>세부내용</th>
            <td colspan="3" style="white-space:pre-wrap;"><c:out value="${result.attkrMemo}" escapeXml="false"/></td>
	    </tr>
		</tbody>
	</table>
	<br/>
</c:forEach>
<c:if test="${fn:length(resultAttkrList) == 0}">
	<div>데이터가 없습니다.</div>
</c:if>
<a name="caseInfo"/>
<h2>상담정보</h2>
<table class="table03">
    <colgroup>
        <col width="20%" />
        <col width="" />
    </colgroup>
    <tbody>
        <tr>
            <th>도움 요청 내용(중복)</th>
            <td>
            	<div id="div_caseHelp">
	             	<script>
	               		getCmmnCd.checkBox('CDHP', 'div_caseHelp', 'caseHelp', '${result.caseHelp}', '4','D');
	               	</script>
	               	${result.caseHelpMemo}
            	</div>
            </td>
        </tr>
        <tr>
            <th>주호소 및 상담내용</th>
            <td style="white-space:pre-wrap;"><c:out value="${resultMemo.sangdamMemo}" escapeXml="false"/></td>
        </tr>
        <tr>
            <th>사례관리자 설정</th>
            <td>${result.caseManagerNm}
            </td>
        </tr>
    </tbody>
</table>

<br/>
<h2>피해구분 추가 : 피해구분 추가하기</h2>
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

<h2>지원경과 : 성폭력 피해자 지원제도 활용 여부</h2>
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
<h2>사례 경과 및 종결 : 수사재판 경과</h2>
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
			<th>불기소</th>
			<td>
				<c:if test="${resultServ.csGroupC20 == '11'}">무혐의</c:if>
				<c:if test="${resultServ.csGroupC20 == '12'}">기소유예</c:if>
				<c:if test="${resultServ.csGroupC20 == '14'}">기타</c:if>
			</td>
		</tr>
		<tr>
           <th>기소</th>
           <td><c:if test="${resultServ.csGroupC20 == '13'}">기소</c:if></td>
       </tr>
       <tr>
           <th>재판</th>
           <td colspan="2">
               1심 재판결과 ${resultServ.csGroupC22Nm} ${resultServ.csGroupC22Memo} 
               <br>
               2심 재판결과 ${resultServ.csGroupC23Nm} ${resultServ.csGroupC23Memo}
               <br>
               3심 재판결과 ${resultServ.csGroupC24Nm} ${resultServ.csGroupC24Memo}
            </td>
        </tr>
    </tbody>
</table>
<br/>
<h2>사례관련 추가 기재 필요 사항</h2>
<table class="table03">
    <tbody>
        <tr>
            <td style="white-space:pre-wrap;"><c:out value="${resultServ.csMemo}" escapeXml="false"/></td>
         </tr>
     </tbody>
</table>
<br/>
<h2>타기관 연계의뢰서 첨부</h2>
<a class="pure-button btnDownload" href="javascript:filePopZip(${result.caseSeqC})"><span>다운로드</span></a>
<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileDownloadZone.jsp" flush="true">
	<jsp:param value="case" name="subFileGroup" />
	<jsp:param value="${result.caseSeqC }" name="subFileCode" />
	<jsp:param value="" name="subFilecodeSub" /> 
	<jsp:param value="" name="subFileFolder" />
</jsp:include>

</form>
<div class="btnGroup">
	<c:if test="${((userVO.userId eq result.caseManager) || (empty result.caseManager) || (userVO.authorCd eq 'BM')) && rbool eq 'true'}">
		<a class="pure-button btnUpdate" href="/bos/instance/case/caseReg.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}"><span>사례수정</span></a>
	</c:if>
	 끽${rbool}
	 흠 ${result.caseManager}
	 으 ${ }(empty result.caseManager)
	<c:if test="${((userVO.userId eq result.caseManager) || (empty result.caseManager) || (userVO.authorCd eq 'BM')) && rbool ne 'true'}">
		<a class="pure-button btnUpdate" href="/bos/instance/case/caseUpdate.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}"><span>사례수정</span></a>
	</c:if>
	
	<a class="pure-button btnUpdate" href="/bos/instance/case/servReg.do?menuNo=${param.menuNo}&caseSeq=${result.caseSeq}"><span>사례부가정보수정</span></a>
	
	<c:if test="${((userVO.userId eq result.caseManager) || (empty result.caseManager) || (userVO.authorCd eq 'BM')) && rbool eq 'true'}">
		<a class="pure-button btnDelete" href="javascript:caseDelete();"><span>삭제</span></a>
	</c:if>
	<c:choose>
		<c:when test="${param.menuNo eq '100216' || param.menuNo eq '100217'}">
			<c:if test="${param.searchType eq 'C'}">
				<a class="pure-button btnList" href="javascript:fn_list2(${param.menuNo});"><span>리스트</span></a>
			</c:if>
			<c:if test="${param.searchType ne 'C'}">
				<a class="pure-button btnList" href="javascript:fn_list(${param.menuNo});"><span>리스트</span></a>
			</c:if>
		</c:when>
		<c:otherwise>
			<a class="pure-button btnList" href="/bos/instance/case/list.do?menuNo=${param.menuNo}"><span>리스트</span></a>
		</c:otherwise>
	</c:choose>
	<button id="btnCasePrintBasic" title="print3-1" class="pure-button btnInsert btnCasePrintView">사례등록지 출력</button>
	<button id="btnCaseServPrint" title="print4-3" class="pure-button btnInsert btnCasePrintView">사례부가정보출력</button>
</div>

<script>
    $('.btnCasePrintView').click(function(e) {
	    e.preventDefault();
	    var thisSeq = $(this).attr("title");
	    var myWindow = window.open("casePrint.do?caseSeq=${result.caseSeq}&thisSeq="+thisSeq, "case_print_window", "width=800, height=800, scrollbars=yes, toolbar=no, menubar=no, location=no");
    });
    
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