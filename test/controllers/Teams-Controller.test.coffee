describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope = $rootScope.$new()
      routeParams = project : project
      $controller('TeamsController', { $scope: $scope, $routeParams : routeParams })

  it '$controller',->
    using $scope, ->
      @.project     .assert_Is project

      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/team/#{project}/list").respond [ 'team-A', 'test-123']
        $httpBackend.flush()
        $scope.teams.assert_Is ['team-A']
