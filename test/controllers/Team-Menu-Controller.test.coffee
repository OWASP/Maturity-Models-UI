describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TeamMenuController', { $scope: $scope, $routeParams : routeParams })

  it '$controller',->
    using $scope, ->

      @.project     .assert_Is project
      @.team        .assert_Is team
