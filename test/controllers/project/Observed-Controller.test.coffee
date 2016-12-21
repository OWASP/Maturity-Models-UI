describe 'controllers | project | ObservedController', ->

  $scope  = null
  project = null
  level   = null
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    project = 'bsimm'
    
    inject ($controller, $rootScope, $routeParams, $httpBackend)->
      $routeParams.project = project
      $routeParams.level   = level
      $scope = $rootScope.$new()
      $controller('ObservedController', { $scope: $scope })
      $httpBackend.flush()

  it 'constructor',->
    using $scope, ->
      @.project.assert_Is 'bsimm'
      @.observed.keys().assert_Is ['Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment']


