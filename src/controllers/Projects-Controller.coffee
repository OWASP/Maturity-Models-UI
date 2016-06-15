angular.module('MM_Graph')
  .controller 'ProjectsController', ($scope, MM_Graph_API)->
    MM_Graph_API.project_List (data)->
      $scope.projects = data      