app = angular.module('MM_Graph')

pad = (value, length) ->
  if value
    padding = length - value.length + 1
    if (padding >= 1)
      value + Array(padding + 1).join(' ')
    else
      value

class Team_Mappings
  constructor: ($routeParams, team_Data)->
    @.$routeParams   = $routeParams
    @.team_Data      = team_Data
    @.domains        = null
    @.mappings       = null

  load_Data: (callback)=>
    @.team_Data.load_Data callback

  project: =>
    @.team_Data.project

  team: =>
    @.team_Data.team

  team_Edit_Map_Domains: ()->
    if @.team_Data.schema
      schema      = @.team_Data.schema
      @.domains     = {}
      for domain_Name,domain of schema.domains
        @.domains[domain_Name] = []
        for practice_Name in domain.practices
          @.domains[domain_Name] = @.domains[domain_Name].concat schema.practices[practice_Name].activities

  team_Raw_Map_Activities: (data, schema)=>
    return @.team_Raw_Map_Activities_For_Level(data, schema, '1') + '\n' +
           @.team_Raw_Map_Activities_For_Level(data, schema, '2') + '\n' +
           @.team_Raw_Map_Activities_For_Level(data, schema, '3')

  team_Raw_Map_Activities_For_Level: (data, schema, level)->
    mapping = "Level #{level}\n" + Array(124).join('-') + '\n'
    for key,value of data?.activities
      activity_Schema = schema?.activities[key]
      if activity_Schema?.level is level
        mapping += "#{pad(key,7)} | #{pad(activity_Schema?.name, 102)} | #{value.value} \n"
        #mapping += "#{pad(key,7)} | #{pad(value.value,4) } | #{pad(activity_Schema?.name, 102)} \n"   # see https://github.com/OWASP/Maturity-Models/issues/202#issuecomment-267292073
    return mapping

  team_Table_Map_Rows: (level, filter)=>
    data       = @.team_Data.data
    schema     = @.team_Data.schema

    return if (not data) or (not schema)

    @.mappings = []

    for domain_Name, domain of schema.domains
      for practice_Name in domain.practices
        practice = schema.practices[practice_Name]
        for activity_Key in practice.activities
          activity = schema.activities[activity_Key]
          if activity
            if (not level) or activity.level is level
              row = [domain_Name, practice_Name, activity_Key, activity.level, activity.name]
              activity_Data = data.activities?[activity_Key]
              value         = activity_Data?.value
              if filter                                         # if filter value is set
                if (not (filter.contains value))                # and it contains the current value
                  continue

              switch value
                when 'Yes'   then row.push true , false, false, false
                when 'No'    then row.push false, true , false, false
                when 'NA'    then row.push false, false, true , false
                when 'Maybe' then row.push false, false, false, true

              @.mappings.push row

app.service 'team_Mappings', ($routeParams, team_Data)=>
  return new Team_Mappings($routeParams, team_Data)