<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<c:if test="${(not empty result.bddDateWorkb && not empty result.bddDateWorke) && code }">
	<c:set var="validUploadDate" value="True"/>
</c:if>
<fmt:parseNumber integerOnly='true' value='${result.bddSeq }' var="bddSeq" />

<form id="formBoard">
	<input type="hidden" name="menuNo" value="${param.menuNo }"/>
	<input type="hidden" name="act" value="C" />
	<input type="hidden" name="bdsSeq" value="${result.bdsSeq }" />
	<input type="hidden" name="bddSeq" value="${bddSeq }" />
</form>
<table cellpadding="0" cellspacing="0" border="0" class="boardView full mt20">
	<caption>view page</caption>
	<colgroup>
		<col width="1%" />
		<col width="14%" />
		<col width="35%" />
		<col width="14%" />
		<col width="35%" />
		<col width="1%" />
	</colgroup>
	<thead>
		<tr>
			<th></th>
			<th id="txtTitle">제목</th>
			<th colspan="3" class="al">${result.bddTitle }</th>
			<th> </th>
		</tr>
	</thead>
	<tbody>
		<c:if test="${paramVO.menuNo eq '100184' }">
			<tr>
				<th></th>
				<th>작성센터</th>
				<td class="al">${result.bddCenterName }</td>
				<th>회신구분</th>
				<td class="al">
					<c:if test="${result.bddDataType eq 'A' }">회신요청(첨부파일)</c:if>
					<c:if test="${result.bddDataType eq 'B' }">회신필요없음</c:if>
					<c:if test="${result.bddDataType eq 'C' }">회신요청(댓글)</c:if>
				</td>
				<th></th>
			</tr>
			<tr>
				<th></th>
				<th>작성자</th>
				<td class="al">${result.bddWriter }</td>
				<th>공지여부</th>
				<td class="al"><c:if test="${result.bddNotice eq '0' }">공지하지않음</c:if><c:if test="${result.bddNotice ne '0' }">공지함</c:if></td>
				<th></th>
			</tr>
			<tr>
				<th></th>
				<th>문서작성일</th>
				<td class="al"><fmt:formatDate value="${result.bddCdate }" pattern="yyyy-MM-dd HH:mm"/></td>
				<th></th>
				<td class="al"></td>
				<th></th>
			</tr>
		</c:if>
		<c:if test="${paramVO.menuNo eq '100185' }">
			<tr>
				<th></th>
				<th>작성자</th>
				<td class="al">${result.bddWriter }</td>
				<th>문서작성일</th>
				<td class="al"><fmt:formatDate value="${result.bddCdate }" pattern="yyyy-MM-dd HH:mm"/></td>
				<th></th>
			</tr>
			<tr>
				<th></th>
				<th>작성센터</th>
				<td class="al">${result.bddCenterName }</td>
				<th>공지여부</th>
				<td class="al"><c:if test="${result.bddNotice eq '0' }">공지하지않음</c:if><c:if test="${result.bddNotice ne '0' }">공지함</c:if></td>
				<th></th>
			</tr>
			<tr>
				<th></th>
				<th>문서 수신정보</th>
				<td class="al">${result.thisReadInfo }</td>
				<th>문서형태</th>
				<td class="al">
					<c:if test="${result.bddDataType eq 'A' }">회신요청(첨부파일)</c:if>
					<c:if test="${result.bddDataType eq 'B' }">회신필요없음</c:if>
					<c:if test="${result.bddDataType eq 'C' }">회신요청(댓글)</c:if>
				</td>
				<th></th>
			</tr>
		</c:if>
		<tr>
			<td colspan="6" class="txt"><util:out escapeXml="false">${result.bddContent }</util:out></td>
		</tr>
	</tbody>
</table>

<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileDownloadZone.jsp" flush="true">
	<jsp:param value="demand" name="subFileGroup" />
	<jsp:param value="${bddSeq }" name="subFileCode" />
	<jsp:param value="${userVO.centerCode }" name="subFilecodeSub" /> 
	<jsp:param value="boardDemand" name="subFileFolder" />
</jsp:include>

<div class="btnGroup">
	<c:if test="${userVO.authorCd eq 'CA' || userVO.authorCd eq 'ROLE_SUPER' || userVO.userId eq result.bddUser }">
		<img id="goUpdate" class="divView" style="cursor:pointer" src="/static/bos/image/common/btn_update.png" alt="정보수정" />
		<img id="goDelete" class="divView" style="cursor:pointer" src="/static/bos/image/common/btn_delete.png" alt="정보삭제" />
	</c:if>
	<img id="goList" style="cursor:pointer" src="/static/bos/image/common/btn_list.png" alt="리스트" />
