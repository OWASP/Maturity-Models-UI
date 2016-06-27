describe 'views | table.page', ->
  $scope        = null
  element       = null
  html          = null
  route         = 
    
  project       = 'bsimm'
  team          = 'team-A'
  test_Data     = { metadata: 42 }
  url           = "/view/#{project}/#{team}/table"
  url_Data      = "/api/v1/table/#{project}/#{team}"
  template_Key  = 'pages/table.page.html'
  url_Template  = '/ui/html/' + template_Key

  beforeEach ()->
    module('MM_Graph')
    inject ($route, $compile, $httpBackend, $location, $rootScope, $templateCache)->
      $templateCache.get_Keys().assert_Contains template_Key

      ngView = $compile("<div ng-view></div>")($rootScope)
      
      using $httpBackend, ->
        @.expectGET(url_Template).respond $templateCache.get(template_Key)
        @.expectGET(url_Data    ).respond test_Data

      $location.path(url)
      $httpBackend.flush()
      
      element = ngView[0].nextSibling
      $scope  = angular.element(element).scope()
      html    = element.outerHTML
      route   = $route.current

  it 'rendered view', ->
    using route, ->
      @.params             .assert_Is { project: 'bsimm', team: 'team-A' }
      @.$$route.templateUrl.assert_Is url_Template
      @.$$route.controller .assert_Is 'TableController'
      
    $(html).find('h1').html('table will go here')
    $(html).find('pre').html().assert_Is '{"metadata":42}' 
    
    