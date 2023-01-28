//
//  CrewDetailView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/27.
//

import SwiftUI

struct CrewDetailView: View {
    
    var viewModel : CrewDetailViewModel = CrewDetailViewModel()
    
    var body: some View {
        ScrollView{
            
            
            LazyVStack.init(spacing: 0, pinnedViews: [.sectionHeaders]){
                Section{
                    CrewInfoHeaderView()
                        .padding(.vertical, 8)
                }
                
                Section(){
                    ForEach(viewModel.users){_ in
                        CrewPlayerCellView()
                            .padding(.vertical,4)
                    }
                }
                
            }
            
            
          
          
        }
        .background(Color.init(red: 46/255, green: 60/255, blue: 87/255))
    }
}

struct CrewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CrewDetailView()
    }
}
