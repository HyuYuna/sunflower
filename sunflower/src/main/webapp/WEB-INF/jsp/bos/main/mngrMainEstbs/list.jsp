<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld" %>

<script src="/static/jslibrary/jquery.form.min.js"></script>

<script>

$(function(){

	$('.iconNmSelect').each(function(index, el) {
		$(this).on('click',function(event) {
			popupW('/bos/main/mngrMainEstbs/iconSelectList.do?viewType=BODY', $(this).data().id, 1200, 800, 0, 1, 3)
		});
	});

	$('.bbsIdFind').each(function(index, el) {
		$(this).on('click',function(event) {
			popupW('/bos/bbs/master/listPop.do?pSiteId=${siteId}&viewType=BODY', $(this).data().id, 1200, 800, 0, 1, 3)
		});
	});

	/*게시판 선택으로 바뀌어서 사용안함
	$(".bbsIdCheck3").on('change',function(){

		var id = "#bbsId_" +  $(this).attr('id').split("_")[1] + "_3";

		var bbsId = $(id).val();

		var inData = {bbsId : bbsId};

		$.post(
			"/bos/main/mngrMainEstbs/bbsIdCheck.json",
			inData,
			function(data) {
				if (data.resultCode == "success"){
					alert("사용하실수 있는 게시판 아이디입니다.");
				}else{
					alert("사용하실수 없는 게시판 아이디입니다.");
					$(id).val("");
					$(id).focus();
				}
			},
		"json");
	});
	*/

	$(".bbsIdCheck").on('change',function(){

		var id = "#bbsId_" +  $(this).attr('id').split("_")[1];

		var bbsId = $(id).val();

		var inData = {bbsId : bbsId};

		$.post(
			"/bos/main/mngrMainEstbs/bbsIdCheck.json",
			inData,
			function(data) {
				if (data.resultCode == "success"){
					alert("사용하실수 있는 게시판 아이디입니다.");
				}else{
					alert("사용하실수 없는 게시판 아이디입니다.");
					$(id).val("");
					$(id).focus();
				}
			},
		"json");
	});

	$(".completeBtn").on('click',function(event) {
		if (!confirm("관리자 대쉬보드 설정을 수정하시겠습니까?")) return false;
		 var id = "#mngrMainEstbs_" +$(this).attr('id').split("_")[1];

		 event.preventDefault();
		 formSubmit(id);

		 $(id).submit();

		return false;
	});

	function formSubmit(id){

		$(id).ajaxForm({
			dataType : "html",
			beforeSubmit: function (data,form,option) {

			},
			success: function(data,status){
				data = $.parseJSON(data);
		        if (data.resultCode == "success") {
		        	alert("관리자 대쉬보드 설정이 수정되었습니다.");
		        	//location.reload();
		        }
		        else {
		        	console.log(JSON.stringify(data));
		        	alert("관리자 대쉬보드 설정이 실패하였습니다.");
		        	return false;
		        }
		    },
		    error: function(){
		    	alert("관리자 대쉬보드 설정이 실패하였습니다.");
		    	return false;
		    }
		});
	}

});


