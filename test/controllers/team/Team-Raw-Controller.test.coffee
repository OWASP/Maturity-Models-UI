describe 'controllers | Team-Raw-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend, $routeParams)->
      $scope      = $rootScope.$new()
      $routeParams.project = project
      $routeParams.team    = team
      $controller('TeamRawController', { $scope: $scope})
      $httpBackend.flush()

  it 'check $scope values',->
    using $scope, ->
      @.project     .assert_Is project
      @.team        .assert_Is team
      @.raw_Data.metadata.team.assert_Is 'Team A'
      @.data.assert_Contains '"team": "Team A"'


  it '$scope.map_Activities', ->
    using $scope, ->
      @.activities.assert_Contains 'SM.1.1'
                  .assert_Contains 'SM.2.2'
                  .assert_Contains 'CP.3.2'
                  .assert_Contains 'Level 2'
                  .assert_Contains 'Level 3'

      @.activities.split('\n').first().assert_Is 'Level 1'



