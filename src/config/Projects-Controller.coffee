angular.module('MM_Graph')
  .controller 'ProjectsController', ($scope, MM_Graph_API)->
    #MM_Graph_API.routes (data)->
    #  $scope.routes = data
    $scope.test = 'project list will go here'