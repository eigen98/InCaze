//
//  Ring.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/14.
//

import SwiftUI

struct Ring: View {
    let lineWidth: CGFloat
    let backgroundColor: Color
    let foregroundColor: Color
    let percentage : Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Track
                RingShape()
                    .stroke (style: StrokeStyle(lineWidth: lineWidth))
                    .fill (backgroundColor)
                RingShape(percent : percentage)
                    .stroke (style: StrokeStyle(lineWidth: lineWidth, lineCap: .round) ) .fill(foregroundColor)
            }
            .animation(Animation.easeIn(duration: 1))
            .padding(lineWidth / 2)
        }
    }
}

struct Ring_Previews: PreviewProvider {
    static var previews: some View {
        Ring(lineWidth: 0.0, backgroundColor: .white, foregroundColor: .red, percentage: 0.0)
    }
}
