describe 'controllers | Project-Scores', ->

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
      $controller('ProjectScoresController', { $routeParams: $routeParams, $scope: $scope })

      $httpBackend.flush()

  xit 'constructor',->

    using $scope, ->
      @.project.assert_Is 'bsimm'
      @.data.empty.level_1.assert_Is { value: 0, percentage: '0%', activities: 38, color: 'black' }
      @.data['team-A'].level_1.assert_Is { value: 18.4, percentage: '48%', activities: 38, color: 'green' }      
      @.data['team-A'].level_2.assert_Is { value: 14.4, percentage: '35%', activities: 41, color: 'green' }
      @.data['team-A'].level_3.assert_Is { value: 4.8, percentage: '15%', activities: 33, color: 'red' }
       
  it '$scope.get_Style', ->
    $scope.get_Style().assert_Is 'green'

  it '$scope.map_Colors', ->
    test_Colors = (level_1, color_1 , level_2, color_2, level_3, color_3) ->
      data = team_xyz: level_1 : { value: level_1 }, level_2 : { value: level_2 } , level_3 : { value: level_3 }
      $scope.map_Colors data
      console.log data.team_xyz.level_3
      console.log color_3
      data.team_xyz.assert_Is { level_1: { value: level_1, color: color_1 }, level_2: { value: level_2, color: color_2 },  level_3: { value: level_3, color: color_3 } }

    test_Colors 0, 'black', 0, 'black', 50, 'green'

    data = team_xyz: level_1 : { value: 0 }, level_2 : { value: 0 } , level_3 : { value: 0 }
    $scope.map_Colors data
    data.team_xyz.assert_Is { level_1: { value: 0, color: 'black' }, level_2: { value: 0, color: 'black' },  level_3: { value: 0, color: 'black' } }



  it 'bug: $scope.map_Colors does nothing with level_1 value is 0', ->
    data =
      team_xyz:
        level_1 : 0

    $scope.map_Colors data

    data.assert_Is { team_xyz: { level_1: 0 } }
