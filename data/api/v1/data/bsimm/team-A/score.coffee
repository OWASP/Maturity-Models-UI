angular.module('MM_Graph').run ($httpBackend)-> $httpBackend.whenGET('/api/v1/data/bsimm/team-A/score').respond {"level_1":{"value":17.2,"percentage":"64%","activities":27},"level_2":{"value":14.2,"percentage":"59%","activities":24},"level_3":{"value":3.8,"percentage":"42%","activities":9}}