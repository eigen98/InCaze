//
//  TimerView.swift
//  Tinowledge
//
//  Created by JeongMin Ko on 2023/01/05.
//

import SwiftUI

struct TimerView: View {
    
    @State var offsets : [CGSize] = Array(repeating: .zero, count: 3)
    
    @State var timer = Timer.publish(every: 4, on: .current, in: .common).autoconnect()
    
    @State var delayTime : Double = 0
    
    var locations: [CGSize] = [
        // rotation1
          CGSize (width: 50, height: 0),
          CGSize (width: 0, height: -50),
          CGSize (width: -50, height: 0),
          // rotation 2
        
          CGSize (width: 50, height: 50),
          CGSize (width: 50, height: -50),
          CGSize (width: -50, height: -50),
          // rotation3
        
          CGSize (width: 0, height: 50),
          CGSize(width: 50, height: 0),
          CGSize (width: 0, height: -60),
          
        // final resetting rotation.
          CGSize (width: 0, height: 0),
          CGSize (width: 0, height: 0),
          CGSize (width: 0, height: 0)
    ]
    
    var body: some View {
        ZStack{
            Color(.clear)
                .ignoresSafeArea()
            
            VStack(spacing: 4){
                
                HStack(spacing: 10){
                    ZStack{
                        Text("60")
                            .font(.system(size: 20, weight: .bold))
                            .frame(width: 50, height: 50)
                            .background(Color.cyan)
                            .offset(offsets[0])
                    }
                }.frame(width: 50, alignment: .leading)
                
                
                
                HStack(spacing: 10){
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: 25, height: 25)
                        .offset(offsets[1])
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: 10, height: 10)
                        .offset(offsets[2])
                }
            }
        }
        .onAppear(perform:{
            doAnimation()
        })
        .onReceive(timer, perform: { _ in
            print("restart Animation")
            delayTime = 0
            doAnimation()
        })
    }
    
    func doAnimation(){
        //
        var tempOffset : [[CGSize]] = []
        
        var currentSet : [CGSize] = []
        
        for value in locations{
            
            currentSet.append(value)
            
            if currentSet.count == 3{
                
                tempOffset.append(currentSet)
                
                currentSet.removeAll()
            }
            
           
        }
        
        if !currentSet.isEmpty{
            
            tempOffset.append(currentSet)
            currentSet.removeAll()
            
        }
        for offset in tempOffset{
            for index in offset.indices{
                doAnimation(delay: .now() + delayTime, value: offset[index], index: index)
                delayTime += 0.3
            }
        }
    }
    
    func doAnimation(delay : DispatchTime, value : CGSize, index : Int){
        
        DispatchQueue.main.asyncAfter(deadline: delay, execute: {
            withAnimation(Animation.easeInOut(duration: 0.5)){
                self.offsets[index] = value
            }
        })
        
    }
    
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
