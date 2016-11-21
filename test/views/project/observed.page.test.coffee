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


  it '$scope.map_Data', ()->
    $scope.domains['Governance'].activities[0].assert_Is 'SM.1.1'
    (data.index for domain, data of $scope.domains                   ).assert_Is [0, 1, 2, 3]
    (data.title for domain, data of $scope.domains                   ).assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
    (data.title for domain, data of $scope.project_Activities).take(4).assert_Is [ 'SM.1.1', 'SM.1.2', 'SM.1.3', 'SM.1.4' ]


    using $scope.project_Activities['SM.1.1'], ->
      @.title.assert_Is 'SM.1.1'
      @.level.assert_Is '1'
      @.name.assert_Is  'Publish process (roles, responsibilities, plan), evolve as necessary'
      @.activities.keys().assert_Contains 'No'