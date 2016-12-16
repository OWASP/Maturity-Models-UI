describe 'views | project.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys()
                    .assert_Contains '/ui/html/pages/project/project.html'
      html = $templateCache.get      '/ui/html/pages/project/project.html'

  it 'check raw template value',->
    #console.log html
    using $(html), ->
      @.find('#project' ).text()                 .assert_Is 'Project {{project}}schemascoresobservedTeams:{{team}}Actions:new teamclear project cache'
      @.find('#project' ).attr('ng-controller')  .assert_Is 'ProjectController'
      @.find('div'      ).length                 .assert_Is 3
      @.find('h4'       ).text()                 .assert_Is 'Project {{project}}'
      @.find('li'       ).eq(0).text().assert_Is 'schema'
      @.find('li'       ).eq(1).text().assert_Is 'scores'
      @.find('li'       ).eq(2).text().assert_Is 'observed'
      @.find('li'       ).eq(3).attr('ng-repeat').assert_Is '(key, team) in teams.sort()'
      @.find('a'        ).eq(3).attr('href')     .assert_Is 'view/{{project}}/{{team}}/table'
      @.find('a'        ).eq(3).html()           .assert_Is '{{team}}'


  it 'check with Controller', ->
    inject ($compile, $rootScope, $routeParams, $httpBackend)->

      $routeParams.project = 'demo'
      element = $compile(angular.element(html))($rootScope)

      $httpBackend.expectGET('/api/v1/project/get/' + $routeParams.project).respond ['team-A','team-B']
      $httpBackend.flush()

      console.log element.find('div').eq(0)
      console.log $(html).find('#project a').eq(0).attr('href')

      using $(element.find('a')), ->
        @.length.assert_Is 12



        check_Link = (id, link, value)=>
          using @.eq(id), ->
            @.attr('href').assert_Is link
            @.html().assert_Is value

        # projectMenu
        check_Link 0 , '/view/project/demo'                   , 'demo'
        check_Link 1 , '/view/project/demo/schema'            , 'schema'
        check_Link 2 , '/view/project/demo/scores'            , 'scores'
        check_Link 3 , '/view/project/demo/observed'          , 'observed'
        check_Link 4 , '/view/project/demo/observed-details'  , 'observed (details)'

        # other links below
        check_Link 5 , 'view/project/demo/schema'             , 'schema'
        check_Link 6 , 'view/project/demo/scores'             , 'scores'
        check_Link 7 , 'view/project/demo/observed'           , 'observed'
        check_Link 8 , 'view/demo/team-A/table'               , 'team-A'
        check_Link 9 , 'view/demo/team-B/table'               , 'team-B'
        check_Link 10, 'view/project/demo/new-team'           , 'new team'
        check_Link 11, 'api/v1/project/caches/clear'          , 'clear project cache'