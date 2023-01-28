//
//  CrewDetailViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
class CrewDetailViewModel : ObservableObject{
    var users : [User] = [
        User(id: "ko_su", email: "ko_su", status: 0, nickname: "도도", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su1", email: "ko_su", status: 0, nickname: "구구", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su2", email: "ko_su", status: 0, nickname: "오레오", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su3", email: "ko_su", status: 0, nickname: "프링글스", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su4", email: "ko_su", status: 0, nickname: "도리토스", createdAt: "", updatedAt: "", isSelectable: false),
    
    ]
}
