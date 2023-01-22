//
//  TrainAnimation.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/29.
//

import Foundation
import SwiftUI
import CoreLocation
import SpriteKit
//달리기 화면
struct TwoPlayerRunningView: View {
    
    @Environment(\.viewController) private var viewControllerHolder: UIViewController?
    
    @ObservedObject var viewModel : RunningViewModel
    @State private var animate: Bool = false
    @State var move: Bool = false
    
    @State var finished = false
    
    @State var pecent = 100.0
    let deviceWidth = UIScreen.main.bounds.width
    @State var size: CGFloat = UIScreen.main.bounds.width
    let trainColor: Color = .black
    
    @State private var currentSpeed: Double = 0
    @State private var timer: Timer?
    @State private var locationManager: CLLocationManager?
    
   
    init( viewModel: RunningViewModel) {
       
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        VStack {
            //게이지

            ZStack {

                //테두리
                Rectangle()
                    .stroke(lineWidth: size * 0.02)
                    .frame(width: size + 20, height: size)
                
                var animation =  Animation.linear(duration: 2).repeatForever()
                
                ZStack{
                    DogGifImageView("giphy-unscreen")
                        .frame(width: 200, height: 200)
                        .offset(x: size * 0.08, y: size * 0.08 ) //
                        
                }
                .offset(x: move ? -50.0 : 30.0 , y: 0)
                .onAppear(perform: {
                    DispatchQueue.main.async {
                                        withAnimation(animation) {
                                            move.toggle()
                                        }
                                    }
                })
                    
                var trainAnimation =  Animation.linear(duration: 0.3).repeatForever(autoreverses: false)
                ZStack{
                    ZStack {
                        Rectangle()
                        Line1()
                            .stroke(style: StrokeStyle(lineWidth: size * 0.02, dash: [10]))
                            .offset(x: 0, y: size * 0.024)
                    }
                    .frame(width: size * 1.2, height: size * 0.02)
                    .offset(x: animate ? 0 : size * 0.08, y: size * 0.08 ) //
                }
                .onAppear(perform: {
                    
                    DispatchQueue.main.async {
                                        withAnimation(trainAnimation) {
                                            animate = true
                                            showStartRunModal()
                                        }
                                    }
                    
                    
                })
                
                
               
                
    //            SpriteView(scene: Smokeing(), options: [.allowsTransparency])
    //                .frame(width: size * 0.8, height: size * 0.8)
    //                .offset(x: -(size * 0.1), y: -(size * 0.42))
                
                
                
                //Train
                Rectangle()
                    .frame(width: size * 0.28, height: size * 0.28)
                    .mask(Image("train").resizable())
                    //.offset(x: size * 0.16, y: 0)
                    .offset(x: move ? -100.0 : 100.0 , y: 0)
                    .onAppear(perform: {
                        DispatchQueue.main.async {
                            withAnimation(animation) {
                                
                            }
                        }
                    })
                    
               
                
                //속도계
                HStack{
                    VStack{
                        SpeedView(value: $viewModel.value.double)
                            .frame(width: 100, height: 100)
                        
                    }
                    Spacer()
                    
                   
                }
                .frame(width: size)
                .padding(.leading, 24)
                .offset(.init(width: 0, height: -size/2 + 60))
                
                //기록
                HStack{
                    Spacer()
                    VStack{
                        Text("Distance")
                        Text("\(viewModel.distance)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.blue)
                    }
                    
                    VStack{
                        Text("Remaining")
                        Text("\(viewModel.distance)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.green)
                    }
                    
                    VStack{
                        Text("opponent")
                        Text("\(viewModel.distance)")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.red)
                    }
                    
                    
                   
                }
                .frame(width: size)
                .padding(.trailing, 24)
                .offset(.init(width: 0, height: -size/2 + 60))
                
                
                //등수
                HStack{
                    Spacer()
                    Text("1")
                        .font(.system(size: 70, weight: .bold))
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(5))
                    
                    Text("th")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.gray)
                        .offset(.init(width: -14, height: 16))

                }
                .frame(width: size)
                .padding(.trailing, 24)
                .offset(.init(width: 0, height: size/2 - 60))

            }
            //.navigationBarBackButtonHidden()
            .mask(Rectangle().frame(width: size, height: size))
            .onAppear {
                
                //animate.toggle()
                move = true
                
    //            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
    //                move = false
    //            })
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
                    finished.toggle()
                    
                })
            }
        }
    }
    
    func startMeasurement() {
        locationManager = CLLocationManager()
            //locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.startUpdatingLocation()
            
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                // update current speed every second
                if let location = self.locationManager?.location {
                    self.currentSpeed = location.speed
                }
            }
    }
    
    func stopMeasurement() {
        timer?.invalidate()
        timer = nil
        locationManager?.stopUpdatingLocation()
        locationManager = nil
        currentSpeed = 0
    }
    
    /*
     시작 모달 보여주기
     */
    func showStartRunModal(){
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            StartQuizModalView()
                .onDisappear{
                    viewModel.addRunningChannel(myId: UserManager.shared.id, oppId: viewModel.oppUser.id)
                }
            
        }
    }
    /*
     종료 모달 보여주기
     */
    func showEndRunModal(){
        self.viewControllerHolder?.present(style: .overCurrentContext, transitionStyle: .crossDissolve) {
            StartQuizModalView()
            
        }
    }
    
}

struct TrainAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        TwoPlayerRunningView(viewModel: RunningViewModel(oppUser: User(id: "", email: "", status: 0, nickname : "", createdAt: "", updatedAt: "")))
    }
}

struct Line1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        return path
    }
}


private class Smokeing: SKScene {
    override func sceneDidLoad() {
        
        size = CGSize(width: 500, height: 500)
        scaleMode = .fill
        
        anchorPoint = CGPoint(x: 0.9, y: 0.1)
        
        backgroundColor = .clear
        
//        let node = SKEmitterNode(fileNamed: "SmokeParticles.sks")!
//        addChild(node)
    }
}
