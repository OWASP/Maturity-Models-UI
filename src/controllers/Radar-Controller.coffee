angular.module('MM_Graph')
  .controller 'RadarController', ($scope, $routeParams, API, $attrs, team_Data)->

    radar_Size  = $attrs.radarSize  || 450
    extra_Level = $attrs.extraLevel || 'level-1'
    target_Div  = $attrs.targetDiv  || '.chart-container'

    $scope.radar_Div = target_Div

    $scope.get_Radar_Config = ()->
      config =
        color   : (index)-> return ['black', 'green', 'orange'][index];
        w       : radar_Size
        h       : radar_Size
        levels  : 6,
        maxValue: 3.0
      config       
    
    $scope.load_Data = (project, team)->  
      if project and team
        $scope.project = project
        $scope.team    = team

        data = []

        team_Data.radar_Fields (data_Fields)=>
          data.push data_Fields
          team_Data.radar_Team team, (data_Radar)->
            data.push data_Radar
            team_Data.radar_Team extra_Level, (data_Radar)->
              data.push data_Radar
              $scope.radar_Data = data
              $scope.show_Radar data, $scope.get_Radar_Config()

    $scope.show_Radar = (data)->
      div    = $scope.radar_Div
      data   = $scope.radar_Data
      config = $scope.get_Radar_Config()

      RadarChart?.draw div, data, config


    team_Data.load_Data ->
      $scope.load_Data team_Data.project, team_Data.team
