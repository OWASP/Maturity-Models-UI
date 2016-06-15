angular.module('MM_Graph')
  .config ($provide)->

      $provide.decorator '$templateCache', ($delegate)->                 # adds a keys() method to $templateCache
                                                                         # (based on http://stackoverflow.com/a/37834469/262379)
        keys = []                                                        # variable to store keys added
        origPut = $delegate.put                                          # capture the original put method
        $delegate.put = (key, value)->                                   # replaced it with our own
          origPut(key, value)                                            # call original
          keys.push(key)                                                 # store value in keys variable

        $delegate.get_Keys = ()-> keys                                   # new method to return keys

        return $delegate