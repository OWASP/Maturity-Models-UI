
describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'
  test_Data   = null
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    test_Data = metadata : 'metadata' , activities: Governance : 42, Intelligence: 43, SSDL: 44 ,Deployment: 45
    inject ($controller, $rootScope)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('EditDataController', { $scope: $scope, $routeParams : routeParams })

  it '$controller (with project and team on $routeParams)',->
    using $scope, ->
      @.messageClass.assert_Is 'secondary'
      @.status      .assert_Is 'loading team data'
      @.project     .assert_Is project
      @.team        .assert_Is team

    inject ($httpBackend)->
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond test_Data
      $httpBackend.flush()
      using $scope, ->
        @.status      .assert_Is 'data loaded'
        @.data_Raw    .assert_Is JSON.stringify(test_Data, null, 4)
        @.data        .assert_Is test_Data
        @.metadata    .assert_Is test_Data.metadata
        @.governance  .assert_Is 42
        @.intelligence.assert_Is 43
        @.ssdl        .assert_Is 44
        @.deployment  .assert_Is 45

  it '$controller (with empty $routeParams)',->
    inject ($controller)->
      $controller('EditDataController', { $scope: $scope, $routeParams : {} })
      $scope.status.assert_Is 'No team provided'

  it '$scope.save_Data', ->
    inject ($httpBackend)->
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond test_Data      
      $httpBackend.flush()
      
      # test with success return value
      $scope.save_Data() 
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", test_Data).respond status: 'ok-status'      
      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'success'
        @.status .assert_Is      'ok-status'

      # test with error return value  
      $scope.save_Data()  
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", test_Data).respond error: 'an-error'

      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'alert'
        @.status .assert_Is      'an-error'  