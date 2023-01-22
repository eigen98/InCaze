//
//  MatchingRepository.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/22.
//

import Foundation
import Combine

enum MatchingRepoError: Error{
    case notFoundWaitingData
    case failPostMyData
    
}
protocol MatchingRepository{
    func getRunningData(channelId : String, oppUserId : String) -> AnyPublisher<Double?, Never>
    func updateMyRunningData(channelId : String, distance: Double) -> AnyPublisher<Double?, RunningRepoError>
    func postCompleteDate() -> AnyPublisher<String?, RunningRepoError>
    
    //상대 유저 선택 가능한 경우
    //func createRunningChannel() -> AnyPublisher<String?, RunningRepoError>
    
    //TODO: 불가능한 경우
}
