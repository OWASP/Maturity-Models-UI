describe 'controllers | Project-Schema', ->

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
      $controller('ProjectSchemaController', { $scope: $scope })
      $httpBackend.flush()

  it 'constructor',->
    using $scope, ->
      @.project.assert_Is 'bsimm'
      (@.level is null).assert_Is_True()
      @.rows.length.assert_Is 112

      @.rows[0][0].assert_Is value: 'Governance'        , rowspan: 34, id: 'Governance'
      @.rows[0][1].assert_Is value: 'Strategy & Metrics', rowspan: 11, id: 'SM'
      @.rows[0][2].assert_Is value: 'SM.1.1'                         , id: 'SM.1.1'
      
      
      
      