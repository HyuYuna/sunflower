<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />
<style>
/* custom 추가 */
#cdTree .jstree-delete { text-decoration:line-through; color:red; }
</style>
<script src="/static/jslibrary/jstree/jstree.min.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>
<script>

var vCodegCode = "${paramVO.codegCode}";

function fnGetCdDetail(id) {
	
	
	if (id != 0) {
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codegCode="+ vCodegCode + "&codeCode="+id, dataType : "json", async: false }).done(function (resdata) {
			for (key in resdata) {
				if (key != "codeUseYn") $('#'+key).val(resdata[key]);
			}
			$("#dpTd").text(resdata.dp);
			$("#codeForm").find('input:radio[name=codeUseYn]').filter(':input[value='+resdata.codeUseYn+']').prop("checked", true);
		});
		$("#updtView").show();
		$("#updtBtnView").show();
		$("#registView").hide();
		$("#registBtnView").hide();
		$("#rootView").hide();
		$(".uptViewCls").show();

	}
	else {
		//최상위 root 선택
		$("#updtView").hide();
		$("#updtBtnView").show();
		$("#registView").hide();
		$("#registBtnView").hide();
		$("#rootView").show();
		$(".uptViewCls").hide();


		$('#codeCode').val('');
		initlMenuList($("#codeForm"));
		$("#codeForm").find('input:radio[name=codeUseYn]:input[value=Y]').prop("checked", true);
	}

	$("#downCdRegistBtn").attr("data-value",id);

}

function fnResetAnchor() {
	$(".jstree-anchor").each(function(n) {
		var node = $("#cdTree").jstree(true).get_node($(this));
		if (typeof node.data != "undefined" && node.data!=null && node.data.codeUseYn != "undefined" && node.data.codeUseYn == "N") {
			$(this).addClass("jstree-delete");
		}
	})
}


//초기화 함수
function initlMenuList($frm) {
	$('#cdOrdr').val('');
	$('#codeName').val('');

	$('input:radio[name=codeUseYn]:input[value=N]').attr("checked", true);
}

