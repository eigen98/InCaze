//
//  AnyTransition+SlideInOut.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/16.
//
 
import Foundation
import SwiftUI


extension AnyTransition {
    static var slideInOut: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .bottom),
            removal: .move(edge: .bottom)
        )
            .combined(with: .scale(scale: 0.5))
            .combined(with: .opacity)
    }
}
