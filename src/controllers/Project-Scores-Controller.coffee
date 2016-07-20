angular.module('MM_Graph')
  .controller 'ProjectScoresController', ($scope, $routeParams, MM_API)->

    project = $routeParams.project

    $scope.get_Style = ()->
      'green'

    $scope.map_Colors = (data)->
      $scope.data = data
      for team, scores of data
        console.log scores
        if scores.level_1
          if scores.level_1.value > 12
            scores.level_1.color = 'green'
          else if scores.level_1.value > 7
            scores.level_1.color = 'orange'
          else
            if scores.level_1.value is 0
              scores.level_1.color = 'black'
            else
              scores.level_1.color = 'red'

          if scores.level_2.value > 11
            scores.level_2.color = 'green'
          else if scores.level_2.value > 7
            scores.level_2.color = 'orange'
          else
            if scores.level_2.value is 0
              scores.level_2.color = 'black'
            else
              scores.level_2.color = 'red'

          if scores.level_3.value > 10
            scores.level_3.color = 'green'
          else if scores.level_3.value > 7
            scores.level_3.color = 'orange'
          else
            if scores.level_3.value is 0
              scores.level_3.color = 'black'
            else
              scores.level_3.color = 'red'

    if project
      $scope.project = project
      MM_API.project_Scores project, -> 
        $scope.map_Colors()
