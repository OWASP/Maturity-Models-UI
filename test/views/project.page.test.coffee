describe 'views | project.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys()
                    .assert_Contains '/ui/html/pages/project.page.html'
      html = $templateCache.get      '/ui/html/pages/project.page.html'

  it 'check raw template value',->
    #console.log html
    using $(html), ->
      @.find('#project' ).text()                 .assert_Is 'Project {{project}}schemascoresTeams:{{team}}Actions:new team'
      @.find('#project' ).attr('ng-controller')  .assert_Is 'ProjectController'
      @.find('div'      ).length                 .assert_Is 3
      @.find('h4'       ).text()                 .assert_Is 'Project {{project}}'
      @.find('li'       ).eq(2).attr('ng-repeat').assert_Is '(key, team) in teams.sort()'
      @.find('a'        ).eq(2).attr('href')     .assert_Is 'view/{{project}}/{{team}}/table'
      @.find('a'        ).eq(2).html()           .assert_Is '{{team}}'


  it 'check with Controller', ->
      inject ($compile, $rootScope, $routeParams, $httpBackend)->

        $routeParams.project = 'demo'
        element = $compile(angular.element(html))($rootScope)

        $httpBackend.expectGET('/api/v1/project/get/' + $routeParams.project).respond ['team-A','team-B']
        $httpBackend.flush()

        using $(element.find('a')), ->
          @.length.assert_Is 5
          using @.eq(0), ->
            @.attr('href').assert_Is 'view/project/demo/schema'
            @.html().assert_Is 'schema'
          using @.eq(1), ->
            @.attr('href').assert_Is 'view/project/demo/scores'
            @.html().assert_Is 'scores'
          using @.eq(2), ->
            @.attr('href').assert_Is 'view/demo/team-A/table'
            @.html().assert_Is 'team-A'
          using @.eq(3), ->
            @.attr('href').assert_Is 'view/demo/team-B/table'
            @.html().assert_Is 'team-B'
          using @.eq(4), ->
            @.attr('href').assert_Is 'view/project/demo/new-team'
            @.html().assert_Is 'new team'


