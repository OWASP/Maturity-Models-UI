describe '| angular | Patches ', ->

  beforeEach ()->
    module('MM_Graph')

  it '$templateCache.get_Keys',->
    inject ($templateCache)->
      test_Key   = 'an_Key'
      test_Value = 'an_Value'
      
      using $templateCache, ()->
        @.keys().assert_Is [ 'put'    , 'get'  , 'remove', 'removeAll',   
                             'destroy', 'info' , 'get_Keys'           ] # confirm method was added to object
        
        @.get_Keys().size().assert_Is $templateCache.info().size        # check get_Keys size
        @.get_Keys().assert_Not_Contains test_Key                       # confirm test key is not there
        
        @.put test_Key, test_Value                                      # add a new key/value pair
        
        @.get_Keys().assert_Contains test_Key                           # confirm that test key is now there
        
        @.get(test_Key).assert_Is test_Value                            # confirm that test value is now mapped to test key

        @.get_Keys().size().assert_Is $templateCache.info().size        # double check that this still works ok