<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="topCategories" value="${adminMenuCategoryMap['menu_0']}" />

<script>

function fCheckAll() {
    var checkField = document.menuAuthFrm.checkField;
    if(document.menuAuthFrm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}

function lnbMenu() {
	var depth01Cnt = ${fn:length(topCategories)};
	var _d = document,
	objID = _d.getElementById('lnb_menu'),
	objUl = objID.getElementsByTagName('ul'),
	objUlLength = objUl.length;

	var initialize = function() {
		for(var i=0; i<objUlLength; i++) {
			//objUl[i].style.display = 'none';
		}
	};

	this.specifyOpen = function(idx) {
		for(var i=0; i<depth01Cnt; i++)
		{
			var lnbObj = _d.getElementById('lnb'+i);
			var lnbUlObj = lnbObj.getElementsByTagName('ul');
			if(idx == i)
			{
				lnbObj.style.display = 'block';
				for(var j=0; j<lnbUlObj.length; j++)
				{
					lnbUlObj[j].style.display = 'block';
				}
			}
			else
			{
				lnbObj.style.display = 'none';
				for(var j=0; j<lnbUlObj.length; j++)
				{
					lnbUlObj[j].style.display = 'none';
				}
			}
		}
	};

	initialize();
}

//멀티입력 처리 함수
function fInsertMenuCreat() {
	tree.jstree(true).open_all();

	/* if( $(":input[name='checkField']:checked").length == 0 ){
		alert("적용할 메뉴를 선택하세요.");
		return;
	} */
	//$('input[name=checkedAuthorForInsert]').val($('input[name=authorCode]').val())
	//console.log($(":input[name='checkField']").val())
	$(":input[name='checkField']").each(function(i, item){
		//console.log($(item).val());
		//console.log($(":input[name='checkField']").eq(i).is(":checked"));
		//console.log($(":input[name='oldCheckFieldAt']").eq(i).val());
		if ($(":input[name='oldCheckFieldAt']").eq(i).val()=="N" && $(":input[name='checkField']").eq(i).is(":checked")==true){ // 신규 권한 추가
			//console.log($(":input[name='checkField']").eq(i).val() + "|" + "I");
			$("#menuAuthIDs").val($("#menuAuthIDs").val() + ($("#menuAuthIDs").val().length>0 ? ',' : '') + $(":input[name='checkField']").eq(i).val() + "|" + "I");
		} else if($(":input[name='oldCheckFieldAt']").eq(i).val()=="Y" && $(":input[name='checkField']").eq(i).is(":checked")==false){ // 권한 삭제
			//console.log($(":input[name='checkField']").eq(i).val() + "|" + "D");
			$("#menuAuthIDs").val($("#menuAuthIDs").val() + ($("#menuAuthIDs").val().length>0 ? ',' : '') + $(":input[name='checkField']").eq(i).val() + "|" + "D");
		}
	});

	$("#menuAuthFrm").attr("action", '/bos/auth/auth/insertMenuAuth.do');
	$("#menuAuthFrm").submit();
}

/* $(function(){
	$(".jstree-leaf").on("click",function(){
		alert("ss");
	})
}); */
</script>

<form name="menuAuthFrm" id="menuAuthFrm" action="#" method="post">
	<input type="hidden" name="menuNo" value="${param.menuNo}"/>
	<input type="hidden" name="csrfToken" value="${csrfToken}"/>
	<div class="view">
			 <dl>
		        <dt scope="row">권한코드</dt>
		        <dd>${resultVO.authorCd}<input name="authorCd" id="authorCd" type="hidden" size="30" value="${resultVO.authorCd}" /></dd>
		        <dt scope="row">권한명</dt>
		        <dd>${resultVO.authorNm}</dd>
		      </dl>
	</div>

	<div class="btnSet">
		<a class="b-reg" href="javascript:fInsertMenuCreat()"><span>권한적용</span></a>
		<a class="b-list" href="/bos/auth/auth/list.do?${pageQueryString }"><span>목록</span></a>
	</div>

	<div class="box">
		<!-- <label><input type='checkbox' name='checkAll' class='check2' onclick='javascript:fCheckAll();' />메뉴목록</label> -->
		<!-- <br/> -->
		<button type="button" class="b- tree-open"><i class="fa fa-folder-open"></i> 모두 열기</button>
		<button type="button" class="b- tree-close"><i class="fa fa-folder"></i> 모두 닫기</button>

		<div id="authomenu">
			<ul id="lnb_menu1">
			<c:if test="${fn:length(topCategories)>0}">
			<c:forEach var="x" begin="0" end="${fn:length(topCategories)-1}">
				<li data-jstree='{"opened":true}'>
					<!-- <a href="#" onclick="objLNB.specifyOpen(${x}); return false;" onkeypress="this.onclick();">${topCategories[x].menuNm}(${topCategories[x].menuNo})</a> -->
					<label>
					<c:if test="${topCategories[x].leafNodeAt eq 'Y'}">
						<input type="text" name="oldCheckFieldAt" size="1" value="${topCategories[x].chkYeoBu>0 ? 'Y' : 'N'}"/>
						<input type='checkbox' name='checkField' class='check2' value="0_${topCategories[x].menuNo}" <c:if test="${topCategories[x].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${topCategories[x].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
					</c:if>
					<!-- <img alt="" src="/static/bos/img/menu_folderclose.gif" /> -->
					${topCategories[x].menuNm}(${topCategories[x].menuNo})
					</label>
					<ul id="lnb${x}">
						<c:set var="d01MenuKey" value="menu_${topCategories[x].menuNo}" />
						<c:set var="d01Categories" value="${adminMenuCategoryMap[d01MenuKey]}" />
						<c:if test="${fn:length(d01Categories)>0}">
				 		<c:forEach var="y" begin="0" end="${fn:length(d01Categories)-1}">
						<li>
							<label>
							<c:if test="${d01Categories[y].leafNodeAt eq 'Y'}">
								<input type="text" name="oldCheckFieldAt" size="1" value="${d01Categories[y].chkYeoBu>0 ? 'Y' : 'N'}"/>
								<input type='checkbox' name='checkField' class='check2' value="0_${topCategories[x].menuNo}_${d01Categories[y].menuNo}" <c:if test="${d01Categories[y].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d01Categories[y].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
							</c:if>
						 	<!-- <img alt="" src="/static/bos/img/menu_folderopen.gif" /> -->
					 		${d01Categories[y].menuNm}(${d01Categories[y].menuNo})
							</label>
							<ul>
							<c:set var="menuKey" value="menu_${d01Categories[y].menuNo}" />
							<c:set var="d02Categories" value="${adminMenuCategoryMap[menuKey]}" />
							<c:if test="${fn:length(d02Categories)>0}">
				 			<c:forEach var="z" begin="0" end="${fn:length(d02Categories)-1}">
							<li>
								<label>
								<c:if test="${d02Categories[z].leafNodeAt eq 'Y'}">
									<input type="text" name="oldCheckFieldAt" size="1" value="${d02Categories[z].chkYeoBu>0 ? 'Y' : 'N'}"/>
									<input type='checkbox' name='checkField' class='check2' value="0_${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}" <c:if test="${d02Categories[z].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d02Categories[z].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
								</c:if>
							 	<!-- <img alt="" src="/static/bos/img/menu_folderclose.gif" /> -->
						 		${d02Categories[z].menuNm}(${d02Categories[z].menuNo})
								</label>
								<ul>
								<c:set var="d02MenuKey" value="menu_${d02Categories[z].menuNo}" />
								<c:set var="d03Categories" value="${adminMenuCategoryMap[d02MenuKey]}" />
								<c:if test="${fn:length(d03Categories)>0}">
								 	<c:forEach var="k" begin="0" end="${fn:length(d03Categories)-1}">
									<li>
										<label>
											<c:if test="${d03Categories[k].leafNodeAt eq 'Y'}">
												<input type="text" name="oldCheckFieldAt" size="1" value="${d03Categories[k].chkYeoBu>0 ? 'Y' : 'N'}"/>
												<input type='checkbox' name='checkField' class='check2' value="0_${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}_${d03Categories[k].menuNo}" <c:if test="${d03Categories[k].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d03Categories[k].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
											</c:if>
										 	<!-- <img alt="" src="/static/bos/img/menu_page.gif" /> -->
									 		${d03Categories[k].menuNm}(${d03Categories[k].menuNo})
										</label>
										<ul>
										<c:set var="d03MenuKey" value="menu_${d03Categories[k].menuNo}" />
										<c:set var="d04Categories" value="${adminMenuCategoryMap[d03MenuKey]}" />
										<c:if test="${fn:length(d04Categories)>0}">
										 	<c:forEach var="l" begin="0" end="${fn:length(d04Categories)-1}">
												<li>
												<label>
													<c:if test="${d04Categories[l].leafNodeAt eq 'Y'}">
														<input type="text" name="oldCheckFieldAt" size="1" value="${d04Categories[l].chkYeoBu>0 ? 'Y' : 'N'}"/>
														<input type='checkbox' name='checkField' class='check2' value="0_${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}_${d03Categories[k].menuNo}_${d04Categories[l].menuNo}" <c:if test="${d04Categories[l].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d04Categories[l].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
													</c:if>
												 	<!-- <img alt="" src="/static/bos/img/menu_page.gif" /> -->
											 		${d04Categories[l].menuNm}(${d04Categories[l].menuNo})
												</label>
												<ul>
												<c:set var="d04MenuKey" value="menu_${d04Categories[l].menuNo}" />
												<c:set var="d05Categories" value="${adminMenuCategoryMap[d04MenuKey]}" />
												<c:if test="${fn:length(d05Categories)>0}">
												 	<c:forEach var="m" begin="0" end="${fn:length(d05Categories)-1}">
														<li>
														<label>
															<c:if test="${d05Categories[m].leafNodeAt eq 'Y'}">
																<input type="text" name="oldCheckFieldAt" size="1" value="${d05Categories[m].chkYeoBu>0 ? 'Y' : 'N'}"/>
																<input type='checkbox' name='checkField' class='check2' value="0_${topCategories[x].menuNo}_${d01Categories[y].menuNo}_${d02Categories[z].menuNo}_${d03Categories[k].menuNo}_${d04Categories[l].menuNo}_${d05Categories[m].menuNo}" <c:if test="${d05Categories[m].chkYeoBu > 0}">checked="checked"</c:if> <c:if test="${d05Categories[m].roleAdminChkYeoBu > 0 and resultVO.authorCode ne 'ROLE_ADMIN'}">disabled="disabled"</c:if> />
															</c:if>
														 	<!-- <img alt="" src="/static/bos/img/menu_page.gif" /> -->
													 		${d05Categories[m].menuNm}(${d05Categories[m].menuNo})
														</label>
														</li>
													</c:forEach>
												</c:if>
												</ul>
											</li>
											</c:forEach>
										</c:if>
										</ul>
									</li>
									</c:forEach>
								</c:if>
								</ul>
							</li>
							</c:forEach>
						</c:if>
						</ul>
					</li>
				</c:forEach>
				</c:if>
				</ul>
			</li>
			</c:forEach>
			</c:if>
			</ul>
		</div>
	<input type="hidden" name="menuAuthIDs" id="menuAuthIDs" value=""/>
	</div>
</form>

<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />
<script src="/static/jslibrary/jstree/jstree.min.js"></script>
<script>
// var objLNB = new lnbMenu();
$('#lnb_menu ul').each(function(index, el) {
	if (!$(this).find('li').length) {
		$(this).remove();
	}
});
$('#authomenu input:checked').each(function(index, el) {
	$(this).parent().parent().attr('data-jstree', '{"selected":true}');
});

	var tree = $("#authomenu");
	function child(data){
		// console.log('data:',data,'data.length:',data.length,'item:',$('#'+data[i]))
		for (var i = 0; i < data.length; i++) {
			if ($('#'+data[i]).has('ul').length ==0) {
				//console.log(data[i],$('#'+data[i]))
				if ($('#'+data[i]).attr('aria-selected')=='true') {
					$('#'+data[i]).find(':checkbox').prop('checked',true)
				}else{
					$('#'+data[i]).find(':checkbox').prop('checked',false)
				}
			}
		}
	}
	tree
		.on('init.jstree', function(event) {
			// 초기세팅
		})
		.on('ready.jstree', function(event) {
			$('li[aria-selected="true"]').each(function(index, el) {
				$(this).find(':checkbox').prop('checked',true)
			});
		})
		.on('open_node.jstree', function(event,data) {
			child(data.node.children)
		})
		.on('deselect_node.jstree', function(event,data) {
			//체크가 풀릴때 실행
			if (data.node.state.selected){
				tree.find('#'+data.node.id).find(':checkbox').prop('checked',true)
			}else{
				tree.find('#'+data.node.id).find(':checkbox').prop('checked',false)
			}
		})
		.on("select_node.jstree",function (e,data) {
			//체크할때
			if (data.node.state.selected){
				tree.find('#'+data.node.id).find(':checkbox').prop('checked',true)
			}else{
				tree.find('#'+data.node.id).find(':checkbox').prop('checked',false)
			}
		})
		.jstree({
		"checkbox" : {
				"keep_selected_style" : false
			},
		"plugins" : [ "checkbox" ],
		"core": {
		    "themes": {
		        // "icons": false
		        'stripes' : true
		    }
		}
	});
	$('.tree-open').on('click',function(event) {
		tree.jstree(true).open_all();
	});
	$('.tree-close').on('click',function(event) {
		tree.jstree(true).close_all();
	});
</script>
