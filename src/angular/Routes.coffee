angular.module('MM_Graph')
  .config  ($routeProvider)->
    pages = '/ui/html/pages'
    $routeProvider
      .when '/view'                                 , templateUrl: "#{pages}/welcome.page.html"
      .when '/view/routes'                          , templateUrl: "#{pages}/routes.page.html"
      .when '/view/projects'                        , templateUrl: "#{pages}/projects.page.html"
      .when '/view/project/:project'                , templateUrl: "#{pages}/project/project.html"
      .when '/view/project/:project/new-team'       , templateUrl: "#{pages}/project/new-team.html"
      .when '/view/project/:project/scores'         , templateUrl: "#{pages}/project/scores.html"
      .when '/view/project/:project/schema'         , templateUrl: "#{pages}/project/schema.html"
      .when '/view/project/:project/schema/:level'  , templateUrl: "#{pages}/project/schema.html"
      .when '/view/:project/:team/admin'            , templateUrl: "#{pages}/team/admin.html"
      .when '/view/:project/:team/edit'             , templateUrl: "#{pages}/team/edit.html"
      .when '/view/:project/:team/radar'            , templateUrl: "#{pages}/team/radar.html"
      .when '/view/:project/:team/metadata'         , templateUrl: "#{pages}/team/metadata.html"
      .when '/view/:project/:team/raw'              , templateUrl: "#{pages}/team/raw.html"
      .when '/view/:project/:team/table'            , templateUrl: "#{pages}/team/table.html"
      .when '/view/:project/:team/table/:level'     , templateUrl: "#{pages}/team/table.html"

      .otherwise templateUrl: "#{pages}/404.page.html"

    
