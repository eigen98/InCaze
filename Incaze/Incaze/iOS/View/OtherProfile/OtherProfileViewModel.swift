//
//  OtherProfileViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/02.
//

import Foundation
import Combine
class OtherProfileViewModel : ObservableObject{
    
    private var bag = Set<AnyCancellable>()
    var service : CrewService
    
    init(service: CrewService) {
        self.service = service
    }
}