</script>

	<table class="table table-hover tal">
		<thead>
			<tr class="tac">
				<th scope="col" width="80">사용여부</th>
				<!-- <th scope="col" width="80">사이즈<br>수정여부</th> -->
				<th scope="col" width="120">명칭</th>
				<th scope="col">설정</th>
				<th scope="col" style="width:30%">설명</th>
				<th scope="col">수정</th>
				<th scope="col">미리보기</th>
			</tr>
		</thead>

		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:choose>
				<c:when test="${result.cd eq 1}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<tr>
							<td class="tac">
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
								${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>-</td>
							<%-- <td>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" <c:if test="${result.bassMg eq '1' or result.bassMg eq null}">checked='checked'</c:if>> 크게 보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="2" <c:if test="${result.bassMg eq '2'}">checked='checked'</c:if>> 작게보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="3" <c:if test="${result.bassMg eq '3'}">checked='checked'</c:if>> 넓게 보기</label> 
														</td> --%>
							<td>가입회원 수의 정보를 보여줌</td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 2}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<input type="hidden" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1">
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>
								<textarea rows="5" cols="60" id="estbsCn_${result.cd}" name="estbsCn_${result.cd}" style="height:150px">${result.estbsCn}</textarea>
							</td>
							<td>구글 로그분석기(Analytics)의    접속 기록을 표시합니다. </td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 3}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<input type="hidden" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1">
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>
								게시물 중 최근게시물을 표시하려는 게시판 코드를 입력해주세요
								<style>
									.codeList li{float:left;width:50%;margin-top:5px;}
								</style>
								<ul class="codeList">
									<li>
										<input type="text" name="bbsId_1_${result.cd}" class="bbsIdCheck3" id="bbsId_1_${result.cd}" value="${childList3[0].bbsId}"  placeholder="게시판코드" />
										<!-- <button type="button" id="bbsIdCheck_1" class="b-ok bbsIdCheck">게시판검증</button> -->
										<input type="hidden" name="fieldOrdr_1_${result.cd}" id="fieldOrdr_1_${result.cd}" value="1" />
										<button type="button" data-id="bbsId_1_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
									</li>
									<li>
										<input type="text" name="bbsId_2_${result.cd}" class="bbsIdCheck3" id="bbsId_2_${result.cd}" value="${childList3[1].bbsId}"  placeholder="게시판코드" />
										<!-- <button type="button" id="bbsIdCheck_2" class="b-ok bbsIdCheck">게시판검증</button> -->
										<input type="hidden" name="fieldOrdr_2_${result.cd}" id="fieldOrdr_2_${result.cd}" value="2" />
										<button type="button" data-id="bbsId_2_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
									</li>
									<li>
										<input type="text" name="bbsId_3_${result.cd}" class="bbsIdCheck3" id="bbsId_3_${result.cd}" value="${childList3[2].bbsId}"  placeholder="게시판코드" />
										<!-- <button type="button" id="bbsIdCheck_3" class="b-ok bbsIdCheck">게시판검증</button> -->
										<input type="hidden" name="fieldOrdr_3_${result.cd}" id="fieldOrdr_3_${result.cd}" value="3" />
										<button type="button" data-id="bbsId_3_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
									</li>
									<li>
										<input type="text" name="bbsId_4_${result.cd}" class="bbsIdCheck3" id="bbsId_4_${result.cd}" value="${childList3[3].bbsId}"  placeholder="게시판코드" />
										<!-- <button type="button" id="bbsIdCheck_4" class="b-ok bbsIdCheck">게시판검증</button> -->
										<input type="hidden" name="fieldOrdr_4_${result.cd}" id="fieldOrdr_4_${result.cd}" value="4" />
										<button type="button" data-id="bbsId_4_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
									</li>
									<li>
										<input type="text" name="bbsId_5_${result.cd}" class="bbsIdCheck3" id="bbsId_5_${result.cd}" value="${childList3[4].bbsId}"  placeholder="게시판코드" />
										<!-- <button type="button" id="bbsIdCheck_5" class="b-ok bbsIdCheck">게시판검증</button> -->
										<input type="hidden" name="fieldOrdr_5_${result.cd}" id="fieldOrdr_5_${result.cd}" value="5" />
										<button type="button" data-id="bbsId_5_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
									</li>
								</ul>
							</td>
							<td>통합게시판에 등록된 최신 게시물을 표시합니다. (등록일 5일 기준)</td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 4}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<input type="hidden" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1">
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>
								<table class="table table-bordered mb0">
									<thead>
										<tr>
											<th scope="col">바로가기명</th>
											<th scope="col">URL</th>
											<th scope="col">아이콘기호</th>
											<th scope="col">선택</th>
										</tr>
									</thead>
									<tbody>
										<%-- <c:forEach var="_result" items="${childList}" varStatus="_status">
											<tr>
												<td>
													<input type="text" name="estbsNm_${_result.cd}_${result.cd}" id="estbsNm_${_result.cd}_${result.cd}" value="${_result.estbsNm}" placeholder="게시판명" />
													<input type="text" name="urlad_${_result.cd}_${result.cd}" id="urlad_${_result.cd}_${result.cd}" value="${_result.urlad}"  placeholder="URL" />
													<label><input type="checkbox" name=""> 새창</label>
												</td>
												<td>
													<input type="text" name="atchFileId_${_result.cd}_${result.cd}" id="atchFileId_${_result.cd}_${result.cd}" value="${_result.atchFileId}"  placeholder="아이콘 기호" />
												</td>
											</tr>
										</c:forEach> --%>
										<tr>
											<td>
												<input type="text" name="estbsNm_1_${result.cd}" id="estbsNm_1_${result.cd}" value="${childList4[0].estbsNm}" placeholder="바로가기명" />
											</td>
											<td>
												<input type="text" name="urlad_1_${result.cd}" id="urlad_1_${result.cd}" value="${childList4[0].urlad}"  placeholder="URL" />
												<label><input type="checkbox" id="popupAt_1_${result.cd}" name="popupAt_1_${result.cd}" value="Y" <c:if test="${childList4[0].popupAt eq 'Y'}">checked='checked'</c:if>> 새창</label>
											</td>
											<td>
												<input type="hidden" name="iconNm_1_${result.cd}" id="iconNm_1_${result.cd}" value="${childList4[0].iconNm}"  placeholder="아이콘 기호" readonly="readonly" />
												<span class="${childList4[0].iconNm} fa-3x vm"></span>
											</td>
											<td>
												<button type="button" data-id="iconNm_1_${result.cd}" class="b-open btn-sm iconNmSelect">아이콘선택</button>
												<input type="hidden" name="fieldOrdr_1_${result.cd}" id="fieldOrdr_1_${result.cd}" value="1" />
											</td>
										</tr>
										<tr>
											<td>
												<input type="text" name="estbsNm_2_${result.cd}" id="estbsNm_2_${result.cd}" value="${childList4[1].estbsNm}" placeholder="바로가기명">
											</td>
											<td>
												<input type="text" name="urlad_2_${result.cd}" id="urlad_2_${result.cd}" value="${childList4[1].urlad}"  placeholder="URL" />
												<label><input type="checkbox" id="popupAt_2_${result.cd}" name="popupAt_2_${result.cd}" value="Y" <c:if test="${childList4[1].popupAt eq 'Y'}">checked='checked'</c:if>> 새창</label>
											</td>
											<td>
												<input type="hidden" name="iconNm_2_${result.cd}" id="iconNm_2_${result.cd}" value="${childList4[1].iconNm}"  placeholder="아이콘 기호" readonly="readonly" />
												<span class="${childList4[1].iconNm} fa-3x vm"></span>
											</td>
											<td>
												<button type="button" data-id="iconNm_2_${result.cd}" class="b-open btn-sm iconNmSelect">아이콘선택</button>
												<input type="hidden" name="fieldOrdr_2_${result.cd}" id="fieldOrdr_2_${result.cd}" value="2" />
											</td>
										</tr>
										<tr>
											<td>
												<input type="text" name="estbsNm_3_${result.cd}" id="estbsNm_3_${result.cd}" value="${childList4[2].estbsNm}" placeholder="바로가기명">
											</td>
											<td>
												<input type="text" name="urlad_3_${result.cd}" id=urlad_3_${result.cd}" value="${childList4[2].urlad}"  placeholder="URL" />
												<label><input type="checkbox" id="popupAt_3_${result.cd}" name="popupAt_3_${result.cd}" value="Y" <c:if test="${childList4[2].popupAt eq 'Y'}">checked='checked'</c:if>> 새창</label>
											</td>
											<td>
												<input type="hidden" name="iconNm_3_${result.cd}" id="iconNm_3_${result.cd}" value="${childList4[2].iconNm}"  placeholder="아이콘 기호" readonly="readonly" />
												<span class="${childList4[2].iconNm} fa-3x vm"></span>
											</td>
											<td>
												<button type="button" data-id="iconNm_3_${result.cd}" class="b-open btn-sm iconNmSelect">아이콘선택</button>
												<input type="hidden" name="fieldOrdr_3_${result.cd}" id="fieldOrdr_3_${result.cd}" value="3" />
											</td>
										</tr>
										<tr>
											<td>
												<input type="text" name="estbsNm_4_${result.cd}" id="estbsNm_4_${result.cd}" value="${childList4[3].estbsNm}" placeholder="바로가기명">
											</td>
											<td>
												<input type="text" name="urlad_4_${result.cd}" id="urlad_4_${result.cd}" value="${childList4[3].urlad}"  placeholder="URL" />
												<label><input type="checkbox" id="popupAt_4_${result.cd}" name="popupAt_4_${result.cd}" value="Y" <c:if test="${childList4[3].popupAt eq 'Y'}">checked='checked'</c:if>> 새창</label>
											</td>
											<td>
												<input type="hidden" name="iconNm_4_${result.cd}" id="iconNm_4_${result.cd}" value="${childList4[3].iconNm}"  placeholder="아이콘 기호" readonly="readonly" />
												<span class="${childList4[3].iconNm} fa-3x vm"></span>
											</td>
											<td>
												<button type="button" data-id="iconNm_4_${result.cd}" class="b-open btn-sm iconNmSelect">아이콘선택</button>
												<input type="hidden" name="fieldOrdr_4_${result.cd}" id="fieldOrdr_4_${result.cd}" value="4" />
											</td>
										</tr>
										<tr>
											<td>
												<input type="text" name="estbsNm_5_${result.cd}" id="estbsNm_5_${result.cd}" value="${childList4[4].estbsNm}" placeholder="바로가기명">
											</td>
											<td>
												<input type="text" name="urlad_5_${result.cd}" id="urlad_5_${result.cd}" value="${childList4[4].urlad}"  placeholder="URL" />
												<label><input type="checkbox" id="popupAt_5_${result.cd}" name="popupAt_5_${result.cd}" value="Y" <c:if test="${childList4[4].popupAt eq 'Y'}">checked='checked'</c:if>> 새창</label>
											</td>
											<td>
												<input type="hidden" name="iconNm_5_${result.cd}" id="iconNm_5_${result.cd}" value="${childList4[4].iconNm}"  placeholder="아이콘 기호" readonly="readonly" />
												<span class="${childList4[4].iconNm} fa-3x vm"></span>
											</td>
											<td>
												<button type="button" data-id="iconNm_5_${result.cd}" class="b-open btn-sm iconNmSelect">아이콘선택</button>
												<input type="hidden" name="fieldOrdr_5_${result.cd}" id="fieldOrdr_5_${result.cd}" value="5" />
											</td>
										</tr>
									</tbody>
								</table>
							</td>
							<td>바로가기 버튼을 4개까지 설정할 수 있습니다. </td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 5}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>-</td>
							<%-- <td>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" <c:if test="${result.bassMg eq '1' or result.bassMg eq null}">checked='checked'</c:if>> 크게 보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="2" <c:if test="${result.bassMg eq '2'}">checked='checked'</c:if>> 작게보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="3" <c:if test="${result.bassMg eq '3'}">checked='checked'</c:if>> 넓게 보기</label> 
															<br/>

														</td> --%>
							<td>오늘의 날씨를 보여줍니다. 단, 외부연동이 안될 시 서비스가 안될 수 있음</td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 6}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<tr>
							<td class="tac">
								${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>-</td>
							<%-- <td>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" <c:if test="${result.bassMg eq '1' or result.bassMg eq null}">checked='checked'</c:if>> 크게 보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="2" <c:if test="${result.bassMg eq '2'}">checked='checked'</c:if>> 작게보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="3" <c:if test="${result.bassMg eq '3'}">checked='checked'</c:if>> 넓게 보기</label> 
														</td> --%>
							<td>오늘의 날짜 캘린더를 볼 수 있습니다. </td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 7}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<input type="hidden" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1">
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>
								<%-- <label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" <c:if test="${result.bassMg eq '1'}">checked='checked'</c:if>> 크게 보기</label>
								<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="2" <c:if test="${result.bassMg eq '2'}">checked='checked'</c:if>> 작게보기</label>
								<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="3" <c:if test="${result.bassMg eq '3'}">checked='checked'</c:if>> 넓게 보기</label>  --%>

								<div>
									관리자공지게시판의 코드를 입력해주세요
									<input type="text" name="bbsId_${result.cd}" id="bbsId_${result.cd}" value="${childList7[0].bbsId}"  placeholder="관리자공지게시판코드" />
									<button type="button" data-id="bbsId_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
									<input type="hidden" name="fieldOrdr_${result.cd}" id="fieldOrdr_${result.cd}" value="1" />

								</div>
							</td>
							<td>관리자공지를 볼 수 있습니다. 단 생성되지 않았을 경우에는 표시되지 않을 수 있습니다.</td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 8}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>-</td>
							<%-- <td>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" <c:if test="${result.bassMg eq '1' or result.bassMg eq null}">checked='checked'</c:if>> 크게 보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="2" <c:if test="${result.bassMg eq '2'}">checked='checked'</c:if>> 작게보기</label>
															<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="3" <c:if test="${result.bassMg eq '3'}">checked='checked'</c:if>> 넓게 보기</label> 
														</td> --%>
							<td>생성된 전체 게시판 현황을 보여줍니다.</td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 9}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>-</td>
							<%--
							<td>
								<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" <c:if test="${result.bassMg eq '1' or empty result.bassMg}">checked='checked'</c:if>> 크게 보기</label>
								<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="2" <c:if test="${result.bassMg eq '2'}">checked='checked'</c:if>> 작게보기</label>
								<label><input type="radio" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="3" <c:if test="${result.bassMg eq '3'}">checked='checked'</c:if>> 넓게 보기</label> 
							</td>
							 --%>
							<td>하드공간, 메모리사용량 등을    표시합니다.</td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
				<c:when test="${result.cd eq 10}">
					<form id="mngrMainEstbs_${result.cd}" class="mngrMainEstbs" name="mngrMainEstbs_${result.cd}" action="/bos/main/mngrMainEstbs/update.json" enctype="multipart/form-data" method="post">
						<input type="hidden" name="csrfToken" value="${csrfToken}"/>
						<input type="hidden" id="mnno_${result.cd}" name="mnno" value="${result.mnno}" />
						<input type="hidden" id="cd_${result.cd}" name="cd" value="${result.cd}" />
						<input type="hidden" id="bassMg_${result.cd}" name="bassMg_${result.cd}" value="1" />
						<input type="hidden" name="fieldOrdr_${result.cd}" id="fieldOrdr_${result.cd}" value="1" />
						<tr>
							<td class="tac">
							${result.cd}
								<input type="checkbox" id="useAt_${result.cd}" name="useAt_${result.cd}" <c:if test="${result.useAt eq 'Y'}">checked='checked'</c:if> value="Y" />
							</td>
							<%-- <td class="tac">
															<input type="checkbox" id="sizeUpdtAt_${result.cd}" name="sizeUpdtAt_${result.cd}" <c:if test="${result.sizeUpdtAt eq 'Y' or empty result.sizeUpdtAt}">checked='checked'</c:if> value="Y" />
														</td> --%>
							<td><label for="useAt_${result.cd}">${result.cdNm }</label></td>
							<td>
								<table class="table table-bordered mb0">
									<thead>
										<tr>
											<th scope="col">게시판명</th>
											<th scope="col">게시판코드</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<input type="text" name="estbsNm_${result.cd}" id="estbsNm_${result.cd}" value="${childList10[0].estbsNm}" class="w100p" placeholder="게시판명">
											</td>
											<td>
												<input type="text" name="bbsId_${result.cd}" class="bbsIdCheck" id="bbsId_${result.cd}" value="${childList10[0].bbsId}" placeholder="게시판코드">
												<button type="button" data-id="bbsId_${result.cd}" class="b-open btn-sm bbsIdFind">게시판선택</button>
											</td>
										</tr>

									</tbody>
								</table>
							</td>
							<td>개별 게시판은 등록된 게시판에 대해서 &quot;크게보기&quot;로    게시판 각각 표시됩니다. </td>
							<td>
								<button type="button" class="b-edit btn-sm completeBtn" id="completeBtn_${result.cd}">수정</button>
							</td>
							<td><button type="button" class="b-view btn-sm" >미리보기</button></td>
						</tr>
					</form>
				</c:when>
			</c:choose>
		</c:forEach>
	</table>
<!-- <div class="btnSet">
	<a class="b-edit" href="javascript:void(0)" onclick="checkForm();"><span>수정</span></a>
</div> -->

