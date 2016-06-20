describe '| angular | Routes ', ->

  beforeEach ()->
    module('MM_Graph')

  it '$routeProvider routers',->
    inject ($route)->
      $route.keys().assert_Is [ 'routes', 'reload', 'updateParams' ]
      #console.log $route.routes.keys()
      expected_Routes = [
        '/view'                       ,'/view/'
        '/view/projects'              ,'/view/projects/'
        '/view/project/:project'      ,'/view/project/:project/'
        '/view/all/radar'             ,'/view/all/radar/'
        '/view/routes'                ,'/view/routes/'
        '/view/:project/teams'        ,'/view/:project/teams/'
        '/view/:project/:team'        ,'/view/:project/:team/'
        '/view/:project/:team/edit'   ,'/view/:project/:team/edit/'
        '/view/:project/:team/raw'    ,'/view/:project/:team/raw/'
        'null' ]
      $route.routes.keys().assert_Is expected_Routes

      