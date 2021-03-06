<%@ page contentType="text/html; charset=utf-8" errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />

<style>
/* custom 추가 */
#tree .jstree-delete { text-decoration:line-through; color:red; }
</style>
<script src="/static/jslibrary/jstree/jstree.min.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>
<script src="/static/jslibrary/jquery.multi-select.js"></script>


<script>
function pasteHTML(sHTML) {
	//var sHTML = "<span style='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.<\/span>";
	oEditors.getById["hpcmCn"].exec("SET_IR", ['']); //초기화
	oEditors.getById["hpcmCn"].exec("PASTE_HTML", [sHTML]);
}

function fnSiteHpcmDetail(id) {
	if (id > 0) {
		$.ajax({ url : "/bos/siteManage/siteHpcm/listJson.json?cHpcmNo="+id, dataType : "json", async: false }).done(function (resdata) {
			for (key in resdata) {
				$('#'+key).val(resdata[key]);
			}
			$('#pGroupId').val(resdata.groupId);
			$('#pSrvcId').val(resdata.srvcId);
			$('#pSrvcNm').val(resdata.srvcNm);
			$('#pMethodId').val(resdata.methodId);
			$('input:radio[name=useAt]:input[value='+resdata.useAt+']').prop("checked", true);
			pasteHTML(resdata.hpcmCn);
		});
		//메뉴 선택정보 가져오기...
		$.ajax({ url : "/bos/siteManage/siteHpcm/menuListJson.json?cHpcmNo="+id, dataType : "json", async: false }).done(function (resdata) {
			$("#menuNos").html("");
			for (var i=0; i<resdata.menuList.length;i++) {
				//console.log(resdata.menuList[i].menuNo)
				$("#menuNos").append("<option value='"+resdata.menuList[i].menuNo+"'>"+resdata.menuList[i].menuNo+") "+resdata.menuList[i].menuNm+"</option>");
			}
		});

		$(".bdView").show();
		$(".btnSet").show();
		$("#rootDdView").hide();
	}
	else {
		//최상위 root 선택
		$(".bdView").hide();
		$(".btnSet").hide();
		$("#rootDdView").show();

		$('#hpcmNo').val('0');
		$('#hpcmNm').val('');
		$('#upperHpcmNo').val('0');
		$('#hpcmCn').val('');
		oEditors.getById["hpcmCn"].exec("SET_IR", ['']); //초기화
		initlHpcmList();
		$('#subYn').val("N");
		$('input:radio[name=useAt]:input[value=Y]').prop("checked", true);
		$("#menuNos").html("");
	}
}

function fnResetAnchor() {
	$(".jstree-anchor").each(function(n) {
		var node = $("#tree").jstree(true).get_node($(this));
		if (typeof node.data != "undefined" && node.data!=null && node.data.useAt != "undefined" && node.data.useAt == "N") {
			$(this).addClass("jstree-delete");
		}
	})
}

