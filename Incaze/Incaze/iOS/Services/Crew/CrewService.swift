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
    //MARK: 크루 이름 중복확인
    func doubleCheckCrewName(crewName : String) -> AnyPublisher<Bool, CrewRepoError>
    
    //MARK: get crew List
    func getCrewList() ->  AnyPublisher<[CrewModel], CrewRepoError>
    //MARK: get crew 상세정보
    func getCrewDetail(crewId : String) -> AnyPublisher<CrewModel?, CrewRepoError>
    
    //MARK: Crew 정보 업데이트(크루이름, 모집상태, 미션조건)
    func updateMyCrew(crewId: String, editedCrew : CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError>
    
    //MARK: 크루 삭제
    func deleteMyCrew(crewId : String) -> AnyPublisher<String?, CrewRepoError>
    
    //MARK: 가입 요청
    
    //MARK: 가입 요청 메시지 조회
    //MARK: 가입 요청 메시지 수락
    
    //MARK: 바로 가입
    
    //MARK: 크루 탈퇴
    
    
    
    
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
    //MARK: 크루 이름 중복 확인
    func doubleCheckCrewName(crewName: String) -> AnyPublisher<Bool, CrewRepoError> {
        return crewRepo.doubleCheckCrewName(name: crewName)
    }
    //MARK: get crew List
    func getCrewList() -> AnyPublisher<[CrewModel], CrewRepoError> {
        return crewRepo.getCrewListData()
    }
    
//    //MARK: get crew 상세정보
    func getCrewDetail(crewId : String) -> AnyPublisher<CrewModel?, CrewRepoError>{
        return crewRepo.getCrewData(crewId: crewId)
    }
    //MARK: update crew
    func updateMyCrew(crewId: String, editedCrew: CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError> {
        return crewRepo.updateCrewData(crewId: crewId, editedCrew: editedCrew)
    }
    //MARK: 크루 삭제
    func deleteMyCrew(crewId : String) -> AnyPublisher<String?, CrewRepoError>{
        return crewRepo.deleteCrew(crewId: crewId)
    }
    
    
}
