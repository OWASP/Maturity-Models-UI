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

  it 'team_Table_Map_Rows - should filter rows based on filter value', ->
    using team_Mappings, ->

      check_Filter = (filter, size)=>
        @.team_Table_Map_Rows null, filter
        @.mappings.size().assert_Is size

      check_Filter ''      , 112
      check_Filter 'Yes'   , 29
      check_Filter 'No'    , 56
      check_Filter 'NA'    , 4
      check_Filter 'Maybe' , 23
      check_Filter 'Yes,No', 85
      check_Filter 'Yes,NA', 33
      check_Filter 'No,NA' , 60

  it 'team_Table_Map_Rows - should filter rows based on level value', ->
    using team_Mappings, ->

      check_Filter = (level, size)=>
        @.team_Table_Map_Rows level, null
        @.mappings.size().assert_Is size

      check_Filter ''     , 112
      check_Filter '1'    , 39
      check_Filter '2'    , 40
      check_Filter '3'    , 33
      check_Filter  null  , 112
      check_Filter  'aaaa', 0

  it 'team_Table_Map_Rows - when there is no team data mapping', ->
    using team_Mappings, ->
      (@.mappings is null).assert_Is_True()
      @.team_Data.schema = null
      @.team_Table_Map_Rows()
      @.team_Data.data = null
      @.team_Table_Map_Rows()
      (@.mappings is null).assert_Is_True()
