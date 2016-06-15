describe '| services | MM_Graph_API', ->

  mm_Graph_API  = null
  $http         = null

  beforeEach ()->
    module('MM_Graph')
    inject ($injector, $httpBackend)->
      $http = $httpBackend
      mm_Graph_API = $injector.get('MM_Graph_API')


  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  #todo: add tests for file_Get, file_List, file_Save (Issue-78)

  it 'project_List', ->
    using mm_Graph_API, ->
      $http.expectGET('/api/v1/project/list').respond ['/','/b']
      @.project_List (data)->
        data.assert_Is ['/','/b']
      $http.flush()

  it 'routes', ()->
    $http.expectGET('/api/v1/routes/list').respond ['/','/b']
    using mm_Graph_API, ->
      @.routes (data)->
        data.assert_Is ['/','/b']
      $http.flush()