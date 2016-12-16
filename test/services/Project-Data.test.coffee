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

      $rootScope = $injector.get('$rootScope');
      $scope     = $rootScope.$new()

  afterEach ->
    $scope.$destroy()
    $rootScope.$destroy()
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it 'constructor', ->
    using project_Data, ->
      (@.project is null).assert_Is_True()
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
        @.schema.config.schema.assert_Is project

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

    inject ($httpBackend)->
      $httpBackend.flush()