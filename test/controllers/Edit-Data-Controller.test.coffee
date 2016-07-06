
describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'
  bsimm_Team  = null
  samm_Team   = null
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, test_Data)->
      $scope      = $rootScope.$new()
      routeParams = project : project , team: team
      bsimm_Team  = test_Data.bsimm_Team
      samm_Team   = test_Data.samm_Team
      $controller('EditDataController', { $scope: $scope, $routeParams : routeParams })

  it '$controller (with project and team on $routeParams)',->
    using $scope, ->
      @.messageClass.assert_Is 'secondary'
      @.status      .assert_Is 'loading team data'
      @.project     .assert_Is project
      @.team        .assert_Is team

    inject ($httpBackend)->
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond bsimm_Team
      $httpBackend.flush()
      using $scope, ->
        @.status      .assert_Is 'data loaded'
        @.data_Raw    .assert_Is JSON.stringify(bsimm_Team, null, 4)
        @.data        .assert_Is bsimm_Team
        @.metadata    .assert_Is bsimm_Team.metadata
        @.domains     .assert_Is bsimm_Team.activities

        @.domains.Governance['SM.1.1']  .assert_Is 'Yes'
        @.domains.Intelligence['AM.1.2'].assert_Is 'Maybe'
        @.domains.SSDL['AA.1.1']        .assert_Is 'NA'
        @.domains.Deployment['PT.1.1']  .assert_Is 'No'

  it '$controller (with empty $routeParams)',->
    inject ($controller)->
      $controller('EditDataController', { $scope: $scope, $routeParams : {} })
      $scope.status.assert_Is 'No team provided'

  it '$scope.save_Data', ->
    inject ($httpBackend)->
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond bsimm_Team
      $httpBackend.flush()
      
      # test with success return value
      $scope.save_Data() 
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", bsimm_Team).respond status: 'ok-status'
      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'success'
        @.status .assert_Is      'ok-status'

      # test with error return value  
      $scope.save_Data()  
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", bsimm_Team).respond error: 'an-error'

      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'alert'
        @.status .assert_Is      'an-error'


  it 'should load SAMM data', ->
    inject ($httpBackend)->
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond samm_Team
      $httpBackend.flush()
      using $scope, ->
        @.domains.Governance[  'SM.1.A'].assert_Is 'Yes'
        @.domains.Construction['TA.1.A'].assert_Is 'No'
        @.domains.Verification['DR.1.A'].assert_Is 'Maybe'
        @.domains.Operation[   'IM.1.A'].assert_Is 'Yes'



