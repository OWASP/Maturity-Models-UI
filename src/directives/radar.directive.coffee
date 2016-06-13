app = angular.module('MM_Graph')

app.directive  'radar', ()->
  controller: 'RadarControllerSmall'
  restrict: 'E',
  scope:
    target: '=target'
  templateUrl: '/ui/html/directives/radar.html'
