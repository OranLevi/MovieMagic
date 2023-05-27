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
        VStack{
            
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, maxHeight: 190)
            } else if vm.isLoading {
                ProgressView()
                    .tint(Color.theme.accent)
                    .frame(maxWidth: .infinity, minHeight: 190)
            } else {
                Image(systemName: "questionmark")
                    .frame(maxWidth: .infinity, minHeight: 190)
            }
        }
    }
}

struct BackdropImageView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.theme.background
            BackdropImageView(backdropPathUrl: "")
        }
        
    }
}
