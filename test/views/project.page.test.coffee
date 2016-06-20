describe '| views | project.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys()
                    .assert_Contains 'pages/project.page.html'
      html = $templateCache.get      'pages/project.page.html'

  it 'check raw template value',->
    console.log html
    using $(html), ->
      @.find('#project' ).text()                 .assert_Is 'Project {{target}}{{value}}'
      @.find('#project' ).attr('ng-controller')  .assert_Is 'ProjectController'
      @.find('div'      ).length                 .assert_Is 3
      @.find('h4'       ).text()                 .assert_Is 'Project {{target}}'
      @.find('li'       ).eq(0).attr('ng-repeat').assert_Is '(key, value) in teams.sort()'
      @.find('a'        ).eq(0).attr('href')     .assert_Is 'view/{{value}}'
      @.find('a'        ).eq(0).html()           .assert_Is '{{value}}'


  it 'check with Controller', ->
      inject ($compile, $rootScope, $routeParams, $httpBackend)->

        $routeParams.target = 'demo'
        element = $compile(angular.element(html))($rootScope)

        $httpBackend.expectGET('/api/v1/project/get/' + $routeParams.target).respond ['demo','appsec']
        $httpBackend.flush()

        using $(element.find('a')), ->
          @.length.assert_Is 2
          using @.eq(0), ->
            @.attr('href').assert_Is 'view/appsec'
            @.html().assert_Is 'appsec'
          using @.eq(1), ->
            @.attr('href').assert_Is 'view/demo'
            @.html().assert_Is 'demo'


