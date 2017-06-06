describe 'controllers | Team-Raw-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      $scope      = $rootScope.$new()
      routeParams = project : project , team: team      
      $controller('TeamMetadataController', { $scope: $scope, $routeParams : routeParams })
      $httpBackend.flush()

  xit 'check $scope values',->
    using $scope, ->
      @.project     .assert_Is project
      @.team        .assert_Is team
      @.data.metadata.team.assert_Is 'Team A'




