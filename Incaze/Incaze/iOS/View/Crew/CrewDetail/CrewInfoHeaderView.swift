//
//  CrewInfoHeaderView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/27.
//

import SwiftUI

enum CrewDetailUserStatus{
    case independent //무소속
    case otherTeam //다른 팀
    case myTeam //내 팀
    case leader //내가 리더
}

struct CrewInfoHeaderView: View {
    var crewNameText : String = "크루 이름"
    var point : Int = 5022
    var noticeText : String = "게임은 즐겁게"
    var maxMemberNum : Int = 50
    var totalMemberNum : Int = 35
    
    var myStatus : CrewDetailUserStatus = .independent
    
    var deviceWidth = UserManager.shared.deviceWidth
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Image(systemName: "figure.run")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    
                    VStack{
                        Text(crewNameText)
                            .foregroundColor(.white)
                            .font(.system(size: 26, weight: .bold))
                        
                        Text("\(point)")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                    Button {
                      
                      
                    } label: {
                      Text("요청") //편집
                        .font(.system(size: 20, weight: .bold))
                        .padding(.vertical, 4)
                        
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(Color.init(red: 86/255, green: 120/255, blue: 145/255))
                    .frame(width: 80, height: 50)
                    
                    
                    Spacer()

                }
            }
            .frame(width: deviceWidth - 48 ,height: 70)
            
            .background(Color(red: 64/255, green:  77/255, blue:  112/255))
            .cornerRadius(22, corners: .allCorners)
            .overlay(RoundedRectangle(cornerRadius: 22)
                .stroke(Color.init(red: 92/255, green:  92/255, blue:  119/255), lineWidth: 2)
            )
            
            VStack{
                HStack(spacing: 16){
                    
                    VStack{
                        Text("최소 등급")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("Newbie")
                            .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                            .font(.system(size: 16, weight: .bold))
                    }
                    
                    VStack{
                        Text("타입")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("승인필요")
                            .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                            .font(.system(size: 16, weight: .bold))
                    }
                    
                    VStack{
                        Text("인원")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                        
                        Text("\(totalMemberNum)/\(maxMemberNum)")
                            .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                            .font(.system(size: 16, weight: .bold))
                    }
                    
                }
            }
            .frame(width: deviceWidth - 48 ,height: 70)
            
            .background(Color(red: 47/255, green:  45/255, blue:  84/255))
            .cornerRadius(22, corners: .allCorners)
            .overlay(RoundedRectangle(cornerRadius: 22)
                .stroke(Color.init(red: 92/255, green:  92/255, blue:  119/255), lineWidth: 2)
            )
            
            
            
            VStack{
                Text("Notice")
                    .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                    .font(.system(size: 20, weight: .bold))
                
                VStack{
                    Text("\(noticeText)")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .bold))
                    
                }.frame(minWidth: deviceWidth - 64, maxWidth: deviceWidth - 64, minHeight: 100 )
                    .background(Color(red: 64/255, green: 67/255, blue: 102/255))
                
                
                    
            }
            .frame(width: deviceWidth - 48 ,height: 200)
            
                .background(Color(red: 64/255, green:  77/255, blue:  112/255))
                .cornerRadius(22, corners: .allCorners)
                .overlay(RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.init(red: 92/255, green:  92/255, blue:  119/255), lineWidth: 2)
                )
        }
        
        
    }
}

struct CrewInfoHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CrewInfoHeaderView()
    }
}