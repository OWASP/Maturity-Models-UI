describe 'views | welcome.page', ->

  options =    
    url_Location    : "/view"
    url_Template_Key: 'pages/welcome.page.html'

  view  = null
  scope = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      view  = $injector.get('Render_View')(options).run()
      scope =  view.scope.$$childHead.$$childHead.$$childHead
        
  it 'pages/view.page.html', ->     
    using view, ->
      @.$('li').length.assert_Is 3   # this is wrong, there should be list with project values
      @.$('#project').attr('ng-controller').assert_Is 'ProjectsController'
      scope.projects.assert_Is ['ASVS', 'bsimm', 'samm']

  it 'access the scope of the ProjectsController', ->  # todo: find a better way to find this
    using view, ->
      scope_1 = @.scope.$$childHead.$$childHead.$$childHead
      scope_2 = angular.element(angular.element(@.element).find('div')[1]).scope()
      scope_1.projects.assert_Is ['ASVS', 'bsimm', 'samm']
      scope_2.projects.assert_Is ['ASVS', 'bsimm', 'samm']