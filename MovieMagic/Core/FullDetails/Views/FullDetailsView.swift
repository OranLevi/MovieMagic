//
//  FullDetailsView.swift
//  MovieMagic
//
//  Created by Oran Levi on 22/05/2023.
//

import SwiftUI

struct FullDetailsView: View {
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
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

struct FullDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        FullDetailsView()
    }
}

extension FullDetailsView {
    private var image: some View {
        Rectangle()
            .fill(Color.white)
            .frame(width: .infinity, height: 250)
            .cornerRadius(10)
    }
    
    private var titleName: some View {
        Text("Name Movie")
            .foregroundColor(Color.theme.accent)
            .font(.title2)
            .fontWeight(.heavy)
    }
    
    private var ratting: some View {
        Text("****")
            .foregroundColor(Color.theme.accent)
            .font(.title2)
            .fontWeight(.heavy)
    }
    
    private var overViewTitle: some View {
        Text("Overview:")
            .foregroundColor(Color.theme.accent)
            .fontWeight(.semibold)
            .font(.title2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overViewDescription: some View {
        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum")
            .foregroundColor(Color.theme.accent)
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