$(function () {
	var chknodeSelect
	var g_cd = "${paramVO.codeCode}";

	$('#cdTree')
	.jstree({
		'core' : {
			'data' : function (node, cb) {
				var t_url = node.id != "#" ? "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codegCode=${paramVO.codegCode}" : "/bos/cmmnCd/cmmnCdCtgry/listJson.json?codegCode=${paramVO.codegCode}";
	            $.ajax({ url :t_url, dataType : "json" }).done(function (data) {

	            	var rootList = [];
	            	var jsonList = [];
	            	var root = {'id' : '0', 'text' : "${cdCtgryVO.codegName}(Root)",'icon' : "jstree-folder",'children':true, 'data' : [{'codeUseYn' : "Y"}], 'state' : { 'opened' : true, 'selected' : true }};
	            	$.each(data,function(key, value) {
	            		var children = true;
	            		if (value.icon == "jstree-file")  children = false;
	            		var item = {'id' : value.codeCode, 'text' : value.codeName + "( "+value.codeCode+" )", 'children':children, 'icon' :value.icon};
	            		var addData = value;
	            		item.data = addData;
	            		jsonList.push(item);
	            	});
	            	root.children = jsonList;
	            	rootList.push(root);
	            	if (node.id == "#") cb(rootList);
	            	else cb(jsonList);
	            });
	        },
			'check_callback' : function(o, n, p, i, m) {
				/*
				if(m && m.dnd && m.pos !== 'i') { return false; }
				if(o === "move_node" || o === "copy_node") {
					if(this.get_node(n).parent === this.get_node(p).id) { return false; }
				}
				*/
				return true;
			},
			'themes' : {
				'responsive' : false,
				'variant' : 'small',
				'stripes' : true
			}
		},
		'sort' : function(a, b) {
			return this.get_type(a) === this.get_type(b) ? (this.get_text(a) > this.get_text(b) ? 1 : -1) : (this.get_type(a) >= this.get_type(b) ? 1 : -1);
		},

		'types' : {
			'default' : { 'icon' : 'folder' },
			'file' : { 'valid_children' : [], 'icon' : 'file' }
		},
		'unique' : {
			'duplicate' : function (name, counter) {
				return name + ' ' + counter;
			}
		},
		'plugins' : ['state','dnd','types','unique','contextmenu']
		,"contextmenu" : {
			"items" : {
				/*
				"create" : {
					"separator_before" : false, //api 참고
					"separator_after" : true, //api 참고
					"label" : "하위신규부서 추가", //node에서 마우스 오른쪽 클릭 시 text
					"action" : function (data) {
						var inst = $.jstree.reference(data.reference),
							obj = inst.get_node(data.reference);
							inst.create_node(obj, { type : "file" }, "last", function (new_node) {
								setTimeout(function () { inst.edit(new_node); },0);
								chknodeSelect = new_node
							});
					}
				},
				*/
				/*
				"rename" : {
					"separator_before" : false,
					"separator_after" : true,
					"label" : "코드명 변경",
					"action" : function (data) {
						var inst = $.jstree.reference(data.reference),
						obj = inst.get_node(data.reference);
						inst.edit(obj);
					}
				},
				*/
				"remove" : {
					"separator_before" : false,
					"separator_after" : true,
					"label" : "코드 삭제",
					"action" : function (data) {
						var inst = $.jstree.reference(data.reference),
						obj = inst.get_node(data.reference);
						if(inst.is_selected(obj)) {
							inst.delete_node(inst.get_selected());
						}
						else {
							inst.delete_node(obj);
						}
					}
				},
				"ccp" : null
			}
		}
	})

	.on('loaded.jstree', function(e, data) {
		fnResetAnchor();
	})
	.on('select_node.jstree', function (e, data) {
		var node = data.node;
		//if (node.id == "0") return;
		//if (typeof node.id != "undefined") return;
		fnGetCdDetail(node.id);
	})
	/*
	.on("click", ".jstree-anchor", function(e) {
	   var node = $("#cdTree").jstree(true).get_node($(this));
	   if (node.id == "0") return;
	   var goUrl = "/bos/cmmnCd/cmmnCdCtgry/listPopup.do?viewType=BODY&codegCode=" + node.data.codegCode + "&cd=" + node.id;
	   window.location.href = goUrl;
	})
	*/
	.on('delete_node.jstree', function (e, data) {
		if (data.node.id == "0") {
			alert("최상위 코드는 삭제할 수 없습니다.");
			data.instance.refresh();
			return;
		}

		if (!confirm("코드를 삭제 하시겠습니까? (삭제하시면 복구가 불가능합니다.)")) {
			data.instance.refresh();
		}
		else {
			var codeCode = data.node.id;
			$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/deleteCdDetail.json", data : { 'codegCode' : vCodegCode, 'codeCode' : codeCode }, dataType : "json", async: false }).done(function (resdata) {
				//var node = $("#cdTree").jstree(true).get_node(menuNo);
				fnGetCdDetail(data.node.parent);
				data.instance.refresh();
				//alert(resdata.msg);
			});
		}
	})
	/*
	.on('create_node.jstree', function (e, data) {
		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/insert.json", data : {'cdId' : vCdId, 'cdNm' : escape(encodeURIComponent("신규메뉴")), 'upperMenuNo' : data.node.parent, 'useAt' : "N", 'popupAt' : "N" }, dataType : "json", async: false }).done(function (resdata) {
			data.instance.set_id(data.node, resdata.cMenuNo);
			data.instance.refresh();
		});
	})
	*/
	/*
	.on('rename_node.jstree', function (e, data) {
		var useAtVal = $("#codeForm").find('input:radio[name=useAt]:checked').val();

		$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/updateCdNm.json", data : { 'cdId' : vCdId, 'cd' : data.node.id, 'cdNm' : escape(encodeURIComponent(data.node.text)), 'upperCd' : data.node.parent, 'useAt' : useAtVal }, dataType : "json", async: false }).done(function (resdata) {
			data.instance.set_id(data.node, resdata.cMenuNo);
			$('#cdTree').jstree(true).get_node(resdata.cd).data = {'useAt' : resdata.useAt}
			fnGetCdDetail(resdata.cd);
			fnResetAnchor();
		});
	})
	*/
	.on('move_node.jstree', function (e, data) {
		if (!confirm((data.node.parents.length-1) + "depth "+  "["+data.node.data.cdNm +"] 코드를 이동하시겠습니까?")) {
			data.instance.refresh();
			return false;
		}

		var codeCode = data.node.id;
		if (codeCode == "" || codeCode == null) {
			return false;
		}

		var instance = $.jstree.reference('#cdTree'), selected = data.node.id, position = $('#'+selected).index();
		var cdData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			cdData.push(val);
		});

	    //alert("moving node id " + data.node.id);
	    //alert("moving old_parent " + data.old_parent);
	    //alert("new parent id " + data.parent);

		cdData = cdData.join(",");
		

		
		if (data.old_parent != data.parent) { //부모키가 틀릴경우
			$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/updateUpperCd.json", data : { 'codegCode' : vCodegCode, 'codeCode' : data.node.id}, dataType : "json", async: false }).done(function (resdata) {
				fnGetCdDetail(data.node.id);
				data.instance.refresh(function() {
					fnResetAnchor();
				});

			});
		}
		else { // 부모 키가 같은 경우
			$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/updateMoveCd.json", data : { 'codegCode' : vCodegCode, 'codeCode' : data.node.id, 'cdData' : cdData }, dataType : "json", async: false }).done(function (resdata) {

				fnGetCdDetail(data.node.id);
				data.instance.refresh();
				fnResetAnchor();
			});
		}


	})
	.on('refresh.jstree', function(event,d) {
		if (chknodeSelect!=undefined) {
			$('#cdTree').jstree(true).open_node(chknodeSelect.parent,function(){
				$('#'+chknodeSelect.id+'_anchor').trigger('click')
			})
		}
	})
	.on('ready.jstree', function(event) {
		/* Act on the event */
		// console.log('ready',chknodeSelect)
	})
	.on('open_node.jstree', function (e, data) {
		fnResetAnchor();
    })
    .on('changed.jstree', function (e, data) {
    	if (typeof data.node != "undefined") fnResetAnchor();
    	//$('#cdTree').jstree(true).get_node(data.id).data = {'useAt' : data.useAt}
    });

	$(".treeopen").on('click',function() {
		$("#cdTree").jstree('open_all');
	});
	$(".treeclose").on('click',function() {
		$("#cdTree").jstree('close_all');
	});

});


