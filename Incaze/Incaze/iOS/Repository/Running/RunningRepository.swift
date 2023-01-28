//
//  RunningRepository.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/21.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase

enum RunningRepoError: Error{
    case notFoundRunningData
    case failUpdateMyData
}

protocol RunningRepository{
    func getRunningData(channelId : String, oppUserId : String) -> AnyPublisher<Double?, Never>
    func updateMyRunningData(channelId : String, distance: Double) -> AnyPublisher<Double?, RunningRepoError>
    func postCompleteDate() -> AnyPublisher<String?, RunningRepoError>
    
    //상대 유저 선택 가능한 경우
    //func createRunningChannel() -> AnyPublisher<String?, RunningRepoError>
    
    //TODO: 불가능한 경우
}

//달리기 Score Repository
class RunningRepositoryImpl : RunningRepository{
    //TODO: 상대 유저 선택 가능한 경우
//    func createRunningChannel() -> AnyPublisher<String?, RunningRepoError> {
//        <#code#>
//    }
    
    var databaseRef : DatabaseReference!
    init() {
        self.databaseRef = Database.database().reference().child("Running")
    }
    
    func getRunningData(channelId : String, oppUserId : String) -> AnyPublisher<Double?, Never> {
        // create a subject that will allow callers to observe data using Combine.
        let subject = CurrentValueSubject<Double?, Never>(nil)
        // get the reference name from the database and observe its value change.
      
        let handle = databaseRef.observe(.value, with: { snapshot in
            //Whenever we get data, we pass it to subject .
            subject.send(snapshot.value as? Double)
        })
        
        // Detach handle on cancellation
        //At last, we add a listener in the subject to get notified when the publisher is canceled, this will make sure we don’t keep observing the database once the caller is done with it.
        return subject.handleEvents(receiveCancel: {[weak self] in
            self?.databaseRef.removeObserver(withHandle: handle)
            
        }).eraseToAnyPublisher()
    }
    
    func updateMyRunningData(channelId : String, distance: Double ) -> AnyPublisher<Double?, RunningRepoError> {
        var myId = UserManager.shared.id
        print("updateMyRunningData channelId : \(channelId)")
        print("update distance \(distance)")
        return Future<Double?, RunningRepoError>{observer in
            self.databaseRef.child(channelId).child(myId).child("distance").setValue(distance){(error, snapshot) in
                if error != nil{
                    observer(.failure(RunningRepoError.failUpdateMyData))
                    print(" \(error ) 실패")
                    return
                }
                print("updateMyRunningData \(snapshot)")
                observer(.success(distance))
                
            }
            
        }.eraseToAnyPublisher()
    }
    
    
    func postCompleteDate() -> AnyPublisher<String?, RunningRepoError>{
        var completeDate = "\(Date())"
        return Future<String?, RunningRepoError>{observer in
            self.databaseRef.setValue(completeDate){(error, snapshot) in
                if error != nil{
                    observer(.failure(RunningRepoError.failUpdateMyData))
                    return
                }
                observer(.success(completeDate))
                
            }
            
        }.eraseToAnyPublisher()
    }
    
}
