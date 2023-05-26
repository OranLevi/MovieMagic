//
//  MediaView.swift
//  MovieMagic
//
//  Created by Oran Levi on 24/05/2023.
//

import SwiftUI

struct MediaView: View {
    
    @StateObject private var vm = MediaViewModel()
    private let dataService = MediaDataService()
    
    @Binding var tabSelection: Int
    
    @State private var showFullDetailView: Bool = false
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            VStack{
                HeaderView(title:
                        tabSelection == 1 ? "Movies" :
                        tabSelection == 2 ? "TV" : "")
                
                ScrollView(.vertical, showsIndicators: false){
                    detail
                    loadMoreButton
                }
                Spacer()
            }
        }        .background(
            NavigationLink(destination: FullDetailsView(id: $vm.selectedItemId, kindMedia: $vm.selectedKindMedia),
                           isActive: $showFullDetailView,
                           label: { EmptyView()})
        )
    }
}

struct MediaView_Previews: PreviewProvider {
    static var previews: some View {
        MediaView(tabSelection: .constant(1))
    }
}


extension MediaView {
    private var detail: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 5,
            pinnedViews: []) {
                ForEach(
                    tabSelection == 1 ? vm.moviesArray :
                        tabSelection == 2 ? vm.tvArray : [])  { item in
                            DetailView(detail: item)
                                .onTapGesture {
                                    vm.selectedItemId = item.id ?? 0
                                    vm.selectedKindMedia = item.kindMedia == "movie" ? .movie : .tv
                                    showFullDetailView.toggle()
                                }
                        }
            }
    }
    
    private var loadMoreButton: some View {
        Button {
            vm.loadMore(mediaType:
                            tabSelection == 1 ? .movie : .tv)
        } label: {
            Text("Load More..")
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.theme.secondaryBackgroundColor)
                .cornerRadius(10)
        }
    }
}
