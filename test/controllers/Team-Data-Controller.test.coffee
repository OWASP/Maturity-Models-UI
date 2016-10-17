describe 'controllers | Team-Data-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      $scope      = $rootScope.$new()
      routeParams = project : project , team: team , level: 1
      $controller('TeamDataController', { $scope: $scope, $routeParams : routeParams })
      $httpBackend.flush()

  it '$controller()',->
    inject (Team_Data)->
      using Team_Data, ->
        @.project     .assert_Is project
        @.team        .assert_Is team
        @.schema.keys().assert_Is [ 'domains', 'practices', 'activities' ]
        @.scores.keys().assert_Is [ 'level_1', 'level_2', 'level_3'      ]
        @.data.keys().assert_Is [ 'metadata', 'activities' ]
