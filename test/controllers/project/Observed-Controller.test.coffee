describe 'controllers | project | ObservedController', ->

  $scope  = null
  project = null
  level   = null
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    project = 'bsimm'
    
    inject ($controller, $rootScope, $routeParams, $httpBackend)->
      $routeParams.project = project
      $routeParams.level   = level
      $routeParams.key     = 'SM.1.1'
      $scope = $rootScope.$new()
      $controller('ObservedController', { $scope: $scope })
      $httpBackend.flush()

  it 'constructor',->
    using $scope, ->
      @.project.assert_Is 'bsimm'
      @.observed.keys().assert_Is ['Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment']
      @.activity.key.assert_Is 'SM.1.1'

  it '$scope.page_Link',->
    $scope.page_Link().assert_Is "view/project/#{project}/observed"


  it '$scope.show_Activity', ->
    $scope.show_Activity().assert_Is_True()
    inject ($routeParams)->
      $routeParams.level = '1'
      $scope.show_Activity(         ).assert_Is_False()
      $scope.show_Activity(level:'1').assert_Is_True()
      $routeParams.level = '2'
      $scope.show_Activity(level:'1').assert_Is_False()

  it '$scope.team_Table_Link',->
    team = 'aaaaa'
    $scope.team_Table_Link(team).assert_Is "view/#{project}/#{team}/table"
