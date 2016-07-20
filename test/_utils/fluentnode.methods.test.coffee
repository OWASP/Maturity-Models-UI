describe '_utils | fluentnode - methods', ->

  it 'Array::contains', ->
    ['a','b'].contains('a'  ).assert_Is_True()
    ['a','b'].contains(['a']).assert_Is_True()
    ['a','b'].contains(['c']).assert_Is_False()

  it 'Array::item', ->
    (['a'].item(null) is null).assert_Is_True()

  it 'Array:take', ->
    ['a','b'].take(1).assert_Is ['a']
    ['a','b'].take(-1).assert_Is ['a','b']

  it 'String::remove ', ->
    'aaabbb'.remove('aaa').assert_Is 'bbb'

  it 'String::contains', ->
    'aaabbb'.contains(/a.*b/g  ).assert_Is_True()
    'aaabbb'.contains(/a.*c/g  ).assert_Is_False()
    'aaabbb'.contains(['a','b']).assert_Is_True()
    'aaabbb'.contains(['a','c']).assert_Is_False()