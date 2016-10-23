# todo: move this helper method to an utils class
find_Element_By_Id = (html, name)->
  angular.element($(html).find("##{name}").eq(0))


describe '| directive | team-table', ->
  $scope       = null
  element      = null
  save_Button  = null
  team_Name    = null
  status_Label = null

  project      = 'bsimm'
  team         = 'team-A'

  beforeEach ()->
    module('MM_Graph')

  beforeEach ->
    inject ($rootScope, $controller, $compile, $httpBackend)->
      $parent_Scope = $rootScope.$new()
      routeParams   = { project: project , team : team }

      $controller('TeamDataController', { $scope: $parent_Scope, $routeParams : routeParams })   # load data via Team-Data-Controller
      $httpBackend.flush()

      element       = $compile(angular.element('<teamSave/>')[0])($parent_Scope)
      $parent_Scope.$apply()

      save_Button   = find_Element_By_Id element.html(), 'save-button'
      team_Name     = find_Element_By_Id element.html(), 'team-name'
      status_Label  = find_Element_By_Id element.html(), 'status-label'

      $scope = element.find('div').eq(0).scope()

  it 'check scope status', ->
    $scope.messageClass.assert_Is 'secondary'
    $scope.status      .assert_Is 'data loaded'

    (typeof $scope.load_Data ).assert_Is 'function'
    (typeof $scope.save_Data ).assert_Is 'function'

  it 'check elements contents', ->

    element.find('div').eq(0).attr('ng-controller').assert_Is 'TeamSaveController'

    team_Name   .attr('type'    ).assert_Is 'text'
    team_Name   .attr('ng-model').assert_Is 'metadata.team'
    save_Button .attr('ng-click').assert_Is 'save_Data()'
    save_Button .html(          ).assert_Is 'save'
    status_Label.attr('ng-class').assert_Is 'messageClass'
    status_Label.html(          ).assert_Is 'data loaded'

    element.find('div').eq(7).attr('ng-class').assert_Is 'messageClass' # bug: should be secondary

  it 'should show team title', ->
    element.find('input').eq(0).val().assert_Is "Team A"

  it 'should save data', ->
    inject ($httpBackend)->
      # test with success return value
      $scope.save_Data()
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}").respond status: 'ok-status'
      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'success'
        @.status .assert_Is      'ok-status'

      # test with error return value
      $scope.save_Data()
      $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}").respond error: 'an-error'

      $httpBackend.flush()
      using $scope, ->
        @.messageClass.assert_Is 'alert'
        @.status .assert_Is      'an-error'