</div>

<c:if test="${paramVO.menuNo eq '100184' }">
	<table class="table02 full mt20">
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="15%" />
				<col width="35%" />
			</colgroup>
			<tr>
				<th>접수여부</th>
				<td class="al">
					<input type="radio" value="R" name="bddrCheck" id="bddrCheckR" ${empty rcept ? 'checked' : '' }><label for="bddrCheckR">열람</label>
					<input type="radio" value="C" name="bddrCheck" id="bddrCheckC" class="ml30" ${not empty rcept ? 'checked' : '' }><label for="bddrCheckC">접수</label>
				</td>
				<th>접수자</th>
				<td>
					<c:if test="${empty result.bddrGetInfo }">
						미접수
					</c:if>
					<c:if test="${not empty result.bddrGetInfo }">
						${result.bddrGetInfo }
					</c:if>
				</td>
			</tr>
	</table>
</c:if>

<c:choose>
	<c:when test="${result.bddDataType eq 'A' }">
		<table id="centerFileUploadList" cellpadding="0" cellspacing="0" border="0" class="table02 full">
			<colgroup>
				<col width="26%" />
				<col width="24%" />
				<col width="24%" />
				<col width="13%" />
				<col width="13%" />
			</colgroup>
			<thead>
				<tr>
					<th>센터명</th>
					<th style="width: 150px;">최초수신정보</th>
					<th>회신정보</th>
					<!--<th>자료 제출자</th>-->
					<th>회신파일</th>
					<!--<th>자료확인 일자</th>-->
					<th>자료관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="center" items="${centerList}" varStatus="status">
					<c:set var="thisTd5" value="-"/>
					<c:set var="thisTd6" value="-"/>
					<c:set var="boardState" value="N"/>
					<c:if test="${not empty center.bdcfCdate }">
						<c:set var="thisTd5" 
							value="<img class='imgUploadedFileDownload' style='cursor:pointer' src='/static/bos/image/common/btn_download.png' alt='${center.filesSeq }' ref='${center.filesSize }'/>"/>
						<c:if test="${result.bddCenter eq userVO.centerCode || empty center.bdcfCheckDate }">
							<c:set var="thisTd6"
								value="<img class='imgUploadedFileDelete' style='cursor:pointer' src='/static/bos/image/common/btn_data.png' alt='${center.filesSeq }' ref='${center.filesSize }' title='${center.bddcCenter }'/>"/>
						</c:if>
						
						<c:set var="boardState" value="Y"/>
					</c:if>
					
					<tr>
						<td>${center.bddcCenterName }</td>
						<td>
							<c:if test="${empty center.bddcCenterUser}">
								-
							</c:if>
							<c:if test="${not empty center.bddcCenterUser}">
								${center.bddcCenterUser } (<fmt:formatDate value="${center.bddcCenterDate }" pattern="yyyy-MM-dd HH:mm"/>)
							</c:if>
						</td>
						<td>
							<c:if test="${empty center.bdcfCdate}">
								미제출
							</c:if>
							<c:if test="${not empty center.bdcfCdate}">
								${center.bdcfWriterUser }<br/>(<fmt:formatDate value="${center.bdcfCdate }" pattern="yyyy-MM-dd HH:mm"/>)
							</c:if>
						</td>
						<td>
							${thisTd5 }
						</td>
						<td>
							${thisTd6 }
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<c:if test="${boardState eq 'N' && validUploadDate eq 'True'}">
			<jsp:include page="/WEB-INF/jsp/bos/share/ekrFileUploadZone.jsp" flush="true">
				<jsp:param value="1" name="fileCnt" /> 
				<jsp:param value="Y" name="boardFile" />
				
				<jsp:param value="boardDemand" name="subFileGroup" />
				<jsp:param value="${bddSeq }" name="subFileCode" />
				<jsp:param value="${userVO.centerCode }" name="subFilecodeSub" /> 
				<jsp:param value="/bos/board/board/view.do?${pageQueryString }" name="afterUrl" />
 			</jsp:include>
		</c:if>
	</c:when>
	<c:when test="${result.bddDataType eq 'C' }">
		<table id="centerFileUploadList" cellpadding="0" cellspacing="0" border="0" class="table02 full">
			<colgroup>
				<col width="20%" />
				<col width="20%" />
				<col width="15%" />
				<col />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th>센터명</th>
					<th>최초수신정보</th>
					<th>회신정보</th>
					<!--<th>제출자</th>-->
					<th>회신내용</th>
					<th>자료관리</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="center" items="${centerList}" varStatus="status">
					<c:set var="thisTd5" value="-"/>
					<c:set var="thisTd6" value="-"/>
					<c:set var="boardState" value="N"/>
					<c:if test="${not empty center.bdcfCdate }">
						<c:if test="${(result.bddCenter eq userVO.centerCode) || (empty center.bdcfCheckDate)}">
							<c:set var="thisTd6"
								value="<img class='imgUploadedFileDelete' style='cursor:pointer' src='/static/bos/image/common/btn_data.png' alt='${center.filesSeq }' ref='${center.filesSize }' title='${center.bddcCenter }'/>" />
						</c:if>
						
						<c:set var="boardState" value="Y"/>
					</c:if>
					
					<tr>
						<td>${center.bddcCenterName }</td>
						<td>
							<c:if test="${empty center.bddcCenterUser}">
								-
							</c:if>
							<c:if test="${not empty center.bddcCenterUser}">
								${center.bddcCenterUser } (<fmt:formatDate value="${center.bddcCenterDate }" pattern="yyyy-MM-dd HH:mm"/>)
							</c:if>
						</td>
						<td>
							<c:if test="${empty center.bdcfCdate}">
								미제출
							</c:if>
							<c:if test="${not empty center.bdcfCdate}">
								${center.bdcfWriterUser }<br/>(<fmt:formatDate value="${center.bdcfCdate }" pattern="yyyy-MM-dd HH:mm"/>)
							</c:if>
						</td>
						<td style='text-align:left;'>${center.bdcfMemo }</td>
						<td>
							${thisTd6 }
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<c:if test="${boardState eq 'N' }">
			<form id="formComment" method="post">
				<input type="hidden" name="act" value="addcomment" /> 
				<input type="hidden" name="bddSeq" value="${result.bddSeq }" />
				<input type="hidden" name="userId" value="${userVO.userId }" />
				<input type="hidden" name="bddcCenter" value="${userVO.centerCode }" />
				<table id="centerFileUploadList" cellpadding="0" cellspacing="0" border="0" class="table02 full mt20">
					<colgroup>
						<col width="10%" />
						<col />
						<col width="10%" />
					</colgroup>
					<thead>
						<tr>
							<th>작성자</th>
							<th>내용</th>
							<th>제출</th>
						</tr>
					</thead>
					<tbody>
						<td>${userVO.userNm }</td>
						<td style="text-align: left;"><textarea id='bdcfMemo' name='bdcfMemo' style='width: 100%; height: 50px;'></textarea></td>
						<td><button class="button" id="btnSaveComment" style='height: 50px; width: 99%;'>제출</button></td>
					</tbody>
				</table>
			</form>
		</c:if>
	</c:when>
	<c:otherwise>
		<table id="centerFileUploadList" cellpadding="0" cellspacing="0" border="0" class="table02 full mt20">
			<thead>
				<tr>
					<th>센터명</th>
					<c:if test="${param.menuNo eq '100185' }">
						<th>최초수신정보</th>
					</c:if>
					<c:if test="${param.menuNo eq '100184' }">
						<th>수신일</th>
						<th>수신자</th>
					</c:if>

				</tr>
			</thead>
			<tbody>
				<c:forEach var="center" items="${centerList}" varStatus="status">
					<tr>
						<td>${center.bddcCenterName }</td>
						<c:if test="${param.menuNo eq '100185' }">
							<td>
								<c:if test="${empty center.bddcCenterUser}">
									-
								</c:if>
								<c:if test="${not empty center.bddcCenterUser}">
									${center.bddcCenterUser } (<fmt:formatDate value="${center.bddcCenterDate }" pattern="yyyy-MM-dd HH:mm"/>)
								</c:if>
							</td>
						</c:if>
						<c:if test="${param.menuNo eq '100184' }">
							<td>
								<c:if test="${empty center.bddcCenterUser}">
									-
								</c:if>
								<c:if test="${not empty center.bddcCenterUser}">
									${center.bddcCenterUser } (<fmt:formatDate value="${center.bddcCenterDate }" pattern="yyyy-MM-dd HH:mm"/>)
								</c:if>
							</td>
							<td>${center.bddcCenterUser }</td>
						</c:if>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>

