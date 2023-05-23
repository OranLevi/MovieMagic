//
//  SearchView.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText: String = ""
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack{
            
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                
                searchTextFiled
                ScrollView(.vertical, showsIndicators: false){
                    results
                }
                Spacer()
                
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Search")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension SearchView {
    
    private var searchTextFiled: some View {
        
        TextField("Search", text: $searchText)
            .modifier(PlaceholderStyle(showPlaceHolder: searchText.isEmpty, placeholder: "Search.."))
            .padding()
            .frame(height: 50)
            .foregroundColor(.white)
            .background(Color.theme.secondaryBackgroundColor)
            .cornerRadius(10)
            .shadow(color: .white, radius: 2)
            .overlay (
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .padding()
                    .opacity(searchText.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        searchText = ""
                    }
                ,alignment: .trailing
            )
    }
    
    private var results: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 5,
            pinnedViews: []) {
                ForEach(0..<10) { _ in
//                    Detail()
                }
            }
    }
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: String
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, 7)
            }
            content
                .foregroundColor(Color.white)
                .padding(5.0)
        }
    }
}
