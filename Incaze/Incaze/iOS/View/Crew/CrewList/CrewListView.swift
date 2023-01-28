//
//  CrewListView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import SwiftUI

struct CrewListView: View {
    @ObservedObject var viewModel : CrewListViewModel = CrewListViewModel()
    
    var body: some View {
        ScrollView{
            
            
            LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders]){
                Section{
                    HStack{
                        ZStack{
                            
                            TextField("", text: $viewModel.searchText,
                                      prompt: Text("크루 이름")
                                .foregroundColor(Color.init(red: 190/255, green: 195/255, blue: 217/255))
                                .font(.system(size: 20, weight: .bold))
                                
                            )
                              .padding()
                              .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black)
                                    
                                    
                              )
                        }
                        .background(Color.init(red: 40/255, green: 57/255, blue: 87/255))
                        
                          .padding(.leading, 20)
                        
                        Button {
                          
                        } label: {
                          Image(systemName: "magnifyingglass") //편집
                            .font(.system(size: 20, weight: .bold))
                            .padding(.vertical, 4)
                            
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.init(red: 86/255, green: 120/255, blue: 145/255))
                        .frame(width: 80, height: 50)
                        
                    }
                    .padding(.vertical, 16)
                }
                
                Section(){
                    ForEach(viewModel.crewList){_ in
                        CrewListCellView()
                            .padding(.vertical,4)
                    }
                }
            }
            
            
          
          
        }
        .background(Color.init(red: 46/255, green: 60/255, blue: 87/255))
    }
}

struct CrewListView_Previews: PreviewProvider {
    static var previews: some View {
        CrewListView()
    }
}
