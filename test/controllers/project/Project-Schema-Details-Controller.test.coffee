describe 'controllers | project | Project-Schema-Details-Controller', ->

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
      $controller('ProjectSchemaDetailsController', { $scope: $scope })
      $httpBackend.flush()

  it 'constructor',->
    using $scope, ->
      @.project.assert_Is 'bsimm'
      @.rows.length.assert_Is 112
      @.rows[0][0].assert_Is 'Governance'
      @.rows[0][1].assert_Is 'Strategy & Metrics'