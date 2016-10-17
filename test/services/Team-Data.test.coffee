describe 'services | Team-Data', ->

  team_Data  = null
  #project = null
  #team    = null
  version = null

  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      team_Data = $injector.get('Team_Data')


  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'constructor', ->
    using team_Data, ->
      (@.project is null).assert_Is_True()
      (@.team    is null).assert_Is_True()

  it 'load (valid data)', ->
    project = 'bsimm'
    team    = 'team-A'
    using team_Data, ->
      @.load project,team, =>
        @.project.assert_Is project
        @.team.assert_Is team
        @.schema.keys().assert_Is [ 'domains', 'practices', 'activities' ]
        @.scores.keys().assert_Is [ 'level_1', 'level_2', 'level_3'      ]
        @.data.keys().assert_Is [ 'metadata', 'activities' ]

      inject ($httpBackend)->
        $httpBackend.flush()

  it 'load (not existing team)', ->
    project = 'aaaa'
    team    = 'bbbb'
    using team_Data, ->
      @.load project,team, ->
        console.log '....'

      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/project/schema/#{project}").respond {}
        $httpBackend.expectGET("/api/v1/data/#{project}/#{team}/score").respond {}
        $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}").respond {}
        $httpBackend.flush()

  it 'load (null project or team)', ->
    using team_Data, ->
      @.load 'aaa',null, =>
        @.load null, 'bbb', =>
          @.load null,null, =>
            (@.project is null).assert_Is_True()
            (@.team    is null).assert_Is_True()