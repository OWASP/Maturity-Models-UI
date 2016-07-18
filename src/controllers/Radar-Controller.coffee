angular.module('MM_Graph')
  .controller 'RadarController', ($scope, $routeParams, MM_API)->
    $scope.radar_Div = '.chart-container'

    $scope.get_Radar_Config = ()->
      config =
        color   : (index)-> return ['black', 'orange', 'green'][index];
        w       : 450,
        h       : 450,
        levels  : 6,
        maxValue: 3.0
      config       
    
    $scope.load_Data = (project, team)->  
      if project and team
        $scope.project = project
        $scope.team    = team
  
        MM_API.data_Radar project, team,(data)->
          $scope.radar_Data = data
          $scope.show_Radar data, $scope.get_Radar_Config()

    $scope.show_Radar = (data, config)->
      div    = $scope.radar_Div
      data   = $scope.radar_Data
      config = $scope.get_Radar_Config()

      RadarChart?.draw div, data, config

    $scope.load_Data $routeParams.project, $routeParams.team
  