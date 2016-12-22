describe 'services | Team-Data', ->

  team_Data     = null
  $scope        = null
  $rootScope    = null
  $httpBackend$ = null

  beforeEach ()->
    module('MM_Graph')
    inject ($injector, $httpBackend)->
      team_Data     = $injector.get('team_Data')
      $rootScope    = $injector.get('$rootScope');
      $scope        = $rootScope.$new()
      $httpBackend$ = $httpBackend

  afterEach ->
    $scope.$destroy()
    $rootScope.$destroy()
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()


  it 'constructor', ->
    using team_Data, ->
      (@.project is null).assert_Is_True()
      (@.team    is null).assert_Is_True()


  it 'load_Data (no project or team)', ->
    inject ($routeParams)=>
      using team_Data, ->
        @.load_Data =>
          (@.data is null).assert_Is_True()
          $routeParams.project = 'aaaa'
          $routeParams.team = null
          @.load_Data =>
            (@.data is null).assert_Is_True()
            $routeParams.project = null
            $routeParams.team    = 'aaaa'
            @.load_Data =>
              (@.data is null).assert_Is_True()

  it 'load_Data (valid project and team)', ->
    inject ($routeParams)=>
      $routeParams.project = 'bsimm'
      $routeParams.team    = 'team-A'
    using team_Data, ->
      @.load_Data ()=>
        @.project.assert_Is 'bsimm'
        @.team.assert_Is    'team-A'
        @.schema.keys().assert_Is [ 'config','metadata', 'domains', 'practices', 'activities' ]
        @.scores.keys().assert_Is [ 'level_1', 'level_2', 'level_3'      ]
        @.data.keys(  ).assert_Is [ 'metadata', 'activities' ]
    $httpBackend$.flush()

  it 'load_Data (non existing team)', ()->
    project = 'aaaa'
    team    = 'bbbb'
    inject ($routeParams)=>
      $routeParams.project = project
      $routeParams.team    = team
    using team_Data, ->
      @.load_Data ()=>
        @.schema.assert_Is schema: 42
        @.scores.assert_Is score : 42
        @.data  .assert_Is data  : 42

      $httpBackend$.expectGET("/api/v1/project/schema/#{project}"    ).respond  { schema: 42}
      $httpBackend$.expectGET("/api/v1/data/#{project}/#{team}/score").respond  { score : 42}
      $httpBackend$.expectGET("/api/v1/team/#{project}/get/#{team}"  ).respond  { data  : 42}
      $httpBackend$.flush()


  it 'load_Data (from cache)', ->
    inject ($routeParams)=>
      $routeParams.project = 'bsimm'
      $routeParams.team    = 'team-A'
      using team_Data, ->
        @.load_Data ()=>
          $routeParams.project = 'bsimm'                        # see https://github.com/OWASP/Maturity-Models/issues/212
          $routeParams.team    = 'team-A'                       # for reason this need to be set here again
          @.load_Data ()=>
            @.data.keys(  ).assert_Is [ 'metadata', 'activities' ]
            @.load_Data ()=>
        $httpBackend$.flush()

  # to remove
