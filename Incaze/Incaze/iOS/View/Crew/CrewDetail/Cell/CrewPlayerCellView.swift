//
//  CrewPlayerCellView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import SwiftUI

struct CrewPlayerCellView: View {
    var deviceWidth = UserManager.shared.deviceWidth
    var user : User
    var body: some View {
        
        VStack{
            HStack(spacing: 16){
                AsyncImage(
                                url: URL(string: "https://avatars.githubusercontent.com/u/68258365?v=4" ),
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
                    Text("귤맛팥죽")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("리더")
                        .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                        .font(.system(size: 16, weight: .bold))
                }
                
                VStack{
                    Text("등급")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("Newbie")
                        .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                        .font(.system(size: 16, weight: .bold))
                }
                
                VStack{
                    Text("today")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                    
                    Text("O")
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

struct CrewPlayerCellView_Previews: PreviewProvider {
    static var previews: some View {
        CrewPlayerCellView( user:  User(id: "ko_su", email: "ko_su", status: 0, nickname: "도도", createdAt: "", updatedAt: "", isSelectable: false))
    }
}
