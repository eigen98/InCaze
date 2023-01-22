//
//  PracticeView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/18.
//

import SwiftUI

struct PracticeView: View {
    var body: some View {
        NavigationView {
            List {
                FeaturedProductRow()
                CategoryRow()
                ProductRow()
            }
            .navigationBarTitle("Musinsa")
        }
    }
}
struct HomeScreen: View {
    var body: some View {
        NavigationView {
            List {
                FeaturedProductRow()
                CategoryRow()
                ProductRow()
                
            }
            .navigationBarTitle("Musinsa")
        }
    }
}

struct FeaturedProductRow: View {
    var body: some View {
        HStack {
            Text("Featured Products")
                .font(.headline)
            Spacer()
            Button(action: {
                // show all featured products
            }) {
                Text("See all")
            }
        }
    }
}

struct CategoryRow: View {
    var body: some View {
        HStack {
            Text("Categories")
                .font(.headline)
            Spacer()
            Button(action: {
                // show all categories
            }) {
                Text("See all")
            }
        }
    }
}

struct ProductRow: View {
    var body: some View {
        HStack {
            Text("New Arrivals")
                .font(.headline)
            Spacer()
            Button(action: {
                // show all new arrivals
            }) {
                Text("See all")
            }
        }
    }
}


struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
