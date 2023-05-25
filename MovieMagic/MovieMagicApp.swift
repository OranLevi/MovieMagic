//
//  MovieMagicApp.swift
//  MovieMagic
//
//  Created by Oran Levi on 21/05/2023.
//

import SwiftUI

@main
struct MovieMagicApp: App {
    
    @State private var tabSelection = 0
    
    init(){
        
        // change Tabbar color
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        UITabBar.appearance().standardAppearance = appearance
        
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView(selection: $tabSelection) {
                    WatchNowView()
                        .tabItem {
                            Label("Watch Now", systemImage: "play.square")
                        }.tag(0)
                        .navigationBarHidden(true).navigationBarTitle("")
                    
                    MediaView(tabSelection: $tabSelection)
                        .tabItem {
                            Label("Movies", systemImage: "film.fill")
                        }.tag(1)
                        .navigationBarHidden(true).navigationBarTitle("")
                    
                    MediaView(tabSelection: $tabSelection)
                        .tabItem {
                            Label("TV", systemImage: "tv.fill")
                        }.tag(2)
                        .navigationBarHidden(true).navigationBarTitle("")
                }
            }
        }
    }
}
