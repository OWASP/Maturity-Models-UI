describe 'views | project | observed.page', ->

  html       = null
  project    = null

  element    = null
  html       = null
  raw_Html   = null
  $html      = null
  $scope     = null

  run_Controller = ()->
    inject ($templateCache, $compile, $httpBackend, $rootScope, observed)->
      $scope   = $rootScope.$new()
      raw_Html = $templateCache.get '/ui/html/pages/project/observed.html'
      element  = $compile(angular.element(raw_Html))($scope)
      $httpBackend.flush()
      $scope = element.eq(1).scope()
      html   = element[1].outerHTML
      $html  = $(html)

  beforeEach ()->
    module 'MM_Graph'
    project = 'bsimm'

    inject ($routeParams)->
      $routeParams.project = project        # dependency inject project value
      run_Controller()


  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'current_Level', ->
    ($scope.current_Level() is null).assert_Is_True

  it 'page_Link', ->
    $scope.page_Link().assert_Is "view/project/#{project}/observed"

  it 'check with no level', ()->

    $scope.observed.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
    $scope.observed['Governance'].activities.keys().assert_Contains 'SM.1.2'


  it 'check links', ->
    html.assert_Contains('id="SM.1.1')


#  it 'bug - $routesParams lost inside $compiler', ()->
#    value = 'aaaa'
#
#    inject ($routeParams)->
#
#      $routeParams.project = project
#      $routeParams.level = value
#    inject (observed)->
#      observed.current_Level().assert_Is value
#    inject ($routeParams)->
#      $routeParams.level.assert_Is value
#
#    run_Controller()
#
#    inject (observed)->
#      (observed.current_Level() is null).assert_Is_True()    # this is wrong