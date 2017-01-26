describe 'directive | team-table', ->
  #project = 'bsimm'
  #team    = 'team-A'
  element = null
  $scope  = null
  html    = null

  beforeEach ()->
    module('MM_Graph')

  beforeEach ->
    inject ($rootScope, $controller, $compile)->
      $scope   = $rootScope.$new()
      element = angular.element('<teamTable/>')[0]
      $compile(element)($scope)
      $scope.$apply()
      html     = element.outerHTML

  it 'check columns names', ->
    table_Headers = (a.innerText for a in $(html).find('th'))
    table_Headers.assert_Is [ '#',
      'Domain',
      'Practice',
      'Key',
      'Level',
      'Activity',
      'Objective',
      'Description',
      'Yes',
      'No',
      'NA',
      'Maybe',
      'Proof (value)',
      'Proof (help)' ]