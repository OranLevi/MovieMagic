//
//  File.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import Foundation
import SwiftUI

struct PosterImageView: View {
    
    @StateObject var vm: PosterImageViewModel
    
    init(content: MovieMagicResult){
        _vm = StateObject(wrappedValue: PosterImageViewModel(content: content))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(minHeight: 185, maxHeight: 185)
            } else if vm.isLoading {
                ProgressView()
                    .tint(Color.theme.accent)
                    .frame(minHeight: 185, maxHeight: 185)
            } else {
                Image(systemName: "questionmark")
                    .frame(minHeight: 185, maxHeight: 185)
            }
        }
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(content: dev.movie)
            .previewLayout(.sizeThatFits)
    }
}
