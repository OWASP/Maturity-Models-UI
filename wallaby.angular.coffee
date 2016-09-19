module.exports = (wallaby)->
  #console.log wallaby

  just_Load = (file)->
    return { pattern: file, instrument: false, load: true, ignore: false }
  config =
    files : [
      just_Load 'bower_components/angular/angular.js'
      just_Load 'bower_components/angular-route/angular-route.js'
      just_Load 'bower_components/angular-mocks/angular-mocks.js'

      just_Load 'bower_components/jquery/dist/jquery.min.js'

      # weird bug where chai will load from node_modules but not from bower_components
      #{pattern: 'bower_components/chai/chai.js', instrument: true},
      just_Load  'node_modules/chai/chai.js'
      './src/**/*.coffee'
      './.dist/js/templates.js'
      './data/**/*.coffee'
    ]
    tests : [
      './test/**/*.coffee'
    ]

    bootstrap:  ()->
      window.expect = chai.expect;

    #workers:
    #  initial: 1,
    #  regular: 1

    #testFramework: 'mocha'

  return config