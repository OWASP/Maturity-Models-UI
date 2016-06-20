angular.module('MM_Graph')
  .controller 'TeamsController', ($scope, $routeParams,  MM_Graph_API)->
    project = $routeParams.project
    if project
      $scope.project = project
      MM_Graph_API.file_List project, (data)->
        teams = (name for name in data when name.contains('team'))
        $scope.teams = teams

