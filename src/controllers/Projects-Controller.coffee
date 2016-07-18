angular.module('MM_Graph')
  .controller 'ProjectsController', ($scope, MM_API)->
    MM_API.project_List (data)->      
      $scope.projects = data      