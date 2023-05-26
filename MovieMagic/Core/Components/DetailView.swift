//
//  DetailView.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct DetailView: View {
    
    let detail: MovieMagicResult
    
    var body: some View {
        
        HStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.theme.secondaryBackgroundColor)
                .frame(width: 180, height: 370, alignment: .center)
                .overlay {
                    VStack{
                        image
                        titleName
                        HStack{
                            ratting
                        }.padding(.vertical,0.2)
                        
                        overView
                        Spacer()
                    }
                    .foregroundColor(Color.theme.secondaryText)
                }
        }.padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(detail: dev.movie)
            .previewLayout(.sizeThatFits)
    }
}

extension DetailView {
    
    private var image: some View {
        PosterImageView(content: detail)
    }
    
    private var titleName: some View {
        Text(detail.title ?? detail.originalTitle ?? detail.originalName ?? detail.name ?? "n/a")
            .foregroundColor(Color.theme.accent)
            .font(.headline)
            .fontWeight(.heavy)
            .lineLimit(1)
            .padding(.horizontal,4)
    }
    
    private var ratting: some View {
        HStack{
            ForEach(0..<5) { index in
                Image(systemName: "star.fill")
                    .foregroundColor((Int(detail.voteAverage ?? 0) / 2) >= index ? Color.yellow : Color.gray )
            }
        }
    }
    
    private var overView: some View {
        Text(detail.overview == "" ? "N/A overview" : detail.overview ?? "")
            .padding(.horizontal,4)
            .font(.footnote)
    }
}
