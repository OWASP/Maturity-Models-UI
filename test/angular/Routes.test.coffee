describe '| angular | Routes ', ->

  beforeEach ()->
    module('MM_Graph')

  it '$routeProvider routers',->
    inject ($route)->
      $route.keys().assert_Is [ 'routes', 'reload', 'updateParams' ]
      #console.log $route.routes.keys()
      routes = [
        '/view'
        '/view/projects'
        '/view/project/:project'
        '/view/project/:project/schema'
        '/view/project/:project/schema/:level'
        '/view/all/radar'
        '/view/routes'
        '/view/:project/teams'
        '/view/:project/:team'
        '/view/:project/:team/edit'
        '/view/:project/:team/raw']
      expected_Routes = []
      for route in routes
        expected_Routes.push route
        expected_Routes.push route + '/'
      expected_Routes.push 'null'

      $route.routes.keys().assert_Is expected_Routes

      