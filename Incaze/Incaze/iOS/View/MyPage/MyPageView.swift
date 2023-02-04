//
//  MyPageView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import SwiftUI

struct MyPageView: View {
    let characters:[String] = ["BasicRunner", "SpaceMan", "JeepCar"]
    @ObservedObject var viewModel : MyPageViewModel
    @State var myname : String = ""
    @State var isAnimating : Bool = true
    var deviceWidth = UserManager.shared.deviceWidth
    @State var offset : CGFloat = .init(0)
    var body: some View {
        
        ScrollView(.vertical){
            
            VStack{
                
                //캐릭터 선택
                VStack{
                    Text("\(myname)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    
                    
                    ZStack{
                        
                        PagingTabView(offset: $offset, content: {
                            var _ = print(offset)
                            
                                HStack(spacing: 0) {
                                    ForEach(characters.indices, id:\.self) { index in
                                        ZStack{
                                            //이미지
                                            HStack{
                                                Color.init(red: 30/255, green: 26/255, blue: 62/255)
                                                
                                            }.frame(width: deviceWidth,
                                                    height: deviceWidth)
                                            
                                            //SPOTLIGHT View
//                                            FanShape()
//                                                .fill(Color.yellow)
//                                                .frame(width: 380, height: 380)
//                                                .rotationEffect(.degrees(63))
//                                                .offset(.init(width: 0, height: -140))
                                            LinearGradient(colors: [.white.opacity(0.2), .white.opacity(0.0)], startPoint: .top, endPoint: .bottom)
                                                .mask(LightShape())
                                                .frame(height: UIScreen.main.bounds.height / 1.8)
                                                .opacity(isAnimating ? 1 : 0)
                                                .offset(y: -160)
                                            
                                    
                                            //텍스트
                                            VStack{
                                                LottieView(jsonName: characters[index])
                                                    .frame(width: 200, height: 120)
                                                //그림자
                                                Ellipse()
                                                    .foregroundColor(.gray)
                                                    .frame(width: 100,height: 20)
                                                    .offset(.init(width: 0, height: -30))
                                                
                                                Text("Newbie")
                                                    .font(.system(size: 30,
                                                                  weight: .bold
                                                                 ))
                                                    .foregroundColor(.white)
                                                
                                            }
                                        
                                        
                                        
                                    }
                                    .frame(width: deviceWidth, height: deviceWidth - 100)
                                    
                                }
                            }
                                
                            
                        })
                        .frame(width: deviceWidth, height: deviceWidth - 100)
                        
                    }
          
                        
                    
                    //Page Indicator
                    HStack(spacing: 14){
                        ForEach(characters.indices, id : \.self){ index in
                            Capsule()
                                .fill(.gray)
                                .frame(width: getIndex() == index ? 20 :  7, height: 7)
                                
                        }
                    }
                    .overlay(
                        Capsule()
                            .fill(.gray)
                            .frame(width:  20, height: 7)
                            .offset(x: getIndicatorOffset())
                        ,alignment: .leading
                    )
                }
                
                
                
                
                //내 정보
                VStack{
                    RecentButtonCellView()
                    LocationInfoCellView()
                    TermsOfUseCellView()
                }
                .padding(.top, 32)
             
            }
        }
        .background(Color.init(red: 30/255, green: 26/255, blue: 62/255))
        .onAppear{
            viewModel.getMyProfile()
        }
        .onReceive(viewModel.userSubject){user in
            self.myname = user.nickname
            
        }
        
    }
    
    func getIndicatorOffset() -> CGFloat{
        let progress = offset / deviceWidth
        
        let maxWidth : CGFloat = 12 + 7
        return progress * maxWidth
    }
    
    func getIndex() -> Int{
        let progress = offset / deviceWidth
        
        return Int(progress)
        
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(viewModel: MyPageViewModel(service: ProfileServiceImpl(profileRepo: UserInfoRepositoryImpl())))
    }
}
//부채꼴 모양
struct FanShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let angle: CGFloat = .pi / 3
        let blades = 50
        
        for i in 0..<blades {
            let startAngle = CGFloat(i) * angle
            let endAngle = startAngle + angle
            
            path.addArc(center: center, radius: radius, startAngle: Angle(degrees: startAngle) , endAngle: Angle(degrees: endAngle), clockwise: false)
            path.addLine(to: center)
        }
        
        return path
    }
}

struct LightShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let part = rect.width / 7
        
        path.move(to: CGPoint(x: rect.midX - part, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX + part, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        path.closeSubpath()

        return path
    }
}
