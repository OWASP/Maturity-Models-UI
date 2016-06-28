class Render_View
  constructor: (options, route, compile, httpBackend, location, rootScope, templateCache)->
    @.options          = options || {}
    @.$route           = route
    @.$compile         = compile
    @.$httpBackend     = httpBackend
    @.$location        = location
    @.$rootScope       = rootScope
    @.$templateCache   = templateCache
    @.project          = @.options.project || 'bsimm'
    @.team             = @.options.team    || 'team-A'
    @.$                = null
    @.element          = null
    @.html             = null
    @.route            = null
    @.ng_View          = null
    @.Url_Template_Key = null
    @.url_Data         = null
    @.url_Location     = null
    @.url_Template     = null

    @.set_Url_Location     @.options.url_Location
    @.set_Url_Template_Key @.options.url_Template_Key
    @.set_Url_Data         @.options.url_Data


  run: =>    
    @.ng_View = @.$compile("<div ng-view></div>")(@.$rootScope)
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
  
  set_Url_Data: (url_Data)=>
    if url_Data and url_Data.path and url_Data.value
      @.url_Data = url_Data
      @.$httpBackend.expectGET(@.url_Data.path).respond @.url_Data.value
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
      @.$httpBackend.expectGET(@.url_Template).respond @.$templateCache.get(@.url_Template_Key)
    @      
    

angular.module('MM_Graph')
       .service 'Render_View', ($route, $compile, $httpBackend, $location, $rootScope, $templateCache)->
          (options)->
            new Render_View(options, $route, $compile, $httpBackend, $location, $rootScope, $templateCache)