function replaceX(str){
	str = str.replace("&amp;","&").replace(/&/gi,"&amp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/"/gi,"&quot;").replace(/'/gi,"&apos;");
	return str;
}


$(function() {

	$('#tree').jstree({
		'core' : {
			'data' : function (node, cb) {
				var t_url = node.id != "#" ? "/bos/siteManage/siteHpcm/listJson.json?upperHpcmNo="+node.id : "/bos/siteManage/siteHpcm/listJson.json";
				$.ajax({ url: t_url, dataType: "json"}).done(function (data) {
					var rootList = [];
					var jsonList = [];
					var root = {'id' : '0', 'text' : "도움말",'icon' : "jstree-folder",'children':true, 'state' : { 'opened' : true, 'selected' : true },'data' : {'useAt' : "Y"}};
					$.each(data,function(key, value) {
						var children = true;
						if (value.icon == "jstree-file") children = false;

						var item = {'id' : value.hpcmNo, 'text' : replaceX(value.hpcmNm), 'children' : children, 'icon' : value.icon};
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
				if (m && m.dnd && m.pos !== 'i') { return false; }
				if (o === "move_node" || o === "copy_node") {
					if (this.get_node(n).parent === this.get_node(p).id) { return false; }
				}
				*/
				return true;
			},
			'themes' : {
				'responsive' : false,
				'variant' : 'small'
				//,'stripes' : true
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
		/* "cookies" : {
			"save_selected" : false
		}, */
		'plugins' : ['state','dnd','types','unique','contextmenu']
		,"contextmenu" : {
			"items" : {
			"create" : {
				"separator_before" : false, //api 참고
				"separator_after" : true, //api 참고
				"label" : "하위신규도움말 추가", //node에서 마우스 오른쪽 클릭 시 text
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
						obj = inst.get_node(data.reference);
						inst.create_node(obj, { type : "file" }, "last", function (new_node) {
							setTimeout(function () { inst.edit(new_node); },0);
						});
				}
			},
			"rename" : {
				"separator_before" : false,
				"separator_after" : true,
				"label" : "도움말명 변경",
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
					obj = inst.get_node(data.reference);
					inst.edit(obj);
				}
			},
			"remove" : {
				"separator_before" : false,
				"separator_after" : true,
				"label" : "도움말 삭제",
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
		//console.log(data)
		fnResetAnchor();
		$("#tree").jstree('open_all');
	})
	.on('select_node.jstree', function (e, data) {
		var node = data.node;
		//if (node.id == "0") return;
		data.instance.set_id(data.node, node.id);
		fnSiteHpcmDetail(node.id);
	})
	.on('delete_node.jstree', function (e, data) {
		if (data.node.id == "0") {
			alert("최상위 도움말은 삭제할 수 없습니다.");
			data.instance.refresh();
			return;
		}
		if ($('#subYn').val() == "Y") {
			alert("서브도움말이 존재합니다. 서브 도움말 삭제 후 가능합니다.");
			data.instance.refresh();
			return;
		}
		if (!confirm("삭제하시겠습니까?")) {
			data.instance.refresh();
			//location.reload();
		}
		else {
			var hpcmNo = $('#hpcmNo').val();
			$.ajax({ url : "/bos/siteManage/siteHpcm/delete.json", data : { 'cHpcmNo' : hpcmNo }, dataType : "json", async: false }).done(function (resdata) {
				//var node = $("#tree").jstree(true).get_node(menuNo);
				fnSiteHpcmDetail(data.node.parent);
				location.reload();
				//alert(resdata.msg);
			});
		}
	})
	.on('create_node.jstree', function (e, data) {
		$.ajax({ url : "/bos/siteManage/siteHpcm/insert.json", data : {'hpcmNo' : "0", 'hpcmNm' : "New node", 'upperHpcmNo' : data.node.parent, 'useAt' : "Y" }, dataType : "json", async: false }).done(function (resdata) {
			//alert(resdata.cHpcmNo);
			data.instance.set_id(data.node, resdata.cHpcmNo);
			//data.instance.refresh();
			location.reload();
		});
	})
	.on('rename_node.jstree', function (e, data) {
		var useAtVal = $('input:radio[name=useAt]:checked').val();
		$.ajax({ url : "/bos/siteManage/siteHpcm/updateSiteHpcmNm.json", data : { 'cHpcmNo' : data.node.id, 'hpcmNm' : data.node.text, 'upperHpcmNo' : data.node.parent, 'useAt' : useAtVal }, dataType : "json", async: false }).done(function (resdata) {
			data.instance.set_id(data.node, data.node.id);
			$('#tree').jstree(true).get_node(resdata.cHpcmNo).data = {'useAt' : resdata.useAt}
			fnSiteHpcmDetail(data.node.id);
			fnResetAnchor();
		});
	})
	.on("move_node.jstree", function(e, data) {
		if (!confirm((data.node.parents.length-1) + "depth "+  "["+data.node.data.hpcmNm +"] 도움말을 이동하시겠습니까?")) {
			data.instance.refresh();
			return false;
		}

		var hpcmNo = data.node.id;
		if (hpcmNo == "" || hpcmNo == null) {
			return false;
		}

		var instance = $.jstree.reference('#tree'), selected = data.node.id, position = $('#'+selected).index();

		var hpcmData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			hpcmData.push(val);
		});

	    //alert("moving node id " + data.node.id);
	    //alert("moving old_parent " + data.old_parent);
	    //alert("new parent id " + data.parent);

		hpcmData = hpcmData.join(",");

		if (data.old_parent != data.parent) { //부모키가 틀릴경우
			$.ajax({ url : "/bos/siteManage/siteHpcm/updateUpperHpcmNo.json", data : { 'cHpcmNo' : data.node.id, 'upperHpcmNo' : data.node.parent }, dataType : "json", async: false }).done(function (resdata) {
				fnSiteHpcmDetail(data.node.id);
				fnResetAnchor();
		   	});
		}
		else { // 부모 키가 같은 경우
			$.ajax({ url : "/bos/siteManage/siteHpcm/updateMoveHpcmNo.json", data : { 'cHpcmNo' : data.node.id, 'upperHpcmNo' : data.node.parent, 'hpcmData' : hpcmData }, dataType : "json", async: false }).done(function (resdata) {
				fnSiteHpcmDetail(data.node.id);
				fnResetAnchor();
			});
		}


	})
	.on('open_node.jstree', function (e, data) {
		fnResetAnchor();
    })
    .on('changed.jstree', function (e, data) {
    	if (typeof data.node != "undefined") fnResetAnchor();
    	//$('#tree').jstree(true).get_node(data.id).data = {'useAt' : data..useAt}
    });

	$(".treeopen").on('click',function() {
		$("#tree").jstree('open_all');
	});
	$(".treeclose").on('click',function() {
		$("#tree").jstree('close_all');
	});

});

function menuLinkSelect() {
	if ($('#hpcmNo').val() == "" || $('#hpcmNo').val() == null) {
		alert('도움말을 선택해 주세요.');
		return;
	}
	window.open("/bos/siteManage/siteHpcm/menuLinkPop.do?siteId=bos&pSiteId=bos&viewType=BODY&pSrvcId=siteHpcm&menuNo=${paramVO.menuNo}","contentsPop","scrollbars=yes,width=800,height=600");
	return;
}

function menuNoSelect(){
	window.open('/bos/cmmn/cmmnMenu/listMenuPop.do?viewType=BODY&pSiteId=bos&pCloseAt=N','innerLinkPopup','resizable=1,scrollbars=1 ,width=800,height=600');
	return false;
}

function fnSetMenuLink(menuNo, menuNm, menuLink, linkNo) {
	var flag = false;
	$("#menuNos option").each(function(){
		if ($(this).val()==menuNo){
			alert("이미 선택된 메뉴입니다.");
			flag = true;
			return;
		}
	});
	if (!flag){
		$("#menuNos").append("<option value='"+menuNo+"'>"+menuNo+") "+menuNm+"</option>");
	}
}

function menuNoDelete(){
	if ($("#menuNos option:selected").length==0){
		alert("선택된 메뉴가 없습니다.");
		$("#menuNos").focus();
		return;
	}
	if (confirm("정말로 삭제하시겠습니까?")){
		$("#menuNos option:selected").remove();
	}
}

//초기화 함수
function initlHpcmList() {
	$('#hpcmOrdr').val('');
	$('#hpcmCn').val('');
	$('#pGroupId').val('');
	$('#pSrvcId').val('');
	$('#pMethodId').val('');
	$('#pSrvcNm').val('');
	$('input:radio[name=useAt]:input[value=N]').attr("checked", true);
}

function insertHpcmList(gubun) {
	if (gubun == 'C') {
		if ($('#hpcmNo').val() == "" || $('#hpcmNo').val() == null) {
			alert('도움말을 선택해주세요.');
			return;
		}
	}
	$('#hpcmNm').val('New node');

	initlHpcmList();

	if (gubun == 'C') {
		$('#upperHpcmNo').val($('#hpcmNo').val());
	}
	else {
		$('#upperHpcmNo').val('0');
	}
	$('#hpcmNo').val('0');
	$('#hpcmOrdr').val('0');

    $.ajax({
        url: '/bos/siteManage/siteHpcm/insert.json',
        type : "POST",
        dataType : 'json',
        data : $("#mainFrm").serialize(),
        success : function(result) {
    		fnSiteHpcmDetail(result.cHpcmNo);
    		//$('#tree').jstree(true).refresh();
            alert(result.msg);
            location.reload();
        }
    });
}

function deleteHpcmList() {
	try {
		if ($('#hpcmNo').val() == "" || $('#hpcmNo').val() == null) {
			alert('도움말을 선택해주세요.');
			return;
		}
		if ($('#subYn').val() == "Y") {
			alert("서브 도움말이 존재합니다. 서브 도움말 삭제 후 가능합니다.");
			return;
		}

		if ($('#hpcmNo').val() == "0") {
			alert("최상위 도움말은 삭제할 수 없습니다.");
			data.instance.refresh();
			return;
		}

		if(!confirm("정말로 삭제하시겠습니까?")) return;

		var hpcmNo = $('#hpcmNo').val();
		$.ajax({ url : "/bos/siteManage/siteHpcm/delete.json", data : { 'cHpcmNo' : hpcmNo }, dataType : "json", async: false }).done(function (resdata) {
			var node = $("#tree").jstree(true).get_node(hpcmNo);
			fnSiteHpcmDetail(node.parent);
			//$('#tree').jstree(true).refresh();
			//$('#tree').jstree(true)._open_to(node.parent).focus();
			alert(resdata.msg);
			location.reload();
		});
	} catch (e){
		location.reload();
	}
}

function checkForm() {
	if ($('#hpcmNo').val() == "0") {
		alert('도움말 Root는 수정하실 수 없습니다.');
		return;
	}

	if ($('#hpcmNo').val() == "" || $('#hpcmNo').val() == null) {
		alert('도움말을 선택해주세요.');
		return;
	}

	var v = new MiyaValidator($("#mainFrm")[0]);

	v.add("hpcmNo", {
		required : true
	});
	v.add("hpcmOrdr", {
		required : true
	});
	v.add("useAt", {
		required : true
	});

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	// 에디터의 내용 적용
	oEditors.getById["hpcmCn"].exec("UPDATE_CONTENTS_FIELD", []);

	if (!confirm('수정 하시겠습니까?')) {
		return;
	}
	else {

		// select 박스 전체 선텍
		$("#menuNos").multiSelect('select_all');
        $.ajax({
            url: '/bos/siteManage/siteHpcm/update.json',
            type : "POST",
            dataType : 'json',
            data : $("#mainFrm").serialize(),
            success : function(result) {
        		fnSiteHpcmDetail($('#hpcmNo').val());
        		//$('#tree').jstree(true).refresh();
                alert(result.msg);
                location.reload();
            }
        });
	}
}

function initDept() {
	$("#hpcmNo").val("");
	$("#userId").val("");
	$("#userNm").val("");
}


function check_num(value) {
	if (isNaN(value)) {
		alert("숫자로만 입력하셔야 합니다.");
		return "";
	}
	else {
		return value;
	}
}

function updateMoveHpcmNo(gubun) {
	var hpcmNo = $('#hpcmNo').val();
	if (hpcmNo == "" || hpcmNo == null) {
		alert('도움말을 선택해주세요.');
		return;
	}

	var instance = $.jstree.reference('#tree'), selected = instance.get_selected(), position = $('#'+selected).index();
	var flag = "";
	var chgHpcmNo = "";

	if (gubun == "U") {
		flag = instance.get_prev_dom(selected, true);
		var hpcmData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {

			if (flag != false && flag.context.id == val) {
				hpcmData.push(hpcmNo);
			}
			if (hpcmNo != val) {
				hpcmData.push(val);
			}
		});
	}
	else if (gubun == "D") {
		flag = instance.get_next_dom(selected, true);
		var hpcmData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (hpcmNo != val) {
				hpcmData.push(val);
			}
			if (flag != false && flag.context.id == val) {
				hpcmData.push(hpcmNo);
			}
		});
	}
	else {
		var hpcmData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (hpcmNo != val) hpcmData.push(val);
		});
		if (gubun == "T") hpcmData.splice(0, 0, hpcmNo);
		else if (gubun == "B") hpcmData.push(hpcmNo);
	}

	$("#hpcmData").val(hpcmData.join(","));


	if (flag) chgHpcmNo = flag.context.id;

	$.ajax({ url : "/bos/siteManage/siteHpcm/updateMoveHpcmNo.json", data : { 'cHpcmNo' : hpcmNo, 'hpcmOrdr' : $("#hpcmOrdr").val(), 'hpcmData' : $("#hpcmData").val(), 'chgHpcmNo' : chgHpcmNo, 'gubun' : gubun }, dataType : "json", async: false }).done(function (resdata) {
		//fnSiteHpcmDetail(node.parent);
		$('#tree').jstree(true).refresh();
	});
}

</script>
<h2>도움말 목록</h2>
<div class="row">
	<div class="col-lg-4">
		<div class="treectrl">
			<div class="btn-group f">
				<button type="button" class="b-default btn-sm treeopen">모두열기</button>
				<button type="button" class="b-default btn-sm treeclose">모두닫기</button>
			</div>
			<div class="btn-group">
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveHpcmNo('T');"><i class="fa fa-angle-double-up"></i><span class="sr-only">처음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveHpcmNo('U');"><i class="fa fa-angle-up"></i><span class="sr-only">이전 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveHpcmNo('D');"><i class="fa fa-angle-down"></i><span class="sr-only">다음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="javascript:updateMoveHpcmNo('B');"><i class="fa fa-angle-double-down"></i><span class="sr-only">마지막 순서로변경</span></button>
			</div>

		</div>
		<div class="beforeDiv">
			<div id="tree">
			</div>
		</div>
	</div>
	<div class="col-lg-8" style="margin-top:-40px">
		<div class="tar mt10 mb5">
			<a class="b-add" href="javascript:insertHpcmList('T')"><span>최상위 추가</span></a>
			<a class="b-add" href="javascript:insertHpcmList('C')"><span>하위신규 추가</span></a>
		</div>
		<div id="rootDdView" style="display:none;">
			<p class="help">도움말을 선택하여 주십시요. Root는 수정/삭제가 불가능합니다.</p>
		</div>
		<div class="bdView afterDiv">
			<form id="mainFrm" name="mainFrm" action="#" method="post">
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
			<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
			<input type="hidden" name="pSiteId" value="${siteId}" />
			<input type="hidden" name="menuNo" value="${param.menuNo}" />
			<input type="hidden" name="hpcmOrdr" id="hpcmOrdr" />
			<input type="hidden" name="hpcmData" id="hpcmData" />
			<table>
				<caption>게시판 쓰기</caption>
				<colgroup>
					<col width="15%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
				  <tr>
					<th scope="row"><label for="hpcmNo"><span class="req"><span>필수입력</span></span>도움말번호</label></th>
					<td>
						<input type="text" name="hpcmNo" id="hpcmNo" size="10" value=""  maxlength="10" readonly="readonly"/>
						<input type="hidden" name="upperHpcmNo" id="upperHpcmNo" size="10" value=""  maxlength="10" readonly="readonly"/>
						<input type="hidden" name="subYn" id="subYn" size="10" value=""  maxlength="50" readonly="readonly"/>
					</td>
				  </tr>
				  <tr>
					<th scope="row"><label for="hpcmNm"><span class="req"><span>필수입력</span></span>도움말명</label></th>
					<td>
						<input type="text" name="hpcmNm" id="hpcmNm" size="10" value=""  class="w100p" maxlength="100"/>
					</td>
				  </tr>
				  <tr>
					<th scope="row" colspan="2" class="tac"><label for="hpcmCn">도움말내용</label></th>
				  </tr>
				  <tr>
					<td colspan="2">
						<textarea name="hpcmCn" id="hpcmCn" cols="30" rows="10" class="w95p board1" style="height:160px;" data-lensize="2000"></textarea>
						<jsp:include page="/WEB-INF/jsp/bos/share/editor.jsp" flush="true">
							<jsp:param name="target" value="hpcmCn" />
						</jsp:include>
					</td>
				  </tr>
				  <tr>
					<th scope="row"><label for="menuNos">메뉴선택</label></th>
					<td>
						<select name="menuNos" id="menuNos" size="6" class="w60p" multiple="multiple" style="vertical-align:top">
						</select>

						<button type="button" class="b-open" onclick="menuNoSelect()">메뉴 선택</button>
						<button type="button" class="b-del" onclick="menuNoDelete()">메뉴 삭제</button>
						<p class="help"> 메뉴를 선택하신 경우 서비스가 선택되어 있더라도 메뉴번호를 기준으로 도움말을 찾습니다.</p>
					</td>
				  </tr>
				  <tr>
					<th scope="row"><label for="srvcId">서비스선택</label></th>
					<td>
						<input name="pSrvcNm" id="pSrvcNm" type="text" size="10" value="" class="w50p" maxlength="100" readonly="readonly"/>
						<input name="pGroupId" id="pGroupId" type="hidden" size="10" value="" class="w20p" maxlength="100"/>
						<input name="pSrvcId" id="pSrvcId" type="hidden" size="10" value="" class="w20p" maxlength="100"/>
						<input name="pMethodId" id="pMethodId" type="hidden" size="10" value="" class="w20p" maxlength="100"/>
						<button type="button" class="b-open" onclick="menuLinkSelect()">프로그램 선택</button>
						<p class="help"> 프로그램의 URL 패턴으로 도움말을 찾습니다.</p>
					</td>
				  </tr>
				  <tr>
					<th scope="row"><label for="useAt1"><span class="req"><span>필수입력</span></span>사용여부</label></th>
					<td>
						<label><input name="useAt" id="useAt1" type="radio" value="Y" /> 사용</label>
						<label><input name="useAt" id="useAt2" type="radio" value="N" />미사용</label>
					</td>
				  </tr>
			</table>
			</form>
		</div>
		<div class="btnSet clear" id="btnSet">
			<!-- <a class="b-reset" href="javascript:initlHpcmList()"><span>초기화</span></a> -->
			<a class="b-edit" href="javascript:checkForm()"><span>수정</span></a>
			<a class="b-del"  href="javascript:deleteHpcmList()"><span>삭제</span></a>
		</div>
	</div>
</div>