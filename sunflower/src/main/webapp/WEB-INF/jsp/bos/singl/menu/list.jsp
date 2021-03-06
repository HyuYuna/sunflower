<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"  errorPage="/cmmn/error.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://bibeault.org/tld/ccc" prefix="ccc" %>

<c:set var="siteId" value="${param.pSiteId}" />
<spring:eval expression="@prop['Globals.ucms.OsType']" var="osType" scope="request" />
<c:set var="siteUrl" value="${osType eq 'WINDOWS' ? '' : siteInfo.siteUrl}" />

<link rel="stylesheet" href="/static/jslibrary/jstree/themes/default/style.css" />
<style>
/* custom 추가 */
#tree .jstree-delete { text-decoration:line-through; color:red; }
</style>
<script src="/static/jslibrary/jstree/jstree.min.js"></script>
<script src="/static/jslibrary/jquery.form.min.js"></script>
<script>

// 메뉴 갯수 제한
<c:if test="${param.pSiteId eq 'bos'}">
var maxChildren = 6;
var siteNm = "관리자사이트 ";
</c:if>
<c:if test="${param.pSiteId ne 'bos'}">
var maxChildren = 10;
var siteNm = "";
</c:if>


// 뎁스 갯수 제한
var maxDepth = "${siteId}" == 'bos' ? 5 : 3;
// 메뉴명 글자수 제한
var menuNmLength = 30;

function fnGetMenuDetail(id) {
	if (id > 0) {
		$.ajax({ url : "/bos/singl/menu/listJson.json?cMenuNo="+id, dataType : "json", async: false }).done(function (resdata) {
			for (key in resdata) {
				var dataVal = resdata[key];
				if (key == "menuNm") dataVal = dataVal.replace("&amp;","&");
				$('#'+key).val(dataVal);
			}
			var menuCntntsCdList = resdata.menuCntntsCdList;
			var menuCntntsCd = resdata.menuCntntsCd;
			if (menuCntntsCd != "" && menuCntntsCd != null) {
				$('input:radio[name="menuCntntsCd"][value="'+resdata.menuCntntsCd+'"]').prop('checked', true);
				$('#menuCntntsCdOri').val(resdata.menuCntntsCd);
			}
			else {
				$('input:radio[name="menuCntntsCd"]').prop('checked', false);
			}
			chkListItem(menuCntntsCd, resdata.menuLink, resdata.bbsNm);

			$('input:radio[name="useAt"][value="'+resdata.useAt+'"]').prop('checked', true);
			$('input:radio[name="popupAt"][value="'+resdata.popupAt+'"]').prop('checked', true);
			$('input:radio[name="scrinExpsrAt"][value="'+resdata.scrinExpsrAt+'"]').prop('checked', true);

			if (resdata.siteId != "bos") {
				$('input:radio[name=menuExpsrSe][value='+resdata.menuExpsrSe+']').prop('checked', true);
			}
			if (resdata.siteId = "bos") {
				if(resdata.userInfoSe == "" || resdata.userInfoSe == null){
					$('input:radio[name=userInfoSe][value=N]').prop('checked', true);
				}else{
					$('input:radio[name=userInfoSe][value='+resdata.userInfoSe+']').prop('checked', true);
				}
			}
			if (resdata.cntntsFileCours == "" || resdata.cntntsFileCours == null) $('#contentsPopBtn').hide();
			else $('#contentsPopBtn').show();
		});
		$(".afterDiv").show();
		$("#btnSet").show();
		$("#rootDdView").hide();

	}
	else {
		$(".afterDiv").hide();
		$("#btnSet").hide();
		$("#rootDdView").show();
		initlMenuList();
		$('#menuNo').val(id);
	}

}

function fnResetAnchor() {

	$(".jstree-anchor").each(function(n) {
		node = $("#tree").jstree(true).get_node($(this));
		//alert(node.data.useAt);
		if (typeof node.data != "undefined" && node.data.useAt == "N") {
			$(this).addClass("jstree-delete");
		}
	})
}

