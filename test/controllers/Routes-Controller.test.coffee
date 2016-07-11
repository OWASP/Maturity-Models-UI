
describe 'angular | RoutesController', ->

  scope = null

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      scope = $rootScope.$new()
      $controller('RoutesController', { $scope: scope })

  it 'constructor',->
    inject ($httpBackend)->
      $httpBackend.flush()
      scope.routes.raw  .assert_Contains '/api/v1/team/:project/get/:team'
      scope.routes.fixed.assert_Contains '/api/v1/team/bsimm/get/team-A'