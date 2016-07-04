class Test_Data
  constructor: ()->
    @.items = ['bsimm_Schema', 'team_A']
      
  bsimm_Schema:       
    "SM.1.1": { "level" :"1", "activity" : "Is there a formal SDL (Software Development Lifecycle) used?"                                   }
    "SM.1.4": { "level" :"1", "activity" : "Is there Continuous Integration (with SDL security hooks)?"                                     }
    "SM.2.2": { "level" :"3", "activity" : "Are there at least two deployment pipelines? (one with the ability to block the release)"       }
    "SM.2.3": { "level" :"1", "activity" : "Is there an Security Champion?"                                                                 }  
    "CP.1.1": { "level" :"2", "activity" : "Are there any regulatory or compliance drivers? (to do Security)"                               }
    "CP.1.2": { "level" :"1", "activity" : "Have Data protections obligations been identified?"                                             }      

  team_A:
    {
        "metadata":{"team":"Team A"},
        "activities": { 
            "Governance":{"SM.1.1":"Yes","SM.1.4":"No","SM.2.3":"NA","CP.1.1":"Maybe","CP.1.2":"Yes","CP.2.1":"Yes","CP.2.2":"Maybe","CP.2.4":"Maybe","CP.2.5":"Maybe","CP.3.2":"No","CP.3.2.1":"Maybe","CP.3.2.2":"Maybe","T.1.1":"Maybe","T.1.2":"No","T.1.6":"Yes","T.1.7":"No","T.2.5":"Yes","T.2.6":"Yes","T.3.2":"No","T.3.4":"Maybe"},
            "Intelligence":{"AM1.2":"Maybe","AM1.2.1":"Maybe","AM1.3":"Maybe","AM1.4":"Maybe","SDF1.1":"Maybe","SDF.1.1":"Maybe","SDF.1.2":"Maybe","SDF.1.2.1":"Maybe","SR.1.1":"Maybe","SR.1.2":"Maybe","SR.1.3":"Maybe","SR.2.4":"No","SR.2.4.1":"No","SR.2.6":"Maybe","SR.2.5":"Maybe"},
            "SSDL":{"AA.1.1":"Maybe","AA.1.4":"Maybe","CR.1.1":"Maybe","CR.1.2":"Maybe","CR.1.5":"Maybe","CR.2.2":"Yes","ST.1.1":"Maybe","ST.1.3":"Maybe","ST.1.3.1":"Maybe","ST.2.1":"No","ST.2.3":"Maybe","ST.2.5":"Maybe","ST.2.6":"Maybe","ST.3.4":"Yes","ST.3.5":"Maybe"},
            "Deployment":{"PT.1.1":"Maybe","PT.1.2":"Maybe","PT.2.2":"Maybe","PT.2.3":"Maybe","SE.1.1":"Maybe","SE.1.1.1":"Maybe","SE.1.1.2":"Maybe","SE.1.4":"Maybe","SE.2.2":"Maybe","SE.2.4":"Maybe","SE.3.2":"Maybe","SE.3.3":"Yes","CMVM.1.1":"Maybe","CMVM.1.2":"Yes","CMVM.2.1":"Maybe","CMVM.2.2":"Maybe","CMVM.2.3":"Maybe","CMVM.3.1":"Maybe","CMVM.3.2":"Maybe"}
        }
    }
  
app = angular.module('MM_Graph')
app.service 'test_Data', ()-> new Test_Data()