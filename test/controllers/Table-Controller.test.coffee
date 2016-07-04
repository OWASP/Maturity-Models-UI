describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'
  data_Schema = null
  data_Team_A = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend, test_Data)->
      data_Schema = test_Data.bsimm_Schema
      data_Team_A = test_Data.team_A
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TableController', { $scope: $scope, $routeParams : routeParams })
      $httpBackend.expectGET("/api/v1/project/schema/#{project}"         ).respond data_Schema
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond data_Team_A
      $httpBackend.flush()

  it '$controller',->
    using $scope, ->
      @.project.assert_Is project
      @.team   .assert_Is team
      @.schema .assert_Is data_Schema
      @.data   .assert_Is data_Team_A
      @.rows.size().assert_Is 5
      @.rows[0].assert_Is [ 'Governance', '', 'SM.1.1', '1', 'Is there a formal SDL (Software Development Lifecycle) used?', true, false,false, false , '']


  it '$scope.map_Rows', ->
    using $scope, ->
      using @.map_Rows(data_Team_A, data_Schema), ->
        @.size().assert_Is 5
        @[0].assert_Is [ 'Governance', '', 'SM.1.1', '1', 'Is there a formal SDL (Software Development Lifecycle) used?', true, false,false, false , '']