app = angular.module('MM_Graph')

app.directive  'activitytable', ()->
  restrict: 'E',
  scope:
    title     : '=title'
    data      : '=data'
    activities: '=activities'
  templateUrl: '/ui/html/directives/activity-table.html'
