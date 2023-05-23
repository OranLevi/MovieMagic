//
//  Detail.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct Detail: View {
    
    let detail: MovieResult
    
    var body: some View {
        
        HStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.secondaryBackgroundColor)
                .frame(width: 180, height: 370, alignment: .center)
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
        Detail(detail: dev.movie)
            .previewLayout(.sizeThatFits)
    }
}

extension Detail {
    
    private var image: some View {
        PosterImageView(movie: detail)
            
       
    }
    
    private var titleName: some View {
        Text(detail.title ?? detail.originalTitle ?? "")
            .foregroundColor(Color.theme.accent)
            .font(.headline)
            .fontWeight(.heavy)
            .lineLimit(1)
            .padding(.horizontal,4)
    }
    
    private var ratting: some View {
        Text("\(detail.voteAverage ?? 0)")
    }
    
    private var overView: some View {
        Text(detail.overview ?? "n/a")
            .padding(.horizontal,4)
            .font(.footnote)
    }
}
