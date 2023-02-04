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
            
            NavigationLink(destination: OtherProfileView()){
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                                   .fill(Color(red: 175/255, green: 147/255, blue: 186/255))
                                   .frame(width: deviceWidth - 80, height: 70)
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 20)
                                           .stroke(lineWidth: 3)
                                           .foregroundColor(.black)
                                   ).offset(y:-20)
                    
                    HStack(spacing: 16){
                        AsyncImage(
                            url: URL(string: "https://avatars.githubusercontent.com/u/68258365?v=4" ),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 50, maxHeight: 50)
                                    .cornerRadius(40, corners: .allCorners)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        .padding(.leading, 28)
                        .offset(y:-20)
                        
                        
                        
                        
                        VStack{
                            Text("귤맛팥죽")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text("리더")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .bold))
                        }.offset(y:-20)
                        
                        VStack{
                            Text("등급")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                            
                            Text("Newbie")
                                .foregroundColor(Color.init(red: 241/255, green:  185/255, blue:  67/255))
                                .font(.system(size: 16, weight: .bold))
                        }.offset(y:-20)
                        
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                           .fill(Color(red: 175/255, green: 147/255, blue: 186/255))
                                           .frame(width: 46, height: 46)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 20)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           ).offset(y:-20)
                            
                            Text("101")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                                .offset(y:-20)
                        }
                       
                        Spacer()
                    }
                }
            }
            
            
            
            
            
            VStack{
                ZStack{
                    ZStack{
                        RoundedRectangle(cornerRadius: 20)
                                       .fill(Color(red: 175/255, green: 147/255, blue: 186/255))
                                       .frame(width: deviceWidth - 80, height: 56)
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(lineWidth: 3)
                                               .foregroundColor(.black)
                                       )
                        
                        HStack{
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                            
                            RoundedRectangle(cornerRadius: 10)
                                           .fill(Color.green)
                                           .frame(width: 30, height: 30)
                                           .overlay(
                                               RoundedRectangle(cornerRadius: 10)
                                                   .stroke(lineWidth: 3)
                                                   .foregroundColor(.black)
                                           )
                        }
                    }
                    .offset(y:44)
                    
                   
                  
                    
                    
                    RoundedRectangle(cornerRadius: 16)
                                   .fill(Color.yellow)
                                   .frame(width: 100, height: 46)
                                   .overlay(
                                       RoundedRectangle(cornerRadius: 16)
                                           .stroke(lineWidth: 3)
                                           .foregroundColor(.black)
                                   )
                    
                    Text("이번주 달성")
                        .font(.system(size: 20,weight: .bold))
                        .foregroundColor(.black)
                    
                    
                    
                    
                    
                }
                
                
                
            }
            .offset(y:-24)
        }
        .frame(width: deviceWidth - 48 ,height: 210)
        
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
