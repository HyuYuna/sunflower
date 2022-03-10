var gulp = require('gulp');
var sass = require('gulp-sass');
var rename = require('gulp-rename');
var minifyCss = require('gulp-minify-css');
var uglify = require('gulp-uglify');

gulp.task('default', function() {
    console.log('scss -> css');

    return gulp.src('src/scss/style.scss')
      .pipe(sass())
      .pipe(rename('rumca.css'))
      .pipe(gulp.dest('src/css'))
});

gulp.task('minify-css', ['default'], function() {
    console.log('css -> min.css');

    return gulp.src('src/css/rumca.css')
        .pipe(minifyCss({compatibility: 'ie8'}))
        .pipe(rename({suffix: '.min'}))
        .pipe(gulp.dest('dist'));
});

gulp.task('minify-js', function() {
    console.log('css -> min.css');

    return gulp.src('src/js/rumca.js')
           .pipe(uglify())
           .pipe(rename({suffix: '.min'}))
           .pipe(gulp.dest('dist'));
});

gulp.task('build', ['default', 'minify-css', 'minify-js'], function() {
    console.log('Production version');
});

gulp.task('watch', ['default'], function (){
    gulp.watch('src/scss/**/*.scss', ['minify-css']);
    gulp.watch('src/js/*.js', ['build']);
});
