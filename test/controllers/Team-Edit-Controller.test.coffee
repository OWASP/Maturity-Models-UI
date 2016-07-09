describe 'controllers | Team-Edit-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope      = $rootScope.$new()
      routeParams = project : project , team: team      
      $controller('TeamEditController', { $scope: $scope, $routeParams : routeParams })

  it '$controller (with project and team on $routeParams)',->
    using $scope, ->
      @.messageClass.assert_Is 'secondary'
      @.status      .assert_Is 'loading team data'
      @.project     .assert_Is project
      @.team        .assert_Is team

    inject ($httpBackend)->      
      $httpBackend.flush()
      using $scope, ->
        @.status       .assert_Is 'data loaded'
        @.data.metadata.assert_Is 'team': 'Team A'
        @.metadata      .assert_Is 'team': 'Team A'
        @.schema.domains.keys().first().assert_Is 'Governance'  

        @.domains.keys().assert_Is ['Governance', 'Intelligence',  'SSDL Touchpoints', 'Deployment' ]

        @.domains['Governance'      ]['SM.1.1'].assert_Is 'Yes'
        @.domains['Intelligence'    ]['AM.1.2'].assert_Is 'Maybe'
        @.domains['SSDL Touchpoints']['AA.1.1'].assert_Is 'Yes'
        @.domains['Deployment'      ]['PT.1.1'].assert_Is 'Yes'

  it '$controller (with empty $routeParams)',->
    inject ($controller)->
      $controller('TeamEditController', { $scope: $scope, $routeParams : {} })
      $scope.status.assert_Is 'No team provided'

  it '$scope.save_Data', ->
    inject ($httpBackend)->      
      $httpBackend.flush()
      
      # test with success return value
      $scope.save_Data() 
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", $scope.data).respond status: 'ok-status'
      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'success'
        @.status .assert_Is      'ok-status'

      # test with error return value  
      $scope.save_Data()  
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", $scope.data).respond error: 'an-error'

      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'alert'
        @.status .assert_Is      'an-error'



xdescribe 'controllers | Edit-Data-Controller (SAMM data)', ->
  $scope      = null
  routeParams = null
  project     = 'samm'
  team        = 'team-E'

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope      = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('EditDataController', { $scope: $scope, $routeParams : routeParams })

  it 'should load SAMM data', ->
    inject ($httpBackend)->
      $httpBackend.flush()
      using $scope, ->
        @.domains.Governance[  'SM.1.A'].assert_Is 'Yes'
        @.domains.Construction['TA.1.A'].assert_Is 'NA'
        @.domains.Verification['DR.1.A'].assert_Is 'Maybe'
        @.domains.Operation[   'IM.1.A'].assert_Is 'NA'