#  it 'load (valid data)', (done)->
#    project = 'bsimm'
#    team    = 'team-A'
#    using team_Data, ->
#      @.subscribe $scope, =>
#        @.project.assert_Is project
#        @.team.assert_Is team
#        @.schema.keys().assert_Is [ 'config','metadata', 'domains', 'practices', 'activities' ]
#        @.scores.keys().assert_Is [ 'level_1', 'level_2', 'level_3'      ]
#        @.data.keys(  ).assert_Is [ 'metadata', 'activities' ]
#        done()
#
#      @.load project,team
#
#      inject ($httpBackend)->
#        $httpBackend.flush()
#
#  it 'load (not existing team)', (done)->
#    project = 'aaaa'
#    team    = 'bbbb'
#    using team_Data, ->
#
#      @.subscribe $scope, =>
#        done()
#
#      @.load project,team
#
#      inject ($httpBackend)->
#        $httpBackend.expectGET("/api/v1/project/schema/#{project}").respond {}
#        $httpBackend.expectGET("/api/v1/data/#{project}/#{team}/score").respond {}
#        $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}").respond {}
#        $httpBackend.flush()
#
#  it 'load (null project or team)', ->
#    using team_Data, ->
#      @.load 'aaa', null
#      @.load null , 'bbb'
#      @.load null , null
#      (@.project is null).assert_Is_True()
#      (@.team    is null).assert_Is_True()
#
#  it 'load_From_Cache', ->
#    project = 'bsimm'
#    team    = 'team-A'
#    call_Count = 0
#    using team_Data, ->
#      @.subscribe $scope, =>
#        call_Count++
#
#        if call_Count is 1
#          @.schema.keys().assert_Is [ 'config','metadata', 'domains', 'practices', 'activities' ]
#          @.schema = {'abc': '123'}
#
#        if call_Count is 2
#          @.schema.keys().assert_Is [ 'abc']
#          @.schema = null
#
#        if call_Count is 3
#          @.schema.keys().assert_Is [ 'config','metadata', 'domains', 'practices', 'activities' ]
#          return @.$rootScope.$destroy()
#
#        @.load_From_Cache project, team
#
#      @.load_From_Cache project, team
#
#      inject ($httpBackend)->
#        $httpBackend.flush()
#
#
#  it 'notify, subscribe ', (done)->
#    using team_Data, ->
#      @.subscribe $scope, ()=>
#        done()
#      @.notify()


#  it 'regression - subscribe is not cleared (creating memory leak)', (done)->
#    count   = 0
#    project = 'bsimm'
#    team    = 'team-A'
#
#    inject ($injector)->
#      $rootScope = $injector.get('$rootScope');
#      $scope_1 = $rootScope.$new();
#      $scope_2 = $rootScope.$new();
#
#      using team_Data, ->
#        @.subscribe $scope_1, -> count++        # register a bunch of events
#        @.subscribe $scope_1, -> count++
#        @.subscribe $scope_1, -> count++
#        @.subscribe $scope_1, -> count++
#        @.subscribe $scope_1, ->
#          count.assert_Is 4                                                                   # was 8 when the bug existed
#          $scope_1.$destroy()                                                                 # destroy scope_1
#          $rootScope.$$listeners['team-data-event'].assert_Is [ null, null, null, null, null] # after destroy there are no valid listerners
#
#
#        $rootScope.$$listeners['team-data-event'].size().assert_Is 5                          # confirm that we have 5 listeners
#        $rootScope.$$listenerCount['team-data-event']   .assert_Is 5
#
#        @.load_From_Cache project, team                                                       # trigger load (and call to all subscriptions
#
#        inject ($httpBackend)->
#          $httpBackend.flush()
#          ($rootScope.$$listenerCount['team-data-event']  is undefined).assert_Is_True()      # confirm $$listenerCount is not defined (anymore)
#
#          team_Data.subscribe $scope_2, ->
#            count++
#            count.assert_Is 5                                                                 # was 9 when the bug existed
#            $scope_2.$destroy()
#            $rootScope.$$listeners['team-data-event'].size().assert_Is 1                      # again after the $destroy there should be no events
#            done()
#
#          $rootScope.$$listenerCount['team-data-event']    .assert_Is 1                       # confirm that we have a total of 2 active eventsregistrations
#          using ($rootScope.$$listeners),->
#            @['team-data-event'].size().assert_Is 6                                           # and 6 registrations
#            ((@['team-data-event'])[0] is null).assert_Is_True()                              # 1st to 5th are null
#            ((@['team-data-event'])[4] is null).assert_Is_True()
#            ((@['team-data-event'])[5] instanceof Function).assert_Is_True()                  # 6th is a function
#          team_Data.load_From_Cache project, team
#



