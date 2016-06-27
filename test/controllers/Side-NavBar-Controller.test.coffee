
describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'
  test_Data   = null
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('SideNavBarController', { $scope: $scope, $routeParams : routeParams })

  it '$controller',->
    using $scope, ->

      @.project     .assert_Is project
      @.team        .assert_Is team
