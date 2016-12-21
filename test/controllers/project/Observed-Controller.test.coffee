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
      $scope = $rootScope.$new()
      $controller('ObservedController', { $scope: $scope })
      $httpBackend.flush()

  it 'constructor',->
    using $scope, ->
      @.project.assert_Is 'bsimm'
      @.observed.keys().assert_Is ['Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment']


  it '$scope.page_Link',->
    $scope.page_Link().assert_Is "view/project/#{project}/observed"

  it '$scope.team_Table_Link',->
    team = 'aaaaa'
    $scope.team_Table_Link(team).assert_Is "view/#{project}/#{team}/table"
