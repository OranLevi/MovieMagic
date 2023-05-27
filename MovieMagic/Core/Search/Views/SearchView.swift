//
//  SearchView.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm: SearchViewModel
    @State private var showFullDetailView: Bool = false
    
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
                
                if !vm.search.isEmpty{
                    ScrollView(.vertical, showsIndicators: false){
                        results
                    }
                } else if vm.isLoading {
                    Spacer()
                    ProgressView()
                        .tint(Color.theme.accent)
                } else {
                    Spacer()
                    noResult
                }
                
                Spacer()
                
            }
            .padding(.horizontal,2)
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
        .background(
            NavigationLink(destination: FullDetailsView(id: $vm.selectedItemId, kindMedia: $vm.selectedKindMedia),
                           isActive: $showFullDetailView,
                           label: { EmptyView()})
        )
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(vm: SearchViewModel(textSearch: ""))
    }
}

extension SearchView {
    
    private var searchTextFiled: some View {
        
        TextField("Search", text: $vm.textSearch)
            .modifier(PlaceholderStyle(showPlaceHolder: vm.textSearch.isEmpty, placeholder: "Search.."))
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
                    .opacity(vm.textSearch.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        vm.textSearch = ""
                    }
                ,alignment: .trailing
            )
    }
    
    private var results: some View {
        
        ScrollViewReader { scrollViewProxy in
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 5,
                pinnedViews: []) {
                    ForEach(vm.search) { item in
                        DetailView(detail: item)
                            .onTapGesture {
                                vm.selectedItemId = item.id ?? 0
                                vm.selectedKindMedia = item.media_type == "movie" ? .movie : .tv
                                showFullDetailView.toggle()
                            }
                    }.id("searchResults")
                } .onChange(of: vm.textSearch) { _ in
                    withAnimation(.spring()){
                        scrollViewProxy.scrollTo("searchResults", anchor: .top)
                    }
                }
        }
    }
    
    private var noResult: some View {
        Text("No result to show!")
            .foregroundColor(Color.theme.accent)
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
