gulp          = require 'gulp'
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
pug           = require 'gulp-pug'
plumber       = require 'gulp-plumber'
templateCache = require('gulp-angular-templatecache');
child_process = require 'child_process'

src_Files_Api  = '../src/**/*.coffee'
src_Files_Ui  = './src/**/*.coffee'
pug_Files     = './views/**/*.pug'
css_Files     = './views/css/**/*.css'

html_Folder    = './.dist/html'
js_Folder      = './.dist/js'
css_Folder     = './.dist/css'

server_Process = null

gulp.task 'compile-pug', ()->
  gulp.src pug_Files
      .pipe plumber()
      .pipe pug()
      .pipe gulp.dest html_Folder

gulp.task 'compile-coffee', ()->
  gulp.src(src_Files_Ui)
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

gulp.task 'server', ()->
  if server_Process
    console.log 'stopping server'
    server_Process.kill()

  server_Process = child_process.spawn 'node', ['../server.js']
  server_Process.stdout.on 'data', (data)->console.log(data.toString().trim())
  server_Process.stderr.on 'data', (data)->console.log(data.toString().trim())
  return true   # without this, gulp will block here and not complete this task 

gulp.task 'watch', ['compile-coffee', 'compile-pug', 'templateCache', 'concat-css', 'server'], ()->
  gulp.watch src_Files_Api , ['server']
  gulp.watch src_Files_Ui  , ['compile-coffee']
  gulp.watch pug_Files     , ['compile-pug', 'templateCache']
  gulp.watch css_Files     , ['concat-css']


gulp.task 'default', ['compile-coffee','compile-pug', 'templateCache', 'concat-css'], ()->
