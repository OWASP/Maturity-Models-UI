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
      (typeof $scope.capture_Params).assert_Is 'function'

  it 'capture_Params()',->
    using $scope, ->
      @.project     .assert_Is project
      @.team        .assert_Is team

  it 'load_data()',->
    using $scope, ->
      @.schema.keys().assert_Is [ 'domains', 'practices', 'activities' ]
      @.scores.keys().assert_Is [ 'level_1', 'level_2', 'level_3'      ]
      @.data.keys().assert_Is [ 'metadata', 'activities' ]