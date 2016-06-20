app = angular.module('MM_Graph')

app.directive  'radar', ()->
  controller: 'RadarControllerSmall'
  restrict: 'E',
  scope:
    project: '=project'
    team   : '=team'
  templateUrl: '/ui/html/directives/radar.html'
