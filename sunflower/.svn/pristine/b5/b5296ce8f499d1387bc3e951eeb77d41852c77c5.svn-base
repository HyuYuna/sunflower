<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="/WEB-INF/tlds/util.tld" prefix="util" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="/static/jslibrary/bootstrap/css/bootstrap.css" />

<script src="/static/jslibrary/jquery-3.5.1.min.js"></script>
<script src="/static/jslibrary/bootstrap/js/bootstrap.js"></script>
<script type="text/javascript" src="/static/jslibrary/jquery.form.min.js"></script>
<style>
	body{background-color:#fff;}
	body:before{display:none;}
	form{margin:50px;}
</style>
</head>
<body>
	<button type="button" class="b-black fileadd">파일추가</button>
	<form id="board" name="board" runat="server" method="post" action="">
		<ul class="imageupload-rotate">
			<li>
				<input type='file' class="file" name="file_1" id="file_1">
				<input type="text" class="angle" name="angle_1" id="angle_1" value="0">
				<div class="imgarea">
					<img alt="파일 선택" src="/static/commons/img/btn-fileselect.png">
				</div>
				<div class="ctrl">
					<button type="button" class="b-default left90">90˚ <i class="fa fa-rotate-left" aria-hidden="true"></i></button>
					<button type="button" class="b-default right90">90˚ <i class="fa fa-rotate-right" aria-hidden="true"></i></button>
				</div>
				<button type="button" class="currentdel">삭제</button>
			</li>
		</ul>
	</form>
	<div class="btnSet">
		<a class="b-reg" href="javascript:checkForm();">등록</a>
	</div>
	<script>
		var filelength = 1
		var maxfilelength = 7
		filehtml =
		`
		<li>
			<input type='file' class=file name="file_x" id="file_x">
			<input type="text" class="angle" name="angle_x" id="angle_x" value="0" name="">
			<div class="imgarea">
				<img alt="파일 선택" src="/static/commons/img/btn-fileselect.png">
			</div>
			<div class="ctrl">
				<button type="button" class="b-default left90  btn btn-default">90˚ <i class="fa fa-rotate-left" aria-hidden="true"></i></button>
				<button type="button" class="b-default right90 btn btn-default">90˚ <i class="fa fa-rotate-right" aria-hidden="true"></i></button>
			</div>
			<button type="button" class="currentdel">삭제</button>
		</li>
		`
		$('.fileadd').on('click',function(event) {
			console.log(filelength)
			filelength+=1;
			if (fileadd()) {
				$('.imageupload-rotate').append(filehtml.replace(/_x/gi,filelength))
			}
			console.log(filelength)
		});
		$('.imageupload-rotate').on('click', '.currentdel', function(event) {
			$(this).parent().remove();
			filelengthchk()
		}).on('click', '.left90', function(event) {
			imageRotaion($(this),-90)
		}).on('click', '.right90', function(event) {
			imageRotaion($(this),90)
		}).on('change', 'input.file', function(event) {
			$(this).parents('li').find('.angle').val(0);
			$(this).parent().find('img').attr('src','/static/commons/img/btn-fileselect.png');
			$(this).parent().find('img').removeAttr('style');
			readURL($(this));
		}).on('click', '.imgarea', function(event) {
			$(this).parent().find('input.file').trigger('click')
		});
		function filelengthchk(argument) {
			filelength = $('.imageupload-rotate li').length
		}
		function fileadd(argument) {
			if (filelength>maxfilelength) {
				filelength-=1;
				alert(`최대${maxfilelength}장까지 등록가능합니다.`)
				return false;
			}
			return true;
		}
		$(function() {
			$('.imageupload-rotate input[type="file"]').each(function(index, el) {
				$(this).on('change', function(event) {
					//readURL(this);
				});
			});
		});
		function imageRotaion(_this,deg) {
			angle = parseInt(_this.parents('li').find('.angle').val())
			console.log(angle, typeof angle)
			angle = (angle + deg) % 360;
			_this.parent().prev().find('img').css('transform','rotate(' + angle + 'deg)');
			// $('#blah')[0].className = "rotate" + angle;
			_this.parents('li').find('.angle').val(angle)
			if (Math.abs(angle)==90 || Math.abs(angle) ==270) {
				_this.parent().prev('.imgarea').find('img')
					.css({
						'max-width' : _this.parent().prev('.imgarea').height(),
						'max-height': _this.parent().prev('.imgarea').width()
					});
			}else{
				_this.parent().prev('.imgarea').find('img')
					.css({
						'max-width' : 'auto',
						'max-height': 'auto'
					});
			}
		}
		function readURL(input) {
			if (input[0].files && input[0].files[0]) {
				var reader = new FileReader();
				reader.onload = function (e) {
					console.log(e)
					input.parent().find('img').attr('src', e.target.result);
				}
				reader.readAsDataURL(input[0].files[0]);
			}
		}
		function checkForm() {
			if (!confirm('등록하시겠습니까?[' + $('#angle').val() + ']')) {
				return;
			}
			$('#board').ajaxForm({
				url: "/bos/thumb/imageUpload/insert.json",
				enctype: "multipart/form-data",
				success: function(data) {
					if (data.resultCode == "success") {
						var file = data.file;
						var src = '/cmmn/file/imageSrc.do?fileStreCours='+file.encFileStreCours+'&streFileNm='+file.encStreFileNm+'&thumb=Y';
						$('#resultImg').attr('src', src);
					}
					else {
						alert("등록에 실패하였습니다.");
					}
				}
			});
			$("#board").submit();
		}
	</script>
	<style>
	.imageupload-rotate li { float: left; width: 350px; position: relative; margin-right: 20px; }
	.imageupload-rotate li .currentdel { position: absolute; z-index: 100; top: 5px; right: 0; color: transparent; border: none; background-color: #000; width: 40px; height: 40px; background: rgba(0, 0, 0, 0.5) url(/static/bos/img/close.svg) center center no-repeat; }
	.imageupload-rotate li .imgarea { margin: 5px 0; background-color: #ddd; position: relative; cursor: pointer; }
	.imageupload-rotate li .imgarea:before { display: block; content: ''; padding-top: 75%; }
	.imageupload-rotate li .imgarea img { position: absolute; top: 0; bottom: 0; left: 0; right: 0; margin: auto; max-width: 100%; max-height: 100%; }
	.imageupload-rotate li .imgarea img.rotate90, .imageupload-rotate li .imgarea img.rotate270 { position: absolute; top: 0; bottom: 0; margin: 0 auto; }
	.imageupload-rotate li .imgarea img.rotate90 { -webkit-transform: rotate(90deg) translateY(-100%); transform: rotate(90deg) translateY(-100%); }
	.imageupload-rotate li .imgarea img.rotate180 { -webkit-transform: rotate(180deg) translate(-100%, -100%); transform: rotate(180deg) translate(-100%, -100%); }
	.imageupload-rotate li .imgarea img.rotate270 { -webkit-transform: rotate(270deg) translateX(-100%); transform: rotate(270deg) translateX(-100%); }
	</style>
</body>
</html>