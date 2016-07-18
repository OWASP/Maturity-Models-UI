angular.module('MM_Graph')
  .controller 'RadarControllerAll', ($scope, $routeParams, MM_API)->
    $scope.version = 'v0.7.7'

    project  = $scope.project  || $routeParams.project  || 'demo'
    team     = $scope.team     || $routeParams.team     || 'team-A'

    target_Div = '.radar-all-data'

    all_Data = {}

    mapData = (list, next)->
      item = list.pop()
      if not item
        #console.log 'all done'
        return next()

      if item.contains('team') #or !(['team-A', 'team-B', 'team-C'].contains item)
          #console.log 'mapping ' + item
          MM_API.team_Get project, item,(data)->
            all_Data[item] =  data
            #console.log data
            return mapData list, next
      else
        mapData list, next

    MM_API.file_List project, (list)->
      mapData list, ->
        #console.log 'ready to plot graph'
        showRadar()

    showRadar  = ()->
      data = []
      data.push get_Radar_Fields()
      data.push get_Default_Data()
      for key,value of all_Data
        calculate_Data value, (team_Data)->
          data.push map_Team_Data team_Data

      RadarChart.draw target_Div, data, radar_Config()

    calculate_Data = (result, next)->

      calculate = (activity, prefix)->
        score = 0.2
        if result.activities
          for key,value of result.activities[activity] when key.contains(prefix)
            if value is 'Yes'
              score += 0.4
            if value is 'NA'
              score += 0.1
        score

      data =
        SM  : calculate 'Governance'  , 'SM'
        CMVM: calculate 'Deployment'  , 'CMVM'
        SE  : calculate 'Deployment'  , 'SE'
        PE  : calculate 'Deployment'  , 'SE'
        ST  : calculate 'SSDL'        , 'ST'
        CR  : calculate 'SSDL'        , 'CR'
        AA  : calculate 'SSDL'        , 'AA'
        SR  : calculate 'Intelligence', 'SR'
        SFD : calculate 'Intelligence', 'SFD'
        AM  : calculate 'Deployment'  , 'AM'
        T   : calculate 'Governance'  , 'T'
        CP  : calculate 'Governance'  , 'CP'

      next data

    radar_Config = ()->
      config =
        color: (index)->
              return ['black', 'orange', 'Aqua', 'Cyan', 'Blue', 'Red',
                      'Pink','Turquoise','Lime','DarkTurquoise','CadetBlue'][index];
        w: 1050,
        h: 450,
        levels: 6,
        maxValue: 3.0
      config

    get_Radar_Fields = ()->
      axes: [
        {axis: "SM"   , yOffset: -2, value: 0},
        {axis: "CMVM" , xOffset: -30, value: 0},
        {axis: "SE"   , xOffset: -10, value: 0},
        {axis: "PT"   , xOffset: -1, value: 0},
        {axis: "ST"   , xOffset: -10, value: 0},
        {axis: "CR"   , xOffset: -10, value: 0},
        {axis: "AA"   , xOffset: 1, value: 0},
        {axis: "SR"   , xOffset: 10, value: 0},
        {axis: "SFD"  , xOffset: 12, value: 0},
        {axis: "AM"   , xOffset: 1, value: 0},
        {axis: "T"    , xOffset: 2, value: 0},
        {axis: "CP"   , xOffset: 10, value: 0},
      ]

    get_Default_Data = ()->
      axes: [
        {value: 2.0},  # Strategy & Metrics
        {value: 2.0},  # Configuration & Vulnerability Management
        {value: 1.8},  # Software Environment
        {value: 1.2},  # Penetration Testing
        {value: 1.5},  # Security Testing
        {value: 1.4},  # Code Review
        {value: 1.4},  # Architecture Analysis
        {value: 1.9},  # Standards & Requirements
        {value: 1.6},  # Security Features & Design
        {value: 1.3},  # Attack Models
        {value: 1.2},  # Training
        {value: 2.1},  # Compliance and Policy
      ]

    map_Team_Data = (data)->
      {
        axes: [
          {value: data.SM  },  # Strategy & Metrics
          {value: data.CMVM},  # Configuration & Vulnerability Management
          {value: data.SE  },  # Software Environment
          {value: data.PE  },  # Penetration Testing
          {value: data.ST  },  # Security Testing
          {value: data.CR  },  # Code Review
          {value: data.AA  },  # Architecture Analysis
          {value: data.SR  },  # Standards & Requirements
          {value: data.SFD },  # Security Features & Design
          {value: data.AM  },  # Attack Models
          {value: data.T   },  # Training
          {value: data.CP  },  # Compliance and Policy
        ]
      }

