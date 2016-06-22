describe 'views | project.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys()
                    .assert_Contains 'pages/project.page.html'
      html = $templateCache.get      'pages/project.page.html'

  it 'check raw template value',->
    #console.log html
    using $(html), ->
      @.find('#project' ).text()                 .assert_Is 'Project {{project}}{{team}}'
      @.find('#project' ).attr('ng-controller')  .assert_Is 'ProjectController'
      @.find('div'      ).length                 .assert_Is 3
      @.find('h4'       ).text()                 .assert_Is 'Project {{project}}'
      @.find('li'       ).eq(0).attr('ng-repeat').assert_Is '(key, team) in teams.sort()'
      @.find('a'        ).eq(0).attr('href')     .assert_Is 'view/{{project}}/{{team}}'
      @.find('a'        ).eq(0).html()           .assert_Is '{{team}}'


  it 'check with Controller', ->
      inject ($compile, $rootScope, $routeParams, $httpBackend)->

        $routeParams.project = 'demo'
        element = $compile(angular.element(html))($rootScope)

        $httpBackend.expectGET('/api/v1/project/get/' + $routeParams.project).respond ['team-A','team-B']
        $httpBackend.flush()

        using $(element.find('a')), ->
          @.length.assert_Is 2
          using @.eq(0), ->
            @.attr('href').assert_Is 'view/demo/team-A'
            @.html().assert_Is 'team-A'
          using @.eq(1), ->
            @.attr('href').assert_Is 'view/demo/team-B'
            @.html().assert_Is 'team-B'