function replaceX(str){
	str = str.replace("&amp;","&").replace(/&/gi,"&amp;").replace(/</gi,"&lt;").replace(/>/gi,"&gt;").replace(/"/gi,"&quot;").replace(/'/gi,"&apos;");
	return str;
}

$(function() {
	var chknodeSelect
	$('#contentsPopBtn').hide();
	$("#loadingDivTxt").text("메뉴 로딩 중입니다.");
	//localStorage.removeItem('jstree');
	$('#tree').jstree({
		'core' : {
			'data' : function (node, cb) {
				var t_url = node.id != "#" ? "/bos/singl/menu/listJson.json?pSiteId=${siteId}&upperMenuNo="+node.id : "/bos/singl/menu/listJson.json?pSiteId=${siteId}";
				$.ajax({ url: t_url, dataType: "json"}).done(function (data) {
					var rootList = [];
					var jsonList = [];
					var root = {'id' : '0', 'text' : "메뉴Root",'icon' : "jstree-folder", 'children' : true, 'state' : { 'opened' : true, 'selected' : true }, 'data' : {'useAt' : "Y"}};
					$.each(data,function(key, value) {
						var children = true;
						if (value.icon == "jstree-file") children = false;

						// 담당부서 지정 아이콘 추가
						var addIcons;

						addIcons = (value.userId) || (value.allDeptAt) ? "<span class='usS'><span class='hidden'>담당자 지정됨</span>&nbsp;<i class='fa fa-vcard'></i></span>" : "" ;

						var item = {'id' : value.menuNo, 'text' : replaceX(value.menuNm) + addIcons , 'children' : children, 'icon' : value.icon};

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
				//if (m && m.dnd && m.pos !== 'i') { return false; }
				/*
				if (o === "move_node" || o === "copy_node") {
					if (this.get_node(n).parent === this.get_node(p).id) { return false; }
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
			'default' : {
				'icon' : 'folder'
				//, 'max_depth' : maxDepth
				//, "max_children" : maxChildren
			},
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
				"label" : "메뉴추가", //node에서 마우스 오른쪽 클릭 시 text
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
					obj = inst.get_node(data.reference);
					inst.create_node(obj, { type : "file" }, "last", function (new_node) {
						setTimeout(function () { inst.edit(new_node); },0);
						chknodeSelect = new_node
						// console.log(new_node.id)
					});
				}
			},
			"rename" : {
				"separator_before" : false,
				"separator_after" : true,
				"label" : "메뉴명 변경",
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
					obj = inst.get_node(data.reference);
					inst.edit(obj);
				}
			},
			"remove" : {
				"separator_before" : false,
				"separator_after" : true,
				"label" : "메뉴삭제",
				"action" : function (data) {
					var inst = $.jstree.reference(data.reference),
					obj = inst.get_node(data.reference);
					if (inst.is_selected(obj)) {
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
		//if (typeof node.id != "undefined")

		if (node.icon == "jstree-folder") $('#cntntsCd_DWN01').show();
		else $('#cntntsCd_DWN01').hide();

		$('#menuCntntsCdOri').val("");
		fnGetMenuDetail(node.id);
	})
	.on('delete_node.jstree', function (e, data) {
		if (data.node.id == "0") {
			alert("최상위 메뉴는 삭제할 수 없습니다.");
			data.instance.refresh();
			return;
		}
		if (!confirm("삭제하시겠습니까?")) {
			data.instance.refresh();
		}
		else {
			var menuNo = data.node.id;//$('#menuNo').val();
			$.ajax({ url : "/bos/singl/menu/delete.json", data : { 'cMenuNo' : menuNo, 'upperMenuNo' : data.node.parent}, dataType : "json", async: false }).done(function (resdata) {
				//var node = $("#tree").jstree(true).get_node(menuNo);
				fnGetMenuDetail(data.node.parent);
				$("#loadingDiv").show();
				data.instance.refresh();
				$("#loadingDiv").hide();
				alert(resdata.msg);
			});
		}
	})
	.on('create_node.jstree', function (e, data) {
		if (data.parent == "0") {
			if (data.position > maxChildren - 1) {
				alert(siteNm + "최상위 메뉴는 "+maxChildren+"개이상 등록하실 수 없습니다.");
				data.instance.refresh();
				return;
			}
		}

		if (data.node.parents.length >= maxDepth +2) {
			alert(maxDepth+"뎁스이상 등록하실 수 없습니다.");
			data.instance.refresh();
			return;
		}

		$.ajax({ url : "/bos/singl/menu/insert.json", data : {'pSiteId' : "${siteId}", 'menuNm' : escape(encodeURIComponent("신규메뉴")), 'upperMenuNo' : data.node.parent, 'useAt' : "N", 'popupAt' : "N", 'scrinExpsrAt' : "N" }, dataType : "json", async: false }).done(function (resdata) {
			data.instance.set_id(data.node, resdata.cMenuNo);
			$("#loadingDiv").show();
			data.instance.refresh();
			$("#loadingDiv").hide();
		});
	})
	.on('rename_node.jstree', function (e, data) {
		var useAtVal = $('input:radio[name=useAt]:checked').val();

				if (data.text.length > menuNmLength) {
						alert(menuNmLength+"자 이상 입력하실 수 없습니다.");
			data.instance.refresh();
			return;
				}

		//escape(encodeURIComponent(data.node.text))
		$.ajax({ url : "/bos/singl/menu/updateMenuNm.json", data : { 'cMenuNo' : data.node.id, 'menuNm' : escape(encodeURIComponent(data.node.text)), 'upperMenuNo' : data.node.parent, 'useAt' : useAtVal }, dataType : "json", async: false }).done(function (resdata) {
			data.instance.set_id(data.node, resdata.cMenuNo);
			$('#tree').jstree(true).get_node(resdata.cMenuNo).data = {'useAt' : resdata.useAt}
			fnGetMenuDetail(resdata.cMenuNo);
			fnResetAnchor();
		});
	})
	.on("move_node.jstree", function(e, data) {
		if (data.node.parents.length >= maxDepth +2) {
			alert(maxDepth+"뎁스이상 등록하실 수 없습니다.");
			data.instance.refresh();
			return;
		}

		if (!confirm((data.node.parents.length-1) + "depth "+  "["+data.node.data.menuNm +"] 메뉴를 이동하시겠습니까?")) {
			data.instance.refresh();
			return false;
		}

		var menuNo = data.node.id;
		if (menuNo == "" || menuNo == null) {
			return false;
		}

		var instance = $.jstree.reference('#tree'), selected = data.node.id, position = $('#'+selected).index();
		var menuData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			menuData.push(val);
		});

	    //alert("moving node id " + data.node.id);
	    //alert("moving old_parent " + data.old_parent);
	    //alert("new parent id " + data.parent);

		menuData = menuData.join(",");

		if (data.old_parent != data.parent) { //부모키가 틀릴경우
			$.ajax({ url : "/bos/singl/menu/updateUpperMenuNo.json", data : { 'cMenuNo' : data.node.id, 'upperMenuNo' : data.node.parent }, dataType : "json", async: false }).done(function (resdata) {
				fnGetMenuDetail(data.node.id);
				$("#loadingDiv").show();
				data.instance.refresh();
				$("#loadingDiv").hide();
				fnResetAnchor();
			});
		}
		else { // 부모 키가 같은 경우
			$.ajax({ url : "/bos/singl/menu/updateMoveMenuNo.json", data : { 'cMenuNo' : data.node.id, 'upperMenuNo' : data.node.parent, 'menuData' : menuData }, dataType : "json", async: false }).done(function (resdata) {

				fnGetMenuDetail(data.node.id);
				$("#loadingDiv").show();
				data.instance.refresh();
				$("#loadingDiv").hide();
				fnResetAnchor();
			});
		}

	})
	.on('refresh.jstree', function(event,d) {
		if (chknodeSelect!=undefined) {
			$('#tree').jstree(true).open_node(chknodeSelect.parent,function(){
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
		//$('#tree').jstree(true).get_node(data.id).data = {'useAt' : data.useAt}
	});

	$(".treeopen").on('click',function() {
		$("#tree").jstree('open_all');
	});
	$(".treeclose").on('click',function() {
		$("#tree").jstree('close_all');
	});

});

function menuLoad() {
	if ("${siteId}" == "bos") {
		if (confirm("관리자메뉴 적용을 위해 재로그인이 필요합니다.\n로그아웃 하시겠습니까?")) {
			location.href = "/bos/member/admin/logout.do";
		}
	}
	else {
			$.ajax({ url : "/bos/singl/menu/menuLoadSite.json", data : { 'pSiteId' : "${siteId}" }, dataType : "json", async: false }).done(function (resdata) {
				alert(resdata.msg);
			});
	}
}

//초기화 함수
function initlMenuList() {
	$('#menuOrdr').val('');
	$('#menuNm').val('');
	$('#menuDc').val('');
	$('#menuLink').val('');
	$('input:radio[name=menuCntntsCd]').attr("checked", false);
	$('input:radio[name=popupAt]:input[value=N]').attr("checked", true);
	$('input:radio[name=scrinExpsrAt]:input[value=N]').attr("checked", true);
	$('input:radio[name=useAt]:input[value=N]').attr("checked", true);
	$('input:radio[name=menuExpsrSe]:input[value=NONE]').attr("checked", true);
	$('input:radio[name=userInfoSe]:input[value=N]').attr("checked", true);
	<c:if test="${siteId ne 'bos'}">
		$('#cntntsFileCours').val('');
	</c:if>
	initDept();
}

function insertMenuList(gubun) {
	var menuNo = $('#menuNo').val();
	if (gubun == 'C') {
		if (menuNo == "" || menuNo == null) {
			alert('메뉴를 선택해주세요.');
			return;
		}
		if ($('#tree').jstree(true).get_node(menuNo).parents.length >= maxDepth +1) {
			alert(maxDepth+"뎁스이상 등록하실 수 없습니다.");
			return;
		}
	}
	if (gubun == 'T') {
		if ($('#tree').jstree(true)._model.data[0].children.length >= maxChildren) {
			alert('최상위메뉴는 '+maxChildren+'개이상 등록하실 수 없습니다.');
			return;
		}
	}

	initlMenuList();

	if (gubun == 'C') {
		$('#upperMenuNo').val(menuNo);
		$('#menuNm').val('하위메뉴');
	}
	else {
		$('#upperMenuNo').val('0');
		$('#menuNm').val('최상위메뉴');
	}
	$('#menuNo').val('0');
	$('#menuOrdr').val('0');

		$.ajax({
				url: '/bos/singl/menu/insert.json',
				type : "POST",
				dataType : 'json',
				data : $("#menuFrm").serialize(),
				success : function(result) {
				fnGetMenuDetail(result.cMenuNo);
				$('#tree').jstree(true).refresh();
						alert(result.msg);
				}
		});
}

function deleteMenuList() {
	if ($('#menuNo').val() == "" || $('#menuNo').val() == null) {
		alert('메뉴를 선택해주세요.');
		return;
	}
	if(!confirm("정말로 삭제하시겠습니까?")) return;

	var menuNo = $('#menuNo').val();
	var upperMenuNo = $('#upperMenuNo').val();
	$.ajax({ url : "/bos/singl/menu/delete.json", data : { 'cMenuNo' : menuNo, 'upperMenuNo' : upperMenuNo }, dataType : "json", async: false }).done(function (resdata) {
		var node = $("#tree").jstree(true).get_node(menuNo);
		fnGetMenuDetail(node.parent);
		$('#tree').jstree(true).refresh();
		//$('#tree').jstree(true)._open_to(node.parent).focus();
		alert(resdata.msg);
	});
}

function checkForm() {
	
	debugger;
	var v = new MiyaValidator($("#menuFrm")[0]);
	var menuNo = $('#menuNo').val();
	//var menuCntntsCd = $('input:radio[name=menuCntntsCd]:checked').val();
	var menuCntntsCd = $('#menuCntntsCd').val();
	
	console.log(menuCntntsCd);
	var menuLink = $('#menuLink').val();
	/* var menuUrl = $("#menuUrl").val(); */
	
	/* if(menuCntntsCd == "DWN01"){
		$('#menuLink').val("");
	}else if (!(menuCntntsCd == "PRG01" || menuCntntsCd == "BBS01")) {
		
		console.log(menuUrl);
		
		$("#menuLink").val(menuUrl);
		
		
	} */
	
	menuLink = $('#menuLink').val();

	if (menuNo == "" || menuNo == null) {
		alert('메뉴를 선택해주세요.');
		return;
	}
	if (menuNo == "0") {
		alert('메뉴Root는 수정할 수 없습니다.');
		return;
	}

	v.add("menuNo", {
		required : true
	});
	v.add("menuOrdr", {
		required : true
	});
	v.add("menuNm", {
		required : true
	});
	v.add("menuCntntsCd", {
		required : true
	}); 

	if (menuCntntsCd == "PRG01" || menuCntntsCd == "BBS01") {
		v.add("menuLink", {
			required : true
		});
	}

	var result = v.validate();
	if (!result) {
		alert(v.getErrorMessage());
		v.getErrorElement().focus();
		return;
	}

	if (menuCntntsCd == "CON01") {
		menuContentCnt();
		if ($('#contentCnt').val() == 0) {
			if (confirm('콘텐츠 버전관리에서 콘텐츠를 등록해야 합니다.\n등록하시겠습니까?')) contentsPop();
			return;
		}
	}
	else if (menuCntntsCd == "LNK01") {
/* 		if (menuLink != "") {
			if (menuLink.substring(0, 7) != "http://") {
				alert("링크선택시 메뉴링크는 'http://'로 시작되어야 합니다.");
				return;
			}
		} */
	}

	if (!confirm('수정 하시겠습니까?')) {
		return;
	}
	else {
		if (menuCntntsCd != "BBS01") $('#bbsId').val('');

				$.ajax({
						url: '/bos/singl/menu/update.json',
						type : "POST",
						dataType : 'json',
						data : $("#menuFrm").serialize(),
						success : function(result) {
						fnGetMenuDetail(menuNo);
						$('#tree').jstree(true).refresh();

						var msg = "${siteId}" != "bos" ? "\n해당사이트 메뉴적용 버튼을 클릭하셔야 홈페이지에 적용됩니다." : "\n해당사이트 메뉴적용 버튼을 클릭하시거나\n재 로그인하시면  홈페이지에 적용됩니다.";
								alert("수정되었습니다." + msg);
						}
				});
	}
}

function initDept() {
	$("#deptId").val("");
	$("#deptKorNm").val("");
	$("#userId").val("");
	$("#userNm").val("");
	$("#userCpno").val("");
	$("#userEmad").val("");
}

function menuLinkSelect() {
	if ($('#menuNo').val() == "" || $('#menuNo').val() == null) {
		alert('메뉴를 선택해주세요.');
		return;
	}
	window.open("menuLinkPop.do?siteId=${siteId}&pSiteId=${siteId}&viewType=BODY&menuNo=${paramVO.menuNo}","contentsPop","scrollbars=yes,width=800,height=600");
	return;
}

function boardSelect() {
	if ($('#menuNo').val() == "" || $('#menuNo').val() == null) {
		alert('메뉴를 선택해주세요.');
		return;
	}
	window.open("/bos/cmmn/cmmnBbsMaster/listPop.do?pSiteId=${siteId}&viewType=BODY","bbsId","scrollbars=yes,width=800,height=600");
	return;
}

function adminSelect() {
	if ($('#menuNo').val() == "" || $('#menuNo').val() == null) {
		alert('메뉴를 선택해주세요.');
		return;
	}
	window.open("/bos/cmmn/cmmnMngr/listPop.do?viewType=BODY","userId","scrollbars=yes,width=800,height=600");
	return;
}

function contentsPop() {
	window.open("/bos/singl/menu/forUpdateContents.do?sSiteId=${siteId}&sMenuNo="+$('#menuNo').val()+"&viewType=BODY&cntntsFileCours=" + $("#cntntsFileCours").val() + "&menuNo=${paramVO.menuNo}","contentsPop","scrollbars=yes,width=970,height=800");
	return;
}

function scrinExpsrAtPop() {
	window.open("/bos/singl/menu/scrinExpsrAtPop.do?sSiteId=${siteId}&sMenuNo="+$('#menuNo').val()+"&viewType=BODY&menuNo=${paramVO.menuNo}","contentsPop","scrollbars=yes,width=970,height=800");
	return;
}

function updateMoveMenuNo(gubun) {
	var menuNo = $('#menuNo').val();
	if (menuNo == "" || menuNo == null) {
		alert('메뉴를 선택해주세요.');
		return;
	}

	var instance = $.jstree.reference('#tree'), selected = instance.get_selected(), position = $('#'+selected).index();
	var flag = "";
	var chgMenuNo = "";

	if (gubun == "U") {
		flag = instance.get_prev_dom(selected, true);
		var menuData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {

			if (flag != false && flag.context.id == val) {
				menuData.push(menuNo);
			}
			if (menuNo != val) {
				menuData.push(val);
			}
		});
	}
	else if (gubun == "D") {
		flag = instance.get_next_dom(selected, true);
		var menuData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (menuNo != val) {
				menuData.push(val);
			}
			if (flag != false && flag.context.id == val) {
				menuData.push(menuNo);
			}
		});
	}
	else {
		var menuData = [];
		$(instance.get_node(instance.get_parent(selected)).children).each(function(e, val) {
			if (menuNo != val) 	menuData.push(val);
		});
		if (gubun == "T") menuData.splice(0, 0, menuNo);
		else if (gubun == "B") menuData.push(menuNo);

	}
	$("#menuData").val(menuData.join(","));

	if (flag) chgMenuNo = flag.context.id;

	$.ajax({ url : "/bos/singl/menu/updateMoveMenuNo.json", data : { 'cMenuNo' : menuNo, 'menuOrdr' : $("#menuOrdr").val(), 'menuData' : $("#menuData").val(), 'chgMenuNo' : chgMenuNo, 'gubun' : gubun }, dataType : "json", async: false }).done(function (resdata) {
		//fnGetMenuDetail(node.parent);
		$('#tree').jstree(true).refresh();
	});
}

</script>

<div class="row">
	<div class="col-md-5">
	<h2>메뉴목록</h2>
		<div class="treectrl">
			<div class="btn-group f">
				<button type="button" class="b-default btn-sm treeopen">모두열기</button>
				<button type="button" class="b-default btn-sm treeclose">모두닫기</button>
				<c:if test="${param.pSiteId eq 'ucms' }">
				<span style="display:inline-block;padding:5px 0 0 105px;"><i class="fa fa-vcard usS"></i>&nbsp;: 담당자 지정됨</span>
				</c:if>
			</div>
			<div class="btn-group">
				<button type="button" class="b-default btn-sm" onclick="updateMoveMenuNo('T');"><i class="fa fa-angle-double-up"></i><span class="sr-only">선택한 메뉴 처음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="updateMoveMenuNo('U');"><i class="fa fa-angle-up"></i><span class="sr-only">선택한 메뉴 이전 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="updateMoveMenuNo('D');"><i class="fa fa-angle-down"></i><span class="sr-only">선택한 메뉴 다음 순서로변경</span></button>
				<button type="button" class="b-default btn-sm" onclick="updateMoveMenuNo('B');"><i class="fa fa-angle-double-down"></i><span class="sr-only">선택한 메뉴 마지막 순서로변경</span></button>
			</div>
		</div>
		<div class="beforeDiv">
			<div id="tree">
			</div>
		</div>
	</div>

	<div class="col-md-7">
		<div class="btnSet">
			<a class="b-add" href="javascript:insertMenuList('T')"><span>최상위신규메뉴추가</span></a>
			<a class="b-add" href="javascript:insertMenuList('C')"><span>하위신규메뉴추가</span></a>
			<a class="b-save" href="javascript:menuLoad();"><span>해당사이트 메뉴적용</span></a>
		</div>
		<h4></h4>
		<div id="rootDdView" style="display:none;" class="tac pt30">
			<p class="help"> 메뉴를 선택하여 주십시요. Root는 수정/삭제가 불가능합니다.</p>
		</div>
		<div class="bdView afterDiv">
			<form id="menuFrm" name="menufrm" action="#" method="post">
			<input type="hidden" name="csrfToken" value="${csrfToken}"/>
			<input type="hidden" name="pageQueryString" value="${pageQueryString}" />
			<input type="hidden" name="pSiteId" value="${siteId}" />
			<input type="hidden" name="menuNo" value="${param.menuNo}" />
			<input type="hidden" name="upperMenuNo" id="upperMenuNo" />
			<input type="hidden" name="menuOrdr" id="menuOrdr" />
			<input type="hidden" name="menuData" id="menuData" />
			<table>
				<caption>메뉴정보</caption>
				<tbody>
					<tr>
						<th scope="row" style="width: 17%"><label for="menuNo">메뉴번호</label></th>
						<td><input name="cMenuNo" id="menuNo" type="text" size="10" value=""  maxlength="10" readonly="readonly">
					</td>
					</tr>
					<tr>
						<th scope="row"> <label for="menuNm"><span class="req"><span>필수입력</span></span>메뉴명</label> </th>
						<td>
							<input name="menuNm" id="menuNm" type="text" value="" maxlength="10"/>
							<script>
								$('#menuNm').attr({
									'maxlength':menuNmLength,
									'size':menuNmLength
								});
							</script>
						</td>
					</tr>
					<%--
					<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>상위메뉴No</th>
					<td><input name="upperMenuNo" id="upperMenuNo" type="text" size="10" value="" maxlength="30" readonly/>
					</td>
					</tr>
					 --%>
					<tr class="menuTr">
					<th scope="row"><label for="menuUrl">메뉴URL</label></th>
					<td><input id="" name="menuUrl" type="text" size="80" readonly="readonly">
					</td>
					</tr>

					<tr>
						<th scope="row"> <span class="req"><span>필수입력</span></span>콘텐츠 선택 </th>
						<td>
							<div class="chkListItem">
							
								<input type="hidden" id="menuCntntsCdOri" readonly="readonly"/>
								<c:forEach var="item" items="${menuCntntsCdList }" varStatus="status">
									<c:if test="${siteId eq 'bos' }">
										<c:if test="${item.codeCode ne 'CON01'}">
												<label for="menuCntntsCd_${item.codeCode}" id="cntntsCd_${item.codeCode}"><input type="radio" name="menuCntntsCd" id="menuCntntsCd_${item.codeCode}" value="${item.codeCode}" data-type="${item.codeCode}" onchange="chkListItem(this.value)"> ${item.codeName}</label>
											</c:if>
									</c:if>
									<c:if test="${siteId ne 'bos' }">
											<label for="menuCntntsCd_${item.codeCode}" id="cntntsCd_${item.codeCode}"><input type="radio" name="menuCntntsCd" id="menuCntntsCd_${item.codeCode}" value="${item.codeCode}" data-type="${item.codeCode}"> ${item.codeName}</label>
									</c:if>
								</c:forEach>
									
									
									
								
								<%-- <input type="hidden" id="menuCntntsCdOri" readonly="readonly"/>
								
								<c:forEach var="item" items="${menuCntntsCdList }" varStatus="status">
									<label for="menuCntntsCd_${item.codeCode}" id="cntntsCd_${item.codeCode}">
										<input type="radio" name="menuCntntsCd" id="menuCntntsCd_${item.codeCode}" value="${item.codeCode}" data-type="${item.codeCode}"/>${item.codeName}</label>
									</label>
								</c:forEach> --%>
								
									<!-- <select name="menuCntntsCd" id="menuCntntsCd" onchange="chkListItem(this.value)">
										<option value="COM01">COM01</option>
										<option value="PRG01">PRG01</option>
										<option value="CON01">CON01</option>
										<option value="BBS01">BBS01</option>
										<option value="LNK01">LNK01</option>
										<option value="DWN01">DWN01</option>
									</select> -->
								
								<%-- <c:forEach var="item" items="${menuCntntsCdCodeList }" varStatus="status">
									<c:if test="${siteId eq 'bos' }">
										<c:if test="${item.cd ne 'CON01'}">
										<c:out value="가나다1라"/>
												<label for="menuCntntsCd_${item.cd}" id="cntntsCd_${item.cd}"><input type="radio" name="menuCntntsCd" id="menuCntntsCd_${item.cd}" value="${item.cd}" data-type="${item.cd}"> ${item.cdNm}</label>
											</c:if>
									</c:if>
									<c:if test="${siteId ne 'bos' }">
										<c:out value="가나다라"/>
											<label for="menuCntntsCd_${item.cd}" id="cntntsCd_${item.cd}"><input type="radio" name="menuCntntsCd" id="menuCntntsCd_${item.cd}" value="${item.cd}" data-type="${item.cd}"> ${item.cdNm}</label>
									</c:if> --%>
									<%--
									<c:if test="${siteId eq 'ucms' }">
										<c:if test="${item.cd ne 'PRG01'}">
												<label><input type="radio" name="menuCntntsCd" value="${item.cd}" data-type="${item.cd}"> ${item.cdNm}</label>
											</c:if>
									</c:if>
									 --%>
								<%-- </c:forEach> --%>
							</div>
							<!-- 준비중 -->
							<div class="row">
								<div class="col-sm-10 col-sm-offset-2">
								<div class="proramchoice"><button type="button" onclick="menuLinkSelect()" class="b-open" title="새창열림">프로그램 선택</button></div>
								<div class="boardchoice"><button type="button" onclick="boardSelect()" class="b-open" title="새창열림">게시판 선택</button></div>
								</div>
							</div>
							<div class="row menulink">
								<div class="col-sm-2 tar">메뉴링크 : </div>
								<div class="col-sm-10">
									<input type="text" name="menuLink" id="menuLink" class="w100p" value="" title="메뉴링크">
									<input type="hidden" name="cntntsFileCours" id="cntntsFileCours" />
									<input type="hidden" name="bbsId" id="bbsId" readonly="readonly"/>
								</div>
							</div>
							<div class="row menulinknm">
								<div class="col-sm-2 tar">게시판명 : </div>
								<div class="col-sm-10">
									<input type="text" id="menuLinkNm" class="w100p" readonly="readonly" title="게시판명">
								</div>
							</div>
							<div class="contentsPopBtn" >
								<button type="button" class="b-open" onclick="contentsPop()" title="새창열림">콘텐츠 버전관리</button>
								<input type="hidden" name="contentCnt" id="contentCnt" readonly="readonly"/>
							</div>
							<div class="inputDeco"></div>
							<script>
								$('.proramchoice').hide();
								$('.boardchoice').hide();
								$('.menulink').hide();
								$('.menulinknm').hide();
								$('#menuCntntsCd').each(function(index, el) {
									$(this).on('click', function () {
										if ($(this).data().type == $('#menuCntntsCdOri').val()) {
											fnGetMenuDetail($('#menuNo').val())
										}
										else {
											chkListItem($(this).data().type, "", "");
										}										
									});
									
								});

								function chkListItem(data, link, linkNm) {
									$('.contentsPopBtn').hide();

/* 									if (data == "LNK01") $('#menuLink').attr("readonly", false);
									else $('#menuLink').attr("readonly", true); */

									if (data != "CON01") $('#contentCnt').val("");

									switch (data) {
									case "COM01":
										$('.scrinExpsrAtBtn').hide();
										$('.proramchoice').hide();
										$('.boardchoice').hide();
										$('.menulink').hide();
										$('.menulinknm').hide();
										$('#menuLink').val("/${siteId}/singl/contents/ready.do");
										$('.inputDeco').html("<p>※ 콘텐츠가 없는 페이지 일 경우 준비중임을 알리는 콘텐츠를 표시합니다.</p>");
										$('.menuTr').show();
										break;
									case "PRG01":
										$('.scrinExpsrAtBtn').hide();
										$('.proramchoice').show();
										$('.boardchoice').hide();
										$('.menulink').show();
										$('.menulinknm').hide();
										$('#menuLink').val(link.replace(/&amp;/gi,'&'));
										$('.inputDeco').html("");
										$('.menuTr').show();
										break;
									case "CON01":
										$('.scrinExpsrAtBtn').hide();
										$('.proramchoice').hide();
										$('.boardchoice').hide();
										$('.menulink').hide();
										$('.menulinknm').hide();
										$('#menuLink').val("/${siteId}/main/contents.do");
										$('#cntntsFileCours').val("/cts/${siteId}/"+$('#menuNo').val()+".jsp");
										$('.contentsPopBtn').show();
										$('.inputDeco').html("※ HTML 콘텐츠로, 콘텐츠 버전관리를 통해 수정 가능합니다.</p>");
										$('.menuTr').show();
										menuContentCnt();
										break;
									case "BBS01":
										$('.scrinExpsrAtBtn').hide();
										$('.proramchoice').hide();
										$('.boardchoice').show();
										$('.menulink').hide();
										$('.menulinknm').show();
										$('#menuLink').val(link.replace(/&amp;/gi,'&'));
										$('#menuLinkNm').val(linkNm);
										$('.inputDeco').html("<p>※ 게시판 형식의 서비스를 선택하여 제공합니다.</p>");
										$('.menuTr').show();
										break;
									case "LNK01":
										$('.scrinExpsrAtBtn').hide();
										$('.proramchoice').hide();
										$('.boardchoice').hide();
										$('.menulinknm').hide();
										$('.menulink').show();
										$('#menuLink').val(link == "" ? "http://" : link.replace(/&amp;/gi,'&'));
										$('.inputDeco').html("<p>※ 외부링크를 직접 입력가능하며, http:// 로 입력하셔야 합니다.</p>");
										$('.menuTr').show();
										break;
									case "DWN01":
										$('.scrinExpsrAtBtn').show();
										$('.proramchoice').hide();
										$('.boardchoice').hide();
										$('.menulink').hide();
										$('.menulinknm').hide();
										$('#menuLink').val("");
										$('.inputDeco').html("<p>※ 해당 메뉴의 콘텐츠는 없으며, 하위 첫번쨰 메뉴를 호출합니다.(기본 화면은 준비중 화면입니다)</p>");
										$('.menuTr').hide();
										break;
									default:
										$('.scrinExpsrAtBtn').hide();
										$('.proramchoice').hide();
										$('.boardchoice').hide();
										$('#menuLink').val(link.replace(/&amp;/gi,'&'));
										break;
									}
									
									
									if (link != "" && link != null) {
										if (data == "LNK01" || data == "DWN01") {
											$('#menuUrl').val(link.replace(/&amp;/gi,'&'));
										}
										else {
											if(link.indexOf("menuNo") <= -1){
												if (link.indexOf("?") > -1) link += "&";
												else link += "?";
												$('#menuUrl').val(link.replace(/&amp;/gi,'&')+"menuNo="+$('#menuNo').val());
											}else{
												$('#menuUrl').val(link);
											}
										}
									}
									else {
										$('#menuUrl').val("");
									}
								}

								function menuContentCnt() {
									$.ajax({ url : "/bos/singl/menu/menuContentCnt.json", data : { 'sMenuNo' : $('#menuNo').val(), 'useAt' : 'Y' }, dataType : "json", async: false }).done(function (resdata) {
										$('#contentCnt').val(resdata.contentCnt);
									});
								}
							</script>

						</td>
					</tr>

				<c:if test="${siteId != 'bos'}">
					<tr class="menuTr">
					<th scope="row">담당자 지정</th>
					<td>
						<div>
						<button type="button" class="b-open" onclick="adminSelect()" title="새창열림">담당자 선택</button>
						<button type="button" class="b-reset" onclick="initDept()">초기화</button>
						</div>
						<ul class="contentadminfo">
							<li>
								<label>
									<span class="title">부서:</span><input type="text" id="deptKorNm" value="" class="board1 w100" readonly="readonly" />
									<input type="hidden" id="deptId" name="deptId" readonly="readonly" />
								</label>
							</li>
							<li>
								<label>
									<span class="title">이름:</span><input type="text" id="userNm" value="" class="board1 w100" readonly="readonly" />
									<input type="hidden" id="userId" name="userId" readonly="readonly" />
								</label>
							</li>
							<li><label><span class="title">연락처:</span><input type="text" id="userCpno" value="" class="board1 w100" readonly="readonly" /></label></li>
							<li><label><span class="title">이메일:</span><input type="text" id="userEmad" value="" class="board1 w100" readonly="readonly" /></label></li>
						</ul>
					</td>
					</tr>
				</c:if>

					<tr>
						<th scope="row"><span class="req"><span>필수입력</span></span>새창열기</th>
						<td>
							<label><input name="popupAt" id="popupAt1" type="radio" value="Y" /> 사용</label>
							<label><input name="popupAt" id="popupAt2" type="radio" value="N" />미사용</label>
						</td>
					</tr>

					<c:choose>
					<c:when test="${paramVO.pSiteId ne 'bos' }">
					<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>메뉴노출구분</th>
					<td>
						<label><input name="menuExpsrSe" id="menuExpsrSe1" type="radio" value="NONE" />해당사항없음</label>
						<label><input name="menuExpsrSe" id="menuExpsrSe2" type="radio" value="LOGIN" />로그인 시</label>
						<label><input name="menuExpsrSe" id="menuExpsrSe3" type="radio" value="NOLOGIN" />비 로그인 시 </label>
					</td>
					</tr>
					<!-- <tr style="display:none;">
					<th scope="row"><span class="req"><span>필수입력</span></span>개인정보 기능여부</th>
					<td>
						<input type="hidden" name="userInfoSe" id="userInfoSe" value="N" />
					</td>
					</tr> -->
					</c:when>
					<c:otherwise>
					<tr style="display:none;">
					<th scope="row"><span class="req"><span>필수입력</span></span>사용여부1</th>
					<td>
						<input type="hidden" name="menuExpsrSe" id="menuExpsrSe" value="NONE" />
					</td>
					</tr>
					<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>개인정보 기능여부</th>
					<td>
						<label><input name="userInfoSe" id="userInfoSe1" type="radio" value="Y" />있음</label>
						<label><input name="userInfoSe" id="userInfoSe2" type="radio" value="N" />없음</label>
					</td>
					</tr>
					</c:otherwise>
					</c:choose>

					<tr>
					<th scope="row"><span class="req"><span>필수입력</span></span>사용여부</th>
					<td>
						<label><input name="useAt" id="useAtY" type="radio" value="Y" /> 사용</label>
						<label><input name="useAt" id="useAtN" type="radio" value="N" />미사용</label>
					</td>
					</tr>

					<tr>
						<th scope="row">화면 노출 여부</th>
						<td>
							<label><input name="scrinExpsrAt" id="scrinExpsrAt1" type="radio" value="Y" /> 노출</label>
							<label><input name="scrinExpsrAt" id="scrinExpsrAt2" type="radio" value="N" />미노출</label>
							<div class="scrinExpsrAtBtn" >
								<button type="button" class="b-open" onclick="scrinExpsrAtPop()" title="새창열림">하위메뉴 일괄적용</button>
							</div>
						</td>
					</tr>

					<%-- <tr>
					<th height="23" class="required_text" >메뉴설명</th>
					<td class="td_txtarea">
					<textarea title="메뉴설명" name="menuDc" id="menuDc" class="textarea" cols="45" rows="2" class="w100p"></textarea>
					</td>
					</tr>

					<c:if test="${siteId != 'bos'}">
					<!-- <tr>
					<th scope="row">자료담당자</th>
					<td><input name="pic" id="pic" type="text" size="70" value=""  maxlength="200" />
					</td>
					</tr>
					<tr>
					<th scope="row">전화번호</th>
					<td><input name="tel" id="tel" type="text" size="70" value=""  maxlength="200" />
					</td>
					</tr> -->
					<tr>
					<th scope="row">키워드명<br>(메타태그)</th>
					<td><input name="kwrdNm" id="kwrdNm" type="text" size="60" value="" maxlength="300" class="w100p" title="키워드명(메타태그)" />
					</td>
					</tr>
					<tr>
					<th scope="row">부가정보<br>(메타태그)</th>
					<td class="td_txtarea"><textarea name="adiInfo" id="adiInfo" cols="45" rows="2" class="w100p" title="부가정보(메타태그)"></textarea>
					</td>
					</tr>
					</c:if> --%>

			</table>
			</form>
		</div>
		<div class="btnSet clear" id="btnSet">
			<!-- <a class="b-reset" href="javascript:initlMenuList()"><span>초기화</span></a> -->
			<a class="b-edit" href="javascript:checkForm();"><span>수정</span></a>
			<a class="b-del"  href="javascript:deleteMenuList();"><span>삭제</span></a>
		</div>
	</div>
</div>

