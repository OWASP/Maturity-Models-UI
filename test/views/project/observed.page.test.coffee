describe 'views | project | observed.page', ->

  html       = null
  project    = null
  team       = null

  element  = null
  html     = null
  raw_Html = null
  $html    = null
  $scope   = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'

    inject ($templateCache, $compile, $rootScope, $routeParams, $httpBackend)->
      $routeParams.project = project
      $routeParams.team    = team
      $scope   = $rootScope.$new()
      raw_Html = $templateCache.get '/ui/html/pages/project/observed.html'
      element  = $compile(angular.element(raw_Html))($scope)
      $httpBackend.flush()

      $scope = element.scope()
      html   = element[0].outerHTML
      $html  = $(html)


  it 'check with Controller', ()->
    #console.log $html.find('div').eq(0).attr('ng-controller')
    #console.log $scope
    #console.log html
    $scope.activities.keys().assert_Contains 'SM.1.2'
    console.log $scope.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
