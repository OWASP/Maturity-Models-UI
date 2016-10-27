angular.module('MM_Graph')
  .controller 'RadarController', ($scope, $routeParams, MM_API, $attrs)->

    radar_Size  = $attrs.radarSize  || 450
    extra_Level = $attrs.extraLevel || 'level-1'
    target_Div  = $attrs.targetDiv  || '.chart-container'

    console.log extra_Level
    console.log target_Div

    $scope.radar_Div = target_Div

    $scope.get_Radar_Config = ()->
      config =
        color   : (index)-> return ['black', 'orange', 'green'][index];
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

        MM_API.data_Radar_Fields project, (data_Fields)=>
          data.push data_Fields
          MM_API.data_Radar_Team project, team,(team_Data)->
            data.push team_Data

            MM_API.data_Radar_Team project, extra_Level,(team_Data)->
              data.push team_Data

              $scope.radar_Data = data
              $scope.show_Radar data, $scope.get_Radar_Config()

    $scope.show_Radar = (data)->
      div    = $scope.radar_Div
      data   = $scope.radar_Data
      config = $scope.get_Radar_Config()

      RadarChart?.draw div, data, config


    $scope.load_Data $routeParams.project, $routeParams.team
