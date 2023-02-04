//
//  ChallengeService.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import Foundation
import Combine

protocol ChallengeService{
    //MARK: 챌린지 결과 생성
    func postChallengeResult(result : RunningSession) -> AnyPublisher<RunningSession?, CrewRepoError>
}

class ChallengeServiceImpl : ChallengeService{
   
    let userInfoRepo : UserInfoRepository
    let crewRepo : CrewRepository
    
    init(userInfoRepo : UserInfoRepository, crewRepo: CrewRepository) {
        self.userInfoRepo = userInfoRepo
        self.crewRepo = crewRepo
    }
    
    //MARK: 챌린지 결과 생성
    func postChallengeResult(result: RunningSession) -> AnyPublisher<RunningSession?, CrewRepoError> {
        //유저 챌린지 결과 추가.
        let publisher = self.userInfoRepo.postUserChallengeResult(result: result)
               .mapError { error in
                   return CrewRepoError.failGetCrewData
               }
               .flatMap { _ in
                   //유저 크루 챌린지 결과 업데이트
                   self.crewRepo.updateCrewChallengeResult(result: result)
               }
           
        return publisher.eraseToAnyPublisher()
    }
    
    
    
}