<form id="formPage" method="post">
	<input type="hidden" name="menuNo" id="menuNo" value="${paramVO.menuNo }"/>
	<input type="hidden" name="pageUnit" id="pageUnit" value="${param.VO.pageUnit }"/>
	<input type="hidden" name="bdsSeq" id="bdsSeq" value="${result.bdsSeq }" />
	<input type="hidden" name="bddSeq" id="bddSeq" value="${result.bddSeq }" />
	<input type="hidden" name="srcCntrGbn" value="${param.VO.srcCntrGbn }"> 
	<input type="hidden" name="srcCntrCod" value="${param.VO.srcCntrCod }"> 
	<input type="hidden" name="searchCnd" value="${param.VO.searchCnd }"> 
	<input type="hidden" name="searchText" value="${param.VO.searchText }">
</form>

<script>
	$("#goUpdate").click(function() {
		var reqUrl = '/bos/board/board/forUpdate.do?';
		var bddSeq = $("#bddSeq").val();
		var params = "${pageQueryString}&bddSeq=" + bddSeq;

		location.href = reqUrl + params;
	});

	$('#goList').click(function() {
		var reqUrl = '/bos/board/board/list.do?';
		var params = "${pageQueryString}";

		location.href = reqUrl + params;
	});

	$('#goDelete').click(function() {
		if (confirm('정보를 삭제하시겠습니까?')) {
			var form = $("#formBoard")[0];
			form.action = "/bos/board/board/delete.do";
			form.submit();
		}
	});

	$("#formComment").validate({
		rules : {
			bdcfMemo : {required : true}
		},
		messages : {
			bdcfMemo : {required : "내용을 입력해 주세요"}
		}
	});

	/* 댓글저장 */
	$('#btnSaveComment').click(function() {
		if ($("#formComment").valid()) {
			$.ajax({
				url : "/bos/board/board/commentSave.json",
				type : "post",
				data : $("#formComment").serialize(),
				success : function(data) {
					if (data.resultCode == "success") {
						alert('내용을 제출했습니다.');

						$('#formPage').attr('action', '/bos/board/board/view.do');
						$('#formPage').submit();
					} else {
						alert('데이터를 저장하지 못했습니다.\n이유 : ' + data.resultString);
					}
				}
			});
		} else {
			alert("필수입력사항을 조건에 맞추어 입력해주세요");
		}
	});

	//첨부파일 삭제용 액션
	$("body").on( "click", ".imgUploadedFileDelete", function() {
		if (confirm('첨부파일을 삭제하시겠습니까?')) {
			var seq = $(this).attr('alt');
			var chk = $(this).attr('ref');
			var bcc = $(this).attr('title');
			actionUploadFileListDeleteCenterJaryo(seq, chk, '${result.bdsSeq}', parseInt('${result.bddSeq}'), bcc);
		} else {
			return;
		}
	});
	
	//첨부파일 다운로드용 액션
	$("body").on("click", ".imgUploadedFileDownload", function() {
		var seq = $(this).attr('alt');
		var chk = $(this).attr('ref');
		
		actionUploadFileListInsertCenterJaryo('${param.menuNo}', seq, chk, '${result.bdsSeq}', '${result.bddSeq}');
	});

	$(function() {
		var pre = $("input[name='bddrCheck']:checked").val();
		var rcept = "${result.bddrGetInfo}";
		var name = '';
		
		$("input:radio[name='bddrCheck']").change(function(){
			if(this.value == 'C'){
				name = '접수';
			} else if(this.value == 'R'){
				name = '열람';
			}
			
			if(!confirm(name + " 상태로 변경 하시겠습니까?")) {
				$(this).prop('checked', false);
				$("input[name='bddrCheck']:radio[value='" + pre + "']").prop('checked', true);
				
				return;
			}

			$.ajax({
				url : "/bos/board/board/centerReceipt.json",
				type : "post",
				data : {bddSeq : parseInt($("#bddSeq").val()), status : this.value},
				success : function(data) {
					if (data.resultCode == "success") {
						alert('변경이 완료되었습니다.');

						$('#formPage').attr('action', '/bos/board/board/view.do');
						$('#formPage').submit();
					} else {
						alert('데이터를 변경하지 못했습니다.\n이유 : ' + data.resultString);
					}
				}
			});
		});
	});
</script>