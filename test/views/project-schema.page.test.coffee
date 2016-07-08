describe 'views | project-schema.page', ->

  html = null
  sample_Schema = 'SM.1.1':
    level: "1",
    description: "SM.1.1 description"

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys()
                    .assert_Contains 'pages/project-schema.page.html'
      html = $templateCache.get      'pages/project-schema.page.html'
      

  it 'check raw template value',->
    using $(html), ->
      @.find('#project').text()                 .assert_Contains '{project}}'
      @.find('#project').attr('ng-controller')  .assert_Is 'ProjectSchemaController'
      @.find('div'     ).length                 .assert_Is 3
      @.find('h4'      ).text()                 .assert_Is 'Schema for Project {{project}} for level {{level}} - {{total}} activities'


  it 'check with Controller', ->

    inject ($compile, $rootScope,$routeParams, $httpBackend)->

      $routeParams.project = 'bsimm'

      element = $compile(angular.element(html))($rootScope)

      $httpBackend.expectGET('/api/v1/project/schema/bsimm').respond sample_Schema
      $httpBackend.flush()

      #$(element).find('td').length.assert_Is 3

      table_Headers = (th.innerText for th in $(element).find('th'))



