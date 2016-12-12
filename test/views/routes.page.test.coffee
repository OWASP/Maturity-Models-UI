describe 'views | routes.page', ->
  
  options =  
    url_Location    : "/view/routes"
    url_Template_Key: 'pages/routes.page.html'

  view = null

  beforeEach ()->
    module('MM_Graph')
    inject ($injector)-> 
      view = $injector.get('Render_View')(options).run()

  afterEach ()->
    inject ($httpBackend)->
      $httpBackend.verifyNoOutstandingExpectation()
      
  it 'pages/team/table.html', ->
    using view, ->            
      @.$('h4'      ).html(               ).assert_Is 'API methods'
      @.$('div'     ).attr('ng-controller').assert_Is 'RoutesController'

      @.$('#raw'    ).attr('id'           ).assert_Is 'raw'

      @.$('#raw a'  ).length               .assert_Is_Bigger_Than 16
      @.$('#raw a'  ).html(               ).assert_Is "/api/v1/data/:project/:team/radar"

      @.$('#fixed'  ).attr('id'           ).assert_Is 'fixed'
      @.$('#fixed a').length               .assert_Is_Bigger_Than 40
      @.$('#fixed a').html(               ).assert_Contains "/api/v1/data/"
      
      @.$('b').length.assert_Is 2
      @.$('b').eq(0).html().assert_Is 'Raw'
      @.$('b').eq(1).html().assert_Is 'Fixed'
      

    