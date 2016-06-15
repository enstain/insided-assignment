var
gulp = require('gulp'),
include = require("gulp-include"),
concat = require('gulp-concat'),
es = require('event-stream'),
sass = require('gulp-sass'),
slim = require("gulp-slim"),
uglify = require('gulp-uglify'),
streamqueue = require('streamqueue'),
coffee = require('gulp-coffee'),
gutil = require('gulp-util'),
shell = require('gulp-shell'),
cssmin = require('gulp-cssmin'),
coffeelint = require('gulp-coffeelint'),
browserSync = require('browser-sync'),
changed = require('gulp-changed'),
isProd = gutil.env.type === 'prod',

sources = {
  sass: 'src/sass/**/*.scss',
  css: 'src/css/**/*.css',
  html: 'src/slim/**/*.slim',
  js: 'src/js/**/*.js',
  coffee: 'src/coffee/**/*.coffee'
},

targets = {
  css: 'www/css',
  html: 'www/',
  js: 'www/js'
};

gulp.task('lint', function() {
  gulp.src(sources.js).pipe(coffeelint()).pipe(coffeelint.reporter());
});

gulp.task('js', function() {
  var stream;
  stream = streamqueue({
    objectMode: true
  });
  stream.queue(gulp.src(sources.js));

  stream.queue(
    gulp.src(sources.coffee)
    .pipe(coffee({
      bare: true
    }))
    .pipe(include({
      extensions: "js"
    }))
  );
  stream.done().pipe(concat("app.js")).pipe(isProd ? uglify() : gutil.noop()).pipe(gulp.dest(targets.js));
});

gulp.task('slim', function(){
  gulp.src(sources.html)
    .pipe(changed(targets.html, { extension: '.html'}))
    .pipe(slim({
      pretty: true
    }))
    .pipe(gulp.dest(targets.html));
});

gulp.task('css', function() {
  var stream;
  stream = streamqueue({
    objectMode: true
  });
  stream.queue(gulp.src(sources.css));
  stream.queue(gulp.src(sources.sass).pipe(sass({
    style: 'expanded',
    includePaths: ['src/css'],
    errLogToConsole: true
  })));
  stream.done().pipe(concat("style.css")).pipe(isProd ? uglify() : gutil.noop()).pipe(gulp.dest(targets.css));
});

gulp.task('server', function() {
  browserSync.init(null, {
    open: true,
    server: {
      baseDir: targets.html
    },
    reloadDelay: 2000,
    watchOptions: {
      debounceDelay: 1000
    }
  });
});

gulp.task('watch', function() {
  gulp.watch(sources.coffee, ['js']);
  gulp.watch(sources.sass, ['css']);
  gulp.watch(sources.html, ['slim']);

  gulp.watch('www/**/**', function(file) {
    if (file.type === "changed") {
      browserSync.reload(file.path);
    }
  });
});

gulp.task('build', ['lint', 'js', 'css', 'slim']);

gulp.task('default', ['watch', 'server']);