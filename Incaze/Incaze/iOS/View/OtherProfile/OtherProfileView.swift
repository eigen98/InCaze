//
//  OtherProfileView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/02.
//

import SwiftUI

struct OtherProfileView: View {
    let characters:[String] = ["BasicRunner", "SpaceMan", "JeepCar"]
    
    @State var isAnimating : Bool = true
    var deviceWidth = UserManager.shared.deviceWidth
    @State var offset : CGFloat = .init(0)
    var body: some View {
        
        ScrollView(.vertical){
            
            VStack{
                
                //캐릭터 선택]
                VStack{
                   
                    
                        
                        //MARK: title
                        ZStack{
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white)
                                           .frame(width: 200, height: 44)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 16)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            Text("Profile")
                                .foregroundColor(.black)
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: 180)
                                
                        }
                    
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
                //MARK: 오늘 운동 수치 뷰
                VStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(red: 39/255, green: 38/255, blue: 70/255))
                                       .frame(width: deviceWidth - 40, height: 200)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(lineWidth: 3)
                                               .foregroundColor(.black)
                                       )
                        
                        VStack{
                            
                            //MARK: 칼로리 뷰
                            HStack{
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.red)
                                                   .frame(width: 46, height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    
                                    Text("Cal")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                        
                                }
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.clear)
                                                   .frame( height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    HStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.red)
                                                       .frame(width: 100, height: 42)
                                                       .overlay(
                                                           RoundedRectangle(cornerRadius: 20)
                                                               .stroke(lineWidth: 0)
                                                               .foregroundColor(.black)
                                                       )
                                                       .padding(.leading, 2)
                                        Spacer()
                                    }
                                    
                                    
                                    Text("444/666")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                        
                                }
                                
                                
                            }
                            
                            
                            
                            //MARK: 운동시간 뷰
                            HStack{
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.green)
                                                   .frame(width: 46, height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    
                                    Text("Time")
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                        
                                }
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                                   .fill(Color.clear)
                                                   .frame( height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    HStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.green)
                                                       .frame(width: 100, height: 42)
                                                       .overlay(
                                                           RoundedRectangle(cornerRadius: 20)
                                                               .stroke(lineWidth: 0)
                                                               .foregroundColor(.black)
                                                       )
                                                       .padding(.leading, 2)
                                        Spacer()
                                    }
                                    
                                    
                                    Text("30분/60분")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                        
                                }
                                
                                
                            }
                            
                            //MARK: 거리 뷰
                            HStack{
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color.yellow)
                                                   .frame(width: 46, height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    
                                    Text("Dis")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                        
                                }
                                
                                ZStack{
                                    RoundedRectangle(cornerRadius: 20)
                                                   .fill(Color.clear)
                                                   .frame( height: 46)
                                                   .overlay(
                                                       RoundedRectangle(cornerRadius: 20)
                                                           .stroke(lineWidth: 3)
                                                           .foregroundColor(.black)
                                                   )
                                    HStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .fill(Color.yellow)
                                                       .frame(width: 100, height: 42)
                                                       .overlay(
                                                           RoundedRectangle(cornerRadius: 20)
                                                               .stroke(lineWidth: 0)
                                                               .foregroundColor(.black)
                                                       )
                                                       .padding(.leading, 2)
                                        Spacer()
                                    }
                                    
                                    
                                    Text("3.68KM")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .bold))
                                        
                                }
                                
                                
                            }
                            
                        }.frame(width: deviceWidth - 64, height: 300)
                    }
                    
                    //MARK: 오늘 운동 수치 타이틀
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                                       .frame(width: 180, height: 44)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(lineWidth: 3)
                                               .foregroundColor(.black)
                                       )
                        
                        Text("Today Activity")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .bold))
                            
                    }
                    .offset(y:-290)
                    
                
                }
                
                
                
                //내 정보
                VStack{
                    RecentButtonCellView()
                    LocationInfoCellView()
                    TermsOfUseCellView()
                }
                .offset(y:-100)
             
            }
        }
        .background(Color.init(red: 30/255, green: 26/255, blue: 62/255))
        
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

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView()
    }
}
