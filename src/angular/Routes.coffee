angular.module('MM_Graph')
  .config  ($routeProvider)->
    pages = '/ui/html/pages'
    $routeProvider
      .when '/view'                                 , templateUrl: "#{pages}/welcome.page.html"
      .when '/view/projects'                        , templateUrl: "#{pages}/projects.page.html"
      .when '/view/project/:project'                , templateUrl: "#{pages}/project.page.html"
      .when '/view/project/:project/schema'         , templateUrl: "#{pages}/project-schema.page.html"
      .when '/view/project/:project/schema/:level'  , templateUrl: "#{pages}/project-schema.page.html"
      .when '/view/all/radar'                       , templateUrl: "#{pages}/all-radar.page.html"
      .when '/view/routes'                          , templateUrl: "#{pages}/routes.page.html"      
      .when '/view/:project/:team'                  , templateUrl: "#{pages}/view.page.html"
      .when '/view/:project/:team/edit'             , templateUrl: "#{pages}/edit.page.html"
      .when '/view/:project/:team/radar'            , templateUrl: "#{pages}/radar.page.html"
      .when '/view/:project/:team/raw'              , templateUrl: "#{pages}/raw.page.html"
      .when '/view/:project/:team/table'            , templateUrl: "#{pages}/table.page.html"

      .otherwise templateUrl: "#{pages}/404.page.html"

    
