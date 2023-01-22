//
//  QuizProgressView.swift
//  Tinowledge
//
//  Created by JeongMin Ko on 2023/01/05.
//

import SwiftUI

struct QuizProgressView: View {
    
    
    var width : CGFloat = 300
    var height : CGFloat = 20
    var percent : CGFloat = 70
    var colorStart = Color.blue
    var colorEnd = Color.green
    
    
    var body: some View {
        let multiplier = width / 100
        ZStack(alignment: .leading){
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: width, height: 20)
                .foregroundColor(.black.opacity(0.1))
            
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .frame(width: percent * multiplier , height: 20)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [colorStart, colorEnd]),
                        startPoint: .leading,
                        endPoint: .trailing)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
            
                .foregroundColor(.clear)
            
        }
    }
}

struct QuizProgressView_Previews: PreviewProvider {
    static var previews: some View {
        QuizProgressView()
    }
}
