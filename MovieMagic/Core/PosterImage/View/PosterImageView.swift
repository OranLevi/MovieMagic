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
    
    init(movie: MovieResult){
        _vm = StateObject(wrappedValue: PosterImageViewModel(movie: movie))
    }
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
            } else {
                Image(systemName: "questionmark")
            }
        }
        
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(movie: dev.movie)
            .previewLayout(.sizeThatFits)
    }
}
