describe 'views | table.page', ->

  project       = 'bsimm'
  team          = 'team-A'

  options =
    project         : project
    team            : team
    url_Location    : "/view/#{project}/#{team}/table"
    url_Template_Key: 'pages/table.page.html'

  view = null

  beforeEach ()->
    module('MM_Graph') 
    inject ($injector, test_Data)->
      view = $injector.get('Render_View')(options)
                .set_Expect_Get("/api/v1/project/schema/#{project}", test_Data.bsimm_Schema)
                .set_Expect_Get("/api/v1/team/#{project}/get/#{team}?pretty", test_Data.bsimm_Schema)
                .run()

  it 'pages/view.page.html', ()->
    using view, ->

      @.$('div').first().attr('ng-controller')
                               .assert_Is 'TableController'
      #@.$('h1').html()         .assert_Is 'table will go here'
      @.$('#teamMenu a').length.assert_Is 6
      @.$routeParams           .assert_Is { project: 'bsimm', team: 'team-A' }

    #console.log view.element.scope
    scope = angular.element(view.element).scope()
    #console.log view.scope.$digest()
    view.$rootScope.$digest()
    #console.log view.$rootScope
    #console.log scope.project

    
    
    


    