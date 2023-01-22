//
//  MeleeRunView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/29.
//

import SwiftUI

struct MeleeRunView: View {
    let startPoint = CGPoint(x: 0, y: 100)
    
    private var samplePath : Path {
            let width: CGFloat = 200
            let height: CGFloat = 100

            let startPoint = CGPoint(x: 0, y: height)
            let middlePoint = CGPoint(x: width / 2 , y: 0)
            let controlPoint1 = CGPoint(x: (startPoint.x + middlePoint.x) / 2, y: height)
            let controlPoint2 = CGPoint(x: (startPoint.x + middlePoint.x) / 2, y: 0)
            
            let endPoint = CGPoint(x: width , y: height)
            let controlPoint3 = CGPoint(x: (middlePoint.x + endPoint.x) / 2, y: 0)
            let controlPoint4 = CGPoint(x: (middlePoint.x + endPoint.x) / 2, y: height)
            
            var result = Path()
            result.move(to: startPoint)
            result.addCurve(to: middlePoint, control1: controlPoint1, control2: controlPoint2)
            result.addCurve(to: endPoint, control1: controlPoint3, control2: controlPoint4)

        
            return result
        }
    var body: some View {
        
        VStack{
            ZStack{
                
                samplePath.stroke(style: StrokeStyle(lineWidth: 3))
                Circle().frame(width: 50, height: 50)
                                .position(
                                    samplePath
                                        .trimmedPath(from: 0,
                                                     to: 0.5)
                                        .currentPoint ?? startPoint
                                )
            }
        }
        
        
        
    }
    
    
}

struct MeleeRunView_Previews: PreviewProvider {
    static var previews: some View {
        MeleeRunView()
    }
}
