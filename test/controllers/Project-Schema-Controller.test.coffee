describe 'controllers | Project-Schema', ->

  $scope  = null
  project = null
  level   = null
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    project = 'bsimm'
    
    inject ($controller, $rootScope, $httpBackend)->
      $routeParams = project:project , level:level
      
      $scope = $rootScope.$new()
      $controller('ProjectSchemaController', { $routeParams: $routeParams, $scope: $scope })

      $httpBackend.flush()

  it 'constructor',->
    #inject ($httpBackend)->
      #scope.projects[1].assert_Is '/b'
      #scope.projects.assert_Is ['/','/b']
    using $scope, ->
      @.project.assert_Is 'bsimm'
      (@.level is null).assert_Is_True() 
      
      #@.total.assert_Is 3  # wrong value
      
      @.data.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
      @.rows.length.assert_Is 112
      
      #console.log @.rows[0][2]
#      console.log @.rows[1]
#      console.log @.rows[2]
#      console.log @.rows[3]

      @.rows[0][0].assert_Is value: 'Governance'        , rowspan: 34, id: 'Governance'
      @.rows[0][1].assert_Is value: 'Strategy & Metrics', rowspan: 11, id: 'SM'
      @.rows[0][2].assert_Is value: 'SM.1.1'                         , id: 'SM.1.1'
      
      
      
      