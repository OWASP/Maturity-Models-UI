describe 'angular | Routes ', ->

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
        '/view/:project/:team'
        '/view/:project/:team/edit'
        '/view/:project/:team/radar'
        '/view/:project/:team/raw'
        '/view/:project/:team/table']
      
      expected_Routes = []      
      for route in routes                               # handle case where angular adds an extra route with / at the end
        expected_Routes.push route
        expected_Routes.push route + '/'
      expected_Routes.push 'null'

      $route.routes.keys().assert_Is expected_Routes



  it '$routeProvider routers',->
    inject ($route, $location, $rootScope,$httpBackend) ->
      pages = '/ui/html/pages'

      map_Expected_GETs = (paths)->
        for path in paths
          $httpBackend.expectGET "#{pages}/#{path}"
                      .respond []

      open_Urls = (urls)->
        for url in urls
          $location.path url.replace(':project', 'bsimm')
          $rootScope.$digest();

      url_Mappings =
        '/view'                                 : 'welcome.page.html'
        '/view/projects'                        : 'projects.page.html'
        '/view/project/:project'                : 'project.page.html'
        '/view/project/:project/schema'         : 'project-schema.page.html'      # there is a bug with the current logic since this request below will not be triggered
#        '/view/project/:project/schema/:level'  : 'project-schema.page.html'     # since it is using the same urlTemplate value
        '/view/all/radar'                       : 'all-radar.page.html'
        '/view/routes'                          : 'routes.page.html'
        '/view/:project/:team'                  : 'view.page.html'
        '/view/:project/:team/edit'             : 'edit.page.html'
        '/view/:project/:team/radar'            : 'radar.page.html'
        '/view/:project/:team/raw'              : 'raw.page.html'
        '/view/:project/:team/table'            : 'table.page.html'
        '/aaaa'                                 : '404.page.html'

      map_Expected_GETs (value for key,value of url_Mappings)
      open_Urls         (key   for key,value of url_Mappings)

      using $httpBackend, ->
        @.flush()
        @.verifyNoOutstandingExpectation()
        @.verifyNoOutstandingRequest()


  # Issues regression tests

  it 'Check for double / in path',->
    inject ($route, $httpBackend, $location, $rootScope)->      
      $httpBackend
        .whenGET (value)->
          value.assert_Not_Contains '//'
          return true
        .respond []              

      $rootScope.$digest();
      $httpBackend.flush()
      
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()


