angular.module('MM_Graph').run ($httpBackend)-> $httpBackend.whenGET('/api/v1/team/bsimm/get/team-A').respond {"metadata":{"team":"Team A"},"activities":{"Governance":{"SM.1.1":"Yes","SM.1.4":"No","SM.2.2":"NA","SM.2.3":"Maybe","CP.1.1":"Maybe","CP.1.2":"Yes","CP.2.1":"Yes","CP.2.2":"Maybe","CP.2.4":"Maybe","CP.2.5":"Maybe","CP.3.2":"No","CP.3.2.1":"Maybe","CP.3.2.2":"Maybe","T.1.1":"Maybe","T.1.2":"No","T.1.6":"Yes","T.1.7":"No","T.2.5":"Yes","T.2.6":"Yes","T.3.2":"No","T.3.4":"Maybe"},"Intelligence":{"AM.1.2":"Maybe","AM.1.2.1":"NA","AM.1.3":"No","AM.1.4":"Yes","SDF1.1":"No","SFD.1.1":"NA","SFD.1.2":"Maybe","SFD.1.2.1":"NA","SR.1.1":"No","SR.1.2":"Yes","SR.1.3":"No","SR.2.4":"NA","SR.2.4.1":"Maybe","SR.2.6":"Maybe","SR.2.5":"Maybe"},"SSDL":{"AA.1.1":"Yes","AA.1.4":"Yes","CR.1.1":"Yes","CR.1.2":"Yes","CR.1.5":"Yes","CR.1.4":"Yes","CR.2.2":"Yes","ST.1.1":"Yes","ST.1.3":"Yes","ST.1.3.1":"Yes","ST.2.1":"Yes","ST.2.3":"Yes","ST.2.5":"Yes","ST.2.6":"Yes","ST.3.4":"Yes","ST.3.5":"Yes"},"Deployment":{"PT.1.1":"Yes","PT.1.2":"Yes","PT.2.2":"Yes","PT.2.3":"Maybe","SE.1.1":"Maybe","SE.1.1.1":"Maybe","SE.1.1.2":"Maybe","SE.1.2":"Yes","SE.1.4":"Maybe","SE.2.2":"Maybe","SE.2.4":"Maybe","SE.3.2":"Maybe","SE.3.3":"Yes","CMVM.1.1":"Maybe","CMVM.1.2":"Yes","CMVM.2.1":"Maybe","CMVM.2.2":"Maybe","CMVM.2.3":"Maybe","CMVM.3.1":"Maybe","CMVM.3.2":"Maybe"}}}