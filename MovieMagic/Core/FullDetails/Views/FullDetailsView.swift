//
//  FullDetailsView.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct FullDetailsView: View {
    
    @StateObject var vm = FullDetailsViewModel()
    @Binding var id: Int
    @Binding var kindMedia: MediaType
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack{
            
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView{
                VStack(alignment: .center, spacing: 20 ){
                    
                    image
                    titleName
                    ratting
                    overViewTitle
                    
                    Divider()
                        .overlay(Color.theme.accent)
                    
                    overViewDescription
                    moreDetailsTitle
                    
                    Divider()
                        .overlay(Color.theme.accent)
                    
                    moreDetailsDescription
                    
                    Spacer()
                }
                .padding()
            }
        }.onAppear{
            vm.loadDetails(mediaType: kindMedia, id: id)
        }
    }
}

struct FullDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDetailsView(id: .constant(0), kindMedia: .constant(.movie))
    }
}

extension FullDetailsView {
    private var image: some View {
        if let backdropPath = vm.fullDetails.first?.backdropPath {
            return AnyView(BackdropImageView(backdropPathUrl: "\(backdropPath)"))
        } else {
            return AnyView(ProgressView())
        }
    }
    
    private var titleName: some View {
        Text(vm.fullDetails.first?.title ?? vm.fullDetails.first?.name ?? "")
            .foregroundColor(Color.theme.accent)
            .font(.title2)
            .fontWeight(.heavy)
    }
    
    private var ratting: some View {
        HStack{
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .foregroundColor((Int(vm.fullDetails.first?.voteAverage ?? 0) / 2) >= index ? Color.yellow : Color.gray )
            }
        }
    }
    
    private var overViewTitle: some View {
        Text("Overview:")
            .foregroundColor(Color.theme.accent)
            .fontWeight(.semibold)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var moreDetailsTitle: some View {
        Text("More Details:")
            .foregroundColor(Color.theme.accent)
            .fontWeight(.semibold)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewDescription: some View {
        Text(vm.fullDetails.first?.overview ?? "N/A overView")
            .foregroundColor(Color.theme.accent)
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var moreDetailsDescription: some View {
        LazyVGrid(
            columns: columns,
            alignment: .center,
            spacing: 5,
            pinnedViews: []) {
                ForEach(vm.moreFullDetails) { item in
                    MoreFullDetails(moreFullDetails: item)
                }
            }
    }
}

