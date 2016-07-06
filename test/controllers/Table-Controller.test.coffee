describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'
  data_Schema = null
  data_Team_A = null
  data_Scores = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend, test_Data)->
      data_Schema = test_Data.bsimm_Schema
      data_Team_A = test_Data.bsimm_Team
      data_Scores = {}                                                       # Issue-89: Add scores to test_Data service
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TableController', { $scope: $scope, $routeParams : routeParams })
      $httpBackend.expectGET("/api/v1/project/schema/#{project}"             ).respond data_Schema
      $httpBackend.expectGET("/api/v1/data/#{project}/#{team}/score"         ).respond data_Scores
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty"    ).respond data_Team_A
      $httpBackend.flush()

  it '$controller',->
    using $scope, ->
      @.project.assert_Is project
      @.team   .assert_Is team
      @.schema .assert_Is data_Schema
      @.data   .assert_Is data_Team_A


  it '$scope.map_Rows', ->
    using $scope, ->
      using @.map_Rows(), ->
        @.size() .assert_Is 5
        @.first().assert_Is [ 'Governance', '', 'SM.1.1', '1', 'Is there a formal SDL (Software Development Lifecycle) used?', true, false,false, false , '']      