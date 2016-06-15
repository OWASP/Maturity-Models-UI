
describe 'controllers | Projects', ->

  scope = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      scope = $rootScope.$new()
      $controller('ProjectsController', { $scope: scope })

  it 'constructor',->
    inject ($httpBackend)->
      $httpBackend.expectGET('/api/v1/project/list').respond ['/','/b']
      $httpBackend.flush()
      scope.projects[1].assert_Is '/b'
      scope.projects.assert_Is ['/','/b']