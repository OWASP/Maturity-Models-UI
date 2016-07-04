app = angular.module('MM_Graph')

app.directive  'teamtable', ()->
  controller: 'TableController'
  restrict: 'E',
  scope:
    level: '=level'    
  templateUrl: '/ui/html/directives/team-table.html'
