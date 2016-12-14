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

  it '_GET (ok route)', ->
    inject ($httpBackend)->
      $httpBackend.expectGET('/a/good/url').respond  status: 42
      mm_API._GET '/a/good/url', (data, status)->
        data.assert_Is status: 42
        status.assert_Is 200
      $httpBackend.flush()

  it '_GET (bad route)', ()->
    inject ($httpBackend)->
      $httpBackend.whenGET('/a/bad/url').respond  404, an: 'error'
      mm_API._GET '/a/bad/url', (data, error, status)->
        (data is null).assert_Is_True()
        error.assert_Is an: 'error'
        status.assert_Is 404
      $httpBackend.flush()

  it '_POST (ok route)', ->
    inject ($httpBackend)->
      post_Data = value: 42
      $httpBackend.expectPOST('/a/good/url', post_Data).respond  status: 42
      mm_API._POST '/a/good/url', post_Data,  (data, status)->
        data.assert_Is status: 42
        status.assert_Is 200
      $httpBackend.flush()

  it '_POST (bad route)', ()->
    inject ($httpBackend)->
      post_Data = value: 42
      $httpBackend.whenPOST('/a/bad/url', post_Data).respond  404, an: 'error'
      mm_API._POST '/a/bad/url', post_Data, (data, error, status)->
        (data is null).assert_Is_True()
        error.assert_Is an: 'error'
        status.assert_Is 404
      $httpBackend.flush()

  it 'data_Radar_Team', ->
    using mm_API, ->
      @.data_Radar_Team project, team, (data)->
        data.axes.first().value.assert_Is 0.4091
      $http.flush()

  it 'data_Radar_Fields', ->
    using mm_API, ->
      @.data_Radar_Fields project, (data)->
        data.axes.first().assert_Is { axis: 'SM', name: 'Strategy & Metrics', key: 'SM', xOffset: 20, value: 0 , size: 11}
      $http.flush()

  it 'project_Get', ->
    using mm_API, ->
      @.project_Get project, (data)->
        data.assert_Contains ['level-1', 'level-2','level-3']
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

    it 'team_New', ->
    using mm_API, ->
      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/team/#{project}/delete/#{team}").respond { status: 'ok'}
      @.team_Delete project, team, (data)->
        data.assert_Is { status: 'ok'}
      $http.flush()