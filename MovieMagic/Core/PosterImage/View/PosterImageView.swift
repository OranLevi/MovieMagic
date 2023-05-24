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
    
    init(watchNow: WatchNowResult){
        _vm = StateObject(wrappedValue: PosterImageViewModel(watchNow: watchNow))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(maxHeight: 185)
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

struct PosterImageView_Previews: PreviewProvider {
    static var previews: some View {
        PosterImageView(watchNow: dev.movie)
            .previewLayout(.sizeThatFits)
    }
}
