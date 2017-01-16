angular.module('MM_Graph')
  .controller 'RadarController', ($scope, $routeParams, team_Data, $attrs)->

    radar_Size  = $attrs.radarSize  || 450
    extra_Level = $attrs.extraLevel #|| 'level-1'
    target_Div  = $attrs.targetDiv  || '.chart-container'

    $scope.radar_Div = target_Div

    $scope.get_Radar_Config = ()->
      color   : (index)-> return ['black', 'green', 'orange'][index];
      w       : radar_Size
      h       : radar_Size
      levels  : 6,
      maxValue: 3.0

    $scope.show_Radar = (data)->
      RadarChart.draw $scope.radar_Div, data, $scope.get_Radar_Config()


    team_Data.load_Data ->
      $scope.project = team_Data.project
      $scope.team    = team_Data.team

      team_Data.radar_Fields                (radar_Fields          )->
        team_Data.radar_Team   $scope.team, (radar_Team            )->
          if extra_Level
            team_Data.radar_Team extra_Level, (radar_Team_Extra_Level)->
              $scope.show_Radar [radar_Fields, radar_Team, radar_Team_Extra_Level]
          else
            $scope.show_Radar [radar_Fields, radar_Team]