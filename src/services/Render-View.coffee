class Render_View
  constructor: (options, route, compile, httpBackend, location, rootScope, templateCache, routeParams)->
    @.options          = options || {}
    @.$route           = route
    @.$compile         = compile
    @.$httpBackend     = httpBackend
    @.$location        = location
    @.$rootScope       = rootScope
    @.$routeParams     = routeParams
    @.$templateCache   = templateCache
    @.project          = @.options.project || 'bsimm'
    @.team             = @.options.team    || 'team-A'
    @.$                = null    
    @.element          = null
    @.html             = null
    @.route            = null
    @.ng_View          = null
    @.scope            = null
    @.url_Template_Key = null    
    @.url_Location     = null
    @.url_Template     = null

    #@.$templateCache.put '/ui/html/directives/team-menu.html' , @.$templateCache.get('directives/team-menu.html')      # caused by the views that have a sub menu
    #@.$templateCache.put '/ui/html/directives/team-table.html', @.$templateCache.get('directives/team-table.html')

    @.set_Url_Location     @.options.url_Location
    @.set_Url_Template_Key @.options.url_Template_Key    


  run: =>
    @.scope      = @.$rootScope.$new()
    @.ng_View    = @.$compile("<div ng-view></div>")(@.scope)
    @.$location.path @.url_Location
    @.$httpBackend.flush()
    @.route      = @.$route.current
    @.element    = @.ng_View[0].nextSibling
    @.html       = @.element.innerHTML
    @.outer_Html = @.element.outerHTML
    @.$          = (selector)-> $(@.outer_Html).find(selector)    
    @.$httpBackend.verifyNoOutstandingExpectation()
    @.$httpBackend.verifyNoOutstandingRequest()
    @

  set_Expect_Get: (path, data)=>
    @.$httpBackend.expectGET(path).respond data
    @
    
  set_Url_Location: (location)=>
    if location
      @.url_Location = location
    @
    
  set_Url_Template_Key: (template_Key)=>
    if template_Key
      @.url_Template_Key = template_Key
      @.url_Template = "/ui/html/#{@.url_Template_Key}"      
    @      
    

angular.module('MM_Graph')
       .service 'Render_View', ($route, $compile, $httpBackend, $location, $rootScope, $templateCache, $routeParams)->  # todo: refactor into options object
          (options)->
            new Render_View(options, $route, $compile, $httpBackend, $location, $rootScope, $templateCache, $routeParams)