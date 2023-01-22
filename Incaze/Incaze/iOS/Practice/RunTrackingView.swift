//
//  RunTrackingView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/29.
//

import SwiftUI

struct RunTrackingView: View {
    @State private var newPath : [CGPoint] = []
    @State private var percentage: CGFloat = .zero
    @Binding var now : CGPoint
    
      var body: some View {
        Color.clear
          .onAppear {
              withAnimation(.linear(duration: 10)) {
                self.percentage = 1.0
              }
          }
          .frame(width: 0, height: 0, alignment: .center)
          
        GeometryReader { geometry in
        Drawing3(paths: newPath)
          .trim(from: 0, to: percentage)
          .stroke(style: .init(lineWidth: 20, lineJoin: .round))
          .onAppear {
            newPath = PolygonShape(sides: 100,
                                   rect: CGRect(x: geometry.frame(in: .local).minX,
                                                y: geometry.frame(in: .local).minY,
                                                width: geometry.size.width,
                                                height: geometry.size.height))
          }
        }.frame(width: 128, height: 128, alignment: .center)
              .background(.blue)
              
      }
    

    func PolygonShape(sides: Int, rect: CGRect) -> [CGPoint] {
        
        var paths:[CGPoint] = []
        
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        var nowPoint = CGPoint()
        
        withAnimation{
            for dix in 0...sides {
                //let angle = (Double(dix) * (360.0 / Double(sides))) * Double.pi / 180
                // let poi = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))
                let poi = CGPoint(x: nowPoint.x +
                                  CGFloat(Int.random(in: 0...5)),
                                  y: nowPoint.y +
                                  CGFloat(Int.random(in: -5...5))
                            )
                nowPoint = poi
                now = poi
                paths.append(poi)
            }
            
        }
        
        
        return paths
    }

}

struct RunTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        RunTrackingView(now: .constant(CGPoint(x: 0, y: 0)))
    }
}

struct Drawing3: Shape {
  var paths:[CGPoint]
  
  var animatableData: [CGPoint] {
    get { paths }
    set { paths = newValue }
  }
    
  func path(in rect: CGRect) -> Path {
    var path = Path()
          
      
    path.move(to: paths.first!)
      withAnimation{
          for dix in 1..<paths.count {
      //        path.addCurve(to: paths[dix],
      //                      control1: CGPoint(x: paths[dix].x + 0.1 ,
      //                                        y:  paths[dix].x + 0.1),
      //                      control2: CGPoint(x: paths[dix].x - 0.1 ,
      //                                        y:  paths[dix].x - 0.1))
              path.addLine(to: paths[dix])
              
              print(paths[dix])
                  
          }
      }
    
      
    return path
  }
}
