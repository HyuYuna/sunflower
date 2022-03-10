/*
폴더구조
static-scss
	  -css
	  -img
	   -sprite	스프라이트이미지
	  -guide
	   -front
		-lib		코딩소스
		-dist		코딩 아웃풋
*/
var jspOut		     = false; // 콘텐트(cts)생성
var gulp             = require('gulp');
var sourcemaps       = require('gulp-sourcemaps');
var sass             = require('gulp-sass');
var browserSync      = require('browser-sync').create();
var autoprefixer     = require('gulp-autoprefixer');
var headerfooter     = require('gulp-headerfooter');
var remove           = require('gulp-remove-content');
var rename           = require("gulp-rename");
var imagemin         = require('gulp-imagemin');
var removeEmptyLines = require('gulp-remove-empty-lines');
var spritesmith      = require('gulp.spritesmith');
var imageResize      = require('gulp-image-resize');
var reload           = browserSync.reload;
var merge 			 = require('merge')
var scssOptions = {
	errLogToConsole: true,
	/** * outputStyle (Type : String , Default : nested) * CSS의 컴파일 결과 코드스타일 지정 * Values : nested, expanded, compact, compressed */
	outputStyle : "compact",
	/** * indentType (>= v3.0.0 , Type : String , Default : space) * 컴파일 된 CSS의 "들여쓰기" 의 타입 * Values : space , tab */
	indentType : "tab",
	/** * indentWidth (>= v3.0.0, Type : Integer , Default : 2) * 컴파일 된 CSS의 "들여쓰기" 의 갯수 */
	indentWidth : 1, // outputStyle 이 nested, expanded 인 경우에 사용
	/** * precision (Type : Integer , Default : 5) * 컴파일 된 CSS 의 소수점 자리수. */
	precision: 6,
	/** * sourceComments (Type : Boolean , Default : false) * 컴파일 된 CSS 에 원본소스의 위치와 줄수 주석표시. */
	sourceComments: true
};
// image sprite
gulp.task('st', function () {
  // Generate our spritesheet
  var spriteData = gulp.src('static/sign/img/sprite/*.png').pipe(spritesmith({
    // imgName      : 'sprite.png',
    // cssName      : 'sprite.scss'
    // This will filter out `fork@2x.png`, `github@2x.png`, ... for our retina spritesheet
    // The normal spritesheet will now receive `fork.png`, `github.png`, ...
    retinaSrcFilter : 'static/sign/img/sprite/*@2x.png',
    imgName         : 'sprite1.png',
    retinaImgName   : 'sprite1@2x.png',
    cssName         : '_sprite1.scss',
    padding         : 20,//이미지와의 여백
    imgPath         : '/static/sign/img/sprite1.png' //scss에서 사용하는 background-img url
  }));
  // Pipe image stream through image optimizer and onto disk
  var imgStream = spriteData.img
    // DEV: We must buffer our stream into a Buffer for `imagemin`
    // .pipe(buffer())
    // .pipe(imagemin())
    .pipe(gulp.dest('static/sign/img/'));
  // Pipe CSS stream through CSS optimizer and onto disk
  var cssStream = spriteData.css
    // .pipe(csso())
    .pipe(gulp.dest('static/sign/scss/'));
  // Return a merged stream to handle both `end` events
  // return merge(imgStream, cssStream);
});
gulp.task('mainst', function () {
  var spriteData = gulp.src('static/sign/img/main/mainsprite/*').pipe(spritesmith({
    imgName: 'mainsprite.png',
    cssName: '_mainsprite.scss',
	padding: 20,//이미지와의 여백
	imgPath : '/static/sign/img/main/mainsprite.png' //scss에서 사용하는 background-img url
  }));
  var imgStream = spriteData.img
    .pipe(gulp.dest('static/sign/img/main/'));
  var cssStream = spriteData.css
    .pipe(gulp.dest('static/sign/scss/'));
  // return merge(imgStream, cssStream);
});
gulp.task('st2', function () {
  var spriteData = gulp.src('static/sign/img/sprite-one/*.png').pipe(spritesmith({
    imgName: 'sprite-one.png',
    cssName: '_sprite-one.scss',
	padding: 20,//이미지와의 여백
	imgPath : '/static/sign/img/sprite-one.png' //scss에서 사용하는 background-img url
  }));
  var imgStream = spriteData.img
    .pipe(gulp.dest('static/sign/img/'));
  var cssStream = spriteData.css
    .pipe(gulp.dest('static/sign/scss/'));
  // return merge(imgStream, cssStream);
});
gulp.task('percentage', function() {
  // gulp.src('static/wescm/img/sprite/temp/2x/*.png')
  gulp.src('static/wescm/img/sprite/temp/2x/gjoin@2x.png')
    .pipe(imageResize({
      percentage: 50
    }))
    .pipe(gulp.dest('/static/wescm/img/temp'));
});
//기본 task 설정
gulp.task('default',
	[
	'server',
	'watch'
]);
// 웹서버를 localhost:3000 로 실행한다.  3001은 관리자
// https://browsersync.io/docs/options
gulp.task('server', function () {
	browserSync.init({
		server: {
			baseDir: './',
			index: "static/guide/index.html"
				},
			port:3000
	});
});

