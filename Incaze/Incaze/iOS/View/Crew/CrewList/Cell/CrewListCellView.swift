//
//  CrewListCellView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import SwiftUI

struct CrewListCellView: View {
    var deviceWidth = UserManager.shared.deviceWidth
    
    var crew : CrewModel
    init( crew: CrewModel) {
       
        self.crew = crew
    }
    var body: some View {
        
        VStack{
            HStack(spacing: 16){
                AsyncImage(
                                url: URL(string: "https://search.pstatic.net/common?type=m&size=174x174&quality=75&direct=true&ttype=input&src=http%3A%2F%2Fbdata.statiz.co.kr%2FeSports%2Fstats%2FeSports%2Flogo%2F202012%2FteamLogo_dark_dss2020121501591422.png" ),
                                content: { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                         .frame(maxWidth: 54, maxHeight: 54)
                                         .cornerRadius(40, corners: .allCorners)
                                },
                                placeholder: {
                                    ProgressView()
                                }
                            )
                .padding(.leading, 16)
                
              
                
                VStack{
                    Text(crew.crewName)
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("\(crew.type)")
                        .foregroundColor(Color.init(red: 141/255, green:  223/255, blue:  175/255))
                        .font(.system(size: 16, weight: .bold))
                }
                
                VStack{
                    Text("인원")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("\(crew.memberCount)/\(crew.limitMember)")
                        .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                        .font(.system(size: 16, weight: .bold))
                }
                
                VStack{
                    Text("최소등급")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("\(crew.minimumGrade)")
                        .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                        .font(.system(size: 16, weight: .bold))
                }
                Spacer()
            }
        }
       
        .frame(width: deviceWidth - 48 ,height: 70)
        
        .background(Color(red: 85/255, green:  85/255, blue:  122/255))
        .cornerRadius(22, corners: .allCorners)
        .overlay(RoundedRectangle(cornerRadius: 22)
            .stroke(Color.init(red: 92/255, green:  92/255, blue:  119/255), lineWidth: 2)
        )
    }
}

struct CrewListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CrewListCellView(crew: CrewModel(id: "",
                                         crewName: "",
                                         leaderId: "",
                                         type: "",
                                         users: [],
                                         limitMember: 5,
                                         memberCount: 5,
                                         minimumGrade: "Newbie",
                                         missionCondition: "11"))
    }
}
