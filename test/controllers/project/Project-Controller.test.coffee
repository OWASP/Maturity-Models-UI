describe 'controllers | project | Project', ->

  scope       = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->   
    inject ($controller, $rootScope, $routeParams)->
      scope = $rootScope.$new()
      $routeParams.project = 'demo'
      $controller('ProjectController', { $scope: scope})

  it 'constructor',->
    inject ($httpBackend)->
      $httpBackend.expectGET('/api/v1/project/get/demo'       ).respond ['/','/b']
      $httpBackend.expectGET('/api/v1/project/schema/demo'    ).respond ['/','/b']
      $httpBackend.expectGET('/api/v1/project/activities/demo').respond ['/','/b']
      $httpBackend.expectGET('/api/v1/project/scores/demo'    ).respond ['/','/b']
      $httpBackend.flush()
      scope.project.assert_Is 'demo'
      scope.teams[1].assert_Is '/b'
      scope.teams.assert_Is ['/','/b']