//
//  CrewService.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import Combine
//크루 관련 Service
protocol CrewService {
    //MARK: create new crew
    func createCrew(crew : CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError>
    //MARK: get crew List
    func getCrewList() ->  AnyPublisher<[CrewModel], CrewRepoError>
}

class CrewServiceServiceImpl : CrewService {
   
   
    
    let crewRepo : CrewRepository
    
    init(crewRepo : CrewRepository) {
        self.crewRepo = crewRepo
    }
    //MARK: create new crew
    func createCrew(crew: CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError> {
        return crewRepo.createCrew(crew: crew)
    }
    //MARK: get crew List
    func getCrewList() -> AnyPublisher<[CrewModel], CrewRepoError> {
        return crewRepo.getCrewListData()
    }
    
}
