describe 'services | project | Observed', ->

  project      = null
  observed     = null
  httpBackend  = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    inject ($injector, $routeParams, $httpBackend)->
      observed = $injector.get('observed')
      $routeParams.project = project
      httpBackend          = $httpBackend

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()


  it 'constructor', ->
    using observed, ->
      @.project_Data.constructor.name.assert_Is 'Project_Data'
      @.$routeParams.assert_Is project : project
      (@.activities     is null).assert_Is_True()
      (@.domains        is null).assert_Is_True()
      (@.observed       is null).assert_Is_True()
      (@.schema         is null).assert_Is_True()


  it 'current_Level', ->
    using observed, ->
      (@.current_Level() is null).assert_Is_True()
      @.$routeParams.level = 'abc'
      @.current_Level().assert_Is 'abc'

  it 'map_Activities', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Data()
        @.activities.first().key.assert_Is 'SM.1.1'
    httpBackend.flush()

  it 'map_Observed', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Domains()
         .map_Observed()

        @.observed.keys().assert_Is  [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]

    httpBackend.flush()

  it 'map_Domains', ->
    using observed, ->
      @.project_Data.load_Data =>
          @.map_Domains()
           .domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]


    httpBackend.flush()