function updateMoveCd(gubun) {
	var codeCode = $('#codeCode').val();
	if (codeCode == "" || codeCode == null) {
		alert('코드를 선택해주세요.');
		return;
	}

	var instance = $.jstree.reference('#cdTree'), selected = instance.get_selected(), position = $('#'+selected).index();
	var flag = "";
	var chgCd = "";

	if (gubun == "U") {
		flag = instance.get_prev_dom(selected, true);
		var cdData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {

			if (flag != false && flag.context.id == val) {
				cdData.push(codeCode);
			}
			if (codeCode != val) {
				cdData.push(val);
			}
		});
	}
	else if (gubun == "D") {
		flag = instance.get_next_dom(selected, true);
		var cdData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (codeCode != val) {
				cdData.push(val);
				//alert(val);
			}
			if (flag != false && flag.context.id == val) {
				cdData.push(cd);
			}
		});
	}
	else {
		var cdData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (codeCode != val) 	cdData.push(val);
		});
		if (gubun == "T") cdData.splice(0, 0, codeCode);
		else if (gubun == "B") cdData.push(codeCode);

	}
	$("#cdData").val(cdData.join(","));

	if (flag) chgCd = flag.context.id;


	$.ajax({ url : "/bos/cmmnCd/cmmnCdCtgry/updateMoveCd.json", data : { 'codegCode' : vCodegCode ,  'codeCode' : codeCode, 'cdOrdr' : $("#cdOrdr").val(), 'cdData' : $("#cdData").val(), 'chgCd' : chgCd, 'gubun' : gubun }, dataType : "json", async: false }).done(function (resdata) {
		//fnGetCdDetail(node.parent);
		$('#cdTree').jstree(true).refresh();
	});

}


document.title = "${cdCtgryVO.codegName}(${cdCtgryVO.codegCode}) 공통상세코드 관리";
</script>

