describe 'angular | Routes ', ->

  beforeEach ()->
    module('MM_Graph')

  it '$routeProvider routers (check list)',->
    inject ($route)->
      $route.keys().assert_Is [ 'routes', 'reload', 'updateParams' ]
      #console.log $route.routes.keys()
      routes = [
        '/view'
        '/view/routes'
        '/view/projects'
        '/view/project/:project'
        '/view/project/:project/new-team'
        '/view/project/:project/scores'
        '/view/project/:project/observed'
        '/view/project/:project/schema'
        '/view/project/:project/schema/:level'
        '/view/:project/:team/admin'
        '/view/:project/:team/edit'
        '/view/:project/:team/radar'
        '/view/:project/:team/metadata'
        '/view/:project/:team/yes-answers'
        '/view/:project/:team/raw'
        '/view/:project/:team/table'
        '/view/:project/:team/table/:level'
      ]
      
      expected_Routes = []      
      for route in routes                                         # handle case where angular adds an extra route with / at the end
        expected_Routes.push route
        expected_Routes.push route + '/'
      expected_Routes.push 'null'

      real_Routes = $route.routes.keys()

      for route in real_Routes                                    # this makes it easier to debug which route is missing
        #console.log route
        expected_Routes.assert_Contains route

      for route,index in expected_Routes
        #console.log route
        real_Routes.assert_Contains route                         # confirm it exists
        real_Routes[index].assert_Is expected_Routes[index]       # confirm order is correct

      $route.routes.keys().assert_Is expected_Routes              # final check to make sure they match


  #todo: fix this test which is not working as originally designed after the fix to the $templateCache
  it '$routeProvider routers',->
    inject ($route, $location, $rootScope,$httpBackend) ->
      pages = '/ui/html/pages'

      #map_Expected_GETs = (paths)->
      #  for path in paths
      #    $httpBackend.expectGET "#{pages}/#{path}"
      #                .respond []

      open_Urls = (urls)->
        for url in urls
          $location.path url.replace(':project', 'bsimm')
          $rootScope.$digest();

      url_Mappings =
        '/view'                                 : 'welcome.page.html'
        '/view/projects'                        : 'projects.page.html'
        '/view/project/:project'                : 'project.page.html'
        '/view/projest/:project/schema'         : 'project-schema.page.html'      # there is a bug with the current logic since this request below will not be triggered
#        '/view/project/:project/schema/:level'  : 'project-schema.page.html'     # since it is using the same urlTemplate value
        #'/view/all/radar'                       : 'all-radar.page.html'
        '/view/routes'                          : 'routes.page.html'
        #'/view/:project/:team'                  : 'view.page.html'
        '/view/:project/:team/edit'             : 'edit.page.html'
        '/view/:project/:team/radar'            : 'radar.page.html'
        '/view/:project/:team/raw'              : 'raw.page.html'
        '/view/:project/:team/table'            : 'table.page.html'
        #'/view/project/:team/table/:level'      : 'table.page.html'               # same prob as above
        '/aaaa'                                 : '404.page.html'

      #map_Expected_GETs (value for key,value of url_Mappings)
      open_Urls         (key   for key,value of url_Mappings)

      using $httpBackend, ->
        #@.flush()
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
      #$httpBackend.flush()
      
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()


