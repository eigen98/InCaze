//
//  CrewRepository.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

enum CrewRepoError: Error{
    case notFoundCrewData
    case failGetCrewData
    case failCreateNewCrew
    
}

protocol CrewRepository{
    //MARK: 크루 생성
    func createCrew(crew : CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError>
    //TODO: 크루 상세 정보 조회
    //func getCrewData(channelId : String, oppUserId : String) -> AnyPublisher<Double?, CrewRepoError>
    //TODO: 크루 정보 업데이트
    //func updateCrewData(channelId : String, distance: Double) -> AnyPublisher<Double?, CrewRepoError>
    //TODO: 크루 삭제
    //func postCompleteDate() -> AnyPublisher<String?, CrewRepoError>
    
    //TODO: 크루 리스트 조회
    
    //상대 유저 선택 가능한 경우
    //func createRunningChannel() -> AnyPublisher<String?, RunningRepoError>
    
    //TODO: 불가능한 경우
}

class CrewRepositoryImpl : CrewRepository{
    
    var db : Firestore
    init(){
        db = Firestore.firestore()
    }
    /*
     //MARK: 크루 생성
     */
    func createCrew(crew: CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError> {
        let dictionary = crew.asDictionary ?? ["crew" : "fail"]
        return Future<CrewModel?, CrewRepoError>{ observer in
            self.db.collection("Crew")
                .addDocument(data: dictionary){error in
                    if let error = error{
                        return observer(.failure(CrewRepoError.failCreateNewCrew))
                        
                    }
                    return observer(.success(crew))
                    
                }
        }.eraseToAnyPublisher()
        
    }
    
    
    
    
}
