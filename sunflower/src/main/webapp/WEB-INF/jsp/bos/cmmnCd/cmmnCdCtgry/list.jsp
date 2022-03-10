<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>

<!-- codeg_code
		    ,codeg_name
		    ,codeg_regdate -->

<form name="cmmnCdCtgryForm" id="cmmnCdCtgryForm" action="/bos/cmmnCd/cmmnCdCtgry/list.do" method="get">
	<input name="menuNo" type="hidden" value="${param.menuNo}"/>
	<!-- 게시판 게시물검색 start -->
	<div class="sh">
		<fieldset>
		<legend>게시물검색</legend>
			<label for="clCd" class="blind">구분</label>
			<%-- <select name="clCd" id="clCd" class="select">
			<option value="">분류</option>
			<c:forEach var="item" items="${cmmnClCdList}" varStatus="status">
				<option value="${item.clCd}" <c:if test="${item.clCd eq param.clCd }">selected="selected"</c:if>>${item.clCdNm}</option>
			</c:forEach>
			</select> --%>
			<select name="searchCnd" class="select" id="searchCnd" title="코드">
			   <option value='1' <c:if test="${param.searchCnd == '1'}">selected="selected"</c:if>>코드ID</option>
			   <option value='2' <c:if test="${param.searchCnd == '2'}">selected="selected"</c:if>>코드ID명</option>
			</select>
			<input type="text" title="검색어" name="searchKwd" value="${param.searchKwd}" />
			
			
			<button class="b-sh">검색</button>
		</fieldset>
	</div>
</form>
<!-- 게시판 게시물검색 end -->

<!-- board list start -->
<div>
	<table class="table table-striped table-hover">
		<caption>게시물 목록</caption>
		<colgroup>
			<col width="8%" />
			<col width="15%" />
			<col width="25%" />
			<col width="12%" />
			<col width="12%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">번호</th>
				<th scope="col">코드ID</th>
				<th scope="col">코드카테고리명</th>
				<th scope="col">생성일</th>
				<th scope="col" class="last">코드관리</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${resultList}" var="result" varStatus="status">
		<tr>
			<td>${(resultCnt) - (paginationInfo.pageSize * (paginationInfo.currentPageNo-1))}</td>
			<%-- <td><a href="/bos/cmmnCd/cmmnCdCtgry/view.do?cdId=${result.cdId}&amp;${pageQueryString}">${result.clCdNm}</a></td> --%>
			<td class="tit"><a href="/bos/cmmnCd/cmmnCdCtgry/view.do?codegCode=${result.codegCode}&amp;${pageQueryString}">${result.codegCode}</a></td>
			<td>${result.codegName}</td>
			<td>${result.codegRegdate}</td>
			<td><button type="button" class="b-set btn-xs" onclick="fnCdDetailPopup('${result.codegCode}');return false;">관리</button></td>
		</tr>
			<c:set var="resultCnt" value="${resultCnt-1}" />
		</c:forEach>

		<c:if test="${fn:length(resultList) == 0}">
			<tr>
				<td class="lt_text3" colspan="6">
					<spring:message code="common.nodata.msg" />
				</td>
			</tr>
		</c:if>
		</tbody>
	</table>
</div>

<div class="btnSet">
	<a class="b-reg" href="javascript:void(0);" id="registBtn"><span>등록</span></a>
</div>

<c:if test="${fn:length(resultList) > 0}">
	${pageNav}
</c:if>

<script>
	function fnCdDetailPopup(codegCode) {
		var url = "/bos/cmmnCd/cmmnCdCtgry/listCdDetailPop.do";
		var params = "?viewType=BODY&codegCode=" + codegCode;
		window.open(url+params , "cdDetailPopup", "width=1200, height=700, scrollbars=yes");

	}

	$("#registBtn").on('click',function() {
		$("#cmmnCdCtgryForm").attr("action","/bos/cmmnCd/cmmnCdCtgry/forInsert.do");
		$("#cmmnCdCtgryForm").submit();
		return false;
	});
	
	
	/**
	*	공통코드 가져오기
	*	사용하는것만 들고온다 codeUseYn=Y
	*	getCmmnCd.select(상위코드, 붙일곳(selectId), 데이터)
	*	getCmmnCd.checkBox(상위코드, 붙일곳(checkBox parentId), 데이터(','로 스플릿), 한줄에 몃개나 나오게 할건지(br태그 추가))
	*	
	*/
	var getCmmnCd = { 
		select : function(upperCode, elementId, selectedData){
			$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false }).done(function (resdata) {
				//엘리먼트 초기화
				$("#"+elementId).empty();
				$("#"+elementId).append("<option>선택</option>");
				
				for (var i = 0; i < resdata.length; i++) {
					if(selectedData == resdata[i].codeCode){
						$("#"+elementId).append("<option value='"+resdata[i].codeCode+"' selected='selected'>" +resdata[i].codeName+ "</option>");
					}else{
						$("#"+elementId).append("<option value='"+resdata[i].codeCode+"'>" +resdata[i].codeName+ "</option>");
					}
				}
			});
		}
	
		,
		checkBox : function(upperCode, elementId, selectedData, brCount){
			$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codeUseYn=Y&codegCode="+ upperCode, dataType : "json", async: false }).done(function (resdata) {
				//엘리먼트 초기화
				$("#"+elementId).empty();
				
				var data = selectedData.split(',');
				
				for (var i = 0; i < resdata.length; i++) {
					var checkHave = data.indexOf(resdata[i].codeCode);
					
					if(checkHave >= 0 ){
						$("#"+elementId).append("<input type='checkbox' values='" +resdata[i].codeCode+ "' checked='checked'>" +resdata[i].codeName+ "</input>")
					}else{
						$("#"+elementId).append("<input type='checkbox' values='" +resdata[i].codeCode+ "'>" +resdata[i].codeName+ "</input>")
					}
					
					if((i+1)%brCount == 0){
						$("#"+elementId).append("<br/>");
					}
						
					
				}
				
			});
		} 
		
	}

</script>