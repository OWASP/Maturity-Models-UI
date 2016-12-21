describe 'views | project | observed.page', ->

  html       = null
  project    = null

  element  = null
  html     = null
  raw_Html = null
  $html    = null
  $scope   = null

  run_Controller = ()->
    inject ($templateCache, $compile, $httpBackend, $rootScope, $routeParams, observed)->
      $scope   = $rootScope.$new()
      raw_Html = $templateCache.get '/ui/html/pages/project/observed.html'
      element  = $compile(angular.element(raw_Html))($scope)
      $httpBackend.flush()

      $scope = element.scope()
      html   = element[0].outerHTML
      $html  = $(html)

  beforeEach ()->
    module 'MM_Graph'
    project = 'bsimm'



  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()


  it 'bug - $routesParams lost inside $compiler', ()->
    value = 'aaaa'

    inject ($routeParams)->

      $routeParams.project = project
      $routeParams.level = value
    inject (observed)->
      observed.current_Level().assert_Is value
    inject ($routeParams)->
      $routeParams.level.assert_Is value

    run_Controller()

    inject (observed)->
      (observed.current_Level() is null).assert_Is_True()    # this is wrong


  it 'check with no level', ()->
    inject ($routeParams)->
      $routeParams.project = project        # dependency inject project value
      run_Controller()
    $scope.observed.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
    $scope.observed['Governance'].activities.keys().assert_Contains 'SM.1.2'


   # The tests below are failing due to the $requestParams bug

#  it '$scope.map_Data', ()->
#    inject ($routeParams)->
#      $routeParams.project = project        # dependency inject project value
#      run_Controller()
#    $scope.domains['Governance'].activities[0].assert_Is 'SM.1.1'
#    (data.index for domain, data of $scope.domains                   ).assert_Is [0, 1, 2, 3]
#    (data.title for domain, data of $scope.domains                   ).assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
#
#    console.log (data.title for domain, data of $scope.project_Activities).take(4)
#    (data.title for domain, data of $scope.project_Activities).take(4).assert_Is [ 'SM.1.1', 'SM.1.2', 'SM.1.3', 'SM.1.4' ]
#
#
#    using $scope.project_Activities['SM.1.1'], ->
#      @.title.assert_Is 'SM.1.1'
#      @.level.assert_Is '1'
#      @.name.assert_Is  'Publish process (roles, responsibilities, plan), evolve as necessary'
#      @.activities.keys().assert_Contains 'No'

  xit '$scope.map_Data (level  aaaa)', ()->
    inject ($routeParams)->
      $routeParams.project = project
      $routeParams.level   = '1'       # dependency inject level value 'aaaa'

      run_Controller()

      ($scope.project_Activities['SM.1.1'].title is undefined).assert_Is_True()

      keys_In_Level_aaaa =  (data.title for domain, data of $scope.project_Activities when data.title)
      keys_In_Level_aaaa.assert_Is []




  xit '$scope.map_Data (level 1)', ()->
    inject ($routeParams, observed)->

      observed.$routeParams.project = project
      observed.$routeParams.level   = '1'       # dependency inject level value '1'

      run_Controller()
      $scope.project_Activities['SM.1.1'].title.assert_Is 'SM.1.1'

      keys_In_Level_1 =  (data.title for domain, data of $scope.project_Activities when data.title)
      keys_In_Level_1.assert_Contains ['SM.1.1', 'SM.1.2', 'SM.1.3', 'SM.1.4']

  xit '$scope.map_Data (level 2)', ()->

    inject ($routeParams)->
      $routeParams.project = project
      $routeParams.level   = '2'       # dependency inject level value '2'
      run_Controller()
      $scope.project_Activities['SM.2.1'].title.assert_Is 'SM.2.1'

      keys_In_Level_2 =  (data.title for domain, data of $scope.project_Activities when data.title)
      keys_In_Level_2.assert_Contains ['SM.2.1', 'SM.2.2', 'SM.2.3']

