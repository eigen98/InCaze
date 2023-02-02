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
    func requestJoinCrew(crewId : String, myInfo : User) -> AnyPublisher<User, CrewRepoError>
    
    //MARK: 가입 요청 메시지 조회
    func getRequestJoinMessages(crewId: String) -> AnyPublisher<[User], CrewRepoError>
    
    //MARK: 가입 요청 메시지 수락
    func approveJoinCrew(crewId: String, user : User) -> AnyPublisher<User, CrewRepoError>
    //MARK: 바로 가입
    func joinCrew(crewId: String, user : User) -> AnyPublisher<User, CrewRepoError>
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
    
    //MARK: 가입 요청
    func requestJoinCrew(crewId : String, myInfo : User) -> AnyPublisher<User, CrewRepoError> {
        return crewRepo.requestJoinCrew(crewId: crewId, myInfo: myInfo)
    }
    
    //MARK: 가입 요청 메시지 조회
    func getRequestJoinMessages(crewId: String) -> AnyPublisher<[User], CrewRepoError> {
        return crewRepo.getRequestJoinMessages(crewId: crewId)
    }
    //MARK: 가입 요청 메시지 수락 (가입 요청 메시지 처리(제거) 호출 -> 크루 멤버 추가 호출)
    func approveJoinCrew(crewId: String, user: User) -> AnyPublisher<User, CrewRepoError>  {
        // flatMap은 "새로운 publishers를 반환한다"를 주의깊게 봐야합니다.
        // map이나 tryMap처럼 어떤 값을 반환하는것이 아니라!! publisher를 반환
         let publisher = crewRepo.deleteRequestJoinMessage(crewId: crewId, userId: user.id)
            .flatMap{_ in self.crewRepo.postNewUserCrewMember(crewId: crewId, user: user)}
            .eraseToAnyPublisher()
            
            
        return publisher
        
    }
    //MARK: 크루 바로 가입
    func joinCrew(crewId: String, user: User) -> AnyPublisher<User, CrewRepoError> {
        return crewRepo.postNewUserCrewMember(crewId: crewId, user: user)
    }
    
    //MARK: 크루

    
}
