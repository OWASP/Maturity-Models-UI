describe 'services | team | Team', ->

  project       = null
  team          = null
  team_Mappings = null
  #httpBackend   = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    team    = 'team-A'
    inject ($injector, $routeParams, $httpBackend)->
      $routeParams.project = project
      $routeParams.team    = team
      team_Mappings        = $injector.get('team_Mappings')
      team_Mappings.load_Data ->
        team_Mappings.project().assert_Is 'bsimm'
      $httpBackend.flush()

  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()


  it 'constructor', ->
    using team_Mappings, ->
      @.team_Data.constructor.name.assert_Is 'Team_Data'
      @.$routeParams.assert_Is {}                            # wrong value
      #@.$routeParams.assert_Is project : project, team : team

#      (@.activities     is null).assert_Is_True()
#      (@.domains        is null).assert_Is_True()
#      (@.observed       is null).assert_Is_True()
#      (@.schema         is null).assert_Is_True()

  it 'project', ->
    team_Mappings.project().assert_Is 'bsimm'

  it 'team', ->
    team_Mappings.team().assert_Is 'team-A'

  it 'team_Edit_Map_Domains', ->
    using team_Mappings, ->
      @.team_Edit_Map_Domains()
      @.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
