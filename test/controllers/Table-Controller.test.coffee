describe 'controllers | Table-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TableController', { $scope: $scope, $routeParams : routeParams })
      $httpBackend.flush()

  it '$controller',->
    using $scope, ->
      @.project.assert_Is project
      @.team   .assert_Is team
      @.schema.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
      @.data.metadata.team.assert_Is 'Team A'

  it '$scope.map_Rows', ->
    using $scope, ->
      using @.map_Rows(), ->        
        @.size() .assert_Is $scope.schema.activities.keys().size()
        @[0].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.1', '1', 'Publish process (roles, responsibilities, plan), evolve as necessary', true , false, false, false, ''] # Yes
        @[1].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.2', '1', 'Create evangelism role and perform internal marketing'               , false, true , false ,false, ''] # NA
        @[2].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.3', '1', 'Educate executives'                                                  , false, false, true , false, ''] # Maybe
        @[3].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.4', '1', 'Identify gate locations, gather necessary artifacts'                 , false, false, false, true , ''] # No