var scss=['commons','ucms','bos']
for (var i = scss.length - 1; i >= 0; i--) {
	scssTocss(scss[i])
}
gulp.task('watch', function () {
	// css
	for (var i = scss.length - 1; i >= 0; i--) {
		gulp.watch(['static/'+scss[i]+'/scss/*.scss'], [scss[i]]);
	}
	// html
	watchLibrary('front');
	// watchContent('sign');
	watchLibrary('bos');

});
function scssTocss(targets){
	gulp.task(targets, function () {
		return gulp.src('static/'+targets+'/scss/*.scss')
			.pipe(sourcemaps.init({loadMaps: false}))
			.pipe(sass(scssOptions).on('error', sass.logError))
			.pipe(autoprefixer({
							browsers: ['last 1 versions'],
							cascade: true
					}))
			.pipe(sourcemaps.write('./'))
			//.pipe(removeEmptyLines())
			.pipe(gulp.dest('static/'+targets+'/css/'))
			.pipe(browserSync.stream());
	});
}
function watchLibrary(targets){
	gulp.watch('static/guide/'+targets+'/lib/*.html')
		.on('change', function(event) {
			console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
			gulp.src(event.path)
				.pipe(headerfooter.header('static/guide/'+targets+'/top.html'))
				.pipe(headerfooter.footer('static/guide/'+targets+'/bottom.html'))
				.pipe(gulp.dest('static/guide/'+targets+'/dist'));
			browserSync.reload();
		});
}
function watchContent(targets){
	gulp.watch('static/guide/'+targets+'/content/*.html')
		.on('change', function(event) {
				console.log('File ' + event.path + ' was ' + event.type + ', running tasks...');
			gulp.src(event.path)
		  		.pipe(headerfooter.header('static/guide/'+targets+'/top.html'))
		  		.pipe(headerfooter.footer('static/guide/'+targets+'/bottom.html'))
		  		.pipe(gulp.dest('static/guide/'+targets+'/dist'));
		  	if (jspOut) {
				gulp.src(event.path)
					.pipe(headerfooter.header('<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>'))
					.pipe(rename({extname: ".jsp"}))
					.pipe(gulp.dest('WEB-INF/jsp/cts/'+targets+'/'));
			}
			browserSync.reload();
		});
}
gulp.task('imagemin', function(){
	gulp.src('static/wesc/img/**')
		.pipe(imagemin())
		.pipe(gulp.dest('dist/images'))
});
// 출처: http://turfrain.tistory.com/entry/gulpwindowchocolatey-이용 [TRstory]
var concat = require('gulp-concat');
gulp.task('htmlmerge', function() {
	return gulp.src('static/guide/front/lib/*.html')
		.pipe(concat('all.html'))
		.pipe(headerfooter.header('static/guide/front/top.html'))
		.pipe(headerfooter.footer('static/guide/front/bottom.html'))
		.pipe(gulp.dest('static/guide/front/'))
		browserSync.reload()
});
var sitemap = require('gulp-sitemap');
gulp.task('sitemap', function () {
    gulp.src('static/guide/**/*.html', {
            read: false
        })
        .pipe(sitemap({
            siteUrl: 'http://127.0.0.1/static/'
        }))
        .pipe(gulp.dest('./static'));
});
var sitemapFiles = require('gulp-sitemap-files');
var clean = require('gulp-clean');
gulp.task('clean', function() {
    gulp.src('static/sitemap.xml')
        .pipe(sitemapFiles('http://www.example.com/'))
        .pipe(clean());
});
