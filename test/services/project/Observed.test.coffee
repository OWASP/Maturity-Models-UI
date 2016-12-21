describe 'services | project | Observed', ->

  project   = null
  observed  = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    inject ($injector, $routeParams)->
      observed = $injector.get('observed')
      $routeParams.project = project

  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()


  it 'constructor', ->
    using observed, ->
      @.project_Data.constructor.name.assert_Is 'Project_Data'
      @.$routeParams.assert_Is project : project
      (@.domains        is null).assert_Is_True()
      (@.observed       is null).assert_Is_True()
      (@.observed_By_Id is null).assert_Is_True()
      (@.schema         is null).assert_Is_True()


  it 'current_Level', ->
    using observed, ->
      (@.current_Level() is null).assert_Is_True()
      @.$routeParams.level = 'abc'
      @.current_Level().assert_Is 'abc'

  it 'get_Observed_By_Id', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Domains()
         .map_Observed()
         .map_Observed_By_Id()
        @.observed_By_Id.first().title.assert_Is 'SM.1.1'

    inject ($httpBackend)=>
      $httpBackend.flush()

  it 'filter_By_Level', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Domains()
         .map_Observed()
         .map_Observed_By_Id()
        @.filter_By_Level '1'

    inject ($httpBackend)=>
      $httpBackend.flush()

  it 'map_Observed', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Domains()
         .map_Observed()

        @.observed.keys().assert_Is  [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]

    inject ($httpBackend)=>
      $httpBackend.flush()

  it 'map_Domains', ->
    using observed, ->
      @.project_Data.load_Data =>
          @.map_Domains()
           .domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]


    inject ($httpBackend)=>
      $httpBackend.flush()

