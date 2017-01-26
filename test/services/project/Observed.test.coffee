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

  it 'activity_For_Key', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Data()

        @.activity_For_Key('SM.1.1').keys().assert_Is [ 'key', 'level', 'name', 'description', 'objective',
                                                        'proof', 'observed', 'Yes', 'No', 'Maybe', 'NA' ]
        using @.activity_For_Key('SM.1.1'), ->
          @.key         .assert_Is 'SM.1.1'
          @.level       .assert_Is '1'
          @.name        .assert_Is 'Publish process (roles, responsibilities, plan), evolve as necessary'
          @.description .assert_Is 'The process for addressing software security is broadcast to all stakeholders so that everyone knows the plan. Goals, roles, responsibilities, and activities are explicitly defined. Most organizations pick and choose from a published methodology, such as the Microsoft SDL or the Cigital Touchpoints, and then tailor the methodology to their needs. An SSDL process must be adapted to the specifics of the development process it governs (e.g., waterfall, agile, etc) and evolves both with the organization and the security landscape. A process must be published to count. In many cases, the methodology is published only internally and is controlled by the SSG. The SSDL does not need to be publicly promoted outside of the firm to have the desired impact.'
          @.objective   .assert_Is 'make the plan explicit '
          @.proof       .assert_Is 'Details should be published on wiki (provide link as proof)'
          @.observed    .assert_Is 4
          #@.Yes         .assert_Is [ 'team-A', 'team-B', 'team-C' ]
          @.No          .assert_Is [ 'save-test' ]
          @.Maybe       .assert_Is []
          @.NA          .assert_Is []

        @.activity_For_Key(null)
          .assert_Is {}
      httpBackend.flush()


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

  it 'map_Observed (check domain activity mappings)',->
    using observed, ->
      @.project_Data = schema: { activities: 'an_key': {} }, activities: 'an_key': {}
      @.domains      = 'domain' : [ 'an_key' ]
      @.map_Observed()
      @.observed['domain'].activities.assert_Is {  an_key: {
          key         : 'an_key',
          level       : 0       ,
          name        : ''      ,
          description : ''      ,
          objective   : ''      ,
          proof       : ''      ,
          observed    : 0       ,
          No          : []      ,
          Yes         : []      ,
          Maybe       : []      ,
          NA          : []    } }


  it 'map_Domains', ->
    using observed, ->
      @.project_Data.load_Data =>
          @.map_Domains()
           .domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]


    httpBackend.flush()

  it 'proofs_For_Activity', ->
    using observed, ->
      @.project_Data.load_Data =>
        @.map_Data()
        activity = @.activity_For_Key('SM.1.1')
        @.proofs_For_Activity activity, (proofs)->
          proofs['level-1'].assert_Is { value: 'Yes', proof: '' }

    httpBackend.flush()