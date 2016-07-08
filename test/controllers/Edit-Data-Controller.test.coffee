describe 'controllers | Edit-Data-Controller', ->
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
      $controller('EditDataController', { $scope: $scope, $routeParams : routeParams })

  it '$controller (with project and team on $routeParams)',->
    using $scope, ->
      @.messageClass.assert_Is 'secondary'
      @.status      .assert_Is 'loading team data'
      @.project     .assert_Is project
      @.team        .assert_Is team

    inject ($httpBackend)->      
      $httpBackend.flush()
      using $scope, ->
        @.status      .assert_Is 'data loaded'
        @.data.metadata.assert_Is 'team': 'Team A'
        @.metadata.assert_Is 'team': 'Team A'
        @.domains.keys().assert_Is ['Governance', 'Intelligence',  'SSDL', 'Deployment' ]

        @.domains.Governance[  'SM.1.1'].assert_Is 'Yes'
        @.domains.Intelligence['AM.1.2'].assert_Is 'Maybe'
        @.domains.SSDL[        'AA.1.1'].assert_Is 'Yes'
        @.domains.Deployment[  'PT.1.1'].assert_Is 'Yes'

  it '$controller (with empty $routeParams)',->
    inject ($controller)->
      $controller('EditDataController', { $scope: $scope, $routeParams : {} })
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

#todo: find why this is needed (and not being capured by
angular.module('MM_Graph').run ($httpBackend)-> $httpBackend.whenGET('/api/v1/team/samm/get/team-E').respond {"metadata":{"team":"SAMM - Team E"},"activities":{"Governance":{"SM.1.A":"Yes","SM.1.B":"No","SM.1.C":"NA","SM.2.A":"Maybe","SM.2.B":"NA","SM.2.C":"No","SM.3.A":"Yes","SM.3.B":"No","PC.1.A":"NA","PC.1.B":"Maybe","PC.2.A":"NA","PC.2.B":"No","PC.3.A":"Yes","PC.3.B":"No","EG.1.A":"NA","EG.1.B":"Maybe","EG.2.A":"NA","EG.2.B":"No","EG.3.A":"Yes","EG.3.B":"No"},"Construction":{"TA.1.A":"NA","TA.1.B":"Maybe","TA.2.A":"NA","TA.2.B":"No","TA.2.C":"Yes","TA.3.A":"No","TA.3.B":"NA","SR.1.A":"Maybe","SR.1.B":"NA","SR.2.A":"No","SR.2.B":"Yes","SR.3.A":"No","SR.3.B":"NA","SA.1.A":"Maybe","SA.1.B":"NA","SA.2.A":"No","SA.2.B":"Yes","SA.3.A":"No","SA.3.B":"NA"},"Verification":{"DR.1.A":"Maybe","DR.1.B":"NA","DR.2.A":"No","DR.2.B":"Yes","DR.3.A":"No","DR.3.B":"NA","IR.1.A":"Maybe","IR.1.B":"NA","IR.2.A":"No","IR.2.B":"Yes","IR.3.A":"No","IR.3.B":"NA","ST.1.A":"Maybe","ST.1.B":"NA","ST.1.C":"No","ST.2.A":"Yes","ST.2.B":"No","ST.3.A":"NA","ST.3.B":"Maybe"},"Operation":{"IM.1.A":"NA","IM.1.B":"No","IM.1.C":"Yes","IM.2.B":"No","IM.2.C":"NA","IM.3.A":"Maybe","IM.3.B":"NA","EH.1.A":"No","EH.1.B":"Yes","EH.2.A":"No","EH.2.B":"NA","EH.3.A":"Maybe","EH.3.B":"NA","OE.1.A":"No","OE.1.B":"Yes","OE.2.A":"No","OE.2.B":"NA","OE.3.A":"Maybe","OE.3.B":"NA"}}}
describe 'controllers | Edit-Data-Controller (SAMM data)', ->
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



