angular.module('MM_Graph')
  .controller 'TeamMenuController', ($scope, $routeParams, $location)->
    project          = $routeParams.project
    team             = $routeParams.team
    base_Path        = "/view/#{project}/#{team}"
    $scope.team      = team
    $scope.project   = project
    $scope.base_Path = base_Path

    $scope.is_Active = (text)->
      if text is 'view' and base_Path is $location.url()
        return 'active'
      if "#{base_Path}/#{text}" is $location.url()
        return 'active'
      return ''
      
    $scope.links =
      [
        { text: 'radar'      , path: "#{base_Path}/radar"             , class: $scope.is_Active('radar'      )}
        { text: 'table'      , path: "#{base_Path}/table"             , class: $scope.is_Active('table'      )}
        { text: 'yes answers', path: "#{base_Path}/yes-answers"       , class: $scope.is_Active('yes-answers')}
        { text: 'edit'       , path: "#{base_Path}/edit"              , class: $scope.is_Active('edit'       )}
        { text: 'metadata'   , path: "#{base_Path}/metadata"          , class: $scope.is_Active('metadata'   )}
        { text: 'raw'        , path: "#{base_Path}/raw"               , class: $scope.is_Active('raw'        )}
        { text: 'admin'      , path: "#{base_Path}/admin"             , class: $scope.is_Active('admin'      )}
      ]