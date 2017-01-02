describe 'services | API', ->

  api     = null
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
      api = $injector.get('API')


  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  call_API = (method, params, callback)->
    api[method].apply null, params.concat(callback)
    $http.flush()


  it '_GET (ok route)', ->
    inject ($httpBackend)->
      $httpBackend.expectGET('/a/good/url').respond  status: 42
      api._GET '/a/good/url', (data, status)->
        data.assert_Is status: 42
        status.assert_Is 200
      $httpBackend.flush()

  it '_GET (bad route)', ()->
    console_Log = console.log
    console.log = (message)->                    # overwrite console.log to confirm message
      message.assert_Is "Error in request: '/a/bad/url': [object Object]"

    inject ($httpBackend)->
      $httpBackend.whenGET('/a/bad/url').respond  404, 'error'
      api._GET '/a/bad/url', (data, error, status)->
        (data is null).assert_Is_True()
        error.assert_Is 'error'
        status.assert_Is 404

        console_Log = console_Log

      $httpBackend.flush()

  it '_POST (ok route)', ->
    inject ($httpBackend)->
      post_Data = value: 42
      $httpBackend.expectPOST('/a/good/url', post_Data).respond  status: 42
      api._POST '/a/good/url', post_Data,  (data, status)->
        data.assert_Is status: 42
        status.assert_Is 200
      $httpBackend.flush()

  it '_POST (bad route)', ()->
    inject ($httpBackend)->
      post_Data = value: 42
      $httpBackend.whenPOST('/a/bad/url', post_Data).respond 404, an: 'error'

      api._POST '/a/bad/url', post_Data, (data, error, status)->
        (data is null).assert_Is_True()
        error.assert_Is an: 'error'
        status.assert_Is 404

      $httpBackend.flush()


  it 'data_Radar_Team'  , -> call_API "data_Radar_Team"  , [project, team], (data)-> data.axes.first().value.assert_Is 0.4091
  it 'data_Radar_Fields', -> call_API "data_Radar_Fields", [project      ], (data)-> data.axes.first().assert_Is { axis: 'SM', name: 'Strategy & Metrics', key: 'SM', xOffset: 20, value: 0 , size: 11}
  it 'project_Get'      , -> call_API "project_Get"      , [project      ], (data)-> data.assert_Contains ['level-1', 'level-2','level-3']
  it 'project_List'     , -> call_API "project_List"     , [             ], (data)-> data.assert_Is ['bsimm','samm']
  it 'project_Scores'   , -> call_API "project_Scores"   , [project      ], (data)-> data['team-A']['level_1'].assert_Is { value: 19.4, percentage: '50%', activities: 39 }
  it 'routes'           , -> call_API "routes"           , [             ], (data)-> data.raw.assert_Contains ['/ping']
  it 'team_Delete', ->
    inject ($httpBackend)->
      $httpBackend.expectGET("/api/v1/team/#{project}/delete/#{team}").respond { status: 'ok'}
      call_API "team_Delete", [ project,team ], (data)->
        data.assert_Is { status: 'ok'}

  it 'team_New', ->
    call_API "team_New", [ project ], (data)->
      data.status.assert_Is 'Ok'
      data.team_Name.assert_Contains 'team-'
      data.team_Name.length.assert_Is 10


  it 'Angular bug $routeParams is lost after API call', ->
    inject ($routeParams)=>
      $routeParams.project = 'bsimm'
      $routeParams.assert_Is project: 'bsimm'           # $routeParams is set
      call_API 'project_Schema', ['bsimm'], (data)=>    # make request using test API
        data.config.schema.assert_Is 'bsimm'            # confirm we got data ok
        $routeParams.assert_Is {}                       # bug: $routeParams data is lost

  it 'Angular bug $routeParams is lost after $http.get call', ->
    inject ($routeParams, $http, $httpBackend)=>
      $routeParams.project = 'bsimm'
      $routeParams.assert_Is project: 'bsimm'           # $routeParams is set
      url = '/api/v1/project/schema/bsimm'
      $http.get url                                     # make request using angular's $http object
        .then (response)->
          response.data.config.schema.assert_Is 'bsimm' # confirm we got data  ok
          $routeParams.assert_Is {}                     # bug: $routeParams data is lost

      $httpBackend.flush()