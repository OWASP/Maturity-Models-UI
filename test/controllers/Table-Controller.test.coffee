angular.module('MM_Graph').run ($httpBackend)-> $httpBackend.whenGET('/api/v1/data/bsimm/team-A/score').respond {"level_1":{"value":17.2,"percentage":"64%","activities":27},"level_2":{"value":14,"percentage":"61%","activities":23},"level_3":{"value":3.8,"percentage":"42%","activities":9}}

describe 'controllers | Table-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      #data_Schema = test_Data.bsimm_Schema
      #data_Team_A = test_Data.bsimm_Team
      data_Scores = {}                                                       # Issue-89: Add scores to test_Data service
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TableController', { $scope: $scope, $routeParams : routeParams })
      #$httpBackend.expectGET("/api/v1/project/schema/#{project}"             ).respond data_Schema
      #$httpBackend.expectGET("/api/v1/data/#{project}/#{team}/score"         ).respond data_Scores
      #$httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty"    ).respond data_Team_A
      $httpBackend.flush()

  it '$controller',->
    using $scope, ->
      @.project.assert_Is project
      @.team   .assert_Is team
      @.schema.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
      @.data.metadata.team.assert_Is 'Team A'


  it '$scope.map_Rows (BROKEN)', ->   # todo - fix this broken test
    using $scope, ->
      using @.map_Rows(), ->
        @.size() .assert_Is 0
        #@.first().assert_Is [ 'Governance', '', 'SM.1.1', '1', 'Is there a formal SDL (Software Development Lifecycle) used?', true, false,false, false , '']