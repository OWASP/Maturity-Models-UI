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
                .set_Expect_Get("/api/v1/project/schema/#{project}", 'test_Data.bsimm_Schema')
                .set_Expect_Get("/api/v1/team/#{project}/get/#{team}?pretty", test_Data.team_A)
                .run()

  xit 'pages/view.page.html', ()->
    using view, ->
      @.$routeParams.assert_Is { project: 'bsimm', team: 'team-A' }      
      @.$('#teamMenu a').length.assert_Is 7
      @.$('td'         ).length.assert_Is 0





    
    
    


    