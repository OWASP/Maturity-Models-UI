describe '_issues | bugs', ->

  beforeEach ->
    module('MM_Graph')

  it 'Issues 144 - There are two Raw titles in the Routes page', ->
    inject ($injector)->
      using $injector.get('Render_View')(url_Location : "/view/routes").run(),->
        @.$('b').length.assert_Is 2
        @.$('b').eq(0).html().assert_Is 'Raw'
        @.$('b').eq(1).html().assert_Is 'Fixed'


  #fixed
  it 'Issue 209 - Observed controller modifies project objects',->
    inject ($controller, $rootScope, $routeParams, $httpBackend, observed)->
      $routeParams.project = 'bsimm'                            # set project to oad
      $scope = $rootScope.$new()                                # create a new scope
      $controller('ObservedController', { $scope: $scope })     # create controller
      $httpBackend.flush()                                      # trigger http calls to load project_Data

      using $scope, ->
        schema_Before     = JSON.stringify @.schema             # capture data after 1st execution of $scope.map_Data()
        activities_Before = JSON.stringify @.project_Activities


        observed.map_Domains()                                  # call 3 methods that map data
        observed.map_Observed                                   # one of these would cause the problem before
        observed.get_Observed_By_Id()

        schema_After      = JSON.stringify @.schema             # capture data after 2nd execution of $scope.map_Data()
        activities_After  = JSON.stringify @.project_Activities

        schema_Before    .assert_Is     schema_After            # confirm that schema value was not change
        activities_Before.assert_Is activities_After            # these where not be equal (now they are)









