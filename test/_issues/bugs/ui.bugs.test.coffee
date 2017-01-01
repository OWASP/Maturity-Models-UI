describe '_issues | bugs', ->

  beforeEach ->
    module('MM_Graph')

  it 'Issue 144 - There are two Raw titles in the Routes page', ->
    inject ($injector)->
      using $injector.get('Render_View')(url_Location : "/view/routes").run(),->
        @.$('b').length.assert_Is 2
        @.$('b').eq(0).html().assert_Is 'Raw'
        @.$('b').eq(1).html().assert_Is 'Fixed'


  it '#213 - Race condition on multiple calls to Team_Data load', ->

    inject ($injector, $routeParams, $httpBackend)->
      team_Data            = $injector.get('team_Data')         # get service
      $routeParams.project = 'bsimm'                            # set project
      $routeParams.team    = 'team-A'                           # and team that have data
      sequence = 0                                              # capture execution order
      team_Data.load_Data ()->                                  # 1st call to load_Data (queues request)
        (++sequence).assert_Is 2                                # confirms this is called after the 2nd call to load_data
        #(++sequence).assert_Is 3
        team_Data.data.metadata.team.assert_Is 'Team A'         # confirm data was retrieved
      team_Data.load_Data ()->                                  # 2nd call to load_Data
        console.log (++sequence)
        (++sequence).assert_Is 4
        team_Data.data.metadata.team.assert_Is 'Team A'
        #(++sequence).assert_Is 1                                # confirm this is call first (HERE IS THE BUG)
        #(team_Data.data is null).assert_Is_True()               # confirm we get no data
        #data.assert_Is no: 'data'                               # note: this will run before the flush below
      (++sequence).assert_Is 1
      #(++sequence).assert_Is 2
      $httpBackend.flush()                                      # flush request and trigger callback to first load_Data call
      $httpBackend.verifyNoOutstandingExpectation()
      $httpBackend.verifyNoOutstandingRequest()

  it '#213 - Race condition on multiple calls to Team_Data load (using API._GET)', ->
    inject ($injector, $httpBackend)->
      api = $injector.get('API')
      url = '/api/v1/project/list'
      sequence = 0
      promise = api._GET url, (data)->
        (++sequence).assert_Is 2                                # only called after $httpBackend.flush()
        data.assert_Is ['bsimm', 'samm']
      promise.then (data)->
        (++sequence).assert_Is 3                                # called after original promise callback is invoked
        data.assert_Is ['bsimm', 'samm']
      promise.then (data)->
        (++sequence).assert_Is 4                                # confirms multiple calls to 'then' are honored
        data.assert_Is ['bsimm', 'samm']
      (++sequence).assert_Is 1
      $httpBackend.flush()                                      # flush request and trigger callback to first load_Data call
      (++sequence).assert_Is 5                                  # confirms that all 'then' have been called

  #fixed
  it 'Issue 209 - Observed controller modifies project objects',->
    inject ($controller, $rootScope, $routeParams, $httpBackend, observed)->
      $routeParams.project = 'bsimm'                                        # set project to oad
      $scope = $rootScope.$new()                                            # create a new scope
      $controller('ObservedController', { $scope: $scope })                 # create controller
      $httpBackend.flush()                                                  # trigger http calls to load project_Data

      using $scope, ->
        schema_Before     = JSON.stringify observed.project_Data.schema    # capture data after 1st execution of $scope.map_Data()
        activities_Before = JSON.stringify observed.project_Data.activities

        observed.map_Domains()                                              # call methods that map data
        observed.map_Observed                                               # one of these would cause the problem before

        schema_After      = JSON.stringify observed.project_Data.schema    # capture data after 2nd execution of $scope.map_Data()
        activities_After  = JSON.stringify observed.project_Data.activities

        schema_Before    .assert_Is     schema_After                        # confirm that schema value was not change
        activities_Before.assert_Is activities_After                        # these where not be equal (now they are)









