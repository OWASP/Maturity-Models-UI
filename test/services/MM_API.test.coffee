describe 'services | MM_API', ->

  mm_Graph_API  = null
  $http         = null
  project       = null
  team          = null
  version       = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    team    = 'team-A'
    version = '/api/v1'
    inject ($injector, $httpBackend)->
      $http = $httpBackend
      mm_Graph_API = $injector.get('MM_API')


  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'data_Radar', ->
    expected_Data = [ { "axes": []}]
    using mm_Graph_API, ->
      $http.expectGET("#{version}/data/#{project}/#{team}/radar").respond expected_Data
      @.data_Radar project, team, (data)->
        data.assert_Is expected_Data
      $http.flush()

  it 'project_List', ->
    using mm_Graph_API, ->      
      @.project_List (data)->
        data.assert_Is ['bsimm','samm']
      $http.flush()

  it 'routes', ()->    
    using mm_Graph_API, ->
      @.routes (data)->
        data.raw.assert_Contains ['/ping']
      $http.flush()