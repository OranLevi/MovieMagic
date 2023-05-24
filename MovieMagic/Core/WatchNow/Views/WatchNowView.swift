//
//  WatchNowView.swift
//  MovieMagic
//
//  Created by Oran Levi on 21/05/2023.
//

import SwiftUI

struct WatchNowView: View {
    
    @StateObject private var vm = WatchNowViewModel()
    
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
                Header(title: "Watch Now")
                
                navBar
                ScrollView(.vertical, showsIndicators: false){
                    detail
                }
                Spacer()
            }
            .padding(.horizontal,2)
        }          .background(
            NavigationLink(destination: FullDetailsView(),
                           isActive: $showFullDetailView,
                           label: { EmptyView()})
        )
    }
}

struct WatchNowView_Previews: PreviewProvider {
    static var previews: some View {
        WatchNowView()
    }
}

extension WatchNowView {
    
    private var navBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                
                ForEach(vm.navBarArray.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 20)
                        .fill(vm.selectedCategory == index ? Color.theme.green : Color.theme.gray)
                        .frame(width: 120, height: 50)
                        .overlay {
                            Text(vm.navBarArray[index])
                                .foregroundColor(Color.theme.accent)
                                .font(.headline)
                                .bold()
                        }
                        .onTapGesture {
                            withAnimation(.spring()){
                                vm.selectedCategory = index
                            }
                        }
                }
            }
        }
    }
    
    private var detail: some View {
        
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 5,
            pinnedViews: []) {
                ForEach(
                    vm.selectedCategory == selectedCategoryNames.populars.rawValue ? vm.popularArray:
                        vm.selectedCategory == selectedCategoryNames.upcoming.rawValue ? vm.upcomingArray:
                        vm.selectedCategory == selectedCategoryNames.trending.rawValue ? vm.trendingArray :
                        vm.selectedCategory == selectedCategoryNames.topRated.rawValue ? vm.moviesTopRatedArray: [])  { item in
                            Detail(detail: item)
                                .onTapGesture {
                                    showFullDetailView.toggle()
                                }
                        }
            }
    }
}

