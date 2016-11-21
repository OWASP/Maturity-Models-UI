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
    $scope.project_Activities.keys().assert_Contains 'SM.1.2'
    $scope.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]


  it '$scope.set_Colors', ()->
    $scope.domains['Governance'].color.assert_Is '#8FC740'
    $scope.domains['Governance'].activities[0].assert_Is 'SM.1.1'

    (data.color for domain,data of $scope.domains).assert_Is ['#8FC740' ,'#E17626' , '#1E609D' ,'#51803C']
    (data.index for domain,data of $scope.domains).assert_Is [0, 1, 2, 3]
    (data.title for domain,data of $scope.domains).assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]

