<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>


<script>

	// 메인 폼 체크
	function checkForm() {
		var form = $("#board")[0];
		var v = new MiyaValidator(form);
		v.add("pSiteId", {
	        required: true
	    });

		var result = v.validate();
		if (!result) {
			alert(v.getErrorMessage());
			v.getErrorElement().focus();
			return;
		}

		if (fn_guideMenuChk()) return; //가이드 메뉴 필수값 체크

		if (!confirm('저장 하시겠습니까?')) {
			return;
		}
		form.submit();

	}

	function replaceX(str){
		str = str.replace("&amp;","&").replace(/&/gi,"&amp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/"/gi,"&quot;").replace(/'/gi,"&apos;");
		return str;
	}


	// 가이드메뉴 폼 체크
	function fn_guideMenuChk(){
		var flag = false;
		$("#guideMenuTable tr").each(function(){
			if ($(this).index()>0 && $(this).find("td input[name=menuNm]")!=undefined && $(this).find("td input[name=menuNm]").val()!=undefined){
				if ($(this).find("td input[name=menuNm]").val()==""){
					alert("메뉴명을 입력하여 주십시요.");
					$(this).find("td input[name=menuNm]").focus();
					flag = true;
					return false;
				}
				if ($(this).find("td input[name=menuLink]").val()==""){
					alert("메뉴링크를 입력하여 주십시요.");
					$(this).find("td input[name=menuLink]").focus();
					flag = true;
					return false;
				}
				// 외부링크 http:// 부터 시작 체크
 				if ($(this).find("td label input[type=radio]").eq(1).is(":checked")){
					if ($(this).find("td input[name=menuLink]").val().indexOf("http://")==-1
							&& $(this).find("td input[name=menuLink]").val().indexOf("https://")==-1){
						alert("외부 링크는 'http://' 부터 입력하셔야 합니다.");
						$(this).find("td input[name=menuLink]").focus();
						flag = true;
						return false;
					}
				}

				if ($(this).find("td label input[type=radio]").eq(1).is(":checked")){
					if (!checkDetailUrl($(this).find("td input[name=menuLink]").val())){
						alert("URL 형식에 맞지 않습니다.");
						$(this).find("td input[name=menuLink]").focus();
						flag = true;
						return false;
					}
				}
			}
		});
		return flag;
	}

	// url 형식 체크
	function checkDetailUrl(strUrl) {
	    var expUrl = /(((http(s)?:\/\/)\S+(\.[^(\n|\t|\s,)]+)+)|((http(s)?:\/\/)?(([a-zA-z\-_]+[0-9]*)|([0-9]*[a-zA-z\-_]+)){2,}(\.[^(\n|\t|\s,)]+)+))+/gi;
	    return expUrl.test(strUrl);
	}

	// 체크함수 (N : 숫자만 , NP : 숫자 + . , NA : 숫자 + 영어)
	function check_txt(value, type) {
		if (type == "N"){ // N :숫자만
			var pattern = /^[0-9]+$/;
			if (!pattern.test(value)) {
				alert("숫자로만 입력하셔야 합니다.");
				return "";
			}
		}else if (type == "NP"){ // NP :숫자 + .
			var pattern = /^[0-9|.]+$/;
			if (!pattern.test(value)) {
				alert("숫자와 .만 입력하셔야 합니다.");
				return "";
			}
		}else if (type == "NA"){ // NA :숫자 + 영어
			var pattern = /[^a-zA-Z0-9|.|/|&|?|:]/;
			if (pattern.test(value)) {
				alert("한글은 사용할 수 없습니다.");
				return "";
			}
		}
		return value;
	}


	// 가이드 메뉴 관련 스크립트
    $(function() {
    	// 상단 추가 버튼 클릭시
    	$("#board").on("click",".btnAddRow",function() {
        	var sMenuSeCd = $(this).attr("menuSeCd");
        	var maxMenuCnt = sMenuSeCd=="01" ? 5 : 8;
        	var menuTit = sMenuSeCd=="01" ? "상단" : "하단";

       		if ($("#guideMenuTable tr").length>(maxMenuCnt+2)) {
       			alert(menuTit+"메뉴는 "+maxMenuCnt+"개이상 입력하실수 없습니다.");
       			return;
       		}
        	$("#cnt").val(parseInt($("#cnt").val())+1);
        	$("#guideMenuTable tr").eq(1).find(".linkSeClass").attr("name","linkSe"+$("#cnt").val());
        	$.trClone = $("#guideMenuTable tr").eq(1).clone().html();
        	//타이틀 수정(replace())
        	$.trClone = $.trClone.replace(/\(0\)/gi,"("+$("#cnt").val()+")");
            $.newTr = $("<tr>"+$.trClone+"</tr>");
			$("#guideMenuTable tr").last().before($.newTr);
			$("#guideMenuTable tr").find(':radio').eq(-1).parent().prev().find(':radio').prop('checked',true);

			if($("#nodata").css("display")!="none") $("#nodata").hide();

    	});

    	// tr 삭제 버튼
		$("#guideMenuTable").on("button[name='btnRemove']","click",function() {
			$(this).closest("tr").remove();
			if ($("#guideMenuTable tr").length==3){
				$("#nodata").show();
			}
		});

    	// tr 맨위로 버튼
		$("#guideMenuTable").on("click",".fa-angle-double-up",function() {
			var $trs = $("#guideMenuTable tr");
			var $tr  = $(this).closest("tr")
			var $clone = $tr.clone();

			if ($tr.prev().attr("id")!="addRow"){
				$trs.eq(2).before($clone)
				$tr.remove();
				return false;

			} else {
				alert("처음 순서입니다.")
			}
		});

		// tr 한단계 위로 버튼
		$("#guideMenuTable").on("click",".fa-angle-up",function() {
			var $tr = $(this).closest("tr");
			var $clone = $tr.clone();
			if ($tr.prev().attr("id")!="addRow"){
				$tr.prev().before($clone);
				$tr.remove();
				return false;
			} else {
				alert("처음 순서입니다.")
			}
		});

		// tr 한단계 밑으로 버튼
		$("#guideMenuTable").on("click",".fa-angle-down",function() {
			var $tr = $(this).closest("tr");
			var $clone = $tr.clone();
			if ($tr.next().attr("id")!="nodata"){
				$tr.next().after($clone);
				$tr.remove();
			} else {
				alert("마지막 순서입니다.")
			}
			return false;
		});

    	// tr 맨밑으로 버튼
		$("#guideMenuTable").on("click",".fa-angle-double-down",function() {
			var $trs = $("#guideMenuTable tr");
			var $tr  = $(this).closest("tr")
			var $clone = $tr.clone();

			if ($tr.next().attr("id")!="nodata"){
				$trs.eq($trs.length-1).before($clone)
				$tr.remove();
				return false;
			} else {
				alert("마지막 순서입니다.")
			}
		});

		//내부/외부 링크
		$("#guideMenuTable").on("change",".targeturlSelection label",function() {
			if ($(this).find("input").val()=="I") {
				$(this).siblings('div').find('div').show().next().attr('class','col-md-9');
				//alert($(this).parent().find("input[name=menuLink]").attr("readonly"));
				$(this).parent().find("input[name=menuLink]").attr("readonly",true);
			} else {
				$(this).siblings('div').find('div:first-child').hide().next().attr('class','col-md-12');
				$(this).parent().find("input[name=menuLink]").attr("readonly",false);
			}
			$(this).parent().parent().find("input[name=pMenuNo]").val("");
			$(this).parent().find("input[name=menuLink]").val("");
		});

		$("#guideMenuTable").on("click",".innerLinkPopup",function() {
			var idx = $(this).closest("tr").index();
			window.open('/bos/cmmn/cmmnMenu/listMenuPop.do?viewType=BODY&pSiteId=${paramVO.pSiteId}&linkNo='+idx,'innerLinkPopup','resizable=1,scrollbars=1 ,width=800,height=600');
			return false;
		});

    });


    function fnSetMenuLink(menuNo, menuNm, menuLink, linkNo) {
    	$("input[name=pMenuNo]").eq(linkNo).val(menuNo);
    	$("input[name=menuNm]").eq(linkNo).val(menuNm);
    	$("input[name=menuLink]").eq(linkNo).val(menuLink);
	}



</script>

	<form id="board" name="board" method="post" enctype="multipart/form-data" action="updateSiteGuideMenu.do">
		<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div>
		<c:if test="${paramVO.menuSeCd eq '01'}">
		<div class="box">
			<p>상단 가이드 메뉴에서 추가로 사용할 메뉴를 설정하시기 바랍니다.(예 : 언어설정 - 중문, 영문, 일문, 바로가기링크, 블로그, 카페링크 등...)</p>
			<p>위치 : 추가메뉴의 경우 기본가이드 메뉴(로그인, 회원가입, 사이트맵)를 기준으로 뒤쪽위치에 활성화됩니다.</p>
			<p class="point">새창링크시 http://를 포함한 절대경로값을 입력함.</p>
		</div>
		</c:if>
		<div class="btnSet">
			<span class="inputDeco">※ ${paramVO.menuSeCd eq '01' ? '상단' : '하단'} 메뉴는 ${paramVO.menuSeCd eq '01' ? '5' : '8'}개까지 설정가능.</span>
			<button type="button" class="b-add btn-xs btnAddRow" menuSeCd="${paramVO.menuSeCd}">추가</button>
			<input type="hidden" name="pSiteId" id="pSiteId"  class="w30p" value="${paramVO.pSiteId}"/>
			<input type="hidden" name="viewType" id="viewType"  class="w30p" value="${paramVO.viewType}"/>
			<input type="hidden" name="menuSeCd" id="menuSeCd"  class="w30p" value="${paramVO.menuSeCd}"/>
			<input type="hidden" name="menuNo" id="menuNo"  class="w30p" value="${paramVO.menuNo}"/>
			<input type="hidden" name="cnt" id="cnt"  class="w30p" value="${fn:length(resultList)}"/>
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
		</div>
		<table id="guideMenuTable" class="table table-striped table-hover">
			<caption>사이트 관리 목록</caption>
			<colgroup>
				<col width="20%" />
				<col width="*" />
				<col width="160px" />
				<col width="10%" />
				<col width="10%" />
				<col width="6%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><span class="req"><span class="sr-only">필수입력</span></span>메뉴명</th>
					<th scope="col"><span class="req"><span class="sr-only">필수입력</span></span>메뉴링크</th>
					<th scope="col">순서</th>
					<th scope="col">새창여부</th>
					<th scope="col">사용여부</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
			<tr style="display:none;" id="addRow">
				<td>
					<input type="hidden" name="mnno" value=""/>
					<input type="hidden" name="pMenuNo" value="" size="5"/>
					<input type="text" name="menuNm" value="" class="w100p" title="메뉴명(0)을 입력하세요." />
				</td>
				<td class="tal targeturlSelection">
 					<label><input type="radio" name="linkSe" value="I" class="linkSeClass" checked="checked"> 내부</label>
					<label><input type="radio" name="linkSe" value="E" class="linkSeClass"> 외부</label>
					<div class="row">
					<div class="col-md-3" style="display:;"><button type="button" class="b-select innerLinkPopup" title="새창열림">내부링크선택</button></div>
					<div class="col-md-9">
						<input type="text" name="menuLink" value="" class="w100p" readonly="readonly" title="메뉴 링크(0) 입력하여 주세요." />
						<p class="help">외부 링크의 경우 반드시 http://를 입력하셔야 합니다.</p>
					</div>
					</div>
				</td>
				<td>
					<span class="btn-group">
						<button type="button" class="b-default fa-angle-double-up" ><span class="sr-only">메뉴 1 순서 맨위로 이동</span></button>
						<button type="button" class="b-default fa-angle-up" ><span class="sr-only">메뉴 1 순서 한단계 위로 이동</span></button>
						<button type="button" class="b-default fa-angle-down" ><span class="sr-only">메뉴 1 순서 한단계 밑으로 이동</span></button>
						<button type="button" class="b-default fa-angle-double-down" ><span class="sr-only">메뉴 1 순서 맨밑으로 이동</span></button>
					</span>
				</td>
				<td>
					<select name="popupAt" title="새창열림 사용여부(0)를 선택하세요.">
					<option value='N' >새창 미사용</option>
					<option value='Y' >새창 사용</option>
					</select>
				</td>
				<td>
					<select name="useAt" title="메뉴 사용여부(0)를 선택하세요.">
					<option value='Y' >사용</option>
					<option value='N' >미사용</option>
					</select>
				</td>
				<td><button type="button" name="btnRemove" class="b-del btn-s" menuSeCd="${paramVO.menuSeCd}"><span class="sr-only">메뉴(0) </span>삭제</button></td>
			</tr>
	<c:set var="cnt" value="0"/>
	<c:if test="${fn:length(resultList)>0}">
	<c:forEach var="x" begin="0" end="${fn:length(resultList)-1}" step="1">
			<tr>
				<td>
					<input type="hidden" name="mnno" value="${resultList[x].mnno}"/>
					<input type="hidden" name="pMenuNo" value="${resultList[x].menuNo}" size="5"/>
					<input type="text" name="menuNm" value="${resultList[x].menuNm}" class="w100p" title="메뉴명(${x+1})을 입력하세요."/>
				</td>
				<td class="tal targeturlSelection">
 					<label><input type="radio" name="linkSe${x+1}" value="I" ${not empty resultList[x].menuNo ? 'checked="checked"' : ''}> 내부</label>
					<label><input type="radio" name="linkSe${x+1}" value="E" ${empty resultList[x].menuNo ? 'checked="checked"' : ''}> 외부</label>
					<div class="row">
					<div class="col-md-3" style="display:${empty resultList[x].menuNo ? 'none' : ''};"><button type="button" class="b-select innerLinkPopup">내부링크선택</button></div>
					<div class="col-md-9">
						<input type="text" name="menuLink" value="${resultList[x].menuLink}" class="w100p" ${empty resultList[x].menuNo ? '' : 'readonly=true'} title="메뉴 링크(${x+1}) 입력하여 주세요."/>
						<p class="help">외부 링크의 경우 반드시 http://를 입력하셔야 합니다.</p>
					</div>
					</div>
				</td>
				<td>
					<span class="btn-group">
						<button type="button" class="b-default fa-angle-double-up" ></button>
						<button type="button" class="b-default fa-angle-up" ></button>
						<button type="button" class="b-default fa-angle-down" ></button>
						<button type="button" class="b-default fa-angle-double-down" ></button>
					</span>
				</td>
				<td>
					<select name="popupAt" title="새창열림 사용여부(${x+1})를 선택하세요.">
					<option value='N' ${resultList[x].popupAt ne 'Y' ? 'selected="selected"' : ''}>새창 미사용</option>
					<option value='Y' ${resultList[x].popupAt eq 'Y' ? 'selected="selected"' : ''}>새창 사용</option>
					</select>
				</td>
				<td>
					<select name="useAt" title="메뉴 사용여부(${x+1})를 선택하세요.">
					<option value='Y' ${resultList[x].useAt eq 'Y' ? 'selected="selected"' : ''}>사용</option>
					<option value='N' ${resultList[x].useAt ne 'Y' ? 'selected="selected"' : ''}>미사용</option>
					</select>
				</td>
				<td><button type="button" name="btnRemove" class="b-del btn-s" menuSeCd="${paramVO.menuSeCd}"><span class="sr-only">메뉴(${x+1}) </span>삭제</button></td>
			</tr>
			<c:set var="cnt" value="${cnt+1}"/>
	</c:forEach>
	</c:if>
			<tr style="display:${cnt eq 0 ? '' : 'none'};" id="nodata"><td colspan="6">데이터가 없습니다.</td></tr>
			</tbody>
		</table>
	</div>

</form>



	<!-- <div class="inputDeco"><p>※ 메뉴링크는 http://부터 입력하셔야 합니다.</p></div> -->
	<div class="btnSet">
		<a class="b-reg" href="javascript:checkForm();"><span>저장</span></a>
		<c:if test="${paramVO.viewType ne 'VIEW'}"><a class="b-cancel" href="/bos/siteManage/siteInfo/list.do?${pageQueryString}"><span>취소</span></a></c:if>
	</div>
