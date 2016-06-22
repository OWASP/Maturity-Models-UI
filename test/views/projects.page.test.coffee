describe 'views | projects.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys()
                    .assert_Contains 'pages/projects.page.html'
      html = $templateCache.get      'pages/projects.page.html'

  it 'check raw template value',->
    using $(html), ->
      @.find('#projects').text()                 .assert_Is 'Projects{{value}}    , see schema'
      @.find('#projects').attr('ng-controller')  .assert_Is 'ProjectsController'
      @.find('div'      ).length                 .assert_Is 3
      @.find('h4'       ).text()                 .assert_Is 'Projects'
      @.find('li'       ).eq(0).attr('ng-repeat').assert_Is '(key, value) in projects.sort()'
      @.find('a'        ).eq(0).attr('href')     .assert_Is 'view/project/{{value}}'
      @.find('a'        ).eq(0).html()           .assert_Is '{{value}}'


  it 'check with Controller', ->
      inject ($compile, $rootScope,$httpBackend)->

        element = $compile(angular.element(html))($rootScope)

        $httpBackend.expectGET('/api/v1/project/list').respond ['demo','appsec']
        $httpBackend.flush()

        using $(element.find('a')), ->
          @.length.assert_Is 4
          using @.eq(0), ->
            @.attr('href').assert_Is 'view/project/appsec'
            @.html().assert_Is 'appsec'
          using @.eq(1), ->
            @.attr('href').assert_Is 'view/project/appsec/schema'
            @.html().assert_Is 'schema'
          using @.eq(2), ->
            @.attr('href').assert_Is 'view/project/demo'
            @.html().assert_Is 'demo'
          using @.eq(3), ->
            @.attr('href').assert_Is 'view/project/demo/schema'
            @.html().assert_Is 'schema'            


