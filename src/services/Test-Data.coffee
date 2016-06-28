class Test_Data
  constructor: ()->
    @.items = ['bsimm_Schema']
      
  bsimm_Schema:       
    "SM.1.1": { "level" :"1", "activity" : "Is there a formal SDL (Software Development Lifecycle) used?"                                   }
    "SM.1.4": { "level" :"1", "activity" : "Is there Continuous Integration (with SDL security hooks)?"                                     }
    "SM.2.2": { "level" :"3", "activity" : "Are there at least two deployment pipelines? (one with the ability to block the release)"       }
    "SM.2.3": { "level" :"1", "activity" : "Is there an Security Champion?"                                                                 }  
    "CP.1.1": { "level" :"2", "activity" : "Are there any regulatory or compliance drivers? (to do Security)"                               }
    "CP.1.2": { "level" :"1", "activity" : "Have Data protections obligations been identified?"                                             }      

app = angular.module('MM_Graph')
app.service 'test_Data', ()-> new Test_Data()