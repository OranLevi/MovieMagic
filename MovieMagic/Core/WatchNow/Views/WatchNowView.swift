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
                HeaderView(title: "Watch Now")
                
                navBar
                if vm.hasData {
                    
                    
                    
                    
                    
                    
                    
                    
                    ScrollView(.vertical, showsIndicators: false){
                        
                        detail
                        
                    }
                    
                    
                    
                    
                    
                    
                } else {
                    Spacer()
                    ProgressView()
                        .tint(Color.theme.accent)
                }
                
                Spacer()
            }
            .padding(.horizontal,2)
        }          .background(
            NavigationLink(destination: FullDetailsView(id: $vm.selectedItemId, kindMedia: $vm.selectedKindMedia),
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
        ScrollViewReader { scrollViewProxy in
            
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 5,
                pinnedViews: []) {
                    ForEach(vm.arrayToShow)  { item in
                        DetailView(detail: item)
                            .onTapGesture {
                                vm.selectedItemId = item.id ?? 0
                                vm.selectedKindMedia = item.kindMedia == "movie" ? .movie : .tv
                                showFullDetailView.toggle()
                            }
                    }.id("watchNow")
                } .onChange(of: vm.selectedCategory) { _ in
                    withAnimation(.spring()){
                        scrollViewProxy.scrollTo("watchNow", anchor: .top)
                    }
                }
        }
    }
}

