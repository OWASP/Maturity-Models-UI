describe 'services | MM-API', ->

  mm_API  = null
  $http   = null
  project = null
  team    = null
  version = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    team    = 'team-A'
    version = '/api/v1'
    inject ($injector, $httpBackend)->
      $http = $httpBackend
      mm_API = $injector.get('MM_API')


  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'data_Radar_Team', ->
    using mm_API, ->
      @.data_Radar_Team project, team, (data)->
        data.axes.first().value.assert_Is 0.75
      $http.flush()

  it 'data_Radar_Fields', ->
    using mm_API, ->
      @.data_Radar_Fields project, (data)->
        data.axes.first().assert_Is { axis: 'SM', name: 'Strategy & Metrics', key: 'SM', xOffset: 20, value: 0 }
      $http.flush()

  it 'project_List', ->
    using mm_API, ->      
      @.project_List (data)->
        data.assert_Is ['bsimm','samm']
      $http.flush()

  it 'project_Scores', ->
    using mm_API, ->
      @.project_Scores project, (data)->
        data['team-A']['level_1'].assert_Is { value: 19.4, percentage: '50%', activities: 39 }
      $http.flush()

  it 'routes', ->
    using mm_API, ->
      @.routes (data)->
        data.raw.assert_Contains ['/ping']
      $http.flush()

  it 'team_New', ->
    using mm_API, ->                      
      @.team_New project, (data)->
        data.status.assert_Is 'Ok'
        data.team_Name.assert_Contains 'team-'
        data.team_Name.length.assert_Is 10
      $http.flush()