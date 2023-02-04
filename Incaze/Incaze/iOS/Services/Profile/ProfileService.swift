//
//  ProfileService.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/03.
//

import Foundation
import Combine

protocol ProfileService{
    //MARK: 프로필 정보 불러오기
    func getUserProfileInfo(userId : String) -> AnyPublisher<User?, UserInfoRepoError>
}



class ProfileServiceImpl : ProfileService{
    let profileRepo : UserInfoRepository
    
    init(profileRepo : UserInfoRepository) {
        self.profileRepo = profileRepo
    }
    
    func getUserProfileInfo(userId: String) -> AnyPublisher<User?, UserInfoRepoError> {
        return profileRepo.getUserProfileInfo(userId: userId)
    }
    
}
