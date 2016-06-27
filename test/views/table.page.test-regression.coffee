describe 'views | table.page', ->

  html          = null
  project       = null
  team          = null
  test_Data     = null
  ngView        = null
  url           = null
  url_Data      = null
  url_Path      = null
  url_Template  = null


  beforeEach ()->
    module('MM_Graph')
    project      = 'bsimm'
    team         = 'team-A'
    test_Data    = { metadata: 42 }
    url          = "/view/#{project}/#{team}/table"
    url_Data     = "/api/v1/table/#{project}/#{team}"
    url_Path     = '/view/:project/:team/table'
    url_Template = '/ui/html/pages/table.page.html'

    inject ($templateCache)->      
      $templateCache.get_Keys().assert_Contains 'pages/table.page.html'
      html = $templateCache.get 'pages/table.page.html'

  it '$templateCache value',->
    using $(html), ->
      $(html).find('h1').html().assert_Is 'table will go here'

  it 'check view content', ->
    inject ($route, $location, $rootScope, $httpBackend, $compile)->

      ngView = $compile("<div ng-view></div>")($rootScope)

      using $httpBackend, ->
        @.expectGET(url_Template).respond(html)
        @.expectGET(url_Data    ).respond test_Data


      $location.path(url)
      $httpBackend.flush()

      element = ngView[0].nextSibling
      $scope = angular.element(element).scope()
      $scope.team.assert_Is 'team-A'
      $scope.table.assert_Is metadata: 42

  it 'check routes /view/:project/:team/table', ()->

    inject ($route, $location, $rootScope, $httpBackend)->
      $httpBackend.expectGET(url_Template).respond(html)
      $location.path(url)
      $rootScope.$digest()

      $location.path().assert_Is url

      using $route.current, ->
        @.controller          .assert_Is 'TableController'
        @.params              .assert_Is { project: 'bsimm', team: 'team-A' }
        @.templateUrl         .assert_Is url_Template
        @.$$route.originalPath.assert_Is url_Path


      #$route.current.assert_Is expected_Route
      $httpBackend.flush()
      $rootScope.$digest()
      

  it 'checking values set by angular routes', ->
    inject ($route, $location, $rootScope, $httpBackend)->
      $httpBackend.expectGET('/ui/html/pages/table.page.html').respond(html)
      $location.path url
      $rootScope.$digest()

      $location.path().assert_Is url

      expected_Route =
        params    : { project: 'bsimm', team: 'team-A' }
        pathParams: { project: 'bsimm', team: 'team-A' },        
        $$route   :          
          templateUrl         : '/ui/html/pages/table.page.html',
          controller          : 'TableController'
          reloadOnSearch      : true,
          caseInsensitiveMatch: false,
          originalPath        : '/view/:project/:team/table',
          regexp              : /^\/view\/(?:([^\/]+))\/(?:([^\/]+))\/table$/,
          keys                : [ { name: 'project', optional: false }, { name: 'team', optional: false } ]
        loadedTemplateUrl     : '/ui/html/pages/table.page.html'
      console.log $route.current
      JSON.stringify($route.current).assert_Is JSON.stringify(expected_Route)
