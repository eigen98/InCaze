//
//  ChallengeButtonModifier.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/04.
//

import Foundation
import SwiftUI
struct UnableFrameModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width:  80 ,height: 70)
            
            .background(Color(red: 39/255, green: 38/255, blue: 70/255))
            .cornerRadius(22, corners: .allCorners)
            .overlay(RoundedRectangle(cornerRadius: 22)
                .stroke(Color.init(red: 92/255, green:  92/255, blue:  119/255), lineWidth: 2)
            )
    }
}

struct PossibleFrameModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width:  80 ,height: 70)
            
            .background(Color(red: 39/255, green: 38/255, blue: 70/255))
            .cornerRadius(22, corners: .allCorners)
            .overlay(RoundedRectangle(cornerRadius: 22)
                .stroke(Color.init(red: 31/255, green:  187/255, blue:  216/255), lineWidth: 2)
            )
    }
}

struct ClearFrameModifier : ViewModifier{
    func body(content: Content) -> some View {
        content
            .frame(width:  80 ,height: 70)
            
            .background(Color(red: 39/255, green: 38/255, blue: 70/255))
            .cornerRadius(22, corners: .allCorners)
            .overlay(RoundedRectangle(cornerRadius: 22)
                .stroke(Color.init(red: 25/255, green:  230/255, blue:  184/255), lineWidth: 2)
            )
    }
}
