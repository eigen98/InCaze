//
//  CrewListViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
class CrewListViewModel : ObservableObject{
    @Published var searchText : String = ""
    var crewList : [CrewModel] = [ CrewModel(id: "", crewName: "런린이만 기기링", leaderId: "ko_su", type: "모집중", users: [], limitMember: 20, memberCount: 5, minimumGrade: "Newbie")]
    
}
