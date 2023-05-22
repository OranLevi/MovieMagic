//
//  Detail.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct Detail: View {
    var body: some View {
        
        HStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.secondaryBackgroundColor)
                .frame(width: 180, height: 300, alignment: .center)
                .overlay {
                    VStack{
                        image
                        titleName
                        ratting
                        overView
                        Spacer()
                    }
                    .foregroundColor(Color.theme.secondaryText)
                }
        }.padding()
    }
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Detail()
            .previewLayout(.sizeThatFits)
    }
}

extension Detail {
    
    private var image: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: 150)
    }
    
    private var titleName: some View {
        Text("Name Movie")
            .foregroundColor(Color.theme.accent)
            .font(.headline)
            .fontWeight(.heavy)
            .lineLimit(1)
            .padding(.horizontal,4)
    }
    
    private var ratting: some View {
        Text("****")
    }
    
    private var overView: some View {
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
            .padding(.horizontal,4)
            .font(.footnote)
    }
}
