describe 'views | table.page', ->

  project       = 'bsimm'
  team          = 'team-A'
  #schema_Data   =
  #console.log schema_File
  options =
    project         : project
    team            : team
    #url_Data        : path: "/api/v1/table/#{project}/#{team}" , value: { metadata: 42}
    url_Location    : "/view/#{project}/#{team}/table"
    url_Template_Key: 'pages/table.page.html'

  view = null

  beforeEach ()->
    module('MM_Graph') 
    inject ($injector, test_Data)->
      view = $injector.get('Render_View')(options)
                .set_Expect_Get("/api/v1/project/schema/#{project}", test_Data.bsimm_Schema)
                .run()

  it 'pages/view.page.html', ()->

    
    #console.log view
    view.$('h1').html().assert_Is 'table will go here'
    view.route.$$route.controller.assert_Is 'TableController'
    #view.$rootScope.schema.assert_Is '{"metadata":42}'
    


    