<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<script>
document.title= "콘텐츠 버전관리";
</script>

<script src="/static/jslibrary/base64.js"></script>
<script>
	function fnModify(frm) {
		if(confirm('새로운 버전으로 등록하시겠습니까?')==false) {
			return;
		}

		frm.action = "/bos/singl/menu/updateContents.do?useAt=Y";
		frm.target = '_self' ;
		frm.submit();
	}


	var win;
	function fnPreView(siteId){
		win = window.open('', 'pop_win', 'width=1200, height=800, resizable=0, scrollbars=yes, status=0, titlebar=0, toolbar=0' );
		//document.priviewForm.action = menuLink + "?menuNo=${paramVO.sMenuNo}";
		//document.priviewForm.action = "/" + siteId + "/main/preview.do";	//로컬 환경
		document.priviewForm.action = "/" + siteId + "/main/preview.do";
		var cont = document.modifyForm.cntntsCn.value;
		document.priviewForm.cntntsCn.value= Base64.encode(cont);
		//document.priviewForm.viewType.value="BODY";
		document.priviewForm.target = 'pop_win';
		document.priviewForm.submit();
	}

	function comparePop(sMenuNo) {
   		window.open("/bos/singl/menu/compareContentsPop.do?viewType=BODY&sMenuNo="+sMenuNo,"comparePop","scrollbars=yes,width=1400,height=800");
   		return;
	}

</script>

<form name="modifyForm" enctype="multipart/form-data" action="/bos/singl/menu/updateContents.do" method="post">
	<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo}"/>
	<input type="hidden" name="sMenuNo" id="sMenuNo" value="${paramVO.sMenuNo}"/>
	<input type="hidden" name="sSiteId" id="sSiteId" value="${empty result.siteId ? param.sSiteId : result.siteId}"/>
	<input type="hidden" name="viewType" id="viewType" value="${paramVO.viewType}"/>
	<input type="hidden" name="gubun" value="${paramVO.gubun}"/>
	<input type="hidden" name="cntntsFileCours" value="${paramVO.cntntsFileCours}" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<h2>콘텐츠 버전관리</h2>
	<div class="bdView">
		<table>
			<caption>콘텐츠 정보</caption>
			<colgroup>
				<col width="15%"/>
				<col width="85%"/>
			</colgroup>
			<tbody>
				<tr>
					<c:if test="${param.gubun ne 'Y'}">
						<th scope="row">버전 번호</th>
						<td>Ver.${result.cntntsMnno}</td>
					</c:if>
				</tr>
				<tr>
					<th scope="row">콘텐츠 명</th>
					<td>${empty result.relateMenuNmList ? result.menuNm : result.relateMenuNmList}</td>
				</tr>
				<tr>
					<th scope="row">콘텐츠 파일 경로</th>
					<td>${result.cntntsFileCours}</td>
				</tr>
				<tr>
					<th scope="row">사용자 URL</th>
					<td>${result.menuLink}</td>
				</tr>
				<tr>
					<th scope="row">최종수정일(수정자)</th>
					<td>${empty result.updtDt ? result.registDt : result.updtDt}<c:if test="${not empty result.registId}">(${empty result.updtId ? result.registId : result.updtId})</c:if></td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>콘텐츠</th>
					<td>
						<textarea rows="50" cols="150" id="cntntsCn" name="cntntsCn" style="height:200px" title="콘텐츠">${result.cntntsCn }</textarea>
						<button type="button" class="b-view w100p mt5" onclick="fnPreView('${result.siteId}');" title="새창열림">미리보기</button>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<c:if test="${param.gubun eq 'Y'}">
		<div class="btnSet c"><a class="b-save" href="javascript:fnModify(document.modifyForm);"><span>수정</span></a></div>
	</c:if>
	<c:if test="${param.gubun ne 'Y'}">
		<div class="btnSet">
			<div class="fl">
				<a class="b-select" href="javascript:comparePop('${param.sMenuNo}');"><span>콘텐츠버젼 비교</span></a>
			</div>
			<a class="b-reg" href="javascript:fnModify(document.modifyForm);"><span>${empty result ? '등록' : '새로운 버전으로 수정'}</span></a>
			<a class="b-del" href="/bos/singl/menu/deleteContents.do?sUseAt=${paramVO.sUseAt}&useAt=${result.useAt}&sMenuNo=${result.menuNo}&cntntsMnno=${result.cntntsMnno}&menuNo=${param.menuNo}&sSiteId=${param.sSiteId}&viewType=${param.viewType}" onclick="return confirm('정말로 삭제하시겠습니까?')"><span>삭제</span></a>
			<c:if test="${param.viewType eq 'BODY' }">
				<a class="b-end" href="javascript:void()" onclick="self.close()"><span>닫기</span></a>
			</c:if>
			<c:if test="${param.viewType ne 'BODY' }">
				<a class="b-cancel" href="/bos/singl/contents/list.do?menuNo=${param.menuNo}&sSiteId=${param.sSiteId}"><span>취소</span></a>
			</c:if>
		</div>

		<h2>콘텐츠 History</h2>
		<div>
			<table class="table table-striped table-hover">
				<caption>콘텐츠 History 목록</caption>
				<thead>
					<tr>
						<th style="width:15%" scope="col" class="fir">버전번호</th>
						<th 				  scope="col">메뉴 명</th>
						<th style="width:15%" scope="col">사용여부</th>
						<th style="width:15%" scope="col">사용여부 변경</th>
						<th style="width:15%" scope="col">수정일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="result2" items="${resultList}" varStatus="status">
						<tr>
							<td>Ver.${result2.cntntsMnno}</td>
							<td>
								<strong>
									<a href="forUpdateContents.do?sMenuNo=${result2.menuNo}&sSiteId=${param.sSiteId}&cntntsMnno=${result2.cntntsMnno}&menuNo=${param.menuNo}&viewType=${param.viewType}">${empty result2.relateMenuNmList ? result2.menuNm : fn:replace(result2.relateMenuNmList,'|',' > ')}</a>
								</strong>
							</td>
							<td>${result2.useAt eq 'Y' ? '<font color="ff6600"><b>사용</b></font>' : '미사용'}</td>
							<td>
								<c:if test="${result2.useAt ne 'Y' }">
									<a class="btn btn-xs btn-info" href="/bos/singl/menu/updateUseAtContents.do?menuNo=${param.menuNo}&viewType=${param.viewType}&sSiteId=${param.sSiteId}&sMenuNo=${result2.menuNo}&cntntsMnno=${result2.cntntsMnno}">사용</a>
								</c:if>
							</td>
							<td>${result2.updtDt}</td>
						</tr>
						<c:set var="resultCnt" value="${resultCnt-1}" />
					</c:forEach>
					<c:if test="${fn:length(resultList) eq 0}">
						<tr>
							<td class="nodata" colspan="5">등록된 콘텐츠가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>


		<c:if test="${fn:length(resultList) > 0}">
			${pageNav}
		</c:if>
	</c:if>
</form>
<form name="priviewForm" enctype="multipart/form-data" action="" method="post">
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<input type="hidden" name="cntntsCn" value=""/>
	<input type="hidden" name="viewType" value="" />
	<input type="hidden" name="menuNm" value="${result.menuNm }" />
	<input type="hidden" name="menuNo" value="${paramVO.sMenuNo}"/>
</form>
