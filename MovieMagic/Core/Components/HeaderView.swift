//
//  Header.swift
//  MovieMagic
//
//  Created by Oran Levi on 21/05/2023.
//

import SwiftUI

struct HeaderView: View {
    
    let title: String
    
    var body: some View {
        
        HStack{
            headerTitle
            searchIcon
        }
        .padding()
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.theme.secondaryBackgroundColor
            HeaderView(title: "Watch Now")
        }
    }
}

extension HeaderView {
    
    private var headerTitle: some View{
        Text(title)
            .font(.largeTitle)
            .fontWeight(.heavy)
            .foregroundColor(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var searchIcon: some View{
        NavigationLink(destination: SearchView(vm: SearchViewModel(textSearch: ""))) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.theme.accent)
                .font(.title2)
        }
        .navigationBarHidden(true).navigationBarTitle("Back")
    }
}
