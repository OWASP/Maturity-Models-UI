describe 'controllers | Radar', ->

  $scope         = null
  project        = null
  team           = null
  version        = null
  draw_Params    = {}

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
      $attrs = {}
      $controller('RadarController', { $scope: $scope, $attrs:$attrs })
      window.RadarChart =
        draw: (div, data, config)->                                                  # capture draw method parameters
          draw_Params['div'   ] = div
          draw_Params['data'  ] = data
          draw_Params['config'] = config
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
      @.color(1).assert_Is 'green'
      @.color(2).assert_Is 'orange'
      (@.color(3) is undefined).assert_Is_True()

  it '$scope.load_Data and show_Radar',->

    using $scope, ->
      @.radar_Div.assert_Is '.chart-container'
      @.project   .assert_Is project
      @.team      .assert_Is team

    draw_Params['div'].assert_Is '.chart-container'
    draw_Params['data'].first().axes.first().assert_Is { axis: 'SM', name: 'Strategy & Metrics', key: 'SM', xOffset: 20, value: 0 , size: 11}
    draw_Params['data'].second().axes.first().assert_Is { value: 0.4091 }
    draw_Params['config'].w.assert_Is 450