describe 'services | Project-Data', ->

  project       = null
  project_Data  = null
  $scope        = null
  $rootScope    = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    inject ($injector)->
      project_Data = $injector.get('project_Data')

  afterEach ->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'constructor', ->
    using project_Data, ->
      (@.activities     is null).assert_Is_True()
      (@.project        is null).assert_Is_True()
      (@.schema         is null).assert_Is_True()
      (@.schema_Details is null).assert_Is_True()
      (@.scores         is null).assert_Is_True()
      (@.teams          is null).assert_Is_True()
      @.API.keys().assert_Contains 'team_New'
      @.$routeParams.assert_Is {}

  it 'load_Data', ()->
    using project_Data, ->
      inject ($routeParams)->
        $routeParams.project = project

      @.$routeParams.assert_Is project: project
      @.load_Data =>
        @.project.assert_Is project
        @.activities.keys().assert_Contains('SM.1.1')
        @.scores.keys().assert_Contains('team-A')
        @.schema_Details.activities['SM.1.1'].keys().assert_Is [ 'description', 'resources', 'objective', 'proof' ]
        @.schema.config.schema.assert_Is project
        @.teams.assert_Contains ['team-A', 'team-B']

     inject ($httpBackend)->
       $httpBackend.flush()

  it 'load_Data (check cache)', ()->
    using project_Data, ->
      inject ($routeParams)->
        $routeParams.project = project
      @.load_Data =>
        @.load_Data =>
          @.project.assert_Is project

    inject ($httpBackend)->
      $httpBackend.flush()

  it 'load_Data (check project change)', ()->
    using project_Data, ->
      inject ($routeParams)->
        $routeParams.project = project
      @.load_Data =>
        inject ($routeParams)->
          $routeParams.project = 'samm'
        @.load_Data =>
          @.project.assert_Is 'samm'
          @.schema.config.schema.assert_Is 'OwaspSAMM'
          @.activities.keys().assert_Contains('SM.1.A')
          @.scores.keys().assert_Contains('team-E')
          @.teams.assert_Contains ['team-A', 'team-E']
    inject ($httpBackend)->
      $httpBackend.flush()