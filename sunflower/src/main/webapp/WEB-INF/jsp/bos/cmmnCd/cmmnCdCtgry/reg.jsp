<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:if test="${empty result}">
	<c:set var="action" value="/bos/cmmnCd/cmmnCdCtgry/insert.do" />
	<c:set var="actionName" value="등록" />
</c:if>
<c:if test="${not empty result}">
	<c:set var="action" value="/bos/cmmnCd/cmmnCdCtgry/update.do" />
	<c:set var="actionName" value="수정" />
</c:if>

<form id="cmmnCdCtgryForm" name="cmmnCdCtgryForm"   action="${action }" method="post">
	<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo }"  />
	<input type="hidden" name="pageQueryString" value="${pageQueryString }"/>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="bdView">
		<table>
			<caption>코드정보 폼</caption>
			<colgroup>
				<col width="15%" />
				<col width="85%" />
			</colgroup>
			<tbody>
				<%-- <tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>분류코드명</th>
					<td>
					<select name="clCd" id="clCd" class="select" title="분류코드명">
					<option value="">- 코드분류 -</option>
					<c:forEach var="item" items="${cmmnClCdList}" varStatus="status">
						<option value="${item.clCd}" <c:if test="${item.clCd eq result.clCd or item.clCd eq param.clCd }">selected="selected"</c:if>>${item.clCdNm}</option>
					</c:forEach>
					</select>
					</td>
				</tr> --%>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>코드ID</th>
					<td>
						<input type="text" name="codegCode" id="codegCode" style="text-transform:uppercase;" value="${result.codegCode }" size="60" maxlength="32" class="w100p" title="코드ID" <c:if test="${not empty result }">readonly="readonly"</c:if> >
						<div class="inputDeco"><p>※코드ID는 DB컬럼과 동일한 명칭을 사용해 주세요!</p></div>
						<script>
						$(document).on("keyup", "input[name=codegCode]", function() {$(this).val( $(this).val().replace(/[^\!-z]/gi,"").toUpperCase() );});
						</script>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>코드카테고리명</th>
					<td>
						<input type="text" name="cdIdNm" id="cdIdNm" value="${result.codegName }" size="60" maxlength="60" class="w100p" title="코드카테고리명" >
					</td>
				</tr>
				<%-- <tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>코드ID설명</th>
					<td>
						<textarea rows="3" cols="60" name="cdIdDc" id="cdIdDc" title="코드ID설명" >${result.cdIdDc }</textarea>
					</td>
				</tr>
				<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>사용여부</th>
					<td>
				   		<select name="useAt" id="useAt" title="사용여부">
				   			<option value="Y"  <c:if test="${result.useAt eq 'Y' }">selected="selected"</c:if> >사용</option>
				   			<option value="N"  <c:if test="${result.useAt eq 'N' }">selected="selected"</c:if>>미사용</option>
				   		</select>
					</td>
				</tr> --%>
			</tbody>
		</table>
	</div>
</form>

<div class="btnSet">
	<a class="b-save" href="javascript:void(0);" id="saveBtn"> ${actionName } </a>
	<a class="b-list" href="/bos/cmmnCd/cmmnCdCtgry/list.do?${pageQueryString}"> 목록 </a>
</div>

<script>


	$("#saveBtn").on('click',function() {

		var varFrom = $("#cmmnCdCtgryForm")[0];
		var v = new MiyaValidator(varFrom);
		
		v.add("codegCode", {
			required : true
		});
		
		v.add("cdIdNm", {
			required : true
		});
		/* v.add("cdIdDc", {
			required : true
		}); */
		/* v.add("useAt", {
			required : true
		}); */
		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (confirm("${actionName } 하시겠습니까?")) {
			varFrom.submit();
		}
		return false;
	});
</script>

