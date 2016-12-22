describe 'controllers | Team-Data-Controller', ->
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
      $routeParams.level   = 1
      #$controller('TeamDataController', { $scope: $scope})
      #$httpBackend.flush()

#  it '$controller()',->
#    inject (team_Data)->
#      using team_Data, ->
#        @.project     .assert_Is project
#        @.team        .assert_Is team
#        @.schema.keys().assert_Is [ 'config', 'metadata', 'domains', 'practices', 'activities' ]
#        @.scores.keys().assert_Is [ 'level_1', 'level_2', 'level_3'      ]
#        @.data.keys()  .assert_Is [ 'metadata', 'activities' ]