<h1>공통상세코드 관리</h1>
<div class="row">
	<div class="col-lg-6">
		<h2>코드목록</h2>
		<div class="treectrl">
			<div class="btn-group f">
				<button type="button" class="b-default btn-sm treeopen">모두열기</button>
				<button type="button" class="b-default btn-sm treeclose">모두닫기</button>
			</div>
			<div class="btn-group">
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveCd('T');"><i class="fa fa-angle-double-up"></i><span class="sr-only">처음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveCd('U');"><i class="fa fa-angle-up"></i><span class="sr-only">이전 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveCd('D');"><i class="fa fa-angle-down"></i><span class="sr-only">다음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveCd('B');"><i class="fa fa-angle-double-down"></i><span class="sr-only">마지막 순서로변경</span></button>
			</div>
		</div>
		<div class="beforeDiv">
			<div id="cdTree">
			</div>

		</div>
	</div>
	<div class="col-lg-6">
		<h2 id="inputTitle">코드상세정보</h2>
		<input id="codegCodeTop" name="codegCode" type="hidden" value="${param.codegCode}" />
		<div class="bdView" id="rootView" style="display:none;"><p class="tac pt10">Root가 선택되었습니다.</p></div>
		<div class="bdView afterDiv" id="updtView">
			<form  id="codeForm" name="codeForm" action="/bos/cmmnCd/cmmnCdCtgry/updateCdDetail.do" method="post">
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
			<input name="viewType" type="hidden" value="BODY" />
			<input type="hidden" name="cdOrdr" id="cdOrdr" />
			<input type="hidden" name="cdData" id="cdData" />
			<%-- <input type="hidden" name="dp" id="dp" value="${result.dp}" title="Depth level"> --%>
			<%-- <input type="hidden" name="codeSort" value="${result.codeSort }" title="정렬순서"/> --%>
			<table>
				<caption>게시판 쓰기</caption>
				<colgroup>
					<col width="30%"/>
					<col width="70%"/>
				</colgroup>
				<tbody>
			 	<tr>
			    	<th scope="row" style="width:22%"><span class="req"><span>필수입력</span></span>상위코드</th>
				    <td>
				    	<input name="codegCode" id="codegCode" type="text" size="15" value="${not empty result.codegCode  ? result.codegCode : '0' }"  maxlength="15" readonly="readonly" title="상위코드" />
				    </td>
			  	</tr>
			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>코드</th>
				    <td nowrap>
				      <input name="codeCode" id="codeCode" type="text" size="15" value="${not empty result.codeCode ? result.codeCode  :  '0' }"  maxlength="15" <c:if test="${not empty result or empty param.codeCode}">readonly="readonly"</c:if> title="코드">
				    </td>
			  	</tr> 
			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>코드순서</th>
				    <td nowrap>
				    	
				      <input name="codeSort" id="codeSort" type="text" size="30" value="${result.codeSort}"  maxlength="30" itle="코드값">
				    </td>
			  	</tr>
			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>코드값</th>
				    <td nowrap>
				    	
				      <input name="codeName" id="codeName" type="text" size="30" value="<util:out escapeXml='false'>${result.codeName}</util:out>"  maxlength="30" itle="코드명">
				    </td>
			  	</tr>
				
			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>사용여부</th>
				    <td>
				      <label><input name="codeUseYn" id="codeUseYn" type="radio" value="Y" <c:if test="${result.codeUseYn eq 'Y' }">checked="checked"</c:if> /> 사용 </label>
				      <label><input name="codeUseYn" type="radio" value="N" <c:if test="${result.codeUseYn eq 'N' }">checked="checked"</c:if> />미사용</label>
				    </td>
			  	</tr>

			</table>
			</form>
		</div>

		<div class="bdView" id="registView" style="display:none">
			<form  id="codeRegForm" name="codeRegForm" action="/bos/cmmnCd/cmmnCdCtgry/insertCdDetail.do" method="post">
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
			<%-- <input name="codegCode" type="hidden" value="${param.codegCode}" /> --%>
			<input name="viewType" type="hidden" value="BODY" />
			<table>
				<caption>게시판 쓰기</caption>
				<colgroup>
					<col width="30%"/>
					<col width="70%"/>
				</colgroup>
				<tbody>
			  	<tr>
			    	<th scope="row"><span class="req"><span>필수입력</span></span>상위코드</th>
					<td>
					<input name="codegCode" type="text" size="15" value="${not empty result.codegCode  ? result.codegCode : '0' }"  maxlength="15" readonly="readonly" title="상위코드">
					</td>
			  	</tr>
			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>코드</th>
				    <td nowrap>
				      <input name="codeCode" type="text" size="15" value=""  maxlength="15" title="코드" />
				    </td>
			  	</tr>
			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>코드명</th>
				    <td nowrap>
				      <input name="codeName" type="text" size="30" value=""  maxlength="30" title="코드명" />
				    </td>
			  	</tr>
				<!--
			  	<tr>
				    <th scope="row">코드명(영문)</th>
				    <td nowrap>
				      <input name="cdEngNm" type="text" size="30" value=""  maxlength="30" />
				    </td>
			  	</tr>
				 -->
			  	<!-- <tr>
				    <th scope="row">Depth</th>
				    <td nowrap>
				      <input type="text" name="dp" value="" readonly="readonly" title="Depth" />
				    </td>
			  	</tr> -->

			  	<!-- <tr>
				    <th scope="row">코드설명</th>
				    <td nowrap>
				      <textarea name="cdDc" cols="25" rows="4" title="코드설명"></textarea>
				    </td>
			  	</tr> -->
			  	<!--
			  	<tr>
				    <th scope="row">코드설명(영문)</th>
				    <td nowrap>
				      <textarea name="cdEngDc" cols="25" rows="4"></textarea>
				    </td>
			  	</tr>
				-->
			  	<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>정렬순서</th>
					<td>
				      <input type="text" name="codeSort" size="15" maxlength="15" value="" title="정렬순서" />
					</td>
			 	</tr>
				
				<!--
				<tr>
					<th scope="row">옵션1</th>
					<td>
				      <input type="text" name="optn1" size="15" maxlength="15" value="" />
					</td>
			 	</tr>
				<tr>
					<th scope="row">옵션2</th>
					<td>
				      <input type="text" name="optn2" size="15" maxlength="15" value="" />
					</td>
			 	</tr>
				<tr>
					<th scope="row">옵션3</th>
					<td>
				      <input type="text" name="optn3" size="15" maxlength="15" value="" />
					</td>
			 	</tr>
				<tr>
					<th scope="row">옵션4</th>
					<td>
				      <input type="text" name="optn4" size="15" maxlength="15" value="" />
					</td>
			 	</tr>
				<tr>
					<th scope="row">옵션5</th>
					<td>
				      <input type="text" name="optn5" size="15" maxlength="15" value="" />
					</td>
			 	</tr>
			  	-->

			  	<tr>
				    <th scope="row"><span class="req"><span>필수입력</span></span>사용여부</th>
				    <td>
				    	<label><input name="codeUseYn" type="radio" value="Y" checked="checked" /> 사용 </label>
				    	<label><input name="codeUseYn" type="radio" value="N" />미사용 </label>
				    </td>
			  	</tr>

			</table>
			</form>
		</div>
	</div>
