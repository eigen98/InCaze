//
//  ClockView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/20.
//

import SwiftUI

struct ClockView: View {
    @State private var rotateSeconds = false
    @State private var dotOffset = false
    var body: some View {
                ZStack{
                    //for phonescreen
                    Color.white
                        .edgesIgnoringSafeArea(.all)
                    
                    
                    VStack(alignment: .center, spacing: 100) {
                        
                        
                        // Path for positioning dots
                        ZStack {
                            Circle()
                                .stroke()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.black)
                                .opacity(0)
                            
                            
                            // Small dots: Equal intervals
                            ForEach(0 ..< 60) {
                                Circle()
                                    .frame(width: 3, height: 3)
                                    .foregroundColor(.black)
                                    .offset(y: -150)
                                    .rotationEffect(.degrees(Double($0) * 6))
                                    .opacity(0.2)
                        }
                            
                            // Big dots: Equal intervals
                            ForEach(0 ..< 12) {
                                Circle()
                                    .frame(width: 10, height: 10)
                                    .foregroundColor(.black)
                                    .offset(y: -150)
                                    .rotationEffect(.degrees(Double($0) * 30))
                                    
                            }
                            
                            
                            // Clock Hands
                            Rectangle()  //  Minutes handle
                                .frame(width: 6, height: 120)
                                .foregroundColor(.red)
                                .rotationEffect(.degrees(0))
                                .cornerRadius(12)
                                .offset(y: 60)
                                
                            Rectangle()  //  Hours handle
                                .frame(width: 6, height: 80)
                                .cornerRadius(12)
                                .foregroundColor(.red)
                                .rotationEffect(.degrees(40), anchor: .top)
                                .offset(y: 40)
                            
                            ZStack { // Seconds handle
                            Rectangle()
                                .frame(width: 200, height: 1)
                                .foregroundColor(.red)
                                .offset(x: 41)
                                
                            
                                
                        Circle()
                                .stroke()
                                .foregroundColor(.red)
                                .frame(width: 18, height: 18)
                                .offset(x: 150)
                                
                        Circle()
                            .frame(width: 5, height: 5)
                            .foregroundColor(Color(#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1)))
                            .offset(x: -57)
                            
                            }.rotationEffect(.degrees(rotateSeconds ? 360 : 0))
                                .animation(Animation.linear(duration: 36).repeatForever(autoreverses: false))
                             .onAppear() {
                                    self.rotateSeconds.toggle()
                            }
                            
                            
                            Circle()  // Central point: Outer
                                .frame(width: 12, height: 12)
                                .foregroundColor(.white)
                                // Inner overlays
                                .overlay(Circle().frame(width: 8, height: 8).foregroundColor(Color(#colorLiteral(red: 0.1921568662, green: 0.007843137719, blue: 0.09019608051, alpha: 1))))
                                .overlay(Circle().frame(width: 4, height: 4).foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))))
                        }
        

                    }
                }
        }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
