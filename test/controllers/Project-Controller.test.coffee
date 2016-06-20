
describe 'controllers | Projects', ->

  scope       = null
  routeParams = null
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      scope = $rootScope.$new()
      routeParams = target : 'demo'
      $controller('ProjectController', { $scope: scope, $routeParams : routeParams })

  it 'constructor',->
    inject ($httpBackend)->
      $httpBackend.expectGET('/api/v1/project/get/'+routeParams.target).respond ['/','/b']
      $httpBackend.flush()
      scope.target.assert_Is 'demo'
      scope.teams[1].assert_Is '/b'
      scope.teams.assert_Is ['/','/b']