</div>

<div class="btnSet clear" id="updtBtnView">
	<!-- <a href="javascript:void(0);" class="b-add" id="topCdRegistBtn">최상위(1depth)코드등록</a> -->
	<a href="javascript:void(0);" class="b-add" id="downCdRegistBtn" data-value="${empty param.codegCode ? '0' : param.codegCode }">하위코드등록</a>


	<a href="javascript:void(0);" class="b-edit uptViewCls" id="updtBtn">수정</a>
	<a href="javascript:void(0);" class="b-del uptViewCls" id="deleteBtn">삭제</a>
	<!--
	<span class="button"><a href="" onclick="fnCodeDeleteProc('${result.code }');return false;">삭제</a></span>
	 -->
</div>

<div class="btnSet clear" id="registBtnView" style="display:none;">
	<a class="b-save" href="javascript:void(0);" id="saveBtn">저장</a>
	<a class="b-back" href="javascript:void(0);" id="backBtn">뒤로 돌아가기</a>
</div>

<script>
	$("#topCdRegistBtn").on('click',function() {
		var $frm = $("#codeForm");
		var $regFrm = $("#codeRegForm");
		var codegCode = $regFrm.find("input[name=codegCode]").val();

		var url ="/bos/cmmnCd/cmmnCdCtgry/getSortOrdr.json";
		var params = {
			codegCode : $regFrm.find("input[name=codegCode]").val(),
			codeCode : $regFrm.find("input[name=upperCd]").val()
		};
		$.post(url,params,function(data) {
			if (data.resultCode == "success") {
				$regFrm.find("input[name=codeSort]").val(data.maxSortOrdr);
			}
		},"json");

		$regFrm.find("input[name=codegCode]").val(codegCode);
		/* $regFrm.find("input[name=dp]").val(1); */

		var defaultVw = document.getElementById("defaultVw");
		var regVw = document.getElementById("regVw");
		var defaultBtn = document.getElementById("defaultBtn");
		var regBtn = document.getElementById("regBtn");

		$("#updtView").hide();
		$("#registView").show();
		$("#updtBtnView").hide();
		$("#registBtnView").show();
		$("#rootView").hide();

		$("#inputTitle").text("최상위코드등록폼");
		return false;
	});

	$("#downCdRegistBtn").on('click',function() {
		var cdVal = $(this).attr("data-value");
		/* if (cdVal == "0") { */
			
			/* 
			alert("해당 코드를 선택해 주세요.");
			return false;
			*/
		/* }  */
		var $frm = $("#codeForm");
		var $regFrm = $("#codeRegForm");
		var codegCode = $frm.find("input[name=codegCode]").val();
		
		if(codegCode == "" || codegCode == null || codegCode == '0'){
			codegCode = $("#codegCodeTop").val();
			//$regFrm.find("input[name=codegCode]").val(codegCode);
		}
		
		console.log(codegCode);
		console.log(cdVal);
		
		
		$regFrm.find("input[name=codegCode]").val(codegCode);
		
		//console.log($("#codeRegForm input[name=codegCode]").val());
		/* var dp = Number($frm.find("input[name=dp]").val()) + 1; */
		/* $regFrm.find("input[name=dp]").val(dp); */


		var defaultVw = document.getElementById("defaultVw");
		var regVw = document.getElementById("regVw");
		var defaultBtn = document.getElementById("defaultBtn");
		var regBtn = document.getElementById("regBtn");

		$("#updtView").hide();
		$("#registView").show();
		$("#updtBtnView").hide();
		$("#registBtnView").show();
		$("#rootView").hide();

		$("#inputTitle").text("하위코드등록폼-("+ codegCode +")");
		return false;
	});

	$("#backBtn").on('click',function() {
		$("#updtView").show();
		$("#registView").hide();
		$("#updtBtnView").show();-
		$("#registBtnView").hide();

		if ($("#downCdRegistBtn").attr("data-value") == "0") {
			$("#rootView").show();
			$("#updtView").hide();
		}

		var $frm = $("#codeForm");
		var codegCode = $frm.find("input[name=codegCode]").val();
		$("#inputTitle").text("코드상세정보");


		return false;
	});

	$("#saveBtn").on('click',function() {
		var $regFrm = $("#codeRegForm");


		if ($regFrm.find("input[name=codegCode]").val() == "") {
			alert("상위코드를 입력해주세요.");
			$regFrm.find("input[name=codegCode]").focus();
			return false;
		}
		else if ($regFrm.find("input[name=codeCode]").val() == "") {
			alert("코드를 입력해주세요.");
			$regFrm.find("input[name=codeCode]").focus();
			return false;
		}
		else if ($regFrm.find("input[name=codeName]").val() == "") {
			alert("코드명을 입력해주세요.");
			$regFrm.find("input[name=codeName]").focus();
			return false;
		}


		if (!confirm("코드를 등록 하시겠습니까?")) return false;

		//$regFrm.attr("action","/bos/cmmnCd/cmmnCdDetail/insert.do");
		//$regFrm.submit();
		$.post("/bos/cmmnCd/cmmnCdCtgry/insertCdDetail.json",$regFrm.serialize(),function(data) {
			if (data.resultCode == "success") {
				alert(data.msg);
				document.location.reload();
			}
			else if (data.resultCode == "error") {
				alert(data.msg);
			}
		},"json");

		return false;
	});


	$("#updtBtn").on('click',function() {
		var $frm = $("#codeForm");

		if ($frm.find("input[name=codegCode]").val() == "") {
			alert("상위코드를 입력해주세요.");
			$frm.find("input[name=codegCode]").focus();
			return false;
		}
		
		else if ($frm.find("input[name=codeCode]").val() == "") {
			alert("코드를 입력해주세요.");
			$frm.find("input[name=codeCode]").focus();
			return false;
		}
		else if ($frm.find("input[name=codeName]").val() == "") {
			alert("코드명을 입력해주세요.");
			$frm.find("input[name=codeName]").focus();
			return false;
		}


		if (!confirm("코드를 수정 하시겠습니까?")) return false;

		$frm.attr("action","/bos/cmmnCd/cmmnCdCtgry/updateCdDetail.do");
		$frm.submit();
		return false;
	});

	$("#deleteBtn").on('click',function() {
		var $frm = $("#codeForm");
		if (!confirm("코드를 삭제 하시겠습니까? (삭제하시면 복구가 불가능합니다.)")) return false;
		$frm.attr("action","/bos/cmmnCd/cmmnCdCtgry/deleteCdDetail.do");
		$frm.submit();
	});

</script>
