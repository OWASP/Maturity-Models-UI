angular.module('MM_Graph')
  .controller 'ProjectsController', ($scope, API)->
    API.project_List (data)->
      $scope.projects = data      