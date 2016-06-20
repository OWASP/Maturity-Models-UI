angular.module('MM_Graph')
  .config  ($routeProvider)->
    $routeProvider
      .when '/view'                                 , templateUrl:'/ui/html/pages/welcome.page.html'
      .when '/view/projects'                        , templateUrl:'/ui/html/pages/projects.page.html'
      .when '/view/project/:project'                , templateUrl:'/ui/html/pages/project.page.html'
      .when '/view/project/:project/schema'         , templateUrl:'/ui/html/pages/project-schema.page.html'
      .when '/view/project/:project/schema/:level'  , templateUrl:'/ui/html/pages/project-schema.page.html'
      .when '/view/all/radar'                       , templateUrl:'/ui/html/pages/all-radar.page.html'
      .when '/view/routes'                          , templateUrl:'/ui/html/pages/routes.page.html'
      .when '/view/:project/teams'                  , templateUrl:'/ui/html/pages/teams.page.html'
      .when '/view/:project/:team'                  , templateUrl:'/ui/html/pages/view.page.html'
      .when '/view/:project/:team/edit'             , templateUrl:'/ui/html/pages/edit.page.html'
      .when '/view/:project/:team/raw'              , templateUrl:'/ui/html/pages/raw.page.html'

      .otherwise templateUrl:'/ui/html/pages/404.page.html'

