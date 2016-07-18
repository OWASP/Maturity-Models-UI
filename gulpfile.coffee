gulp          = require 'gulp'
coffee        = require 'gulp-coffee'
concat        = require 'gulp-concat'
pug           = require 'gulp-pug'
plumber       = require 'gulp-plumber'
templateCache = require('gulp-angular-templatecache');
child_process = require 'child_process'

src_Files_Api  = '../api/src/**/*.coffee'
src_Files_Ui  = './src/**/*.coffee'
pug_Files     = './views/**/*.pug'
css_Files     = './views/css/**/*.css'

bower_Folder   = './bower_components'
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
      .pipe templateCache( module: 'MM_Graph', root:'/ui/html/' )
      .pipe gulp.dest js_Folder
  
gulp.task 'concat-css', ()->
  sources = [
              bower_Folder + '/foundation/css/foundation.min.css'     ,
              bower_Folder + '/radar-chart-d3/src/radar-chart.min.css',
              css_Files
            ]
  gulp.src(sources)
      .pipe concat css_Folder + '/app.css'
      .pipe gulp.dest '.'

gulp.task 'concat-js-libs', ()->                                            # this only needs to be done once
  sources = [
              bower_Folder + '/d3/d3.min.js'                          ,     # Issue 53 - Only use d3 script includes on pages that need it
              bower_Folder + '/radar-chart-d3/src/radar-chart.min.js' ,

              bower_Folder + '/angular/angular.js'                    ,     #todo: Add support for using min in production
              bower_Folder + '/angular-route/angular-route.min.js'    ,
              bower_Folder + '/jquery/dist/jquery.min.js'             ,

              #bower_Folder + 'foundation/js/foundation.js'
            ]
  
  gulp.src(sources)
      .pipe concat js_Folder + '/libs.js'
      .pipe gulp.dest '.'

gulp.task 'server', ()->
  if server_Process
    console.log 'stopping server'
    server_Process.kill()

  server_Process = child_process.spawn 'node', ['../../server.js']
  server_Process.stdout.on 'data', (data)->console.log(data.toString().trim())
  server_Process.stderr.on 'data', (data)->console.log(data.toString().trim())
  return true                                                             # without this, gulp will block here and not complete this task

gulp.task 'watch', ['compile-coffee', 'compile-pug', 'templateCache', 'concat-css', 'server', 'concat-js-libs'], ()->
  gulp.watch src_Files_Api , ['server']
  gulp.watch src_Files_Ui  , ['compile-coffee']
  gulp.watch pug_Files     , ['compile-pug', 'templateCache']
  gulp.watch css_Files     , ['concat-css']


gulp.task 'default', ['compile-coffee','compile-pug', 'templateCache', 'concat-css', 'concat-js-libs'], ()->
