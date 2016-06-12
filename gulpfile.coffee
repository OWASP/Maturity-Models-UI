gulp          = require 'gulp'
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
pug           = require 'gulp-pug'
plumber       = require 'gulp-plumber'
templateCache = require('gulp-angular-templatecache');


source_Files  = './src/**/*.coffee'
pug_Files     = './views/**/*.pug'
css_Files     = './views/css/**/*.css'

html_Folder   = './.dist/html'
js_Folder     = './.dist/js'
css_Folder    = './.dist/css'

gulp.task 'compile-pug', ()->
  gulp.src pug_Files
      .pipe plumber()
      .pipe pug()
      .pipe gulp.dest html_Folder

gulp.task 'compile-coffee', ()->
  gulp.src(source_Files)
      .pipe plumber()
      .pipe coffee {bare: true}
      .pipe concat js_Folder + '/angular-src.js'
      .pipe gulp.dest '.'

gulp.task 'templateCache', ['compile-pug'], ()->
  gulp.src html_Folder + '/**/*.html'
      .pipe templateCache( module: 'MM_Graph' )
      .pipe gulp.dest js_Folder
  
gulp.task 'concat-css', ()->
  gulp.src(css_Files)
      .pipe concat css_Folder + '/app.css'
      .pipe gulp.dest '.'
  
gulp.task 'watch', ['compile-coffee', 'compile-pug', 'templateCache', 'concat-css'], ()->
  gulp.watch source_Files, ['compile-coffee']
  gulp.watch pug_Files   , ['compile-pug', 'templateCache']
  gulp.watch css_Files   , ['concat-css']

gulp.task 'default', ['compile-coffee','compile-pug', 'templateCache'], ()->
