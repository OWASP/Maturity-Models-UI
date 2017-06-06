app = angular.module('MM_Graph')

class Keyboard
  constructor: ($injector)->
    @.$injector  = $injector
    @.$window    = @.$injector.get('$window')                             # get reference to $window and $rootScope objects
    @.$rootScope = @.$injector.get('$rootScope')

  on_Key_Down:($event)=>
    @.$rootScope.$broadcast 'keydown', $event                             # broadcast a global keydown event
    if $event.code is 'KeyS' and ($event.ctrlKey or $event.metaKey)       # detect S key pressed and either OSX Command or Window's Control keys pressed
      @.$rootScope.$broadcast 'keyup_CtrS', $event                        # broadcast keyup_CtrS event
     #$event.preventDefault()                                             # this should be used by the event listeners to prevent default browser behaviour

  setup_Hooks: ()=>
    angular.element(@.$window).bind "keydown", @.on_Key_Down              # hook keydown event in window (only called once per app load)
    @

app.service 'keyboard', ($injector)=>
  return new Keyboard($injector).setup_Hooks()