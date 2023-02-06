//
//  RunningSession.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import Foundation
struct RunningSession : Codable{
    let stage : String // 단계 (1-0, 1-2...)
    let isCompleted : Bool // 성공여부
    let date: String// 운동 날짜
    let distance: Double //달린 거리
    let duration: Double //달린 시간
    let pace: Double //페이스
    let caloriesBurned: Int //칼로리 소모량
    
}
