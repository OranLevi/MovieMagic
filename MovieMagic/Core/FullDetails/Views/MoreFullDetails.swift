//
//  MoreFullDetails.swift
//  MovieMagic
//
//  Created by Oran Levi on 26/05/2023.
//

import SwiftUI

struct MoreFullDetails: View {
    
    let moreFullDetails: MoreFullDetailsModel
    
    var body: some View {
        ZStack{
            Color.theme.secondaryBackgroundColor
            VStack{
                Text(moreFullDetails.title)
                    .font(.caption)
                    .foregroundColor(Color.theme.secondaryText)
                Text(moreFullDetails.value)
                    .font(.headline)
                    .foregroundColor(Color.theme.accent)
            }
            .padding()
        } .cornerRadius(20)
    }
}

struct moreDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.theme.background
            MoreFullDetails(moreFullDetails: dev.moreFullDetails)
                .previewLayout(.sizeThatFits)
        }
    }
}
