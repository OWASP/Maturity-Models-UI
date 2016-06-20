describe '| angular | Routes ', ->

  beforeEach ()->
    module('MM_Graph')

  it '$routeProvider routers',->
    inject ($route)->
      $route.keys().assert_Is [ 'routes', 'reload', 'updateParams' ]
      #console.log $route.routes.keys()
      expected_Routes = [
        '/view'                 ,'/view/'
        '/view/projects'        ,'/view/projects/'
        '/view/project/:target' ,'/view/project/:target/'
        '/view/all/radar'       ,'/view/all/radar/'
        '/view/routes'          ,'/view/routes/'
        '/view/teams'           ,'/view/teams/'
        '/view/:target'         ,'/view/:target/'
        '/view/:target/edit'    ,'/view/:target/edit/'
        '/view/:target/raw'     ,'/view/:target/raw/'
        'null' ]
      $route.routes.keys().assert_Is expected_Routes

      