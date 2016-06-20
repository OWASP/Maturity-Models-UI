
describe 'controllers | Projects', ->

  scope       = null
  routeParams = null
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      scope = $rootScope.$new()
      routeParams = project : 'demo'
      $controller('ProjectController', { $scope: scope, $routeParams : routeParams })

  it 'constructor',->
    inject ($httpBackend)->
      $httpBackend.expectGET('/api/v1/project/get/'+routeParams.project).respond ['/','/b']
      $httpBackend.flush()
      scope.project.assert_Is 'demo'
      scope.teams[1].assert_Is '/b'
      scope.teams.assert_Is ['/','/b']