//
//  BackdropImageView.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import SwiftUI

struct BackdropImageView: View {
    
    @StateObject var vm: BackdropImageViewModel
    
    init(backdropPathUrl: String){
        _vm = StateObject(wrappedValue: BackdropImageViewModel(backdropPathUrl: backdropPathUrl))
    }
    
    var body: some View {
        ZStack{
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: 190)
            } else {
                Image(systemName: "questionmark")
            }
        }
    }
}

struct BackdropImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackdropImageView(backdropPathUrl: dev.movie.backdropPath ?? "")
    }
}
