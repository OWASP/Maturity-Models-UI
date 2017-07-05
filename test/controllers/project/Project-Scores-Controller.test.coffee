describe 'controllers | project | Project-Scores', ->

  $scope  = null
  project = null
  level   = null
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    project = 'bsimm'
    
    inject ($controller, $rootScope, $httpBackend, $routeParams)->
      $routeParams.project = project
      $routeParams.level   = level
      
      $scope = $rootScope.$new()
      $controller('ProjectScoresController', { $routeParams: $routeParams, $scope: $scope })

      $httpBackend.flush()

  it 'constructor',->
    using $scope, ->
      @.project.assert_Is 'bsimm'
      @.data['team-A'].level_1.assert_Is { value: 25, percentage: '64%', activities: 39, color: 'green' }
      @.data['team-A'].level_2.assert_Is { value: 23, percentage: '57%', activities: 40, color: 'green' }
      @.data['team-A'].level_3.assert_Is { value: 8 , percentage: '24%', activities: 33, color: 'orange'}
       
  it '$scope.get_Style', ->
    $scope.get_Style().assert_Is 'green'

  it '$scope.map_Colors', ->
    test_Colors = (level_1, color_1 , level_2, color_2, level_3, color_3) ->
      data = team_xyz: level_1 : { value: level_1 }, level_2 : { value: level_2 } , level_3 : { value: level_3 }
      $scope.map_Colors data
      data.team_xyz.assert_Is { level_1: { value: level_1, color: color_1 }, level_2: { value: level_2, color: color_2 },  level_3: { value: level_3, color: color_3 } }

    test_Colors 0 , 'black'   , 0 , 'black' , 0 , 'black'
    test_Colors 1 , 'red'     , 12, 'green' , 0 , 'black'
    test_Colors 1 , 'red'     , 1 ,  'red'  , 1 , 'red'
    test_Colors 10, 'orange'  , 12, 'green' , 0 , 'black'
    test_Colors 11, 'orange'  , 11, 'orange', 0 , 'black'
    test_Colors 11, 'orange'  , 11, 'orange', 10, 'orange'
    test_Colors 11, 'orange'  , 19, 'green' , 0 , 'black'
    test_Colors 13, 'green'   , 20, 'green' , 50, 'green'


  it 'bug: $scope.map_Colors does nothing with level_1 value is 0', ->
    data =
      team_xyz:
        level_1 : 0

    $scope.map_Colors data

    data.assert_Is { team_xyz: { level_1: 0 } }
