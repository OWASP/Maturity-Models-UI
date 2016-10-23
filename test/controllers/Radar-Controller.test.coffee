describe 'controllers | Radar', ->

  $scope         = null
  project        = null
  team           = null
  version        = null

  beforeEach ->
    module('MM_Graph')
    project = 'bsimm'
    team    = 'team-A'
    version = '/api/v1'

  beforeEach ->
    inject ($controller, $rootScope, $routeParams, $httpBackend)->
      $routeParams.project = project
      $routeParams.team    = team

      $scope = $rootScope.$new()
      $controller('RadarController', { $scope: $scope })

      $httpBackend.flush()

  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it '$scope.get_Radar_Config', ->
    using $scope.get_Radar_Config(), ->
      @.w       .assert_Is 450
      @.h       .assert_Is 450
      @.levels  .assert_Is 6
      @.maxValue.assert_Is 3.0
      @.color(0).assert_Is 'black'
      @.color(1).assert_Is 'orange'
      @.color(2).assert_Is 'green'
      (@.color(3) is undefined).assert_Is_True()

  it '$scope.load_Data',->
    using $scope, ->
      @.radar_Data.first().axes.first().assert_Is { axis: 'Strategy & Metrics', key: 'SM', xOffset: 1, value: 0 }
      @.radar_Data.second().axes.first().assert_Is { value: 0.75 }
      @.project   .assert_Is project
      @.team      .assert_Is team

  it '$scope.show_Radar', ->
    window.RadarChart =
      draw: (div, data, config)->
        div.assert_Is $scope.radar_Div
        data.first().axes.first().assert_Is { axis: 'Strategy & Metrics',key: 'SM', xOffset: 1, value: 0 }
        data.second().axes.first().assert_Is { value: 0.75 }
        config.levels.assert_Is 6
    $scope.radar_Div.assert_Is '.chart-container' 
    
    $scope.show_Radar()
