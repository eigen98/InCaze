//
//  OtherProfileViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/02.
//

import Foundation
import Combine
class OtherProfileViewModel : ObservableObject{
    
    var service : ProfileService
    private var bag = Set<AnyCancellable>()
    
    init(service: ProfileService) {
        self.service = service
    }
    
    var userSubject = PassthroughSubject<User, Never>()
    
    func getUserProfile(){
        service.getUserProfileInfo(userId: UserManager.shared.id)
            .sink(receiveCompletion: {observer in
                switch observer {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            }, receiveValue: {[weak self]user in
                if let user = user {
                    self?.userSubject.send(user)
                }
               
            }).store(in: &bag)
    }
}
