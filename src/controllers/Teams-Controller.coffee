angular.module('MM_Graph')
  .controller 'TeamsController', ($scope, MM_Graph_API)->
    MM_Graph_API.file_List (data)->
      #teams = (name for name in data when name.contains('team'))
      teams = []
      for name in data
        if name.contains('team')
          if not (['team-A', 'team-B', 'team-C','team-D','team-random'].contains name)
            teams.push name
      $scope.teams = teams

