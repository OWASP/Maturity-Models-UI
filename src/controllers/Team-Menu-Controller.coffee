angular.module('MM_Graph')
  .controller 'TeamMenuController', ($scope, $routeParams)->
    project          = $routeParams.project
    team             = $routeParams.team
    base_Path        = "/view/#{project}/#{team}"
    $scope.team      = team
    $scope.project   = project
    $scope.base_Path = base_Path
    $scope.links =
      [
        { text: 'view' , path: base_Path            }
        { text: 'table', path: "#{base_Path}/table" }
        { text: 'radar', path: "#{base_Path}/radar" }
        { text: 'edit' , path: "#{base_Path}/edit"  }
        { text: 'raw'  , path: "#{base_Path}/raw"   }
      ]