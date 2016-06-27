describe 'controllers | Projects', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('OldTableController', { $scope: $scope, $routeParams : routeParams })

  it '$controller',->
    using $scope, ->
      @.project     .assert_Is project
      @.team        .assert_Is team

      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/table/#{project}/#{team}").respond a: 42
        $httpBackend.flush()
        $scope.table.assert_Is a: 42
