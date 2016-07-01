app = angular.module('MM_Graph')

app.directive  'teammenu', ()->
  controller: 'TeamMenuController'
  restrict: 'E',
  templateUrl: '/ui/html/directives/team-navbar.html'
