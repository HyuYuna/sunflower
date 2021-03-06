<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="util" uri="/WEB-INF/tlds/util.tld"%>
<script>
	function modify(){
		if (!checkForm()) {
			return;
		}
		if(confirm('<spring:message code="common.update.msg" />')){
			document.boardMaster.action = "/bos/bbs/master/update.do?menuNo=${param.menuNo}";
			document.boardMaster.submit();
		}
	}

	function save(){
		if (!checkForm()) {
			return;
		}
		if(confirm('<spring:message code="common.save.msg" />')){
			document.boardMaster.action = "/bos/bbs/master/insert.do?menuNo=${param.menuNo}";
			document.boardMaster.submit();
		}
	}

	function deleteOne(){
		if(confirm('<spring:message code="common.delete.msg" />')){
			document.boardMaster.action = "/bos/bbs/master/delete.do?menuNo=${param.menuNo}";
			document.boardMaster.submit();
		}
	}

	function pop()
	{
		var PopWindow = "pop_win";
		var win = window.open( "/bos/bbs/attrb/pageAttrList.do?bbsId=${result.bbsId}",
		     PopWindow,
		     "toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=800,height=900,left=50,top=50"
		);
	}

	function fn_filterChk(obj){
		 var chktext = /[;:|\)*~`!^\+┼<>@\#$%&\'\"\\\(]/gi;
		 if (chktext.test(obj.value)) {
		     alert("특수문자는 입력하실 수 없습니다.");
			 obj.focus();
			 return false;
		  }
		  return true;
	}

	function checkForm() {
		var form = $("#boardMaster")[0];
		var v = new MiyaValidator(form);

	    v.add("bbsNm", {
	        required: true
	    });
	    v.add("bbsTyCd", {
	        required: true
	    });
	    v.add("bbsAttrbCd", {
	        required: true
	    });
	    v.add("cmPosblAt", {
	        required: true
	    });
	    /*
	    v.add("replyPosblAt", {
	        required: true
	    });
	    */
	    v.add("fileAtchPosblAt", {
	        required: true
	    });
	    v.add("prevNextPosblAt", {
	        required: true
	    });
	    v.add("pageUnit", {
	        required: true
	    });
	    v.add("pageSize", {
	        required: true
	    });
	    /*
	    v.add("tableNm", {
	        required: true
	    });
	    */

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return false;
		}
		// 제목 특수문자 제외처리
		if (!fn_filterChk(form.bbsNm)) return false;
		return true;
	}

</script>

<ul class="nav nav-tabs">
	<li role="presentation" class="active"><a href="/bos/bbs/master/forUpdate.do?bbsId=${paramVO.bbsId}&menuNo=${paramVO.menuNo}">기능및 표시 설정</a></li>
	<li role="presentation"><a href="/bos/bbs/authMaster/forUpdateRole.do?bbsId=${paramVO.bbsId}&menuNo=${paramVO.menuNo}">권한설정</a></li>
</ul>

<form id="boardMaster" name="boardMaster" action="/bos/bbs/master/insert.do?menuNo=${param.menuNo}" enctype="multipart/form-data" method="post">
	<input name="pagQueryString" type="hidden" value="${pageQueryString}"/>
	<input name="bbsId" type="hidden" value="${result.bbsId}" />
	<input name="atchPosblFileCo" type="hidden" value="10" />
	<input name="tableNm" id="tableNm" type="hidden" value="TB_BBS_ESTN" />
	<input name="replyPosblAt" id="replyPosblAt" type="hidden" value="Y" />
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
<div class="bdView">
<table>
	<caption>게시판 쓰기</caption>
	<colgroup>
		<col width="17%"/>
		<col width="83%"/>
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="bbsNm">게시판명 </label></th>
			<td>
				<input name="bbsNm" id="bbsNm" type="text" size="60" value='${result.bbsNm}' maxlength="60" />
			</td>
		</tr>
		<tr>
			<th scope="row"><label for="aditCntntsCn">추가컨텐츠</label></th>
			<td>
		      <textarea name="aditCntntsCn" id="aditCntntsCn" class="aditCntntsCn"  cols="75" rows="15"  >${result.aditCntntsCn}</textarea>
			</td>
		</tr>

	<c:if test="${not empty result}">
		<tr>
			<th scope="row">게시판URL</th>
			<td><a href="/bos/bbs/${result.bbsId}/list.do?menuNo=${param.menuNo}" target="_blank">/bos/bbs/${result.bbsId}/list.do</a></td>
		</tr>
	</c:if>
		<!--
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="bbsTyCd">게시판 유형 </label></th>
			<td>
	    	<select name="bbsTyCd" id="bbsTyCd">
    	  		<option value=''>선택하세요</option>
    	  	<c:forEach var="item" items="${BBS_TY_CD_MAP}" varStatus="status">
	      		<option value="${item.key}" <c:if test="${item.key eq result.bbsTyCd}">selected</c:if> >${item.key}(${item.value})</option>
	      	</c:forEach>
      		</select>
			</td>
		</tr>
		-->
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="bbsAttrbCd">게시판 유형 </label></th>
			<td>
      		<input type="hidden" name="bbsTyCd" id="bbsTyCd" value="BBST01" /> <!-- BBST03 -->
      		<select name="bbsAttrbCd" id="bbsAttrbCd">
    	  		<option value='' label="선택하세요" />
			<c:forEach var="attrb" items="${attrbList}" varStatus="status">
	      		<option value="${attrb.attrbCd}" <c:if test="${attrb.attrbCd eq result.bbsAttrbCd}">selected</c:if> >${attrb.attrbNm}(${attrb.attrbCd})</option>
	      	</c:forEach>
      		</select>

      		<script>
      			$("#bbsAttrbCd").on('change',function() {
      				var $this = $(this);
      				if ($this.val() == "PG0001") {
      					$("#bbsTyCd").val("BBST03");
      				}
      				else {
      					$("#bbsTyCd").val("BBST01");
      				}
      			});
      		</script>
			</td>
		</tr>

		<!--
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span>답장가능여부 </th>
			<td>
	    	<label><spring:message code="button.possible" /> : <input type="radio" name="replyPosblAt" class="radio2" value="Y" <c:if test="${result.replyPosblAt eq 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.impossible" /> : <input type="radio" name="replyPosblAt" class="radio2" value="N" <c:if test="${result.replyPosblAt eq 'N'}"> checked="checked"</c:if>></label>
			</td>
		</tr>
		 -->
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span>댓글 사용여부 </th>
			<td>
	    	<label><spring:message code="button.use" /> : <input type="radio" name="cmPosblAt" class="radio2" value="Y" <c:if test="${result.cmPosblAt eq 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.notUsed" /> : <input type="radio" name="cmPosblAt" class="radio2" value="N" <c:if test="${result.cmPosblAt eq 'N'}"> checked="checked"</c:if>></label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span>파일첨부가능여부 </th>
			<td>
	     	<label><spring:message code="button.use" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="Y" <c:if test="${result.fileAtchPosblAt eq 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.notUsed" /> : <input type="radio" name="fileAtchPosblAt" class="radio2" value="N" <c:if test="${result.fileAtchPosblAt eq 'N'}"> checked="checked"</c:if>></label>
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span>이전글다음글가능여부 </th>
			<td>
	    	<label><spring:message code="button.use" /> : <input type="radio" name="prevNextPosblAt" class="radio2" value="Y" <c:if test="${result.prevNextPosblAt eq 'Y'}"> checked="checked"</c:if>>&nbsp;</label>
	     	<label><spring:message code="button.notUsed" /> : <input type="radio" name="prevNextPosblAt" class="radio2" value="N" <c:if test="${result.prevNextPosblAt eq 'N'}"> checked="checked"</c:if>></label>
			</td>
		</tr>

		<%-- <tr id="posblAtchFileNumberLayer" ${result.fileAtchPosblAt eq "Y" ? "style='display:block;'" : "style='display:none;'" }>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="bbsIntrcn">첨부가능파일 숫자 </label></th>
			<td>
	     	<select name="posblAtchFileNumber" class="select">
	  		   <option selected="selected" value"0">--선택하세요--</option>
	  		   <option value='1' <c:if test="${result.posblAtchFileNumber eq '1'}">selected="selected"</c:if>>1개</option>
	  		   <option value='2' <c:if test="${result.posblAtchFileNumber eq '2'}">selected="selected"</c:if>>2개</option>
	  		   <option value='3' <c:if test="${result.posblAtchFileNumber eq '3'}">selected="selected"</c:if>>3개</option>
	  	   </select>
			</td>
		</tr> --%>
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="pageUnit">목록수 </label></th>
			<td>
				<input name="pageUnit" id="pageUnit" type="text" size="20" value='${result.pageUnit}' maxlength="20" style="width:20%" >
			</td>
		</tr>
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="pageSize">페이지수 </label></th>
			<td>
				<input name="pageSize" id="pageSize" type="text" size="20" value='${result.pageSize}' maxlength="20" style="width:20%" >
			</td>
		</tr>
		<!--
		<tr>
			<th scope="row"><span class="req"><span>필수입력</span></span><label for="tableNm">테이블명</label></th>
			<td>
				<input name="tableNm" id="tableNm" type="text" size="60" value="${empty result ? 'TB_BBS_ESTN' : result.tableNm}" maxlength="60" style="width:30%" >
			</td>
		</tr>
		-->
	</tbody>
</table>
</div>
</form>

	<div class="btnSet">
	<c:if test="${empty result}">
		<a class="b-reg" href="javascript:void(0)" onclick="save();"><span>등록</span></a>
	</c:if>
	<c:if test="${not empty result}">
		<a class="b-edit" href="javascript:void(0)" onclick="modify();"><span>수정</span></a>
		<a class="b-del" href="javascript:void(0)" onclick="deleteOne();"><span>삭제</span></a>
	</c:if>
		<a class="b-cancel" href="/bos/bbs/master/list.do?${pageQueryString }"><span>취소</span></a>
	</div>